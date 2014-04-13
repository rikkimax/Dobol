module dobol.generator_d.defs;
import dobol.parser.defs;
import std.string : toLower;

pure string generatedDcode(ref DobolProgram data) {
	string ret;
	
	ret ~= "/**\n";
	ret ~= " * " ~ headerLine();
	
	ret ~= " *  Program: \t\t" ~ data.id ~ "\n";
	ret ~= " *  Author: \t\t" ~ data.author ~ "\n";
	ret ~= " *  Installation: \t" ~ data.installation ~ "\n";
	ret ~= " *  Date_Written: \t" ~ data.date_written ~ "\n";
	ret ~= " *  Date_Compiled: \t" ~ data.date_compiled ~ "\n";
	ret ~= " *  Security: \t\t" ~ data.security ~ "\n";
	ret ~= " *  Generated: \t\t" ~ __TIMESTAMP__ ~ "\n";
	ret ~= " *\n";
	
	ret ~= " *  Source_Computer: \t" ~ data.environmentDivision.source_computer ~ "\n";
	ret ~= " *  Object_Computer: \t" ~ data.environmentDivision.object_computer ~ "\n";
	
	ret ~= " * " ~ headerLine();
	ret ~= " */\n";
	
	ret ~= "\n";
	
	handleDataDivision(data, ret);
	
	return ret;
}

pure void handleDataDivision(ref DobolProgram data, ref string output) {
	foreach(spn; data.environmentDivision.specialNames) {
		bool gotDevice;
		foreach(device; __traits(allMembers, DobolSystemDevices)) {
			if (device == spn.value) {
				gotDevice = true;
				break;
			}
		}
		
		if (gotDevice) {
			output ~= "alias " ~ transformName(spn.name) ~ " = DobolSystemDevices." ~ spn.value ~ ";\n";
		} else {
			output ~= "alias " ~ transformName(spn.name) ~ " = " ~ spn.value ~ ";\n";
		}
	}
	
	if (data.environmentDivision.specialNames.length > 0)
		output ~= "\n";
	
	foreach(entry; data.dataDivision.fileSectionEntries) {
		output ~= "struct " ~ transformName(entry.name) ~ " {\n";
		bool outerGot;
		
		outerGot = false;
		foreach(record; entry.records) {
			if (record.type != "" && record.name != "FILLER" && record.redefines == "") {
				outerGot = true;
				output ~= getIndent(1) ~ "string " ~ transformName(record.name) ~ ";\n";
			}
		}
		
		if (outerGot)
			output ~= "\n";
		
		outerGot = false;
		foreach(record; entry.records) {
			if (record.type == "") {
				outerGot = true;
				output ~= getIndent(1) ~ "@property string " ~ transformName(record.name) ~ "() {\n";
				output ~= getIndent(2) ~ "return ";
				
				auto entries = entry.filterOnNameLevel(record.name);
				bool got;
				foreach(entry2; entries) {
					if (entry2.type != "" && entry2.name != "FILLER" && record.redefines == "") {
						output ~= transformName(entry2.name) ~ " ~ ";
						got = true;
					}
				}
				
				if (got) {
					output.length -= 3;
				}
				
				output ~= "; }\n";
			}
		}
		
		if (outerGot)
			output ~= "\n";
		
		outerGot = false;
		foreach(record; entry.records) {
			if (record.type != "" && record.name != "FILLER" && record.redefines != "") {
				outerGot = true;
				output ~= getIndent(1) ~ "alias " ~ transformName(record.name) ~ " = " ~ transformName(record.redefines) ~ ";\n";
			}
		}
		
		if (outerGot)
			output ~= "\n";
		
		// check types of variables
		// if wrong make correct
		output ~= getIndent(1) ~ "void validate() {\n";
		foreach(record; entry.records) {
			if (record.type != "" && record.name != "FILLER" && record.redefines == "") {
				output ~= validateAgainstNameType(transformName(record.name), record.type, 2);
			}
		}
		output ~= getIndent(1) ~ "}\n";
		
		output ~= "}\n\n";
	}
	
	if (data.dataDivision.fileSectionEntries.length > 0)
		output ~= "\n";
}

pure string headerLine() {
	string ret;
	
	ret ~= "/";
	for(size_t i = 0; i < 78; i++) {
		ret ~= "-";
	}
	ret ~= "\\\n";
	
	return ret;
}

pure string transformName(string name) {
	return name.replace("-", "_");
}

pure string validateAgainstNameType(string name, string type, size_t indentOffset) {
	string ret;
	
	if (type.length > 3 && type[0 .. 2].toLower() == "x(" && type[$-1] == ')') {
		ret ~= getIndent(indentOffset) ~ "if (" ~ name ~ ".length != " ~ type[2 .. $-1] ~ ") {\n";
		
		ret ~= getIndent(indentOffset + 1) ~ "if (" ~ name ~ ".length < " ~ type[2 .. $-1] ~ ") {\n";
		ret ~= getIndent(indentOffset + 2) ~ name ~ " ~= dobolSpaceCreator(" ~ type[2 .. $-1] ~ " - " ~ name ~ ".length);\n";
		ret ~= getIndent(indentOffset + 1) ~ "} else {\n";
		ret ~= getIndent(indentOffset + 2) ~ name ~ ".length = " ~ type[2 .. $-1] ~ ";\n";
		ret ~= getIndent(indentOffset + 1) ~ "}\n";
		
		ret ~= getIndent(indentOffset) ~ "}\n";
	} else {
		
	}
	
	return ret;
}

enum DobolSystemDevices {
	C01,
	C02,
	C03,
	C04,
	C05,
	C06,
	C07,
	C08,
	C09,
	C10,
	C11,
	C12
}

pure string dobolSpaceCreator(size_t size) {
	string ret;
	
	for (size_t i = 0; i < size; i++) {
		ret ~= " ";
	}
	
	return ret;
}

private {
	pure string replace(string text, string oldText, string newText, bool caseSensitive = true, bool first = false) {
		string ret;
		string tempData;
		bool stop;
		foreach(char c; text) {
			if (tempData.length > oldText.length && !stop) {
				ret ~= tempData;
				tempData = "";
			}
			if (((oldText[0 .. tempData.length] != tempData && caseSensitive) || (oldText[0 .. tempData.length].toLower() != tempData.toLower() && !caseSensitive)) && !stop) {
				ret ~= tempData;
				tempData = "";
			}
			tempData ~= c;
			if (((tempData == oldText && caseSensitive) || (tempData.toLower() == oldText.toLower() && !caseSensitive)) && !stop) {
				ret ~= newText;
				tempData = "";
				stop = first;
			}
		}
		if (tempData != "") {
			ret ~= tempData;	
		}
		return ret;
	}
	
	unittest {
		string test = "Hello World!";
		test = test.replace("Hello", "Hi");
		assert(test == "Hi World!");
		
		assert(replace("Hello World!", "o", "a") == "Hella Warld!");
		assert(replace("Hello World!", "!", "#") == "Hello World#");
	}
	
	
	/**
	 * Helpers
	 */
	
	pure string getIndent(size_t size) {
		string ret;
		
		for (size_t i=0; i < size; i++) {
			ret ~= "    ";
		}
		
		return ret;
	}
}