```D
import std.stdio : writeln;
/**
 * /------------------------------------------------------------------------------\
 *  Program:            PAY4
 *  Author:             LYDIA
 *  Generated:          Sun Apr 27 03:11:26 2014
 *
 *  Source_Computer:    IBM-PC
 *  Object_Computer:    IBM-PC
 * /------------------------------------------------------------------------------\
 */

alias NEW_PAGE = DobolSystemDevices.C01;

string IR_NUMBER;
string IR_NAME;
string IR_HOURS;
string IR_RATE;
string IR_UNION;
string IR_MORTGAGE;

@property string INPUT_REC() {
    return IR_NUMBER ~ IR_NAME ~ IR_HOURS ~ IR_RATE ~ IR_UNION ~ IR_MORTGAGE; }

void validateINPUT_FILE() {
    assert(IR_NUMBER.length == 4, "Invalid data for IR_NUMBER on type X(6)");

    assert(IR_NAME.length == 5, "Invalid data for IR_NAME on type X(20)");

    assert(IR_HOURS.length == 5, "Invalid data for IR_HOURS on type 99V99");
    assert((cast(ubyte)(IR_HOURS[0])) >= cast(ubyte)'0' && (cast(ubyte)(IR_HOURS[0])) <= cast(ubyte)'9', "Invalid data for IR_HOURS on type 99V99");
    assert((cast(ubyte)(IR_HOURS[1])) >= cast(ubyte)'0' && (cast(ubyte)(IR_HOURS[1])) <= cast(ubyte)'9', "Invalid data for IR_HOURS on type 99V99");
    assert(IR_HOURS[2] == '.');
    assert((cast(ubyte)(IR_HOURS[3])) >= cast(ubyte)'0' && (cast(ubyte)(IR_HOURS[3])) <= cast(ubyte)'9', "Invalid data for IR_HOURS on type 99V99");
    assert((cast(ubyte)(IR_HOURS[4])) >= cast(ubyte)'0' && (cast(ubyte)(IR_HOURS[4])) <= cast(ubyte)'9', "Invalid data for IR_HOURS on type 99V99");

    assert(IR_RATE.length == 5, "Invalid data for IR_RATE on type 99V99");
    assert((cast(ubyte)(IR_RATE[0])) >= cast(ubyte)'0' && (cast(ubyte)(IR_RATE[0])) <= cast(ubyte)'9', "Invalid data for IR_RATE on type 99V99");
    assert((cast(ubyte)(IR_RATE[1])) >= cast(ubyte)'0' && (cast(ubyte)(IR_RATE[1])) <= cast(ubyte)'9', "Invalid data for IR_RATE on type 99V99");
    assert(IR_RATE[2] == '.');
    assert((cast(ubyte)(IR_RATE[3])) >= cast(ubyte)'0' && (cast(ubyte)(IR_RATE[3])) <= cast(ubyte)'9', "Invalid data for IR_RATE on type 99V99");
    assert((cast(ubyte)(IR_RATE[4])) >= cast(ubyte)'0' && (cast(ubyte)(IR_RATE[4])) <= cast(ubyte)'9', "Invalid data for IR_RATE on type 99V99");

    assert(IR_UNION.length == 5, "Invalid data for IR_UNION on type 99V99");
    assert((cast(ubyte)(IR_UNION[0])) >= cast(ubyte)'0' && (cast(ubyte)(IR_UNION[0])) <= cast(ubyte)'9', "Invalid data for IR_UNION on type 99V99");
    assert((cast(ubyte)(IR_UNION[1])) >= cast(ubyte)'0' && (cast(ubyte)(IR_UNION[1])) <= cast(ubyte)'9', "Invalid data for IR_UNION on type 99V99");
    assert(IR_UNION[2] == '.');
    assert((cast(ubyte)(IR_UNION[3])) >= cast(ubyte)'0' && (cast(ubyte)(IR_UNION[3])) <= cast(ubyte)'9', "Invalid data for IR_UNION on type 99V99");
    assert((cast(ubyte)(IR_UNION[4])) >= cast(ubyte)'0' && (cast(ubyte)(IR_UNION[4])) <= cast(ubyte)'9', "Invalid data for IR_UNION on type 99V99");

    assert(IR_MORTGAGE.length == 6, "Invalid data for IR_MORTGAGE on type 999V99");
    assert((cast(ubyte)(IR_MORTGAGE[0])) >= cast(ubyte)'0' && (cast(ubyte)(IR_MORTGAGE[0])) <= cast(ubyte)'9', "Invalid data for IR_MORTGAGE on type 999V99");
    assert((cast(ubyte)(IR_MORTGAGE[1])) >= cast(ubyte)'0' && (cast(ubyte)(IR_MORTGAGE[1])) <= cast(ubyte)'9', "Invalid data for IR_MORTGAGE on type 999V99");
    assert((cast(ubyte)(IR_MORTGAGE[2])) >= cast(ubyte)'0' && (cast(ubyte)(IR_MORTGAGE[2])) <= cast(ubyte)'9', "Invalid data for IR_MORTGAGE on type 999V99");
    assert(IR_MORTGAGE[3] == '.');
    assert((cast(ubyte)(IR_MORTGAGE[4])) >= cast(ubyte)'0' && (cast(ubyte)(IR_MORTGAGE[4])) <= cast(ubyte)'9', "Invalid data for IR_MORTGAGE on type 999V99");
    assert((cast(ubyte)(IR_MORTGAGE[5])) >= cast(ubyte)'0' && (cast(ubyte)(IR_MORTGAGE[5])) <= cast(ubyte)'9', "Invalid data for IR_MORTGAGE on type 999V99");

}
string OR_NUMBER;
string OR_NAME;
string OR_GROSS;
string OR_TAX;
string OR_UNION;
string OR_MORTGAGE;
string OR_NETT;

@property string OUTPUT_REC() {
    return OR_NUMBER ~ OR_NAME ~ OR_GROSS ~ OR_TAX ~ OR_UNION ~ OR_UNION_X ~ OR_MORTGAGE ~ OR_MORTGAGE_X ~ OR_NETT; }

    alias OR_UNION_X = OR_UNION;
    alias OR_MORTGAGE_X = OR_MORTGAGE;

void validateOUTPUT_FILE() {
    assert(OR_NUMBER.length == 4, "Invalid data for OR_NUMBER on type X(6)");

    assert(OR_NAME.length == 5, "Invalid data for OR_NAME on type X(20)");

    assert(OR_GROSS.length == 7, "Invalid data for OR_GROSS on type ZZZ9.99");
    assert(((cast(ubyte)(OR_GROSS[0])) >= cast(ubyte)'A' && (cast(ubyte)(OR_GROSS[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_GROSS[0])) >= cast(ubyte)'a' && (cast(ubyte)(OR_GROSS[0])) <= cast(ubyte)'z'), "Invalid data for OR_GROSS on type ZZZ9.99");
    assert(((cast(ubyte)(OR_GROSS[1])) >= cast(ubyte)'A' && (cast(ubyte)(OR_GROSS[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_GROSS[1])) >= cast(ubyte)'a' && (cast(ubyte)(OR_GROSS[1])) <= cast(ubyte)'z'), "Invalid data for OR_GROSS on type ZZZ9.99");
    assert(((cast(ubyte)(OR_GROSS[2])) >= cast(ubyte)'A' && (cast(ubyte)(OR_GROSS[2])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_GROSS[2])) >= cast(ubyte)'a' && (cast(ubyte)(OR_GROSS[2])) <= cast(ubyte)'z'), "Invalid data for OR_GROSS on type ZZZ9.99");
    assert((cast(ubyte)(OR_GROSS[3])) >= cast(ubyte)'0' && (cast(ubyte)(OR_GROSS[3])) <= cast(ubyte)'9', "Invalid data for OR_GROSS on type ZZZ9.99");
    assert((cast(ubyte)(OR_GROSS[5])) >= cast(ubyte)'0' && (cast(ubyte)(OR_GROSS[5])) <= cast(ubyte)'9', "Invalid data for OR_GROSS on type ZZZ9.99");
    assert((cast(ubyte)(OR_GROSS[6])) >= cast(ubyte)'0' && (cast(ubyte)(OR_GROSS[6])) <= cast(ubyte)'9', "Invalid data for OR_GROSS on type ZZZ9.99");

    assert(OR_TAX.length == 7, "Invalid data for OR_TAX on type ZZZ9.99");
    assert(((cast(ubyte)(OR_TAX[0])) >= cast(ubyte)'A' && (cast(ubyte)(OR_TAX[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_TAX[0])) >= cast(ubyte)'a' && (cast(ubyte)(OR_TAX[0])) <= cast(ubyte)'z'), "Invalid data for OR_TAX on type ZZZ9.99");
    assert(((cast(ubyte)(OR_TAX[1])) >= cast(ubyte)'A' && (cast(ubyte)(OR_TAX[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_TAX[1])) >= cast(ubyte)'a' && (cast(ubyte)(OR_TAX[1])) <= cast(ubyte)'z'), "Invalid data for OR_TAX on type ZZZ9.99");
    assert(((cast(ubyte)(OR_TAX[2])) >= cast(ubyte)'A' && (cast(ubyte)(OR_TAX[2])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_TAX[2])) >= cast(ubyte)'a' && (cast(ubyte)(OR_TAX[2])) <= cast(ubyte)'z'), "Invalid data for OR_TAX on type ZZZ9.99");
    assert((cast(ubyte)(OR_TAX[3])) >= cast(ubyte)'0' && (cast(ubyte)(OR_TAX[3])) <= cast(ubyte)'9', "Invalid data for OR_TAX on type ZZZ9.99");
    assert((cast(ubyte)(OR_TAX[5])) >= cast(ubyte)'0' && (cast(ubyte)(OR_TAX[5])) <= cast(ubyte)'9', "Invalid data for OR_TAX on type ZZZ9.99");
    assert((cast(ubyte)(OR_TAX[6])) >= cast(ubyte)'0' && (cast(ubyte)(OR_TAX[6])) <= cast(ubyte)'9', "Invalid data for OR_TAX on type ZZZ9.99");

    assert(OR_UNION.length == 7, "Invalid data for OR_UNION on type ZZZ9.99");
    assert(((cast(ubyte)(OR_UNION[0])) >= cast(ubyte)'A' && (cast(ubyte)(OR_UNION[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_UNION[0])) >= cast(ubyte)'a' && (cast(ubyte)(OR_UNION[0])) <= cast(ubyte)'z'), "Invalid data for OR_UNION on type ZZZ9.99");
    assert(((cast(ubyte)(OR_UNION[1])) >= cast(ubyte)'A' && (cast(ubyte)(OR_UNION[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_UNION[1])) >= cast(ubyte)'a' && (cast(ubyte)(OR_UNION[1])) <= cast(ubyte)'z'), "Invalid data for OR_UNION on type ZZZ9.99");
    assert(((cast(ubyte)(OR_UNION[2])) >= cast(ubyte)'A' && (cast(ubyte)(OR_UNION[2])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_UNION[2])) >= cast(ubyte)'a' && (cast(ubyte)(OR_UNION[2])) <= cast(ubyte)'z'), "Invalid data for OR_UNION on type ZZZ9.99");
    assert((cast(ubyte)(OR_UNION[3])) >= cast(ubyte)'0' && (cast(ubyte)(OR_UNION[3])) <= cast(ubyte)'9', "Invalid data for OR_UNION on type ZZZ9.99");
    assert((cast(ubyte)(OR_UNION[5])) >= cast(ubyte)'0' && (cast(ubyte)(OR_UNION[5])) <= cast(ubyte)'9', "Invalid data for OR_UNION on type ZZZ9.99");
    assert((cast(ubyte)(OR_UNION[6])) >= cast(ubyte)'0' && (cast(ubyte)(OR_UNION[6])) <= cast(ubyte)'9', "Invalid data for OR_UNION on type ZZZ9.99");

    assert(OR_MORTGAGE.length == 7, "Invalid data for OR_MORTGAGE on type ZZZ9.99");
    assert(((cast(ubyte)(OR_MORTGAGE[0])) >= cast(ubyte)'A' && (cast(ubyte)(OR_MORTGAGE[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_MORTGAGE[0])) >= cast(ubyte)'a' && (cast(ubyte)(OR_MORTGAGE[0])) <= cast(ubyte)'z'), "Invalid data for OR_MORTGAGE on type ZZZ9.99");
    assert(((cast(ubyte)(OR_MORTGAGE[1])) >= cast(ubyte)'A' && (cast(ubyte)(OR_MORTGAGE[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_MORTGAGE[1])) >= cast(ubyte)'a' && (cast(ubyte)(OR_MORTGAGE[1])) <= cast(ubyte)'z'), "Invalid data for OR_MORTGAGE on type ZZZ9.99");
    assert(((cast(ubyte)(OR_MORTGAGE[2])) >= cast(ubyte)'A' && (cast(ubyte)(OR_MORTGAGE[2])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_MORTGAGE[2])) >= cast(ubyte)'a' && (cast(ubyte)(OR_MORTGAGE[2])) <= cast(ubyte)'z'), "Invalid data for OR_MORTGAGE on type ZZZ9.99");
    assert((cast(ubyte)(OR_MORTGAGE[3])) >= cast(ubyte)'0' && (cast(ubyte)(OR_MORTGAGE[3])) <= cast(ubyte)'9', "Invalid data for OR_MORTGAGE on type ZZZ9.99");
    assert((cast(ubyte)(OR_MORTGAGE[5])) >= cast(ubyte)'0' && (cast(ubyte)(OR_MORTGAGE[5])) <= cast(ubyte)'9', "Invalid data for OR_MORTGAGE on type ZZZ9.99");
    assert((cast(ubyte)(OR_MORTGAGE[6])) >= cast(ubyte)'0' && (cast(ubyte)(OR_MORTGAGE[6])) <= cast(ubyte)'9', "Invalid data for OR_MORTGAGE on type ZZZ9.99");

    assert(OR_NETT.length == 7, "Invalid data for OR_NETT on type ZZZ9.99");
    assert(((cast(ubyte)(OR_NETT[0])) >= cast(ubyte)'A' && (cast(ubyte)(OR_NETT[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_NETT[0])) >= cast(ubyte)'a' && (cast(ubyte)(OR_NETT[0])) <= cast(ubyte)'z'), "Invalid data for OR_NETT on type ZZZ9.99");
    assert(((cast(ubyte)(OR_NETT[1])) >= cast(ubyte)'A' && (cast(ubyte)(OR_NETT[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_NETT[1])) >= cast(ubyte)'a' && (cast(ubyte)(OR_NETT[1])) <= cast(ubyte)'z'), "Invalid data for OR_NETT on type ZZZ9.99");
    assert(((cast(ubyte)(OR_NETT[2])) >= cast(ubyte)'A' && (cast(ubyte)(OR_NETT[2])) <= cast(ubyte)'Z') || ((cast(ubyte)(OR_NETT[2])) >= cast(ubyte)'a' && (cast(ubyte)(OR_NETT[2])) <= cast(ubyte)'z'), "Invalid data for OR_NETT on type ZZZ9.99");
    assert((cast(ubyte)(OR_NETT[3])) >= cast(ubyte)'0' && (cast(ubyte)(OR_NETT[3])) <= cast(ubyte)'9', "Invalid data for OR_NETT on type ZZZ9.99");
    assert((cast(ubyte)(OR_NETT[5])) >= cast(ubyte)'0' && (cast(ubyte)(OR_NETT[5])) <= cast(ubyte)'9', "Invalid data for OR_NETT on type ZZZ9.99");
    assert((cast(ubyte)(OR_NETT[6])) >= cast(ubyte)'0' && (cast(ubyte)(OR_NETT[6])) <= cast(ubyte)'9', "Invalid data for OR_NETT on type ZZZ9.99");

}

string WA_EMPLOYEE_COUNT;
string WA_PAGE_COUNT;
string WA_LINE_COUNT;
string WA_LINE_THROW;
string WB_EOF_IND;
enum WB_EOF = "Y";
string WB_UNION_IND;
enum WB_UNION_NOT_POSS = "Y";
string WB_MORTGAGE_IND;
enum WB_MORTGAGE_NOT_POSS = "Y";
string WC_L2_PAGE_NAME = "PAYROLL LIST";
string WC_L2_PAGE_NO;
string WD_L15_TOTAL_EMPLOYEES;
string WD_L15_TOTAL_GROSS;
string WD_L15_TOTAL_MORTGAGE;
string WD_L17_TOTAL_TAX;
string WD_L17_TOTAL_UNION;
string WD_L19_TOTAL_NETT;
string WD_L19_TOTAL_EXCEPTIONS;
string WF_GROSS;
string WF_TAX;
string WF_NETT;
string WF_TEMP_DED;
string WG_TOTAL_GROSS;
string WG_TOTAL_TAX;
string WG_TOTAL_NETT;
string WG_TOTAL_UNION;
string WG_TOTAL_MORTGAGE;
string WG_TOTAL_EMPLOYEES;
string WG_TOTAL_EXCEPTIONS;
string WH_SPARE_HEAD = "PAYROLL TOTALS";

@property string WD_TOTAL_LINES() {
    return WD_L15_TOTAL_EMPLOYEES ~ WD_L15_TOTAL_GROSS ~ WD_L15_TOTAL_MORTGAGE ~ WD_L17_TOTAL_TAX ~ WD_L17_TOTAL_UNION ~ WD_L19_TOTAL_NETT ~ WD_L19_TOTAL_EXCEPTIONS; }
@property string WF_EMPLOYEE_VALUES() {
    return WF_GROSS ~ WF_TAX ~ WF_NETT ~ WF_TEMP_DED; }
@property string WA_COUNTERS() {
    return WA_EMPLOYEE_COUNT ~ WA_PAGE_COUNT ~ WA_LINE_COUNT ~ WA_LINE_THROW; }
@property string WG_TOTALS() {
    return WG_TOTAL_GROSS ~ WG_TOTAL_TAX ~ WG_TOTAL_NETT ~ WG_TOTAL_UNION ~ WG_TOTAL_MORTGAGE ~ WG_TOTAL_EMPLOYEES ~ WG_TOTAL_EXCEPTIONS; }
@property string WB_INDICATORS() {
    return WB_EOF_IND ~ WB_UNION_IND ~ WB_MORTGAGE_IND; }
@property string WC_HEADING_LINES() {
    return WC_L2_PAGE_NAME ~ WC_L2_PAGE_NO; }
@property string WH_MISCELLANEOUS() {
    return WH_SPARE_HEAD; }

void validateWorkingDataDivison() {
    assert(WA_EMPLOYEE_COUNT.length == 5, "Invalid data for WA_EMPLOYEE_COUNT on type S9(8)");
    assert(WA_EMPLOYEE_COUNT[0] == '-' && WA_EMPLOYEE_COUNT[0] == ' ', "Invalid data for WA_EMPLOYEE_COUNT on type S9(8)");
    assert((cast(ubyte)(WA_EMPLOYEE_COUNT[1])) >= cast(ubyte)'0' && (cast(ubyte)(WA_EMPLOYEE_COUNT[1])) <= cast(ubyte)'9', "Invalid data for WA_EMPLOYEE_COUNT on type S9(8)");
    assert((cast(ubyte)(WA_EMPLOYEE_COUNT[2])) >= cast(ubyte)'0' && (cast(ubyte)(WA_EMPLOYEE_COUNT[2])) <= cast(ubyte)'9', "Invalid data for WA_EMPLOYEE_COUNT on type S9(8)");

    assert(WA_PAGE_COUNT.length == 5, "Invalid data for WA_PAGE_COUNT on type S9(8)");
    assert(WA_PAGE_COUNT[0] == '-' && WA_PAGE_COUNT[0] == ' ', "Invalid data for WA_PAGE_COUNT on type S9(8)");
    assert((cast(ubyte)(WA_PAGE_COUNT[1])) >= cast(ubyte)'0' && (cast(ubyte)(WA_PAGE_COUNT[1])) <= cast(ubyte)'9', "Invalid data for WA_PAGE_COUNT on type S9(8)");
    assert((cast(ubyte)(WA_PAGE_COUNT[2])) >= cast(ubyte)'0' && (cast(ubyte)(WA_PAGE_COUNT[2])) <= cast(ubyte)'9', "Invalid data for WA_PAGE_COUNT on type S9(8)");

    assert(WA_LINE_COUNT.length == 5, "Invalid data for WA_LINE_COUNT on type S9(8)");
    assert(WA_LINE_COUNT[0] == '-' && WA_LINE_COUNT[0] == ' ', "Invalid data for WA_LINE_COUNT on type S9(8)");
    assert((cast(ubyte)(WA_LINE_COUNT[1])) >= cast(ubyte)'0' && (cast(ubyte)(WA_LINE_COUNT[1])) <= cast(ubyte)'9', "Invalid data for WA_LINE_COUNT on type S9(8)");
    assert((cast(ubyte)(WA_LINE_COUNT[2])) >= cast(ubyte)'0' && (cast(ubyte)(WA_LINE_COUNT[2])) <= cast(ubyte)'9', "Invalid data for WA_LINE_COUNT on type S9(8)");

    assert(WA_LINE_THROW.length == 5, "Invalid data for WA_LINE_THROW on type S9(8)");
    assert(WA_LINE_THROW[0] == '-' && WA_LINE_THROW[0] == ' ', "Invalid data for WA_LINE_THROW on type S9(8)");
    assert((cast(ubyte)(WA_LINE_THROW[1])) >= cast(ubyte)'0' && (cast(ubyte)(WA_LINE_THROW[1])) <= cast(ubyte)'9', "Invalid data for WA_LINE_THROW on type S9(8)");
    assert((cast(ubyte)(WA_LINE_THROW[2])) >= cast(ubyte)'0' && (cast(ubyte)(WA_LINE_THROW[2])) <= cast(ubyte)'9', "Invalid data for WA_LINE_THROW on type S9(8)");

    assert(WB_EOF_IND.length == 1, "Invalid data for WB_EOF_IND on type X");

    assert(WB_UNION_IND.length == 1, "Invalid data for WB_UNION_IND on type X");

    assert(WB_MORTGAGE_IND.length == 1, "Invalid data for WB_MORTGAGE_IND on type X");

    assert(WC_L2_PAGE_NAME.length == 1, "Invalid data for WC_L2_PAGE_NAME on type X");

    assert(WC_L2_PAGE_NO.length == 2, "Invalid data for WC_L2_PAGE_NO on type Z9");
    assert(((cast(ubyte)(WC_L2_PAGE_NO[0])) >= cast(ubyte)'A' && (cast(ubyte)(WC_L2_PAGE_NO[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WC_L2_PAGE_NO[0])) >= cast(ubyte)'a' && (cast(ubyte)(WC_L2_PAGE_NO[0])) <= cast(ubyte)'z'), "Invalid data for WC_L2_PAGE_NO on type Z9");
    assert((cast(ubyte)(WC_L2_PAGE_NO[1])) >= cast(ubyte)'0' && (cast(ubyte)(WC_L2_PAGE_NO[1])) <= cast(ubyte)'9', "Invalid data for WC_L2_PAGE_NO on type Z9");

    assert(WD_L15_TOTAL_EMPLOYEES.length == 3, "Invalid data for WD_L15_TOTAL_EMPLOYEES on type ZZ9");
    assert(((cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[0])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_EMPLOYEES on type ZZ9");
    assert(((cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[1])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_EMPLOYEES on type ZZ9");
    assert((cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[2])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_EMPLOYEES[2])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_EMPLOYEES on type ZZ9");

    assert(WD_L15_TOTAL_GROSS.length == 9, "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_GROSS[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_GROSS[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_GROSS[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_GROSS[0])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_GROSS[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_GROSS[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_GROSS[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_GROSS[1])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_GROSS[3])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_GROSS[3])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_GROSS[3])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_GROSS[3])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_GROSS[4])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_GROSS[4])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_GROSS[4])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_GROSS[4])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L15_TOTAL_GROSS[5])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_GROSS[5])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L15_TOTAL_GROSS[7])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_GROSS[7])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L15_TOTAL_GROSS[8])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_GROSS[8])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_GROSS on type ZZ,ZZ9.99");

    assert(WD_L15_TOTAL_MORTGAGE.length == 9, "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[0])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[1])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[3])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[3])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[3])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[3])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[4])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[4])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[4])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[4])) <= cast(ubyte)'z'), "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[5])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[5])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[7])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[7])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L15_TOTAL_MORTGAGE[8])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L15_TOTAL_MORTGAGE[8])) <= cast(ubyte)'9', "Invalid data for WD_L15_TOTAL_MORTGAGE on type ZZ,ZZ9.99");

    assert(WD_L17_TOTAL_TAX.length == 9, "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_TAX[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_TAX[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_TAX[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_TAX[0])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_TAX[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_TAX[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_TAX[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_TAX[1])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_TAX[3])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_TAX[3])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_TAX[3])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_TAX[3])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_TAX[4])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_TAX[4])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_TAX[4])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_TAX[4])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L17_TOTAL_TAX[5])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L17_TOTAL_TAX[5])) <= cast(ubyte)'9', "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L17_TOTAL_TAX[7])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L17_TOTAL_TAX[7])) <= cast(ubyte)'9', "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L17_TOTAL_TAX[8])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L17_TOTAL_TAX[8])) <= cast(ubyte)'9', "Invalid data for WD_L17_TOTAL_TAX on type ZZ,ZZ9.99");

    assert(WD_L17_TOTAL_UNION.length == 9, "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_UNION[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_UNION[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_UNION[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_UNION[0])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_UNION[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_UNION[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_UNION[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_UNION[1])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_UNION[3])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_UNION[3])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_UNION[3])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_UNION[3])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L17_TOTAL_UNION[4])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L17_TOTAL_UNION[4])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L17_TOTAL_UNION[4])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L17_TOTAL_UNION[4])) <= cast(ubyte)'z'), "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L17_TOTAL_UNION[5])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L17_TOTAL_UNION[5])) <= cast(ubyte)'9', "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L17_TOTAL_UNION[7])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L17_TOTAL_UNION[7])) <= cast(ubyte)'9', "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L17_TOTAL_UNION[8])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L17_TOTAL_UNION[8])) <= cast(ubyte)'9', "Invalid data for WD_L17_TOTAL_UNION on type ZZ,ZZ9.99");

    assert(WD_L19_TOTAL_NETT.length == 9, "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L19_TOTAL_NETT[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L19_TOTAL_NETT[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L19_TOTAL_NETT[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L19_TOTAL_NETT[0])) <= cast(ubyte)'z'), "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L19_TOTAL_NETT[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L19_TOTAL_NETT[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L19_TOTAL_NETT[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L19_TOTAL_NETT[1])) <= cast(ubyte)'z'), "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L19_TOTAL_NETT[3])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L19_TOTAL_NETT[3])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L19_TOTAL_NETT[3])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L19_TOTAL_NETT[3])) <= cast(ubyte)'z'), "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert(((cast(ubyte)(WD_L19_TOTAL_NETT[4])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L19_TOTAL_NETT[4])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L19_TOTAL_NETT[4])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L19_TOTAL_NETT[4])) <= cast(ubyte)'z'), "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L19_TOTAL_NETT[5])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L19_TOTAL_NETT[5])) <= cast(ubyte)'9', "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L19_TOTAL_NETT[7])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L19_TOTAL_NETT[7])) <= cast(ubyte)'9', "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");
    assert((cast(ubyte)(WD_L19_TOTAL_NETT[8])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L19_TOTAL_NETT[8])) <= cast(ubyte)'9', "Invalid data for WD_L19_TOTAL_NETT on type ZZ,ZZ9.99");

    assert(WD_L19_TOTAL_EXCEPTIONS.length == 3, "Invalid data for WD_L19_TOTAL_EXCEPTIONS on type ZZ9");
    assert(((cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[0])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[0])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[0])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[0])) <= cast(ubyte)'z'), "Invalid data for WD_L19_TOTAL_EXCEPTIONS on type ZZ9");
    assert(((cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[1])) >= cast(ubyte)'A' && (cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[1])) <= cast(ubyte)'Z') || ((cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[1])) >= cast(ubyte)'a' && (cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[1])) <= cast(ubyte)'z'), "Invalid data for WD_L19_TOTAL_EXCEPTIONS on type ZZ9");
    assert((cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[2])) >= cast(ubyte)'0' && (cast(ubyte)(WD_L19_TOTAL_EXCEPTIONS[2])) <= cast(ubyte)'9', "Invalid data for WD_L19_TOTAL_EXCEPTIONS on type ZZ9");

    assert(WF_GROSS.length == 8, "Invalid data for WF_GROSS on type S9(6)V99");
    assert(WF_GROSS[0] == '-' && WF_GROSS[0] == ' ', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[1])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[1])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[2])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[2])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[3])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[3])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[4])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[4])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[5])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[5])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[6])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[6])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[7])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[7])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[8])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[8])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[9])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[9])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[10])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[10])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[11])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[11])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[12])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[12])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[13])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[13])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[14])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[14])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[15])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[15])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[16])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[16])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[17])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[17])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[18])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[18])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[19])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[19])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WF_GROSS[20])) >= cast(ubyte)'0' && (cast(ubyte)(WF_GROSS[20])) <= cast(ubyte)'9', "Invalid data for WF_GROSS on type S9(6)V99");

    assert(WF_TAX.length == 8, "Invalid data for WF_TAX on type S9(6)V99");
    assert(WF_TAX[0] == '-' && WF_TAX[0] == ' ', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[1])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[1])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[2])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[2])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[3])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[3])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[4])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[4])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[5])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[5])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[6])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[6])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[7])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[7])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[8])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[8])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[9])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[9])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[10])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[10])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[11])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[11])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[12])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[12])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[13])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[13])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[14])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[14])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[15])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[15])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[16])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[16])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[17])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[17])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[18])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[18])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[19])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[19])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");
    assert((cast(ubyte)(WF_TAX[20])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TAX[20])) <= cast(ubyte)'9', "Invalid data for WF_TAX on type S9(6)V99");

    assert(WF_NETT.length == 8, "Invalid data for WF_NETT on type S9(6)V99");
    assert(WF_NETT[0] == '-' && WF_NETT[0] == ' ', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[1])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[1])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[2])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[2])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[3])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[3])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[4])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[4])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[5])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[5])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[6])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[6])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[7])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[7])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[8])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[8])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[9])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[9])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[10])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[10])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[11])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[11])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[12])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[12])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[13])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[13])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[14])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[14])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[15])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[15])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[16])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[16])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[17])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[17])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[18])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[18])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[19])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[19])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");
    assert((cast(ubyte)(WF_NETT[20])) >= cast(ubyte)'0' && (cast(ubyte)(WF_NETT[20])) <= cast(ubyte)'9', "Invalid data for WF_NETT on type S9(6)V99");

    assert(WF_TEMP_DED.length == 8, "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert(WF_TEMP_DED[0] == '-' && WF_TEMP_DED[0] == ' ', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[1])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[1])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[2])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[2])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[3])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[3])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[4])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[4])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[5])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[5])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[6])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[6])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[7])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[7])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[8])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[8])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[9])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[9])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[10])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[10])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[11])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[11])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[12])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[12])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[13])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[13])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[14])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[14])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[15])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[15])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[16])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[16])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[17])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[17])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[18])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[18])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[19])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[19])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");
    assert((cast(ubyte)(WF_TEMP_DED[20])) >= cast(ubyte)'0' && (cast(ubyte)(WF_TEMP_DED[20])) <= cast(ubyte)'9', "Invalid data for WF_TEMP_DED on type S9(6)V99");

    assert(WG_TOTAL_GROSS.length == 8, "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert(WG_TOTAL_GROSS[0] == '-' && WG_TOTAL_GROSS[0] == ' ', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[3])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[3])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[4])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[4])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[5])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[5])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[6])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[6])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[7])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[7])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[8])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[8])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[9])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[9])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[10])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[10])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[11])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[11])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[12])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[12])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[13])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[13])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[14])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[14])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[15])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[15])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[16])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[16])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[17])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[17])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[18])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[18])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[19])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[19])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_GROSS[20])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_GROSS[20])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_GROSS on type S9(6)V99");

    assert(WG_TOTAL_TAX.length == 8, "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert(WG_TOTAL_TAX[0] == '-' && WG_TOTAL_TAX[0] == ' ', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[3])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[3])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[4])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[4])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[5])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[5])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[6])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[6])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[7])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[7])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[8])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[8])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[9])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[9])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[10])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[10])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[11])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[11])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[12])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[12])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[13])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[13])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[14])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[14])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[15])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[15])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[16])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[16])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[17])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[17])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[18])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[18])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[19])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[19])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_TAX[20])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_TAX[20])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_TAX on type S9(6)V99");

    assert(WG_TOTAL_NETT.length == 8, "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert(WG_TOTAL_NETT[0] == '-' && WG_TOTAL_NETT[0] == ' ', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[3])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[3])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[4])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[4])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[5])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[5])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[6])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[6])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[7])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[7])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[8])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[8])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[9])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[9])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[10])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[10])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[11])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[11])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[12])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[12])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[13])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[13])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[14])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[14])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[15])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[15])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[16])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[16])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[17])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[17])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[18])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[18])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[19])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[19])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_NETT[20])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_NETT[20])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_NETT on type S9(6)V99");

    assert(WG_TOTAL_UNION.length == 8, "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert(WG_TOTAL_UNION[0] == '-' && WG_TOTAL_UNION[0] == ' ', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[3])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[3])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[4])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[4])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[5])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[5])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[6])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[6])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[7])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[7])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[8])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[8])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[9])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[9])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[10])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[10])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[11])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[11])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[12])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[12])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[13])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[13])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[14])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[14])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[15])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[15])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[16])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[16])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[17])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[17])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[18])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[18])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[19])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[19])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_UNION[20])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_UNION[20])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_UNION on type S9(6)V99");

    assert(WG_TOTAL_MORTGAGE.length == 8, "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert(WG_TOTAL_MORTGAGE[0] == '-' && WG_TOTAL_MORTGAGE[0] == ' ', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[3])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[3])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[4])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[4])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[5])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[5])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[6])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[6])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[7])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[7])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[8])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[8])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[9])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[9])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[10])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[10])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[11])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[11])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[12])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[12])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[13])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[13])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[14])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[14])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[15])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[15])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[16])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[16])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[17])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[17])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[18])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[18])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[19])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[19])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");
    assert((cast(ubyte)(WG_TOTAL_MORTGAGE[20])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_MORTGAGE[20])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_MORTGAGE on type S9(6)V99");

    assert(WG_TOTAL_EMPLOYEES.length == 4, "Invalid data for WG_TOTAL_EMPLOYEES on type S999");
    assert(WG_TOTAL_EMPLOYEES[0] == '-' && WG_TOTAL_EMPLOYEES[0] == ' ', "Invalid data for WG_TOTAL_EMPLOYEES on type S999");
    assert((cast(ubyte)(WG_TOTAL_EMPLOYEES[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_EMPLOYEES[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_EMPLOYEES on type S999");
    assert((cast(ubyte)(WG_TOTAL_EMPLOYEES[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_EMPLOYEES[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_EMPLOYEES on type S999");
    assert((cast(ubyte)(WG_TOTAL_EMPLOYEES[3])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_EMPLOYEES[3])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_EMPLOYEES on type S999");
    assert((cast(ubyte)(WG_TOTAL_EMPLOYEES[4])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_EMPLOYEES[4])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_EMPLOYEES on type S999");

    assert(WG_TOTAL_EXCEPTIONS.length == 5, "Invalid data for WG_TOTAL_EXCEPTIONS on type S9(8)");
    assert(WG_TOTAL_EXCEPTIONS[0] == '-' && WG_TOTAL_EXCEPTIONS[0] == ' ', "Invalid data for WG_TOTAL_EXCEPTIONS on type S9(8)");
    assert((cast(ubyte)(WG_TOTAL_EXCEPTIONS[1])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_EXCEPTIONS[1])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_EXCEPTIONS on type S9(8)");
    assert((cast(ubyte)(WG_TOTAL_EXCEPTIONS[2])) >= cast(ubyte)'0' && (cast(ubyte)(WG_TOTAL_EXCEPTIONS[2])) <= cast(ubyte)'9', "Invalid data for WG_TOTAL_EXCEPTIONS on type S9(8)");

    assert(WH_SPARE_HEAD.length == 5, "Invalid data for WH_SPARE_HEAD on type X(26)");

}

void MAIN_LINE() {
    writeln("STARTING PAY4");
    INITIALISE();
    DEAL_WITH_EMPLOYEE();
    TIDY_UP();
    writeln("FINISHING PAY4");
}

void INITIALISE() {
    writeln("2A INITIALISE");
    READ_EMPLOYEE();
}

void READ_EMPLOYEE() {
    writeln("2A JUST READ " ~ INPUT_REC);
}

void PRINT_LINE() {
    writeln("2C JUST PUTTING OUT " ~ OUTPUT_REC);
}

void TIDY_UP() {
    writeln("2D TIDY-UP");
    PRINT_TOTALS();
}

void DEAL_WITH_EMPLOYEE() {
    writeln("3A DEALING WITH EMPLOYEE " ~ INPUT_REC);
}

void PRINT_HEADINGS() {
    writeln("3B-PRINT-HEADINGS");
    PRINT_FIRST_LINE();
    PRINT_LINE();
}

void CALC_VALUES() {
    writeln("4A-CALC-VALUES");
    writeln("GROSS = " ~ WF_GROSS);
}

void SETUP_LINE() {
    writeln("4B-SETUP-LINE " ~ IR_NAME);
}

void ACCUM_TOTALS() {
}

void PRINT_TOTALS() {
    writeln("4D-PRINT-TOTALS");
    PRINT_FIRST_LINE();
    PRINT_LINE();
    PRINT_LINE();
    PRINT_LINE();
}

void PRINT_FIRST_LINE() {
    writeln("PRINT-FIRST-LINE");
}
```
