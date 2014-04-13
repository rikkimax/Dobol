module dobol.parser.defs;
import dobol.parser.handler;
public import dobol.parser.handler : parseDobol = handleDobolParsing;
import std.conv : to;

struct DobolProgram {
	string text;
	
	string id;
	string author;
	string installation;
	string date_written;
	string date_compiled;
	string security;
	
	DobolEnvironmentDivison environmentDivision;
	DataDivision dataDivision;
	ProcedureDivision procedureDivision;
	
	string toString(size_t indent = 0) {
		string ret;
		
		ret ~= getIndent(indent) ~ "id: " ~ id ~ "\n";
		ret ~= getIndent(indent) ~ "author: " ~ author ~ "\n";
		ret ~= getIndent(indent) ~ "installation: " ~ installation ~ "\n";
		ret ~= getIndent(indent) ~ "date_written: " ~ date_written ~ "\n";
		ret ~= getIndent(indent) ~ "date_compiled: " ~ date_compiled ~ "\n";
		ret ~= getIndent(indent) ~ "security: " ~ security ~ "\n";
		
		ret ~= getIndent(indent) ~ "Environment Division: {\n";
		ret ~= environmentDivision.toString(indent + 1);
		ret ~= getIndent(indent) ~ "}\n";
		
		ret ~= getIndent(indent) ~ "Data Division: {\n";
		ret ~= dataDivision.toString(indent + 1);
		ret ~= getIndent(indent) ~ "}\n";
		
		ret ~= getIndent(indent) ~ "Procedure Division: {\n";
		ret ~= procedureDivision.toString(indent + 1);
		ret ~= getIndent(indent) ~ "}\n";
		
		return ret;
	}
}

struct DobolEnvironmentDivison {
	string source_computer;
	string object_computer;
	SpecialName[] specialNames;
	FileControlEntry[] fileControlEntries;
	
	string toString(size_t indent = 0) {
		string ret;
		ret ~= getIndent(indent) ~ "source-computer: " ~ source_computer ~ "\n";
		ret ~= getIndent(indent) ~ "object-computer: " ~ source_computer ~ "\n";
		
		ret ~= getIndent(indent) ~ "Special-Names {\n";
		foreach(entry; specialNames) {
			ret ~= getIndent(indent + 1) ~ entry.name ~ " = " ~ entry.value ~ "\n";
		}
		ret ~= getIndent(indent) ~ "}\n";
		
		ret ~= getIndent(indent) ~ "File-Control {\n";
		foreach(entry; fileControlEntries) {
			ret ~= entry.toString(indent + 1);
		}
		ret ~= getIndent(indent) ~ "}\n";
		
		return ret;
	}
}

struct SpecialName {
	string name;
	string value;
}

enum FileControlAssignTo {
	Disk,
	Port,
	Printer,
	Reader,
	Remote,
	Tape,
	Virtual
}

/**
 * Sooo not complete.
 */
struct FileControlEntry {
	string name;
	FileControlAssignTo assignTo;
	string assignToFileName;
	
	string toString(size_t indent = 0) {
		string ret;
		ret ~= getIndent(indent) ~ name ~ " = " ~ (to!string(assignTo)) ~ " " ~ assignToFileName ~ "\n";
		return ret;
	}
}

struct DataDivision {
	FileSectionEntry[] fileSectionEntries;
	FileSectionRecordEntry[]  workerStorageSectionEntries;
	
	string toString(size_t indent = 0) {
		string ret;
		
		ret ~= getIndent(indent) ~ "File Section: {\n";
		foreach(entry; fileSectionEntries) {
			ret ~= entry.toString(indent + 1);
		}
		ret ~= getIndent(indent) ~ "}\n";
		
		ret ~= getIndent(indent) ~ "Worker Storage Section: {\n";
		foreach(entry; workerStorageSectionEntries) {
			ret ~= entry.toString(indent + 1);
		}
		ret ~= getIndent(indent) ~ "}\n";
		
		return ret;
	}
}

struct FileSectionEntry {
	string name;
	
	bool isStandard;
	FileSectionRecordEntry[] records;
	
	string toString(size_t indent = 0) {
		string ret;
		
		ret ~= getIndent(indent) ~ name ~ " " ~ (isStandard ? "= standard " : "") ~ "{\n";
		foreach(record; records) {
			ret ~= record.toString(indent + 1);
		}
		ret ~= getIndent(indent) ~ "}\n";
		
		return ret;
	}
	
	pure FileSectionRecordEntry[] filterOnNameLevel(string name) {
		FileSectionRecordEntry[] ret;
		
		bool got;
		size_t level;
		
		foreach(record; records) {
			if (got) {
				if (record.level <= level) break;
				ret ~= record;
			} else if (record.name == name) {
				got = true;
				level = record.level;
			}
		}
		
		return ret;
	}
}

struct FileSectionRecordEntry {
	size_t level;
	string name;
	string type;
	
	bool blankWhenZero;
	string redefines;
	bool isComp;
	string value;
	
	string toString(size_t indent = 0) {
		string ret;
		ret ~= getIndent(indent) ~ "level " ~ to!string(level) ~ " " ~ name ~ " " ~ type ~ (blankWhenZero ? " blank when zero" : "") ~ (redefines == "" ? "" : " redefines " ~ redefines) ~ (isComp ? " is comp type" : "");
		if (value.length > 0) {
			ret ~= " {\n";
			ret ~= getIndent(indent + 1) ~ value ~ "\n";
			ret ~= getIndent(indent) ~ "}\n";
		} else {
			ret ~= "\n";
		}
		return ret;
	}
}

struct ProcedureDivision {
	ProcedureDivisionSection[] sections;
	
	string toString(size_t indent = 0) {
		string ret;
		foreach(entry; sections) {
			ret ~= entry.toString(indent);
		}
		return ret;
	}
}

struct ProcedureDivisionSection {
	string id;
	string name;
	bool isStop;
	
	ProcedureDivisionStatement[] statements;
	
	string toString(size_t indent = 0) {
		string ret;
		ret ~= getIndent(indent) ~ id ~ " : " ~ name ~ " {\n";
		foreach(entry; statements) {
			ret ~= entry.toString(indent + 1);
		}
		ret ~= getIndent(indent) ~ "}\n";
		return ret;
	}
}

enum StatementTypes {
	Unknown,
	Exit,
	StopRun,
	Display,
	Perform,
	Open,
	Move,
	Read,
	Write,
	Add,
	Close,
	Subtract,
	IfCondition,
	Multiply,
	Endif
}

class ProcedureDivisionStatement {
	StatementTypes type;
	string args;
	
	ProcedureDivisionStatement previousCondition;
	ProcedureDivisionStatement[] conditionStatement;
	ProcedureDivisionStatement[] elseStatement;
	
	union {
		OpenStatement open;
		PerformStatement perform;
		MoveStatement move;
		ReadStatement read;
		WriteStatement write;
		AddStatement add;
		SubtractStatement subtract;
		MultiplyStatement multiply;
	}
	
	string toString(size_t indent = 0) {
		string ret;
		if (type != StatementTypes.Endif) {
			ret ~= getIndent(indent) ~ to!string(type);
			
			if (args.length > 0) {
				ret ~= " args {\n";
				ret ~= getIndent(indent + 1) ~ args ~ "\n";
				ret ~= getIndent(indent) ~ "}";
			}
			
			if (conditionStatement !is null) {
				ret ~= " condition {\n";
				foreach(s; conditionStatement) {
					ret ~= s.toString(indent + 1);
				}
				ret ~= getIndent(indent) ~ "}";
			}
			
			if (elseStatement !is null) {
				ret ~= " else {\n";
				foreach(s; elseStatement) {
					ret ~= s.toString(indent + 1);
				}
				ret ~= getIndent(indent) ~ "}";
			}
			
			ret ~= "\n";
		}
		return ret;
	}
}

struct OpenStatement {
	string filename; 
	
	bool isInput;
	bool isOutput;
}

struct PerformStatement {
	string funcname;
	
	string untilCondition;
}

struct MoveStatement {
	string fromval;
	string toval;
}

struct ReadStatement {
	string toval;
	
	bool hasOnEnd;
	ProcedureDivisionStatement onEnd;
}

struct WriteStatement {
	string fromval;
	string afterVal;
}

struct AddStatement {
	string fromval;
	string toval;
}

struct SubtractStatement {
	string fromval;
	string toval;
	string givingval;
}

struct MultiplyStatement {
	string fromval;
	string byval;
	string givingval;
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