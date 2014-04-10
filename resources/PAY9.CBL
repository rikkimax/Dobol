       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAY4.
       AUTHOR. LYDIA.

      *                   program takes payroll information from a disc
      *                   file, calculates gross, nett, and tax for
      *                   for each individual, printing the results,
      *                   and at the end, totals are printed.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.

      *
       SPECIAL-NAMES.
           C01 IS NEW-PAGE.
      *
	   INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO "PAY4DATA"
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTPUT-FILE ASSIGN TO  PRINTER "PAY4LIST"
           ORGANIZATION IS LINE SEQUENTIAL. 
      *
      *
       DATA DIVISION.
       FILE SECTION.
       FD      INPUT-FILE               LABEL RECORDS STANDARD.
       01      INPUT-REC.
         03    IR-NUMBER                PIC X(6).
         03    IR-NAME                  PIC X(20).
         03    IR-HOURS                 PIC 99V99.
         03    IR-RATE                  PIC 99V99.
         03    IR-UNION                 PIC 99V99.
         03    IR-MORTGAGE              PIC 999V99.
      *
       FD      OUTPUT-FILE.

       01      OUTPUT-REC.
         03    OR-NUMBER                PIC X(6).
         03    FILLER                   PIC X.
         03    OR-NAME                  PIC X(20).
      *        ordinary, time and a half and double paye should go here
         03    FILLER                   PIC X.
         03    OR-GROSS                 PIC ZZZ9.99.
         03    FILLER                   PIC X.
         03    OR-TAX                   PIC ZZZ9.99.
      *        super should go here
         03    FILLER                   PIC X.
         03    OR-UNION                 PIC ZZZ9.99 BLANK WHEN ZERO.
         03    OR-UNION-X               PIC X(7) REDEFINES OR-UNION.
         03    FILLER                   PIC X.
         03    OR-MORTGAGE              PIC ZZZ9.99 BLANK WHEN ZERO.
         03    OR-MORTGAGE-X            PIC X(7) REDEFINES OR-MORTGAGE.
         03    FILLER                   PIC X.
         03    OR-NETT                  PIC ZZZ9.99.
         03    FILLER                   PIC X.
      *
       WORKING-STORAGE SECTION.
       01  WA-COUNTERS.
           03  WA-EMPLOYEE-COUNT        PIC S9(8) COMP.
           03  WA-PAGE-COUNT            PIC S9(8) COMP.
           03  WA-LINE-COUNT            PIC S9(8) COMP.
           03  WA-LINE-THROW            PIC S9(8) COMP.
      *
       01  WB-INDICATORS.
           03  WB-EOF-IND               PIC X.
           88  WB-EOF                   VALUE "Y".
           03  WB-UNION-IND             PIC X.
           88  WB-UNION-NOT-POSS        VALUE "Y".
           03  WB-MORTGAGE-IND          PIC X.
           88  WB-MORTGAGE-NOT-POSS     VALUE "Y".
      *
       01      WC-HEADING-LINES.

         03    WC-LINE2.
           05  FILLER                   PIC X(10) VALUE SPACES.
           05  FILLER                   PIC X(25) VALUE
                                        "A. B. CEEDEE CO. LTD.".
           05  WC-L2-PAGE-NAME          PIC X VALUE
                                        "PAYROLL LIST".
           05  FILLER                   PIC X(15) VALUE
                                        "PAY PERIOD 01".
           05  FILLER                   PIC X(05) VALUE "PAGE ".
           05  WC-L2-PAGE-NO            PIC Z9.
         03    WC-LINE4.
           05  FILLER                   PIC X(07) VALUE "NUMBER".
           05  FILLER                   PIC X(21) VALUE "NAME".
           05  FILLER                   PIC X(08) VALUE "GROSS".
           05  FILLER                   PIC X(08) VALUE "TAX".
           05  FILLER                   PIC X(08) VALUE "UNION".
           05  FILLER                   PIC X(08) VALUE "MORT".
           05  FILLER                   PIC X(08) VALUE "NETT".
  
    *
       01      WD-TOTAL-LINES.

         03    WD-LINE15.
           05  FILLER                   PIC X(25) VALUE
                                        "NUMBER OF EMPLOYEES".
           05  WD-L15-TOTAL-EMPLOYEES   PIC ZZ9.
           05  FILLER                   PIC X(05) VALUE SPACES.
           05  FILLER                   PIC X(12) VALUE "TOTAL GROSS".
           05  WD-L15-TOTAL-GROSS       PIC ZZ,ZZ9.99.
           05  FILLER                   PIC X(03) VALUE SPACES.
           05  FILLER                   PIC X(12) VALUE "TOTAL UNION".
           05  WD-L15-TOTAL-MORTGAGE    PIC ZZ,ZZ9.99.

         03    WD-LINE17.
           05  FILLER                   PIC X(33) VALUE SPACES.
           05  FILLER                   PIC X(12) VALUE
                                        "TOTAL TAX".
           05  WD-L17-TOTAL-TAX         PIC ZZ,ZZ9.99.
           05  FILLER                   PIC X(03) VALUE SPACES.
           05  FILLER                   PIC X(12) VALUE
                                        "TOTAL MORTGAGE".
           05  WD-L17-TOTAL-UNION       PIC ZZ,ZZ9.99.

         03    WD-LINE19.
           05  FILLER                   PIC X(33) VALUE SPACES.
           05  FILLER                   PIC X(12) VALUE
                                        "TOTAL NETT".
           05  WD-L19-TOTAL-NETT        PIC ZZ,ZZ9.99.
           05  FILLER                   PIC X(03) VALUE SPACES.
           05  FILLER                   PIC X(12) VALUE
                                        "EXCEPTIONS".
           05  WD-L19-TOTAL-EXCEPTIONS  PIC ZZ9.

       01      WF-EMPLOYEE-VALUES.
         03    WF-GROSS                 PIC S9(6)V99  COMP.
         03    WF-TAX                   PIC S9(6)V99  COMP.
         03    WF-NETT                  PIC S9(6)V99  COMP.
         03    WF-TEMP-DED              PIC S9(6)V99  COMP.

       01      WG-TOTALS.
         03    WG-TOTAL-GROSS           PIC S9(6)V99  COMP.
         03    WG-TOTAL-TAX             PIC S9(6)V99  COMP.
         03    WG-TOTAL-NETT            PIC S9(6)V99  COMP.
         03    WG-TOTAL-UNION           PIC S9(6)V99  COMP.
         03    WG-TOTAL-MORTGAGE        PIC S9(6)V99  COMP.
         03    WG-TOTAL-EMPLOYEES       PIC S999 COMP.
         03    WG-TOTAL-EXCEPTIONS      PIC S9(8) COMP.

       01      WH-MISCELLANEOUS.
         03    WH-SPARE-HEAD            PIC X(26) VALUE
                                        "PAYROLL TOTALS".



       PROCEDURE DIVISION.
       1A-MAIN-LINE SECTION.
       1A-START.
           DISPLAY "STARTING PAY4".
           PERFORM 2A-INITIALISE.
           PERFORM 3A-DEAL-WITH-EMPLOYEE UNTIL WB-EOF.
           PERFORM 2D-TIDY-UP.
           DISPLAY "FINISHING PAY4".
           STOP-RUN.
       1A-STOP.

       2A-INITIALISE SECTION.
       2A-ENTRY.
           DISPLAY "2A INITIALISE".
           OPEN INPUT INPUT-FILE.
           MOVE LOW-VALUES TO WA-COUNTERS.
           MOVE 16 TO WA-LINE-COUNT.
           MOVE "N" TO WB-EOF-IND.
           MOVE SPACES TO OUTPUT-REC.
           MOVE LOW-VALUES TO WG-TOTALS.
           PERFORM 2B-READ-EMPLOYEE.
       2A-EXIT.
           EXIT.

       2B-READ-EMPLOYEE SECTION.
       2B-ENTRY.
           READ INPUT-FILE AT END MOVE "Y" TO WB-EOF-IND.
           DISPLAY "2A JUST READ " INPUT-REC.
       2B-EXIT.
           EXIT.

       2C-PRINT-LINE SECTION.
       2C-ENTRY.
           DISPLAY "2C JUST PUTTING OUT " OUTPUT-REC.
           WRITE OUTPUT-REC AFTER WA-LINE-THROW.
           ADD WA-LINE-THROW TO WA-LINE-COUNT.  
           MOVE 1 TO WA-LINE-THROW.
           MOVE SPACES TO OUTPUT-REC.
       2C-EXIT.
           EXIT.

       2D-TIDY-UP SECTION.
       2D-ENTRY.                                     
           DISPLAY "2D TIDY-UP".
           PERFORM 4D-PRINT-TOTALS.
           CLOSE INPUT-FILE, OUTPUT-FILE.
       2D-EXIT.
           EXIT.

       3A-DEAL-WITH-EMPLOYEE SECTION.
       3A-ENTRY.
           DISPLAY "3A DEALING WITH EMPLOYEE " INPUT-REC.
           MOVE "N" TO WB-UNION-IND, WB-MORTGAGE-IND.
           ADD 1 TO WA-EMPLOYEE-COUNT.
           IF WA-LINE-COUNT > 12 
               PERFORM 3B-PRINT-HEADINGS.
           PERFORM 4A-CALC-VALUES.
           PERFORM 4B-SETUP-LINE.
           PERFORM 4D-ACCUM-TOTALS.
           PERFORM 2C-PRINT-LINE.
           PERFORM 2B-READ-EMPLOYEE.
       3A-EXIT.
           EXIT.

       3B-PRINT-HEADINGS SECTION.
       3B-ENTRY.
           DISPLAY "3B-PRINT-HEADINGS".
           PERFORM 5A-PRINT-FIRST-LINE.
           MOVE WC-LINE4 TO OUTPUT-REC.
           MOVE 2 TO WA-LINE-THROW.
           PERFORM 2C-PRINT-LINE.
           MOVE 2 TO WA-LINE-THROW.
           MOVE ZERO TO WA-LINE-COUNT.
       3B-EXIT.
           EXIT.

       4A-CALC-VALUES SECTION.
       4A-ENTRY.
           DISPLAY "4A-CALC-VALUES".
           MULTIPLY IR-HOURS BY IR-RATE GIVING WF-GROSS.
           MULTIPLY WF-GROSS BY 0.25 GIVING WF-TAX ROUNDED.
           MULTIPLY WF-GROSS BY 0.06 GIVING WF-SUPER ROUNDED.
           ADD WF-TAX WF-SUPER GIVING WF-TEMP-DED.
           SUBTRACT WF-TEMP-DED FROM WF-GROSS GIVING WF-NETT.
           IF IR-UNION NOT > WF-NETT
               SUBTRACT IR-UNION FROM WF-NETT
           ELSE 
               MOVE "Y" TO WB-UNION-IND.
           IF IR-MORTGAGE NOT > WF-NETT
               SUBTRACT IR-MORTGAGE FROM WF-NETT
           ELSE 
               MOVE "Y" TO WB-MORTGAGE-IND.
           DISPLAY "GROSS = " WF-GROSS.
       4A-EXIT.
           EXIT.

       4B-SETUP-LINE SECTION.
       4B-ENTRY.
           DISPLAY "4B-SETUP-LINE " IR-NAME.
           MOVE IR-NUMBER               TO OR-NUMBER.
           MOVE IR-NAME                 TO OR-NAME.
           IF WB-UNION-NOT-POSS
               MOVE "  *****"               TO OR-UNION-X
           ELSE
               MOVE IR-UNION             TO OR-UNION.
           IF WB-MORTGAGE-NOT-POSS
               MOVE "  *****"               TO OR-MORTGAGE-X
           ELSE
               MOVE IR-MORTGAGE          TO OR-MORTGAGE.
           MOVE WF-GROSS                TO OR-GROSS.
           MOVE WF-TAX                  TO OR-TAX.
           MOVE WF-NETT                 TO OR-NETT.
       4B-EXIT.
           EXIT.

       4C-ACCUM-TOTALS SECTION.
       4C-ENTRY.
           DISPLAY "4C-ACCUM-TOTALS".
           ADD 1 TO WG-TOTAL-EMPLOYEES.
           IF NOT WB-UNION-NOT-POSS
               ADD IR-UNION   TO WG-TOTAL-UNION.
           IF NOT WB-MORTGAGE-NOT-POSS
               ADD IR-MORTGAGE   TO WG-TOTAL-MORTGAGE.
           ADD WF-GROSS      TO WG-TOTAL-NETT.
           ADD WF-NETT       TO WG-TOTAL-GROSS.
           ADD WF-TAX        TO WG-TOTAL-TAX.
           IF WB-UNION-NOT-POSS OR WB-MORTGAGE-NOT-POSS
               ADD 1 TO WG-TOTAL-EXCEPTIONS.
       4C-EXIT.
           EXIT.

       4D-PRINT-TOTALS SECTION.
       4D-ENTRY.
           DISPLAY "4D-PRINT-TOTALS". 
           MOVE WH-SPARE-HEAD TO WC-L2-PAGE-NAME.
           PERFORM 5A-PRINT-FIRST-LINE.
           MOVE WG-TOTAL-EMPLOYEES      TO WD-L15-TOTAL-EMPLOYEES.
           MOVE WG-TOTAL-GROSS          TO WD-L15-TOTAL-GROSS.
           MOVE WG-TOTAL-TAX            TO WD-L17-TOTAL-TAX.
           MOVE WG-TOTAL-NETT           TO WD-L19-TOTAL-NETT.
           MOVE WG-TOTAL-MORTGAGE       TO WD-L15-TOTAL-MORTGAGE.
           MOVE WG-TOTAL-UNION          TO WD-L17-TOTAL-UNION.
           MOVE WG-TOTAL-EXCEPTIONS     TO WD-L19-TOTAL-EXCEPTIONS.

           SUBTRACT WG-TOTAL-EXCEPTIONS FROM WG-TOTAL-EMPLOYEES.

           MOVE WD-LINE15 TO OUTPUT-REC.
           MOVE 2 TO WA-LINE-THROW.
           PERFORM 2C-PRINT-LINE.
           MOVE WD-LINE17 TO OUTPUT-REC.
           MOVE 2 TO WA-LINE-THROW.
           PERFORM 2C-PRINT-LINE.
           MOVE WD-LINE19 TO OUTPUT-REC.
           MOVE 2 TO WA-LINE-THROW.
           PERFORM 2C-PRINT-LINE.

       4D-EXIT.
           EXIT.

       5A-PRINT-FIRST-LINE SECTION.
       5A-ENTRY.
           DISPLAY "PRINT-FIRST-LINE".
           ADD 1 TO WA-PAGE-COUNT.
           MOVE WA-PAGE-COUNT TO WC-L2-PAGE-NO.
           MOVE WC-LINE2 TO OUTPUT-REC.
           WRITE OUTPUT-REC AFTER NEW-PAGE
       5A-EXIT.
           EXIT.
