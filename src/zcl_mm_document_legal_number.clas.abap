class ZCL_MM_DOCUMENT_LEGAL_NUMBER definition
  public
  inheriting from ZCL_CA_DOCUMENT_LEGAL_NUMBER
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !RBKP_KEY type RBKP_KEY
    raising
      CX_T100_MSG .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_DOCUMENT_LEGAL_NUMBER IMPLEMENTATION.


METHOD constructor.

  DATA: lv_xblnr  TYPE bkpf-xblnr,
        lv_msgv1  TYPE string,
        lv_msgv2  TYPE string.

  SELECT SINGLE xblnr
  FROM rbkp
  INTO lv_xblnr
  WHERE belnr EQ rbkp_key-belnr
    AND gjahr EQ rbkp_key-gjahr.

  IF sy-subrc NE 0.

    lv_msgv1 = rbkp_key-belnr.
    lv_msgv2 = rbkp_key-gjahr.

    RAISE EXCEPTION TYPE cx_t100_msg
      EXPORTING
        t100_msgid = 'M8'
        t100_msgno = 184
        t100_msgv1 = lv_msgv1
        t100_msgv2 = lv_msgv2.

  ENDIF.

  CALL METHOD super->constructor
    EXPORTING
      xblnr = lv_xblnr.

ENDMETHOD.
ENDCLASS.
