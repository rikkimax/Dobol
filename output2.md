```D
/**
 * /------------------------------------------------------------------------------\
 *  Program:            PAY4
 *  Author:             LYDIA
 *  Installation:       
 *  Date_Written:       
 *  Date_Compiled:      
 *  Security:           
 *  Generated:          Sun Apr 13 15:29:40 2014
 *
 *  Source_Computer:    IBM-PC
 *  Object_Computer:    IBM-PC
 * /------------------------------------------------------------------------------\
 */

alias NEW_PAGE = DobolSystemDevices.C01;

struct INPUT_FILE {
    string IR_NUMBER;
    string IR_NAME;
    string IR_HOURS;
    string IR_RATE;
    string IR_UNION;
    string IR_MORTGAGE;

    @property string INPUT_REC() {
        return IR_NUMBER ~ IR_NAME ~ IR_HOURS ~ IR_RATE ~ IR_UNION ~ IR_MORTGAGE; }

    void validate() {
        if (IR_NUMBER.length != 6) {
            if (IR_NUMBER.length < 6) {
                IR_NUMBER ~= dobolSpaceCreator(6 - IR_NUMBER.length);
            } else {
                IR_NUMBER.length = 6;
            }
        }
        if (IR_NAME.length != 20) {
            if (IR_NAME.length < 20) {
                IR_NAME ~= dobolSpaceCreator(20 - IR_NAME.length);
            } else {
                IR_NAME.length = 20;
            }
        }
    }
}

struct OUTPUT_FILE {
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

    void validate() {
        if (OR_NUMBER.length != 6) {
            if (OR_NUMBER.length < 6) {
                OR_NUMBER ~= dobolSpaceCreator(6 - OR_NUMBER.length);
            } else {
                OR_NUMBER.length = 6;
            }
        }
        if (OR_NAME.length != 20) {
            if (OR_NAME.length < 20) {
                OR_NAME ~= dobolSpaceCreator(20 - OR_NAME.length);
            } else {
                OR_NAME.length = 20;
            }
        }
    }
}
```
