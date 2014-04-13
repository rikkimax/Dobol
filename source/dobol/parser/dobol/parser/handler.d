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
	string procedureText;
	
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
									entry.redefines = lineA[5];
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
						procedureText = "";
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
						if (deft.length == procedure.id.length + "-stop".length && deftl[0 .. procedure.id.length + "-stop".length] == procedure.id.toLower() ~ "-stop") {
							handleProcedureParsing(data, procedureText);
						} else if (deft.length == procedure.id.length + "-exit".length && deftl[0 .. procedure.id.length + "-exit".length] == procedure.id.toLower() ~ "-exit") {
							handleProcedureParsing(data, procedureText);
						} else if (deft.length > procedure.id.length && deftl[0 .. procedure.id.length] == procedure.id.toLower()) {
							//ignore
							procedureText ~= deft ~ "\n";
						}
						
					} else if (lineA.length == 2) {
						if (lineAl[1] == "section") {
							if (procedureText.length > deft.length)
								handleProcedureParsing(data, procedureText);
							goto case ParseSkeletonStages.ProcedureDivision;
						} else {
							procedureText ~= deft ~ "\n";
						}
					} else {
						procedureText ~= deft ~ "\n";
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

pure void handleProcedureParsing(ref DobolProgram data, string text) {
	string[] lines = breakIntoVerbs(text
	                                .replace("\r\n", " ").replace("\n\r", " ")
	                                .replace("\n", " ").replace("\r", " ")
	                                ).notEmptyElements();
	
	ProcedureDivisionStatement currentCondition;
	bool trueConditionStage;
	
	ProcedureDivisionStatement readStatement;
	
	ProcedureDivisionSection procedureDivision = data.procedureDivision.sections[$-1];
	
	void addStatement(ProcedureDivisionStatement statement) {
		if (statement.type == StatementTypes.IfCondition) {
			if (currentCondition is null) {
				currentCondition = statement;
				data.procedureDivision.sections[$-1].statements ~= statement;
				trueConditionStage = true;
			} else {
				if (trueConditionStage) {
					currentCondition.conditionStatement ~= statement;
				} else {
					currentCondition.elseStatement ~= statement;
				}
				currentCondition = statement;
				trueConditionStage = true;
			}
			
			return;
		} else if (statement.type == StatementTypes.Unknown) {
			return;
		}
		
		if (readStatement !is null) {
			readStatement.read.onEnd = statement;
			readStatement = null;
		} else if (currentCondition is null) {
			data.procedureDivision.sections[$-1].statements ~= statement;
		} else {
			if (trueConditionStage) {
				currentCondition.conditionStatement ~= statement;
			} else {
				currentCondition.elseStatement ~= statement;
			}
		}
		
		if (statement.type == StatementTypes.Read) {
			if (statement.read.hasOnEnd)
				readStatement = statement;
		}
	}
	
	foreach(i, deft; lines) {
		string deftl = deft.toLower();
		string[] lineA = deft.split(" ");
		string[] lineAl = deftl.split(" ");
		
		if (i == 0) {
			if (!isVerb(lineA[0])) {
				continue;
			}
		}
		
		ProcedureDivisionStatement statement = new ProcedureDivisionStatement();
		statement.previousCondition = currentCondition;
		
		if (lineA.length > 0) {
			bool nothing;
			bool removeFirstArg;
			
			if (lineAl[0] == "exit") {
				statement.type = StatementTypes.Exit;	
			} else if (lineAl[0] == "stop-run") {
				statement.type = StatementTypes.StopRun;
			} else if (lineAl[0] == "end-if") {
				statement.type = StatementTypes.Endif;
				if (currentCondition !is null) {
					currentCondition = currentCondition.previousCondition;
				}
			} else if (lineAl[0] == "else") {
				trueConditionStage = false;
				continue;
			} else if (lineA[0].length > procedureDivision.id.length && lineA[0][0 .. procedureDivision.id.length] == procedureDivision.id) {
				removeFirstArg = true;
				nothing = true;
			} else {
				nothing = true;
			}
			
			if (!nothing) {
				addStatement(statement);
				if (lineA.length > 1) {
					statement = new ProcedureDivisionStatement();
					statement.previousCondition = currentCondition;
				} else {
					continue;
				}
			}
			
			if (removeFirstArg || !nothing) {
				deft = deft[(lineA[0].length + 1) .. $];
				deftl = deftl[(lineA[0].length + 1) .. $];
				lineA = lineA[1 .. $];
				lineAl = lineAl[1 .. $];
			}
		}
		
		if (lineA.length == 2) {
			if (lineAl[1] == "section") {
				continue;
			}
		} else if (lineA.length == 3) {
			if (lineA[0].length > procedureDivision.id.length && lineA[0][0 .. procedureDivision.id.length] == procedureDivision.id && lineAl[2] == "section") {
				continue;
			}
		}
		
		if (lineA.length > 1) {
			switch(lineAl[0]) {
				case "display":
					statement.type = StatementTypes.Display;
					statement.args = deft["display ".length .. $];
					break;
				case "perform":
					statement.type = StatementTypes.Perform;
					handlePerformStatement(statement, deft);
					break;
				case "open":
					statement.type = StatementTypes.Open;
					handleOpenStatement(statement, deft);
					break;
				case "move":
					statement.type = StatementTypes.Move;
					handleMoveStatement(statement, deft);
					break;
				case "read":
					statement.type = StatementTypes.Read;
					handleReadStatement(statement, deft);
					break;
				case "write":
					statement.type = StatementTypes.Write;
					handleWriteStatement(statement, deft);
					break;
				case "add":
					statement.type = StatementTypes.Add;
					handleAddStatement(statement, deft);
					break;
				case "close":
					statement.type = StatementTypes.Close;
					statement.args = deft["close ".length .. $];
					break;
				case "subtract":
					statement.type = StatementTypes.Subtract;
					handleSubtractStatement(statement, deft);
					break;
				case "multiply":
					statement.type = StatementTypes.Multiply;
					handleMultiplyStatement(statement, deft);
					break;
				case "if":
					statement.type = StatementTypes.IfCondition;
					statement.args = deft["if ".length .. $];
					break;
				default:
					debug {
						import std.stdio;
						writeln(deft);
					}
					break;
			}
		}
		
		addStatement(statement);
	}
}

pure void handlePerformStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["peform ".length .. $].strip();
	string[] lineA = statement.args.split(" ").notEmptyElements();
	
	if (lineA.length > 0) {
		statement.perform.funcname = lineA[0];
	}
	
	if (lineA.length == 3) {
		if (lineA[1].toLower() == "until") {
			statement.perform.untilCondition = lineA[2];
		}
	}
}

pure void handleOpenStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["open ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	if (lineA.length == 2) {
		statement.open.filename = lineA[1];
		statement.open.isInput = lineA[0].toLower() == "input";
		statement.open.isOutput = lineA[0].toLower() == "output";
	}
}

pure void handleMoveStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["move ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	if (lineA.length == 3) {
		if (lineA[1].toLower() == "to") {
			statement.move.fromval = lineA[0];
			statement.move.toval = lineA[2];
		}
	}
}

pure void handleReadStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["read ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	
	if (lineA.length > 0) {
		statement.read.toval = lineA[0];
	}
	
	if (lineA.length == 3) {
		statement.read.hasOnEnd = lineA[1].toLower() == "at" && lineA[2].toLower() == "end";
	}
}

pure void handleWriteStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["write ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	
	if (lineA.length > 0) {
		statement.write.fromval = lineA[0];
	}
	
	if (lineA.length == 3) {
		if (lineA[1].toLower() == "after") {
			statement.write.afterVal = lineA[2];
		}
	}
}

pure void handleAddStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["add ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	
	if (lineA.length > 0) {
		statement.add.fromval = lineA[0];
	}
	
	if (lineA.length == 3) {
		if (lineA[1].toLower() == "to") {
			statement.add.toval = lineA[2];
		}
	}
}

pure void handleSubtractStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["subtract ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	
	if (lineA.length > 0) {
		statement.subtract.fromval = lineA[0];
	}
	
	if (lineA.length == 3) {
		if (lineA[1].toLower() == "from") {
			statement.subtract.toval = lineA[2];
		}
	} else if (lineA.length == 5) {
		if (lineA[1].toLower() == "from" && lineA[3].toLower() == "giving") {
			statement.subtract.toval = lineA[2];
			statement.subtract.givingval = lineA[4];
		}
	}
}

pure void handleMultiplyStatement(ProcedureDivisionStatement statement, string text) {
	statement.args = text["multiply ".length .. $];
	string[] lineA = statement.args.split(" ").notEmptyElements();
	
	if (lineA.length > 0) {
		statement.multiply.fromval = lineA[0];
	}
	
	if (lineA.length == 3) {
		if (lineA[1].toLower() == "by") {
			statement.multiply.byval = lineA[2];
		}
	} else if (lineA.length == 5) {
		if (lineA[1].toLower() == "by" && lineA[3].toLower() == "giving") {
			statement.multiply.byval = lineA[2];
			statement.multiply.givingval = lineA[4];
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
			
			if (ret.length > 0 && ret[$-1] == ' ')
				ret.length--;
			
			ret ~= "\n";
		}
		
		return ret;
	}
	
	pure bool isVerb(string text) {
		switch(text) {
			case "end-if":
			case "else":
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
	
	pure string[] breakIntoVerbs(string text) {
		string[] ret;
		string temp;
		
		bool quoted = false;
		
		foreach(word; text.split(" ")) {
			if (word == "") continue;
			if (word.length > 1 && word[0] == '"')
				quoted = true;
			else if (word[0] == '"')
				quoted = !quoted;
			
			if (!quoted && isVerb(word.toLower())) {
				if (temp.length > 0) {
					ret ~= temp[0 .. $-1];
				}
				temp = word ~ " ";
			} else if (word[$-1] == '.') {
				ret ~= temp ~ word;
				temp = "";
			} else {
				temp ~= word ~ " ";
			}
			
			if (word.length > 1 && word[$-1] == '"')
				quoted = false;
			else if (word.length > 2 && word[$-2 .. $] == "\".")
				quoted = false;
		}
		
		if (temp != "")
			ret ~= temp;
		
		return ret;
	}
	
	unittest {
		string text = """
DISPLAY \"PRINT-FIRST-LINE\".
ADD 1 TO WA-PAGE-COUNT.
MOVE WA-PAGE-COUNT TO WC-L2-PAGE-NO.
MOVE WC-LINE2 TO OUTPUT-REC.
WRITE OUTPUT-REC AFTER NEW-PAGE.

IF NOT WB-MORTGAGE-NOT-POSS
   ADD IR-MORTGAGE   TO WG-TOTAL-MORTGAGE.
END-IF."""
			.replace("\r\n", " ").replace("\n\r", " ")
				.replace("\n", " ").replace("\r", " ");
		string[] output = breakIntoVerbs(text);
		
		assert(output[0] == "DISPLAY \"PRINT-FIRST-LINE\".");
		assert(output[1] == "ADD 1 TO WA-PAGE-COUNT.");
		assert(output[2] == "MOVE WA-PAGE-COUNT TO WC-L2-PAGE-NO.");
		assert(output[3] == "MOVE WC-LINE2 TO OUTPUT-REC.");
		assert(output[4] == "WRITE OUTPUT-REC AFTER NEW-PAGE.");
		assert(output[5] == "IF NOT WB-MORTGAGE-NOT-POSS");
		assert(output[6] == "ADD IR-MORTGAGE TO WG-TOTAL-MORTGAGE.");
		assert(output[7] == "END-IF.");
	}
}