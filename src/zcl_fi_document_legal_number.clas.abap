class ZCL_FI_DOCUMENT_LEGAL_NUMBER definition
  public
  inheriting from ZCL_CA_DOCUMENT_LEGAL_NUMBER
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !BKPF_KEY type BKPF_KEY
    raising
      CX_T100_MSG .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FI_DOCUMENT_LEGAL_NUMBER IMPLEMENTATION.


METHOD constructor.

  DATA: lv_xblnr  TYPE bkpf-xblnr,
        lv_msgv1  TYPE string,
        lv_msgv2  TYPE string,
        lv_msgv3  TYPE string.

  SELECT SINGLE xblnr
  FROM bkpf
  INTO lv_xblnr
  WHERE bukrs EQ bkpf_key-bukrs
    AND belnr EQ bkpf_key-belnr
    AND gjahr EQ bkpf_key-gjahr.

  IF sy-subrc NE 0.

    lv_msgv1 = bkpf_key-bukrs.
    lv_msgv2 = bkpf_key-belnr.
    lv_msgv3 = bkpf_key-gjahr.

    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = 'F5A'
        t100_msgno = 397
        t100_msgv1 = lv_msgv1
        t100_msgv2 = lv_msgv2
        t100_msgv3 = lv_msgv3.

  ENDIF.

  CALL METHOD super->constructor
    EXPORTING
      xblnr = lv_xblnr.

ENDMETHOD.
ENDCLASS.
