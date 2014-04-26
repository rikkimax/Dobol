module dobol.generator_d.defs;
import dobol.parser.defs;
import std.string : toLower, indexOf;
import std.conv : to;

pure string generatedDcode(ref DobolProgram data) {
	string ret;
	string validateFuncs;
	
	ret ~= "import std.stdio : writeln;\n";
	
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
	
	handleFileDataDivision(data, ret, validateFuncs);
	handleWorkingDataDivision(data, ret, validateFuncs);
	handleProcedures(data, ret);
	
	ret ~= "void validate() {\n" ~ validateFuncs ~ "}\n";
	
	return ret;
}

pure void handleFileDataDivision(ref DobolProgram data, ref string output, ref string validateFuncs) {
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
		bool outerGot;
		
		outerGot = false;
		foreach(record; entry.records) {
			if (record.type != "" && record.name != "FILLER" && record.redefines == "") {
				outerGot = true;
				if (record.value == "")
					output ~= getIndent(1) ~ "string " ~ transformName(record.name) ~ ";\n";
				else
					output ~= getIndent(1) ~ "string " ~ transformName(record.name) ~ " = \"" ~ record.value ~ "\";\n";
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
		output ~= getIndent(1) ~ "void validate" ~ transformName(entry.name) ~ "() {\n";
		validateFuncs ~= getIndent(1) ~ "validate" ~ transformName(entry.name) ~ "();\n";
		foreach(record; entry.records) {
			if (record.type != "" && record.name != "FILLER" && record.redefines == "") {
				output ~= validateAgainstNameType(transformName(record.name), record.type, 2);
				output ~= "\n";
			}
		}
		output ~= getIndent(1) ~ "}\n";
	}
	
	if (data.dataDivision.fileSectionEntries.length > 0)
		output ~= "\n";
}

pure void handleWorkingDataDivision(ref DobolProgram data, ref string output, ref string validateFuncs) {
	string[] levelNames;
	size_t[] levelValues;
	string[][string[]] entriesLevelNames;
	string[] entryNames;
	string[] entryTypes;
	
	foreach(i, entry; data.dataDivision.workerStorageSectionEntries) {
		void updateLevels() {
			string[] newLevelNames;
			size_t[] newLevelValues;
			
			if (levelValues.length == 0) {
				newLevelNames ~= entry.name;
				newLevelValues ~= entry.level;
			} else {
				foreach(i, levelValue; levelValues) {
					if (levelValue < entry.level) {
						newLevelValues ~= levelValue;
						newLevelNames ~= levelNames[i];
					} else {
						// >=
						newLevelValues ~= entry.level;
						newLevelNames ~= entry.name;
						break;
					}
				}
			}
			
			levelNames = newLevelNames;
			levelValues = newLevelValues;
		}
		
		if (entry.type != "" && entry.name != "FILLER") {
			if (cast(immutable)levelNames in entriesLevelNames)
				entriesLevelNames[cast(immutable)levelNames] ~= entry.name;
			else {
				entriesLevelNames[cast(immutable)levelNames] = [entry.name];
			}
			entryNames ~= entry.name;
			entryTypes ~= entry.type;
			
			if (entry.redefines == "") {
				if (entry.value == "")
					output ~= "string " ~ transformName(entry.name) ~ ";\n";
				else if (entry.value[0] == '\"' && entry.value[$-1] == '\"')
					output ~= "string " ~ transformName(entry.name) ~ " = " ~ entry.value ~ ";\n";
				else
					output ~= "string " ~ transformName(entry.name) ~ " = \"" ~ entry.value ~ "\";\n";
			} else {
				output ~= "alias " ~ transformName(entry.name) ~ " = " ~ transformName(entry.redefines) ~ ";\n";
			}
		} else if (entry.type == "")
			updateLevels();
	}
	
	if (entriesLevelNames.keys.length > 0)
		output ~= "\n";
	
	foreach(newprop; entriesLevelNames.keys) {
		if (entriesLevelNames[newprop].length == 0) {
			//pragma(msg, entriesLevelNames[newprop], " has no values");
			continue;
		}
		output ~= "@property string " ~ transformName(newprop[$-1]) ~ "() {\n";
		output ~= getIndent(1) ~ "return ";
		
		foreach(prop; entriesLevelNames[newprop]) {
			output ~= transformName(prop) ~ " ~ ";
		}
		output.length -= 3;
		
		output ~="; }\n";
	}
	
	if (entriesLevelNames.keys.length > 0)
		output ~= "\n";
	
	output ~= "void validateWorkingDataDivison() {\n";
	validateFuncs ~= getIndent(1) ~ "validateWorkingDataDivison();\n";
	foreach(i, name; entryNames) {
		output ~= validateAgainstNameType(transformName(name), entryTypes[i], 1);
		output ~= "\n";
	}
	
	if (entryNames.length > 0) {
		output ~= "}\n";
	}
	
	if (data.dataDivision.workerStorageSectionEntries.length > 0)
		output ~= "\n";
}

pure void handleProcedures(ref DobolProgram data, ref string output) {
	foreach(procedure; data.procedureDivision.sections) {
		output ~= "void " ~ transformName(procedure.name) ~ "() {\n";
		
		foreach(statement; procedure.statements) {
			switch(statement.type) {
				case StatementTypes.Display:
					output ~= getIndent(1) ~ "writeln(";
					
					bool isInQuoted;
					
					foreach(i, arg; statement.args.split(" ")) {
						if (arg[0] == '\"' && !isInQuoted)
							isInQuoted = true;
						
						if (isInQuoted) {
							output ~= arg;
						} else {
							output ~= transformName(arg);
						}
						
						if (arg[$-1] == '\"')
							isInQuoted = false;
						else if (isInQuoted)
							output ~= " ";
						
						if (i + 1 < statement.args.split(" ").length && !isInQuoted)
							output ~= " ~ ";
					}
					
					output ~= ");\n";
					break;
				case StatementTypes.Perform:
					// ugh how does statement.perform.untilCondition work?
					output ~= getIndent(1) ~ transformName(statement.perform.funcname[procedure.id.length + 1 .. $]) ~ "();\n";
					break;
				case StatementTypes.Open:
				case StatementTypes.Move:
				case StatementTypes.Read:
				case StatementTypes.Write:
				case StatementTypes.IfCondition:
				case StatementTypes.Multiply:
				case StatementTypes.Add:
				case StatementTypes.Subtract:
				default:
					break;
			}
		}
		
		output ~= "}\n\n";
	}
	
	if (data.procedureDivision.sections.length > 0)
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
	ret ~= getIndent(indentOffset) ~ "assert(" ~ name ~ ".length == " ~ to!string(type.length) ~ ", \"Invalid data for " ~ name ~ " on type " ~ type ~ "\");\n";
	
	bool assumeNextIs9 = false;
	
	//S999
	//X(12)
	//S9(6)V99
	void iterate(char c, ref size_t i) {
		switch(c) {
			case 'S':
				ret ~= getIndent(indentOffset) ~ "assert(" ~ name ~ "[" ~ to!string(i) ~ "] == '-' && " ~ name ~ "[" ~ to!string(i) ~ "] == ' ', \"Invalid data for " ~ name ~ " on type " ~ type ~ "\");\n";
				i++;
				assumeNextIs9 = true;
				goto case '9';
			case '9':
				// must be a number
				ret ~= getIndent(indentOffset) ~ "assert((cast(ubyte)(" ~ name ~ "[" ~ to!string(i) ~ "])) >= cast(ubyte)'0' && (cast(ubyte)(" ~ name ~ "[" ~ to!string(i) ~ "])) <= cast(ubyte)'9', \"Invalid data for " ~ name ~ " on type " ~ type ~ "\");\n";
				break;
			case 'V':
				// must be a dot
				ret ~= getIndent(indentOffset) ~ "assert(" ~ name ~ "[" ~ to!string(i) ~ "] == '.');\n";
				break;
			case '.':
			case 'X':
				// can be anything
				// so do nothing
				break;
			case 'Z':
				// can be a letter
				ret ~= getIndent(indentOffset) ~ "assert(((cast(ubyte)(" ~ name ~ "[" ~ to!string(i) ~ "])) >= cast(ubyte)'A' && (cast(ubyte)(" ~ name ~ "[" ~ to!string(i) ~ "])) <= cast(ubyte)'Z') || ((cast(ubyte)(" ~ name ~ "[" ~ to!string(i) ~ "])) >= cast(ubyte)'a' && (cast(ubyte)(" ~ name ~ "[" ~ to!string(i) ~ "])) <= cast(ubyte)'z'), \"Invalid data for " ~ name ~ " on type " ~ type ~ "\");\n";
				break;
			default:
				break;
		}
	}
	
	bool isBracketed;
	char lastFromBracketed;
	char last;
	string lengthFromBracketedText;
	bool wasBracketed;
	size_t index;
	
	foreach(c; type) {
		if (assumeNextIs9) {
			assert(c == '9', "S can only be procedded by a 9");
			assumeNextIs9 = false;
		}
		if (isBracketed) {
			if (c == ')') {
				isBracketed = false;
				wasBracketed = true;
			} else
				lengthFromBracketedText ~= c;
		} else if (c == '(') {
			isBracketed = true;
			lengthFromBracketedText = "";
			lastFromBracketed = last;
		} else if (wasBracketed) {
			for (size_t i = 0; i < to!size_t(lengthFromBracketedText); i++) {
				iterate(lastFromBracketed, index);
				index++;
			}
		} else {
			iterate(c, index);
			index++;
		}
		
		if (c != '(' && c != ')')
			last = c;
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
	
	pure string[] split(string text, string[] delimaters...) {
		string[] ret;
		ptrdiff_t i;
		while((i = min(text.indexOfs(delimaters))) >= 0) {
			ret ~= text[0 .. i];
			text = text[i + lengthOfIndex(text, i, delimaters) .. $];
		}
		if (text.length > 0) {
			ret ~= text;	
		}
		return ret;
	}
	
	unittest {
		string test = "abcd|efgh|ijkl";
		assert(test.split("|") == ["abcd", "efgh", "ijkl"]);
		string test2 = "abcd||efgh||ijkl";
		assert(test2.split("||") == ["abcd", "efgh", "ijkl"]);
	}
	
	pure size_t[] indexOfs(string text, string[] delimiters) {
		size_t[] ret;
		
		foreach(delimiter; delimiters) {
			ret ~= text.indexOf(delimiter);
		}
		
		return ret;
	}
	
	pure size_t lengthOfIndex(string text, size_t index, string[] delimiters) {
		foreach(delimiter; delimiters) {
			if (text.indexOf(delimiter) == index) return delimiter.length;
		}
		assert(0);
	}
	
	pure size_t min(size_t[] nums...) {
		size_t ret = size_t.max;
		
		foreach(i; nums) {
			if (i < ret) {
				ret = i;
			}
		}
		
		return ret;
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