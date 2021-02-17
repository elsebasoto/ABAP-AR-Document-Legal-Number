class ZCL_SD_DOCUMENT_LEGAL_NUMBER definition
  public
  inheriting from ZCL_CA_DOCUMENT_LEGAL_NUMBER
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !VBELN type VBELN_VF
    raising
      CX_T100_MSG .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_DOCUMENT_LEGAL_NUMBER IMPLEMENTATION.


METHOD constructor.

  DATA: lv_xblnr TYPE vbrk-xblnr,
        lv_msgv1 TYPE string.

  SELECT SINGLE xblnr
  FROM vbrk
  INTO lv_xblnr
  WHERE vbeln EQ vbeln.

  IF sy-subrc NE 0.

    lv_msgv1 = vbeln.

    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = 'VF'
        t100_msgno = 041
        t100_msgv1 = lv_msgv1.

  ENDIF.

  CALL METHOD super->constructor
    EXPORTING
      xblnr = lv_xblnr.

ENDMETHOD.
ENDCLASS.
