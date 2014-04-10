module dobol.parser;
import dobol.parser.defs;
import std.stdio;

void main() {
	auto data = DobolProgram(import("pay9.cbl"));
	parseDobol(data);
	writeln(data.toString());
}