# ABAP AR Document Legal Number
Class to help you when you need work with argentinian legal document number (XBLNR)

## ZCL_CA_DOCUMENT_LEGAL_NUMBER Class:

This is the main class and need an XBLNR value to work. This class allow branch with 4 of 5 digits. AFIP add the fifth digit with the RG 4290.

#### VALIDATE_XBLNR_FORMAT
 This method return true 'X' or false ' ' if the XBLNR value it's valid.  Here a regular expresion with C_REGEX_TO_VALIDATE constant attribute is executed.

Examples:
* Valid: 1234A12345678
* Valid: 01234M12345678
* Invalid: A0123412345678

#### SPLIT_XBLNR

This method return the splitted value in branch, letter and number. To do this, use the C_REGEX_TO_SPLIT constant attribute.

Example:
* XBLNR = '02531A87654321' => Branch = '02531' ; Letter = 'A' ; Number = '87654321'

### ZCL_SD_DOCUMENT_LEGAL_NUMBER, ZCL_FI_DOCUMENT_LEGAL_NUMBER and ZCL_MM_DOCUMENT_LEGAL_NUMBER Classes:

These child classes serve as a bridge between the SAP document and the legal number to use the same functions of the inherited class
