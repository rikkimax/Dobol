module dobol.parser;
import dobol.parser.defs;
import std.stdio;

void main() {
	auto data = DobolProgram(import("pay9.cbl"));
	/*auto data = DobolProgram("""
	 IDENTIFICATION DIVISION.
	 PROCEDURE DIVISION.
	 5A-PRINT-FIRST-LINE SECTION.
	 5A-ENTRY.
	 DISPLAY \"PRINT-FIRST-LINE\".
	 ADD 1 TO WA-PAGE-COUNT.
	 MOVE WA-PAGE-COUNT TO WC-L2-PAGE-NO.
	 MOVE WC-LINE2 TO OUTPUT-REC.
	 WRITE OUTPUT-REC AFTER NEW-PAGE.
	 5A-EXIT.
	 EXIT.
	 """);*/
	parseDobol(data);
	writeln(data.toString());
}