module dobol.parser.handler;
import dobol.parser.defs;
import std.string : toLower, indexOf, strip;

class SkeletalDefinition {
	SkeletalDefinition previous;
	SkeletalDefinition next;
	
	string text;
	
	pure this(string text) {
		this.text = text;
	}
	
	pure this(string text, SkeletalDefinition next) {
		this.text = text;
		this.next = next;
	}
}

pure void handleDobolParsing(ref DobolProgram data) {
	string[] text = data.text
		.removeComments()
			.replace("\r\n", " ").replace("\n\r", " ")
			.replace("\n", " ").replace("\r", " ")
			.split(" ").notEmptyElements();
	
	SkeletalDefinition[] definitions;
	
	string preFinish;
	bool inQuotes;
	foreach(entry; text) {
		if (entry[0] == '"')
			inQuotes = true;
		if (entry[$-1] == '"')
			inQuotes = false;
		
		if (preFinish.length > 0)
			preFinish ~= " ";
		if (entry[$-1] == '.' && (!inQuotes || entry[$-2 .. $] == "\".")) {
			inQuotes = false;
			preFinish ~= entry[0 .. $-1];
			if (definitions.length > 0) {
				definitions ~= new SkeletalDefinition(preFinish, definitions[$-1]);
				if (definitions.length > 1)
					definitions[$-2].next = definitions[$-1];
			} else
				definitions ~= new SkeletalDefinition(preFinish);
			preFinish = "";
		} else {
			preFinish ~= entry;
		}
	}
	
	parseDobolSkeleton(data, definitions);
}

enum ParseSkeletonStages : size_t {
	Error,
	Start,
	ProgramId,
	ProgramInfo,
	ProgramInfoAuthor,
	ProgramInfoInstallation,
	ProgramInfoDateWritten,
	ProgramInfoDateCompiled,
	ProgramInfoSecurity,
	EnvironmentDivision,
	EnvironmentDivisionConfigurationSection,
	EnvironmentDivisionConfigurationSectionSourceComputer,
	EnvironmentDivisionConfigurationSectionObjectComputer,
	EnvironmentDivisionConfigurationSectionSpecialNames,
	EnvironmentDivisionInputOutputSection,
	EnvironmentDivisionInputOutputSectionFileControl,
	DataDivision,
	DataDivisionFileSection,
	DataDivisionWorkingStorageSection,
	ProcedureDivision,
	ProcedureDivisionSection
}

pure void parseDobolSkeleton(ref DobolProgram data, SkeletalDefinition[] definitions) {
	size_t stage = ParseSkeletonStages.Start;
	
	foreach(def; definitions) {
		string deft = def.text;
		string deftl = def.text.toLower();
		string[] lineA = deft.split(" ");
		string[] lineAl = deftl.split(" ");
		
		switch(stage) {
			case ParseSkeletonStages.Start:
				if (deftl == "program-id")
					stage = ParseSkeletonStages.ProgramId;
				else if (deftl == "identification division") {}
				else if (deftl == "environment division")
					stage = ParseSkeletonStages.EnvironmentDivision;
				else if (deftl == "data division")
					stage = ParseSkeletonStages.DataDivision;
				else if (deftl == "procedure division")
					stage = ParseSkeletonStages.ProcedureDivision;
				else
					goto case ParseSkeletonStages.Error;
				break;
			case ParseSkeletonStages.ProgramId:
				data.id = deft;
				stage++;
				break;
				
			case ParseSkeletonStages.ProgramInfo:
				if (deftl == "author")
					stage = ParseSkeletonStages.ProgramInfoAuthor;
				else if (deftl == "installation")
					stage = ParseSkeletonStages.ProgramInfoInstallation;
				else if (deftl == "date-written")
					stage = ParseSkeletonStages.ProgramInfoDateWritten;
				else if (deftl == "date-compiled")
					stage = ParseSkeletonStages.ProgramInfoDateCompiled;
				else if (deftl == "security")
					stage = ParseSkeletonStages.ProgramInfoSecurity;
				else goto case ParseSkeletonStages.Start;
				
				break;
			case ParseSkeletonStages.ProgramInfoAuthor:
				data.author = deft;
				stage = ParseSkeletonStages.ProgramInfo;
				break;
			case ParseSkeletonStages.ProgramInfoInstallation:
				data.installation = deft;
				stage = ParseSkeletonStages.ProgramInfo;
				break;
			case ParseSkeletonStages.ProgramInfoDateWritten:
				data.date_written = deft;
				stage = ParseSkeletonStages.ProgramInfo;
				break;
			case ParseSkeletonStages.ProgramInfoDateCompiled:
				data.date_compiled = deft;
				stage = ParseSkeletonStages.ProgramInfo;
				break;
			case ParseSkeletonStages.ProgramInfoSecurity:
				data.security = deft;
				stage = ParseSkeletonStages.ProgramInfo;
				break;
				
			case ParseSkeletonStages.EnvironmentDivision:
				if (deftl == "configuration section")
					stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSection;
				else if (deftl == "input-output section")
					stage = ParseSkeletonStages.EnvironmentDivisionInputOutputSection;
				else
					goto case ParseSkeletonStages.Start;
				break;
				
			case ParseSkeletonStages.EnvironmentDivisionConfigurationSection:
				if (deftl == "source-computer")
					stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSectionSourceComputer;
				else if (deftl == "object-computer")
					stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSectionObjectComputer;
				else if (deftl == "special-names")
					stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSectionSpecialNames;
				else
					goto case ParseSkeletonStages.EnvironmentDivision;
				break;
			case ParseSkeletonStages.EnvironmentDivisionConfigurationSectionSourceComputer:
				data.environmentDivision.source_computer = deft;
				stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSection;
				break;
			case ParseSkeletonStages.EnvironmentDivisionConfigurationSectionObjectComputer:
				data.environmentDivision.object_computer = deft;
				stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSection;
				break;
				
			case ParseSkeletonStages.EnvironmentDivisionConfigurationSectionSpecialNames:
				// we're only supporting it of the syntax:
				// C01 IS mnemonic
				// ..
				// C012
				
				if (lineAl.length == 3) {
					if (lineAl[1] == "is") {
						data.environmentDivision.specialNames ~= SpecialName(lineA[2], lineA[0]);
					}
				}
				
				stage = ParseSkeletonStages.EnvironmentDivisionConfigurationSection;
				break;
				
			case ParseSkeletonStages.EnvironmentDivisionInputOutputSection:
				if (deftl == "file-control") 
					stage = ParseSkeletonStages.EnvironmentDivisionInputOutputSectionFileControl;
				else
					goto case ParseSkeletonStages.EnvironmentDivision;
				break;
			case ParseSkeletonStages.EnvironmentDivisionInputOutputSectionFileControl:
				if (lineA.length > 4) {
					if (lineAl[0] == "select" && lineAl[2] == "assign" && lineAl[3] == "to") {
						FileControlEntry entry = FileControlEntry(lineA[1]);
						
						bool hasAssignTo = true;
						switch(lineAl[4]) {
							case "printer":
								entry.assignTo = FileControlAssignTo.Printer;
								break;
							default:
								hasAssignTo = false;
								entry.assignTo = FileControlAssignTo.Disk;
								break;
						}
						if (hasAssignTo) {
							lineA = lineA[0 .. 4] ~ lineA[5 .. $];
							lineAl = lineAl[0 .. 4] ~ lineAl[5 .. $];
						}
						
						if (lineA[4].length > 1) {
							if (lineA[4][0] == '"')
								lineA[4] = lineA[4][1 .. $];
							if (lineA[4][$-1] == '"')
								lineA[4] = lineA[4][0 .. $-1];
							entry.assignToFileName = lineA[4];
						}
						
						data.environmentDivision.fileControlEntries ~= entry;
					} else {
						goto case ParseSkeletonStages.EnvironmentDivisionInputOutputSection;
					}
				} else {
					goto case ParseSkeletonStages.EnvironmentDivisionInputOutputSection;
				}
				break;
				
			case ParseSkeletonStages.DataDivision:
				if (deftl == "file section")
					stage = ParseSkeletonStages.DataDivisionFileSection;
				else if (deftl == "working-storage section")
					stage = ParseSkeletonStages.DataDivisionWorkingStorageSection;
				else
					goto case ParseSkeletonStages.Start;
				break;
			case ParseSkeletonStages.DataDivisionFileSection:
				if (lineA.length > 1) {
					if (lineAl[0] == "fd") {
						data.dataDivision.fileSectionEntries ~= FileSectionEntry(lineA[1]);
						
						if (lineA.length > 4) {
							if (lineAl[2] == "label" && lineAl[3] == "records" && lineAl[4] == "standard") {
								data.dataDivision.fileSectionEntries[$-1].isStandard = true;
							}
						}
					} else {
						try {
							size_t value = to!size_t(lineA[0]);
						} catch (Exception e) {
							goto case ParseSkeletonStages.DataDivision;
						}
						
						FileSectionRecordEntry entry = FileSectionRecordEntry(to!size_t(lineA[0]), lineA[1]);
						
						if (lineA.length > 3) {
							if(lineAl[2] == "pic") {
								entry.type = lineA[3];
							}
							
							if (lineA.length > 4) {
								if (lineAl[4] == "redefines") {
									entry.redefines = lineAl[5];
								} else if (lineAl[4] == "comp") {
									entry.isComp = true;
								}
							}
							
							if (lineA.length > 6) {
								if (lineAl[4] == "blank" && lineAl[5] == "when" && lineAl[6] == "zero") {
									entry.blankWhenZero = true;
								}
							}
							
							if (lineA.length > 5) {
								if (lineAl[4] == "value") {
									
									foreach(v; lineA[5 .. $]) {
										entry.value ~= v ~ " ";
									}
									if (entry.value.length > 0)
										entry.value.length--;
								}
							}
						}
						
						if (data.dataDivision.fileSectionEntries.length > 0)
							data.dataDivision.fileSectionEntries[$-1].records ~= entry;
						else
							assert(0, "Cannot have a file section record without a FD label");
					}
				} else {
					goto case ParseSkeletonStages.DataDivision;
				}
				
				break;
			case ParseSkeletonStages.DataDivisionWorkingStorageSection:
				try {
					size_t value = to!size_t(lineA[0]);
				} catch (Exception e) {
					goto case ParseSkeletonStages.DataDivision;
				}
				
				FileSectionRecordEntry entry = FileSectionRecordEntry(to!size_t(lineA[0]), lineA[1]);
				
				if (lineA.length > 3) {
					if(lineAl[2] == "pic") {
						entry.type = lineA[3];
					}
					
					if (lineA.length > 4) {
						if (lineAl[4] == "redefines") {
							entry.redefines = lineAl[5];
						} else if (lineAl[4] == "comp") {
							entry.isComp = true;
						}
					}
					
					if (lineA.length > 6) {
						if (lineAl[4] == "blank" && lineAl[5] == "when" && lineAl[6] == "zero") {
							entry.blankWhenZero = true;
						}
					}
					
					if (lineA.length > 5) {
						if (lineAl[4] == "value") {
							
							foreach(v; lineA[5 .. $]) {
								entry.value ~= v ~ " ";
							}
							if (entry.value.length > 0)
								entry.value.length--;
						}
					}
				}
				
				data.dataDivision.workerStorageSectionEntries ~= entry;
				break;
				
			case ParseSkeletonStages.ProcedureDivision:
				if (lineA.length > 1) {
					if (lineAl[1] == "section") {
						stage = ParseSkeletonStages.ProcedureDivisionSection;
						string[] nameValues = lineA[0].split("-");
						data.procedureDivision.sections ~= ProcedureDivisionSection(nameValues[0], lineA[0][nameValues[0].length + 1 .. $]);
					} else {
						goto case ParseSkeletonStages.Start;
					}
				} else {
					goto case ParseSkeletonStages.Start;
				}
				break;
				
			case ParseSkeletonStages.ProcedureDivisionSection:
				if (data.procedureDivision.sections.length > 0) {
					auto procedure = data.procedureDivision.sections[$-1];
					
					if (lineA.length == 1) {
						if (deft.length > procedure.id.length) {
							if (deftl[0 .. procedure.id.length] == procedure.id.toLower()) {
								// ignore
								break;
							}
						}
						
						ProcedureDivisionStatement statement = new ProcedureDivisionStatement();
						
						switch(lineAl[0]) {
							case "stop-run":
								statement.functionType = DobolFunctions.StopRun;
								break;
							case "exit":
								statement.functionType = DobolFunctions.Exit;
								break;
							default:
								break;
						}
						
						if (statement.functionType == DobolFunctions.Unknown) {
							goto case ParseSkeletonStages.ProcedureDivision;
						}
						
						data.procedureDivision.sections[$-1].statements ~= statement;
						
					} else if (lineA.length > 1) {
						if (lineAl[1] == "section") {
							goto case ParseSkeletonStages.ProcedureDivision;
						}
						
						ProcedureDivisionStatement handleStatementGet(string op, string text) {
							ProcedureDivisionStatement statement = new ProcedureDivisionStatement();
							
							switch(op) {
								case "display":
									statement.functionType = DobolFunctions.Display;
									statement.args = text["display ".length .. $];
									break;
								case "perform":
									statement.functionType = DobolFunctions.Perform;
									statement.args = text["perform ".length .. $];
									break;
								case "open":
									statement.functionType = DobolFunctions.Open;
									statement.args = text["open ".length .. $];
									break;
								case "move":
									statement.functionType = DobolFunctions.Move;
									statement.args = text["move ".length .. $];
									break;
								case "read":
									statement.functionType = DobolFunctions.Read;
									statement.args = text["read ".length .. $];
									break;
								case "write":
									statement.functionType = DobolFunctions.Write;
									statement.args = text["write ".length .. $];
									break;
								case "add":
									statement.functionType = DobolFunctions.Add;
									statement.args = text["add ".length .. $];
									break;
								case "close":
									statement.functionType = DobolFunctions.Close;
									statement.args = text["close ".length .. $];
									break;
								case "subtract":
									statement.functionType = DobolFunctions.Subtract;
									statement.args = text["subtract ".length .. $];
									break;
								case "if":
									statement.functionType = DobolFunctions.IfCondition;
									
									string args;
									string conditionStatement;
									bool gotVerb = false;
									foreach(word; text["if ".length + 1 .. $].split(" ")) {
										if (isVerb(word.toLower()))
											gotVerb = true;
										if (gotVerb)
											conditionStatement ~= word ~ " ";
										else
											args ~= word ~ " ";
									}
									args.length--;
									
									statement.args = args;
									
									string temp = conditionStatement;
									
									string elseStatement;
									bool gotElse = false;
									conditionStatement = "";
									foreach_reverse(word; temp.split(" ")) {
										if (word.toLower() == "else")
											gotElse = true;
										
										if(gotElse)
											conditionStatement = word ~ " " ~ conditionStatement;
										else
											elseStatement = word ~ " " ~ elseStatement;
									}
									
									if (conditionStatement == "") {
										conditionStatement = elseStatement;
										elseStatement = "";
									}
									
									if (conditionStatement.length > 0)
										conditionStatement.length--;
									if (elseStatement.length > 0)
										elseStatement.length--;
									
									string[] temp2 = conditionStatement.split(" ");
									statement.conditionStatement = handleStatementGet(temp2[0].toLower(), conditionStatement);
									
									if (elseStatement != "") {
										temp2 = elseStatement.split(" ");
										statement.elseStatement = handleStatementGet(temp2[0].toLower(), elseStatement);
									}
									
									break;
								case "multiply":
									statement.functionType = DobolFunctions.Multiply;
									statement.args = text["multiply ".length .. $];
									break;
								default:
									break;
							}
							
							return statement;
						}
						
						data.procedureDivision.sections[$-1].statements ~= handleStatementGet(lineAl[0], deft);
					}
					
				} else {
					goto case ParseSkeletonStages.ProcedureDivision;
				}
				break;
				
			case ParseSkeletonStages.Error:
				debug {
					import std.stdio;
					writeln(def.text);
				}
				//assert(0);
				break;
				
			default:
				debug {
					import std.stdio;
					writeln(def.text);
				}
				break;
		}
	}
}

private {
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
	
	pure string[] notEmptyElements(string[] elements) {
		string[] ret;
		
		foreach(e; elements) {
			e = e.strip();
			if (e != "")
				ret ~= e;
		}
		
		return ret;
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
	
	pure string removeComments(string text) {
		string ret;
		
	L1: foreach(line; text.split("\r\n", "\n\r", "\n", "\r")) {
			string[] lineA = line.strip().split(" ");
			foreach (l; lineA) {
				if (l == "*")
					continue L1;
				else
					ret ~= l ~ " ";
			}
			
			if (ret[$-1] == ' ')
				ret.length--;
			
			ret ~= "\n";
		}
		
		return ret;
	}
	
	pure bool isVerb(string text) {
		switch(text) {
			case "multiply":
			case "if":
			case "close":
			case "subtract":
			case "add":
			case "write":
			case "read":
			case "move":
			case "open":
			case "perform":
			case "display":
			case "exit":
			case "stop-run":
				return true;
				
			default:
				return false;
		}
	}
}