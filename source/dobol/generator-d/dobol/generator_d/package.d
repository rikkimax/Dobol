module dobol.generator_d;
public import dobol.generator_d.defs;
import dobol.parser.defs;

void main() {
	debug {
		import std.stdio;
		writeln(test());
	}
	
	MAIN_LINE();
}

pure string test() {
	DobolProgram program = DobolProgram(import("pay9.cbl"));
	parseDobol(program);
	string text = generatedDcode(program);
	return text;
}

mixin(test());