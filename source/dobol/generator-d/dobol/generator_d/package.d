module dobol.generator_d;
public import dobol.generator_d.defs;
import dobol.parser.defs;

void main() {
	DobolProgram program = DobolProgram(import("pay9.cbl"));
	parseDobol(program);
	string text = generatedDcode(program);
	
	debug {
		import std.stdio;
		writeln(text);
	}
}