class ZCL_CA_DOCUMENT_LEGAL_NUMBER definition
  public
  abstract
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !XBLNR type XBLNR
    raising
      CX_T100_MSG .
  methods VALIDATE_XBLNR_FORMAT
    returning
      value(RESULT) type BOOLEAN
    raising
      CX_DYNAMIC_CHECK .
  methods SPLIT_XBLNR
    exporting
      !BRANCH type CHAR5
      !LETTER type J_1APCHAR
      !NUMBER type CHAR8
    raising
      CX_SY_RANGE_OUT_OF_BOUNDS .
  methods GET_XBLNR
    returning
      value(XBLNR) type XBLNR .
protected section.
private section.

  data XBLNR type XBLNR .
  constants C_REGEX_TO_VALIDATE type STRING value '^\d{4,5}[ABCEM]{1}\d{8}$' ##NO_TEXT.
  constants C_REGEX_TO_SPLIT type STRING value '[ABCEM]{1}' ##NO_TEXT.

  methods REGEX_VALIDATION
    importing
      !TEXT type XBLNR
      !PATTERN type STRING
    returning
      value(RESULT) type BOOLEAN
    raising
      CX_DYNAMIC_CHECK .
ENDCLASS.



CLASS ZCL_CA_DOCUMENT_LEGAL_NUMBER IMPLEMENTATION.


METHOD constructor.

  IF xblnr IS INITIAL.
    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = 'SLS_LORD'
        t100_msgno = 018
        t100_msgv1 = 'XBLNR'.
  ENDIF.

  me->xblnr = xblnr.

ENDMETHOD.


METHOD get_xblnr.

  xblnr = me->xblnr.

ENDMETHOD.


METHOD regex_validation.

  DATA: ol_matcher TYPE REF TO cl_abap_matcher,
        ol_regex   TYPE REF TO cl_abap_regex.

  CREATE OBJECT ol_regex
    EXPORTING
      pattern = pattern.

  CREATE OBJECT ol_matcher
    EXPORTING
      regex = ol_regex
      text  = text.

  CALL METHOD ol_matcher->match
    RECEIVING
      success = result.


ENDMETHOD.


METHOD split_xblnr.

  DATA: lv_offset TYPE i.

  FIND FIRST OCCURRENCE OF REGEX me->c_regex_to_split IN me->xblnr MATCH OFFSET lv_offset.

  letter = me->xblnr+lv_offset(1).

  lv_offset = lv_offset + 1.

  number = me->xblnr+lv_offset.

ENDMETHOD.


METHOD validate_xblnr_format.

  result = me->regex_validation( text    = me->xblnr
                                 pattern = me->c_regex_to_validate ).

ENDMETHOD.
ENDCLASS.
