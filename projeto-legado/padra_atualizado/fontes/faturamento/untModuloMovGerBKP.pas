unit untModuloMovGer;

interface

uses
  SysUtils, Classes, DB,   Uni,
  Variants, Forms;

type
  TfrmModuloMovGer = class(TDataModule)
    qryMovGer: TUniQuery;
    qryMovGerGER_CODEMP: TStringField;
    qryMovGerGER_NUMDOC: TStringField;
    qryMovGerGER_ESPDOC: TStringField;
    qryMovGerGER_CODVEN: TStringField;
    qryMovGerGER_CODTRA: TStringField;
    qryMovGerGER_CODFOR: TStringField;
    qryMovGerGER_CODCLI: TStringField;
    qryMovGerGER_TIP_FC: TStringField;
    qryMovGerGER_SERIE_: TStringField;
    qryMovGerGER_DTAENT: TDateField;
    qryMovGerGER_HORENT: TTimeField;
    qryMovGerGER_DTADOC: TDateField;
    qryMovGerGER_CONPAG: TStringField;
    qryMovGerGER_ESTADO: TStringField;
    qryMovGerGER_NOMCON: TStringField;
    qryMovGerGER_ENDCON: TStringField;
    qryMovGerGER_BAICON: TStringField;
    qryMovGerGER_CEPCON: TStringField;
    qryMovGerGER_CIDCON: TStringField;
    qryMovGerGER_ESTCON: TStringField;
    qryMovGerGER_TELCON: TStringField;
    qryMovGerGER_CGCCPF: TLargeintField;
    qryMovGerGER_CGCCON: TStringField;
    qryMovGerGER_IESCON: TStringField;
    qryMovGerGER_BASSIM: TFloatField;
    qryMovGerGER_BASIPI: TFloatField;
    qryMovGerGER_ALQIPI: TFloatField;
    qryMovGerGER_TOTIPI: TFloatField;
    qryMovGerGER_BASICM: TFloatField;
    qryMovGerGER_ALQICM: TFloatField;
    qryMovGerGER_TOTICM: TFloatField;
    qryMovGerGER_TOTRET: TFloatField;
    qryMovGerGER_ALQRET: TFloatField;
    qryMovGerGER_BASRET: TFloatField;
    qryMovGerGER_DESESP: TFloatField;
    qryMovGerGER_VLRCON: TFloatField;
    qryMovGerGER_TOTPRO: TFloatField;
    qryMovGerGER_TOTCUS: TFloatField;
    qryMovGerGER_TOTMED: TFloatField;
    qryMovGerGER_TIPFRE: TStringField;
    qryMovGerGER_TOTFRE: TFloatField;
    qryMovGerGER_PESBRU: TFloatField;
    qryMovGerGER_PESLIQ: TFloatField;
    qryMovGerGER_VOLUME: TFloatField;
    qryMovGerGER_ESPECI: TStringField;
    qryMovGerGER_MARCA_: TStringField;
    qryMovGerGER_MEN001: TStringField;
    qryMovGerGER_MEN002: TStringField;
    qryMovGerGER_JAFATU: TSmallintField;
    qryMovGerGER_TIPFAT: TStringField;
    qryMovGerGER_NUMFAT: TStringField;
    qryMovGerGER_DTAFAT: TDateField;
    qryMovGerGER_VENFAT: TStringField;
    qryMovGerGER_CNDFAT: TStringField;
    qryMovGerGER_VALFAT: TFloatField;
    qryMovGerGER_VPAR01: TFloatField;
    qryMovGerGER_VPAR02: TFloatField;
    qryMovGerGER_VPAR03: TFloatField;
    qryMovGerGER_VPAR04: TFloatField;
    qryMovGerGER_VPAR05: TFloatField;
    qryMovGerGER_VPAR06: TFloatField;
    qryMovGerGER_VPAR07: TFloatField;
    qryMovGerGER_VPAR08: TFloatField;
    qryMovGerGER_VPAR09: TFloatField;
    qryMovGerGER_VPAR10: TFloatField;
    qryMovGerGER_VPAR11: TFloatField;
    qryMovGerGER_VPAR12: TFloatField;
    qryMovGerGER_NOTESP: TStringField;
    qryMovGerGER_CLAFIS: TStringField;
    qryMovGerGER_CODDIG: TStringField;
    qryMovGerGER_PORDES: TFloatField;
    qryMovGerGER_R_GCON: TStringField;
    qryMovGerX: TUniQuery;
    qryMovGerXGER_CODEMP: TStringField;
    qryMovGerXGER_NUMDOC: TStringField;
    qryMovGerXGER_ESPDOC: TStringField;
    qryMovGerXGER_CODTRA: TStringField;
    qryMovGerXGER_CODVEN: TStringField;
    qryMovGerXGER_CODFOR: TStringField;
    qryMovGerXGER_CODCLI: TStringField;
    qryMovGerXGER_TIP_FC: TStringField;
    qryMovGerXGER_SERIE_: TStringField;
    qryMovGerXGER_DTAENT: TDateField;
    qryMovGerXGER_HORENT: TTimeField;
    qryMovGerXGER_DTADOC: TDateField;
    qryMovGerXGER_CONPAG: TStringField;
    qryMovGerXGER_ESTADO: TStringField;
    qryMovGerXGER_NOMCON: TStringField;
    qryMovGerXGER_ENDCON: TStringField;
    qryMovGerXGER_BAICON: TStringField;
    qryMovGerXGER_CEPCON: TStringField;
    qryMovGerXGER_CIDCON: TStringField;
    qryMovGerXGER_ESTCON: TStringField;
    qryMovGerXGER_TELCON: TStringField;
    qryMovGerXGER_CGCCPF: TLargeintField;
    qryMovGerXGER_CGCCON: TStringField;
    qryMovGerXGER_IESCON: TStringField;
    qryMovGerXGER_BASSIM: TFloatField;
    qryMovGerXGER_BASIPI: TFloatField;
    qryMovGerXGER_ALQIPI: TFloatField;
    qryMovGerXGER_TOTIPI: TFloatField;
    qryMovGerXGER_BASICM: TFloatField;
    qryMovGerXGER_ALQICM: TFloatField;
    qryMovGerXGER_TOTICM: TFloatField;
    qryMovGerXGER_TOTRET: TFloatField;
    qryMovGerXGER_ALQRET: TFloatField;
    qryMovGerXGER_BASRET: TFloatField;
    qryMovGerXGER_DESESP: TFloatField;
    qryMovGerXGER_VLRCON: TFloatField;
    qryMovGerXGER_TOTPRO: TFloatField;
    qryMovGerXGER_TOTCUS: TFloatField;
    qryMovGerXGER_TOTMED: TFloatField;
    qryMovGerXGER_TIPFRE: TStringField;
    qryMovGerXGER_TOTFRE: TFloatField;
    qryMovGerXGER_PESBRU: TFloatField;
    qryMovGerXGER_PESLIQ: TFloatField;
    qryMovGerXGER_VOLUME: TFloatField;
    qryMovGerXGER_ESPECI: TStringField;
    qryMovGerXGER_MARCA_: TStringField;
    qryMovGerXGER_MEN001: TStringField;
    qryMovGerXGER_MEN002: TStringField;
    qryMovGerXGER_JAFATU: TSmallintField;
    qryMovGerXGER_TIPFAT: TStringField;
    qryMovGerXGER_NUMFAT: TStringField;
    qryMovGerXGER_DTAFAT: TDateField;
    qryMovGerXGER_VENFAT: TStringField;
    qryMovGerXGER_CNDFAT: TStringField;
    qryMovGerXGER_VALFAT: TFloatField;
    qryMovGerXGER_VPAR01: TFloatField;
    qryMovGerXGER_VPAR02: TFloatField;
    qryMovGerXGER_VPAR03: TFloatField;
    qryMovGerXGER_VPAR04: TFloatField;
    qryMovGerXGER_VPAR05: TFloatField;
    qryMovGerXGER_VPAR06: TFloatField;
    qryMovGerXGER_VPAR07: TFloatField;
    qryMovGerXGER_VPAR08: TFloatField;
    qryMovGerXGER_VPAR09: TFloatField;
    qryMovGerXGER_VPAR10: TFloatField;
    qryMovGerXGER_VPAR11: TFloatField;
    qryMovGerXGER_VPAR12: TFloatField;
    qryMovGerXGER_NOTESP: TStringField;
    qryMovGerXGER_CLAFIS: TStringField;
    qryMovGerXGER_CODDIG: TStringField;
    qryMovGerXGER_PORDES: TFloatField;
    qryMovGerXGER_R_GCON: TStringField;
    qryMovDet: TUniQuery;
    qryMovDetDET_CODEMP: TStringField;
    qryMovDetDET_CODITE: TStringField;
    qryMovDetDET_CODVEN: TStringField;
    qryMovDetDET_CODDIV: TStringField;
    qryMovDetDET_CODMAR: TStringField;
    qryMovDetDET_CODFOR: TStringField;
    qryMovDetDET_CODCLI: TStringField;
    qryMovDetDET_NUMDOC: TStringField;
    qryMovDetDET_ESPDOC: TStringField;
    qryMovDetDET_SERIE_: TStringField;
    qryMovDetDET_DTAENT: TDateField;
    qryMovDetDET_HORENT: TTimeField;
    qryMovDetDET_DTADOC: TDateField;
    qryMovDetDET_CONPAG: TStringField;
    qryMovDetDET_TIP_FC: TStringField;
    qryMovDetDET_ESTADO: TStringField;
    qryMovDetDET_DESCRI: TStringField;
    qryMovDetDET_UNIDAD: TStringField;
    qryMovDetDET_FORITE: TStringField;
    qryMovDetDET_QTDITE: TFloatField;
    qryMovDetDET_UNITAR: TFloatField;
    qryMovDetDET_UNIORI: TFloatField;
    qryMovDetDET_TOTITE: TFloatField;
    qryMovDetDET_VLRCON: TFloatField;
    qryMovDetDET_TOTCUS: TFloatField;
    qryMovDetDET_TOTMED: TFloatField;
    qryMovDetDET_DESCON: TFloatField;
    qryMovDetDET_TOTFRE: TFloatField;
    qryMovDetDET_DESESP: TFloatField;
    qryMovDetDET_DESACE: TFloatField;
    qryMovDetDET_CODREP: TStringField;
    qryMovDetDET_PERCOM: TFloatField;
    qryMovDetDET_TOTCOM: TFloatField;
    qryMovDetDET_CLAFIS: TStringField;
    qryMovDetDET_CODFIS: TStringField;
    qryMovDetDET_VALIPI: TFloatField;
    qryMovDetDET_ALQIPI: TFloatField;
    qryMovDetDET_BASIPI: TFloatField;
    qryMovDetDET_VALICM: TFloatField;
    qryMovDetDET_ALQICM: TFloatField;
    qryMovDetDET_BASICM: TFloatField;
    qryMovDetDET_VALRET: TFloatField;
    qryMovDetDET_ALQRET: TFloatField;
    qryMovDetDET_BASRET: TFloatField;
    qryMovDetDET_TOTPES: TFloatField;
    qryMovDetDET_PERBAS: TFloatField;
    qryMovDetDET_PERRED: TFloatField;
    qryMovDetDET_JAFATU: TSmallintField;
    qryMovDetDET_TIPFAT: TStringField;
    qryMovDetDET_NUMFAT: TStringField;
    qryMovDetDET_DTAFAT: TDateField;
    qryMovDetDET_VENFAT: TStringField;
    qryMovDetDET_CNDFAT: TStringField;
    qryMovDetDET_VALFAT: TFloatField;
    qryMovDetDET_IDEPRO: TStringField;
    qryMovDetDET_INCPIS: TStringField;
    qryMovDetDET_NOTESP: TStringField;
    qryMovDetDET_REFERE: TStringField;
    qryMovDetDET_DOCDEV: TStringField;
    qryMovDetDET_ESPDEV: TStringField;
    qryMovDetDET_EMPDEV: TStringField;
    qryMovDetDET_ITETIN: TStringField;
    qryMovDetDET_ITECHA: TStringField;
    qryMovDetDET_DESCOR: TStringField;
    qryMovDetDET_TIPEMB: TStringField;
    qryMovDetDET_QTDEMB: TFloatField;
    qryMovDetDET_PREEMB: TFloatField;
    qryMovDetDET_TIPPRE: TStringField;
    qryMovDetDET_PRVTIN: TFloatField;
    qryMovDetDET_PRCTIN: TFloatField;
    qryMovDetDET_FATTIN: TFloatField;
    qryMovDetDET_PROEMB: TStringField;
    qryMovDetDET_CODDIG: TStringField;
    qryMovDetX: TUniQuery;
    qryMovDetXDET_CODEMP: TStringField;
    qryMovDetXDET_CODVEN: TStringField;
    qryMovDetXDET_CODITE: TStringField;
    qryMovDetXDET_CODDIV: TStringField;
    qryMovDetXDET_CODMAR: TStringField;
    qryMovDetXDET_CODFOR: TStringField;
    qryMovDetXDET_CODCLI: TStringField;
    qryMovDetXDET_NUMDOC: TStringField;
    qryMovDetXDET_ESPDOC: TStringField;
    qryMovDetXDET_SERIE_: TStringField;
    qryMovDetXDET_DTAENT: TDateField;
    qryMovDetXDET_HORENT: TTimeField;
    qryMovDetXDET_DTADOC: TDateField;
    qryMovDetXDET_CONPAG: TStringField;
    qryMovDetXDET_TIP_FC: TStringField;
    qryMovDetXDET_ESTADO: TStringField;
    qryMovDetXDET_DESCRI: TStringField;
    qryMovDetXDET_REFERE: TStringField;
    qryMovDetXDET_UNIDAD: TStringField;
    qryMovDetXDET_FORITE: TStringField;
    qryMovDetXDET_QTDITE: TFloatField;
    qryMovDetXDET_UNITAR: TFloatField;
    qryMovDetXDET_UNIORI: TFloatField;
    qryMovDetXDET_TOTITE: TFloatField;
    qryMovDetXDET_VLRCON: TFloatField;
    qryMovDetXDET_TOTCUS: TFloatField;
    qryMovDetXDET_TOTMED: TFloatField;
    qryMovDetXDET_DESCON: TFloatField;
    qryMovDetXDET_TOTFRE: TFloatField;
    qryMovDetXDET_DESESP: TFloatField;
    qryMovDetXDET_DESACE: TFloatField;
    qryMovDetXDET_CODREP: TStringField;
    qryMovDetXDET_PERCOM: TFloatField;
    qryMovDetXDET_TOTCOM: TFloatField;
    qryMovDetXDET_CLAFIS: TStringField;
    qryMovDetXDET_CODFIS: TStringField;
    qryMovDetXDET_VALIPI: TFloatField;
    qryMovDetXDET_ALQIPI: TFloatField;
    qryMovDetXDET_BASIPI: TFloatField;
    qryMovDetXDET_VALICM: TFloatField;
    qryMovDetXDET_ALQICM: TFloatField;
    qryMovDetXDET_BASICM: TFloatField;
    qryMovDetXDET_VALRET: TFloatField;
    qryMovDetXDET_ALQRET: TFloatField;
    qryMovDetXDET_BASRET: TFloatField;
    qryMovDetXDET_TOTPES: TFloatField;
    qryMovDetXDET_PERBAS: TFloatField;
    qryMovDetXDET_PERRED: TFloatField;
    qryMovDetXDET_JAFATU: TSmallintField;
    qryMovDetXDET_TIPFAT: TStringField;
    qryMovDetXDET_NUMFAT: TStringField;
    qryMovDetXDET_DTAFAT: TDateField;
    qryMovDetXDET_VENFAT: TStringField;
    qryMovDetXDET_CNDFAT: TStringField;
    qryMovDetXDET_VALFAT: TFloatField;
    qryMovDetXDET_IDEPRO: TStringField;
    qryMovDetXDET_INCPIS: TStringField;
    qryMovDetXDET_NOTESP: TStringField;
    qryMovDetXDET_DOCDEV: TStringField;
    qryMovDetXDET_ESPDEV: TStringField;
    qryMovDetXDET_EMPDEV: TStringField;
    qryMovDetXDET_ITETIN: TStringField;
    qryMovDetXDET_ITECHA: TStringField;
    qryMovDetXDET_DESCOR: TStringField;
    qryMovDetXDET_TIPEMB: TStringField;
    qryMovDetXDET_QTDEMB: TFloatField;
    qryMovDetXDET_PREEMB: TFloatField;
    qryMovDetXDET_TIPPRE: TStringField;
    qryMovDetXDET_PRVTIN: TFloatField;
    qryMovDetXDET_PRCTIN: TFloatField;
    qryMovDetXDET_FATTIN: TFloatField;
    qryMovDetXDET_PROEMB: TStringField;
    qryMovDetXDET_CODDIG: TStringField;
    qryMovGerGER_CODCND: TStringField;
    qryMovGerXGER_CODCND: TStringField;
    qryMovDetDET_CODCND: TStringField;
    qryMovDetXDET_CODCND: TStringField;
    qryMovGerGER_CODFPG: TStringField;
    qryMovGerXGER_CODFPG: TStringField;
    qryMovDetDET_CODFPG: TStringField;
    qryMovDetXDET_CODFPG: TStringField;
    qryMovGerAUTOINCREM: TStringField;
    qryMovGerXAUTOINCREM: TStringField;
    qryMovDetAUTOINCREM: TStringField;
    qryMovDetXAUTOINCREM: TStringField;
    qryMovDetDET_SEQGER: TStringField;
    qryMovDetXDET_SEQGER: TStringField;
    qryMovGerGER_FATNOT: TFloatField;
    qryMovGerXGER_FATNOT: TFloatField;
    qryMovDetDET_ITEEMB: TStringField;
    qryMovDetDET_GRUEMB: TStringField;
    qryMovDetXDET_ITEEMB: TStringField;
    qryMovDetXDET_GRUEMB: TStringField;
    qryMovDetDET_LAZQUA: TIntegerField;
    qryMovDetXDET_LAZQUA: TIntegerField;
    qryMovGerGER_CODS01: TStringField;
    qryMovGerGER_CODS02: TStringField;
    qryMovGerGER_CODS03: TStringField;
    qryMovGerGER_CODS04: TStringField;
    qryMovGerGER_CODS05: TStringField;
    qryMovGerGER_CODS06: TStringField;
    qryMovGerGER_DESS01: TStringField;
    qryMovGerGER_DESS02: TStringField;
    qryMovGerGER_DESS03: TStringField;
    qryMovGerGER_DESS04: TStringField;
    qryMovGerGER_DESS05: TStringField;
    qryMovGerGER_DESS06: TStringField;
    qryMovGerGER_VALS01: TFloatField;
    qryMovGerGER_VALS02: TFloatField;
    qryMovGerGER_VALS03: TFloatField;
    qryMovGerGER_VALS04: TFloatField;
    qryMovGerGER_VALS05: TFloatField;
    qryMovGerGER_VALS06: TFloatField;
    qryMovGerGER_PRAENT: TIntegerField;
    qryMovGerGER_TOTSER: TFloatField;
    qryMovGerGER_PERISS: TFloatField;
    qryMovGerGER_VALISS: TFloatField;
    qryMovGerXGER_CODS01: TStringField;
    qryMovGerXGER_CODS02: TStringField;
    qryMovGerXGER_CODS03: TStringField;
    qryMovGerXGER_CODS04: TStringField;
    qryMovGerXGER_CODS05: TStringField;
    qryMovGerXGER_CODS06: TStringField;
    qryMovGerXGER_DESS01: TStringField;
    qryMovGerXGER_DESS02: TStringField;
    qryMovGerXGER_DESS03: TStringField;
    qryMovGerXGER_DESS04: TStringField;
    qryMovGerXGER_DESS05: TStringField;
    qryMovGerXGER_DESS06: TStringField;
    qryMovGerXGER_VALS01: TFloatField;
    qryMovGerXGER_VALS02: TFloatField;
    qryMovGerXGER_VALS03: TFloatField;
    qryMovGerXGER_VALS04: TFloatField;
    qryMovGerXGER_VALS05: TFloatField;
    qryMovGerXGER_VALS06: TFloatField;
    qryMovGerXGER_PRAENT: TIntegerField;
    qryMovGerXGER_TOTSER: TFloatField;
    qryMovGerXGER_PERISS: TFloatField;
    qryMovGerXGER_VALISS: TFloatField;
    qryMovGerGER_CLAFI2: TStringField;
    qryMovGerGER_CLAFI3: TStringField;
    qryMovGerGER_NATOPE: TStringField;
    qryMovGerXGER_CLAFI2: TStringField;
    qryMovGerXGER_CLAFI3: TStringField;
    qryMovGerXGER_NATOPE: TStringField;
    qryMovDetDET_PROMOC: TStringField;
    qryMovDetXDET_PROMOC: TStringField;
    qryMovDetDET_SEQTIN: TStringField;
    qryMovDetXDET_SEQTIN: TStringField;
    qryMovDetDET_CODVE2: TStringField;
    qryMovDetDET_TOTCO2: TFloatField;
    qryMovDetXDET_CODVE2: TStringField;
    qryMovDetXDET_TOTCO2: TFloatField;
    qryMovDetDET_QTDPUL: TFloatField;
    qryMovDetXDET_QTDPUL: TFloatField;
    qryMovDetDET_PEDCOM: TStringField;
    qryMovDetXDET_PEDCOM: TStringField;
    qryMovGerGER_DESACE: TFloatField;
    qryMovGerXGER_DESACE: TFloatField;
    qryMovGerGER_ORIDOC: TStringField;
    qryMovGerXGER_ORIDOC: TStringField;
    qryMovDetDET_ORIDOC: TStringField;
    qryMovDetXDET_ORIDOC: TStringField;
    qryMovGerGER_DTAROM: TDateField;
    qryMovGerGER_HORROM: TTimeField;
    qryMovGerGER_OPEROM: TStringField;
    qryMovGerGER_NUMROM: TStringField;
    qryMovGerGER_CONENT: TStringField;
    qryMovGerXGER_DTAROM: TDateField;
    qryMovGerXGER_HORROM: TTimeField;
    qryMovGerXGER_OPEROM: TStringField;
    qryMovGerXGER_NUMROM: TStringField;
    qryMovGerXGER_CONENT: TStringField;
    qryMovGerGER_IMPRES: TSmallintField;
    qryMovGerXGER_IMPRES: TSmallintField;
    qryMovGerGER_CODREP: TStringField;
    qryMovGerXGER_CODREP: TStringField;
    qryMovGerGER_VALROM: TFloatField;
    qryMovGerXGER_VALROM: TFloatField;
    qryMovDetDET_IMPRES: TSmallintField;
    qryMovDetDET_QTDROM: TFloatField;
    qryMovDetXDET_IMPRES: TSmallintField;
    qryMovDetXDET_QTDROM: TFloatField;
    qryMovDetDET_NUM_PD: TStringField;
    qryMovDetDET_ESP_PD: TStringField;
    qryMovDetDET_EMP_PD: TStringField;
    qryMovDetXDET_NUM_PD: TStringField;
    qryMovDetXDET_ESP_PD: TStringField;
    qryMovDetXDET_EMP_PD: TStringField;
    qryMovDetDET_IND_PD: TIntegerField;
    qryMovDetXDET_IND_PD: TIntegerField;
    qryMovGerGER_ALQIRF: TFloatField;
    qryMovGerGER_VALIRF: TFloatField;
    qryMovGerGER_ALQPIS: TFloatField;
    qryMovGerGER_VALPIS: TFloatField;
    qryMovGerGER_ALQCOF: TFloatField;
    qryMovGerGER_VALCOF: TFloatField;
    qryMovGerGER_ALQCSL: TFloatField;
    qryMovGerGER_VALCSL: TFloatField;
    qryMovGerGER_IRFRET: TFloatField;
    qryMovGerGER_PISRET: TFloatField;
    qryMovGerGER_COFRET: TFloatField;
    qryMovGerGER_CSLRET: TFloatField;
    qryMovGerGER_SERRET: TFloatField;
    qryMovGerGER_NOTRET: TStringField;
    qryMovGerGER_NORESE: TStringField;
    qryMovGerGER_ALIRFP: TFloatField;
    qryMovGerGER_ALPISP: TFloatField;
    qryMovGerGER_ALCOFP: TFloatField;
    qryMovGerGER_ALCSLP: TFloatField;
    qryMovGerXGER_ALQIRF: TFloatField;
    qryMovGerXGER_VALIRF: TFloatField;
    qryMovGerXGER_ALQPIS: TFloatField;
    qryMovGerXGER_VALPIS: TFloatField;
    qryMovGerXGER_ALQCOF: TFloatField;
    qryMovGerXGER_VALCOF: TFloatField;
    qryMovGerXGER_ALQCSL: TFloatField;
    qryMovGerXGER_VALCSL: TFloatField;
    qryMovGerXGER_IRFRET: TFloatField;
    qryMovGerXGER_PISRET: TFloatField;
    qryMovGerXGER_COFRET: TFloatField;
    qryMovGerXGER_CSLRET: TFloatField;
    qryMovGerXGER_SERRET: TFloatField;
    qryMovGerXGER_NOTRET: TStringField;
    qryMovGerXGER_NORESE: TStringField;
    qryMovGerXGER_ALIRFP: TFloatField;
    qryMovGerXGER_ALPISP: TFloatField;
    qryMovGerXGER_ALCOFP: TFloatField;
    qryMovGerXGER_ALCSLP: TFloatField;
    qryMovGerGER_PESGSO: TFloatField;
    qryMovGerGER_VLSGSO: TFloatField;
    qryMovGerXGER_PESGSO: TFloatField;
    qryMovGerXGER_VLSGSO: TFloatField;
    qryMovGerGER_IRPRRT: TFloatField;
    qryMovGerGER_IRPRDV: TFloatField;
    qryMovGerGER_IRSERT: TFloatField;
    qryMovGerGER_IRSEDV: TFloatField;
    qryMovGerGER_PIPRRT: TFloatField;
    qryMovGerGER_PIPRDV: TFloatField;
    qryMovGerGER_PISERT: TFloatField;
    qryMovGerGER_PISEDV: TFloatField;
    qryMovGerGER_COPRRT: TFloatField;
    qryMovGerGER_COPRDV: TFloatField;
    qryMovGerGER_COSERT: TFloatField;
    qryMovGerGER_COSEDV: TFloatField;
    qryMovGerGER_CSPRRT: TFloatField;
    qryMovGerGER_CSPRDV: TFloatField;
    qryMovGerGER_CSSERT: TFloatField;
    qryMovGerGER_CSSEDV: TFloatField;
    qryMovGerXGER_IRPRRT: TFloatField;
    qryMovGerXGER_IRPRDV: TFloatField;
    qryMovGerXGER_IRSERT: TFloatField;
    qryMovGerXGER_IRSEDV: TFloatField;
    qryMovGerXGER_PIPRRT: TFloatField;
    qryMovGerXGER_PIPRDV: TFloatField;
    qryMovGerXGER_PISERT: TFloatField;
    qryMovGerXGER_PISEDV: TFloatField;
    qryMovGerXGER_COPRRT: TFloatField;
    qryMovGerXGER_COPRDV: TFloatField;
    qryMovGerXGER_COSERT: TFloatField;
    qryMovGerXGER_COSEDV: TFloatField;
    qryMovGerXGER_CSPRRT: TFloatField;
    qryMovGerXGER_CSPRDV: TFloatField;
    qryMovGerXGER_CSSERT: TFloatField;
    qryMovGerXGER_CSSEDV: TFloatField;
    qryMovGerGER_ORDPRO: TStringField;
    qryMovGerXGER_ORDPRO: TStringField;
    qryMovDetDET_ORDPRO: TStringField;
    qryMovDetXDET_ORDPRO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function fCarregaDadosServico(strTabela, strNumDoc, strEspDoc,
      strCodEmp: String; var fltPerIss, fltValIss, fltTotSer: Double): Boolean;

    function fGravaMovGer(strNomeTabela: String;
                          Var strAutInc: String;
                          strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodTra,
                          strCodVen,
                          strCodFor,
                          strCodCli,
                          strTip_Fc: String;
                          dtaDtaEnt,
                          tmrHorEnt,
                          dtaDtaDoc: TDateTime;
                          strConPag,
                          strEstado,
                          strNomCon,
                          strEndCon,
                          strBaiCon,
                          strCepCon,
                          strCidCon,
                          strEstCon,
                          strTelCon,
                          strCgcCpf,
                          strCgcCon,
                          strIesCon,
                          strCli_Rg: String;
                          fltBasSim,
                          fltBasIpi,
                          fltAlqIpi,
                          fltTotIpi,
                          fltBasIcm,
                          fltAlqIcm,
                          fltTotIcm,
                          fltTotRet,
                          fltAlqRet,
                          fltBasRet,
                          fltDesEsp,
                          fltVlrCon,
                          fltTotPro,
                          fltTotCus,
                          fltTotMed: Double;
                          strTipFre: String;
                          fltTotFre,
                          fltPesBru,
                          fltPesLiq,
                          fltVolume: Double;
                          strEspeci,
                          strMarca,
                          strMen001,
                          strMen002: String;
                          blnJafatu: Boolean;
                          strTipFat,
                          strNumFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat,
                          fltVPar01,
                          fltVPar02,
                          fltVPar03,
                          fltVPar04,
                          fltVPar05,
                          fltVPar06,
                          fltVPar07,
                          fltVPar08,
                          fltVPar09,
                          fltVPar10,
                          fltVPar11,
                          fltVPar12: Double;
                          strSerie,
                          strNotEsp,
                          strClaFis,
                          strClaFi2,
                          strClaFi3,
                          strNatOpe: String;
                          fltPorDes: Double;
                          strCodDig,
                          strCodCnd,
                          strCodFpg: String;
                          fltFatNot: Double;
                          strCodS01,
                          strCodS02,
                          strCodS03,
                          strCodS04,
                          strCodS05,
                          strCodS06,
                          strDesS01,
                          strDesS02,
                          strDesS03,
                          strDesS04,
                          strDesS05,
                          strDesS06: String;
                          fltValS01,
                          fltValS02,
                          fltValS03,
                          fltValS04,
                          fltValS05,
                          fltValS06: Double;
                          intPraEnt: Integer;
                          fltTotSer,
                          fltPerIss,
                          fltValIss,
                          fltDesAce: Double;
                          strOriDoc,
                          strConEnt,
                          strCodRep: String;
                          fltAlqIrf,
                          fltValIrf,
                          fltAlqPis,
                          fltValPis,
                          fltAlqCof,
                          fltValCof,
                          fltAlqCsl,
                          fltValCsL,
                          fltIrfRet,
                          fltPisRet,
                          fltCofRet,
                          fltCslRet: Double;
                          strNotRet: String;
                          fltAlIrfP,
                          fltAlPisP,
                          fltAlCofP,
                          fltAlCslP,
                          fltSerRet: Double;
                          strNoReSe: String;
                          fltPeSgSo,
                          fltVlSgSo,
                          fltIrPrRt,
                          fltIrPrDv,
                          fltIrSeRt,
                          fltIrSeDv,
                          fltPiPrRt,
                          fltPiPrDv,
                          fltPiSeRt,
                          fltPiSeDv,
                          fltCoPrRt,
                          fltCoPrDv,
                          fltCoSeRt,
                          fltCoSeDv,
                          fltCsPrRt,
                          fltCsPrDv,
                          fltCsSeRt,
                          fltCsSeDv: Double;
                          strOrdPro: String): Boolean;

    function fGravaMovDet(strNomeTabela: String;
                          Var strAutInc: String;
                          strSeqGer: String;
                          strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodIte,
                          strCodVen,
                          strCodDiv,
                          strCodMar,
                          strCodFor,
                          strCodCli: String;
                          dtaDtaEnt,
                          dtaHorEnt,
                          dtaDtaDoc: TDateTime;
                          strConPag,
                          strTip_Fc,
                          strEstado,
                          strDescri,
                          strRefere,
                          strUnidad,
                          strForIte: String;
                          fltQtdIte,
                          fltUnitar,
                          fltUniOri,
                          fltTotIte,
                          fltVlrCon,
                          fltTotCus,
                          fltTotMed,
                          fltDesCon,
                          fltTotFre,
                          fltDesEsp: Double;
                          strCodRep,
                          strCodVe2: String;
                          fltPerCom,
                          fltTotCom,
                          fltTotCo2: Double;
                          strClaFis,
                          strCodFis: String;
                          fltValIpi,
                          fltAlqIpi,
                          fltBasIpi,
                          fltValIcm,
                          fltAlqIcm,
                          fltBasIcm,
                          fltValRet,
                          fltAlqRet,
                          fltBasRet,
                          fltTotPes,
                          fltPerBas,
                          fltPerRed: Double;
                          blnJafatu: Boolean;
                          strTipFat,
                          strNumFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat: Double;
                          strIdePro,
                          strIncPis,
                          strSerie: String;
                          fltDesAce: Double;
                          strNotEsp,
                          strDocDev,
                          strEspDev,
                          strEmpDev,
                          strIteCha,
                          strIteTin,
                          strDesCor,
                          strTipEmb: String;
                          fltQtdEmb,
                          fltPreEmb: Double;
                          strTipPre: String;
                          fltPrvTin,
                          fltPrcTin,
                          fltFatTin: Double;
                          strProEmb,
                          strCodDig,
                          strCodCnd,
                          strCodFpg,
                          strIteEmb,
                          strGruEmb: String;
                          intLazQua: Integer;
                          strPromoc,
                          strSeqTin: String;
                          fltQtdPul: Double;
                          strPedCom,
                          strOriDoc,
                          strNum_Pd,
                          strEsp_Pd,
                          strEmp_Pd: String;
                          intInd_Pd: Integer;
                          strOrdPro: String): Boolean;

    procedure pImprimeFatImp(strTabela, strNumDoc, strEspDoc, strCodEmp, strTip_Fc, strOriDoc: String;
      blnReimpressao: Boolean; strSaida: String = 'I'; intQtdImp: Integer = 1; blnComPre: Boolean = True;
      fltDebCli: Double = 0.0; blnDocSep: Boolean = False; blnTickIF: Boolean = False; blnIteRep: Boolean = False);

  end;

var
  frmModuloMovGer: TfrmModuloMovGer;

implementation

uses untFuncoes, untfuncoesSimples, untQckFatImp, untQckFatImpJato, untQckFatImpPDOR,
  untQckFatImpPDORJato, untQckFatImpTRDV, untQckFatImpTRDVJato,
  untQckFatImpNF, untQckFatImpNFJato, untModuloSPR, untModuloCfgRel,
  untQckFatImpPDOR40Col, untQckFatImpTRDV40Col, untQckFatImpNF40Col,
  untQckFatImp40Col, untFatImpressao, untQckFatImp30Col,
  untQckFatImpNF30Col, untQckFatImpPDOR30Col, untQckFatImpTRDV30Col;

{$R *.dfm}

function TfrmModuloMovGer.fGravaMovGer(strNomeTabela: String;
                                       Var strAutInc: String;
                                       strNumDoc,
                                       strEspDoc,
                                       strCodEmp,
                                       strCodTra,
                                       strCodVen,
                                       strCodFor,
                                       strCodCli,
                                       strTip_Fc: String;
                                       dtaDtaEnt,
                                       tmrHorEnt,
                                       dtaDtaDoc: TDateTime;
                                       strConPag,
                                       strEstado,
                                       strNomCon,
                                       strEndCon,
                                       strBaiCon,
                                       strCepCon,
                                       strCidCon,
                                       strEstCon,
                                       strTelCon,
                                       strCgcCpf,
                                       strCgcCon,
                                       strIesCon,
                                       strCli_Rg: String;
                                       fltBasSim,
                                       fltBasIpi,
                                       fltAlqIpi,
                                       fltTotIpi,
                                       fltBasIcm,
                                       fltAlqIcm,
                                       fltTotIcm,
                                       fltTotRet,
                                       fltAlqRet,
                                       fltBasRet,
                                       fltDesEsp,
                                       fltVlrCon,
                                       fltTotPro,
                                       fltTotCus,
                                       fltTotMed: Double;
                                       strTipFre: String;
                                       fltTotFre,
                                       fltPesBru,
                                       fltPesLiq,
                                       fltVolume: Double;
                                       strEspeci,
                                       strMarca,
                                       strMen001,
                                       strMen002: String;
                                       blnJafatu: Boolean;
                                       strTipFat,
                                       strNumFat: String;
                                       dtaDtaFat: TDateTime;
                                       strVenFat,
                                       strCndFat: String;
                                       fltValFat,
                                       fltVPar01,
                                       fltVPar02,
                                       fltVPar03,
                                       fltVPar04,
                                       fltVPar05,
                                       fltVPar06,
                                       fltVPar07,
                                       fltVPar08,
                                       fltVPar09,
                                       fltVPar10,
                                       fltVPar11,
                                       fltVPar12: Double;
                                       strSerie,
                                       strNotEsp,
                                       strClaFis,
                                       strClaFi2,
                                       strClaFi3,
                                       strNatOpe: String;
                                       fltPorDes: Double;
                                       strCodDig,
                                       strCodCnd,
                                       strCodFpg: String;
                                       fltFatNot: Double;
                                       strCodS01,
                                       strCodS02,
                                       strCodS03,
                                       strCodS04,
                                       strCodS05,
                                       strCodS06,
                                       strDesS01,
                                       strDesS02,
                                       strDesS03,
                                       strDesS04,
                                       strDesS05,
                                       strDesS06: String;
                                       fltValS01,
                                       fltValS02,
                                       fltValS03,
                                       fltValS04,
                                       fltValS05,
                                       fltValS06: Double;
                                       intPraEnt: Integer;
                                       fltTotSer,
                                       fltPerIss,
                                       fltValIss,
                                       fltDesAce: Double;
                                       strOriDoc,
                                       strConEnt,
                                       strCodRep: String;
                                       fltAlqIrf,
                                       fltValIrf,
                                       fltAlqPis,
                                       fltValPis,
                                       fltAlqCof,
                                       fltValCof,
                                       fltAlqCsl,
                                       fltValCsL,
                                       fltIrfRet,
                                       fltPisRet,
                                       fltCofRet,
                                       fltCslRet: Double;
                                       strNotRet: String;
                                       fltAlIrfP,
                                       fltAlPisP,
                                       fltAlCofP,
                                       fltAlCslP,
                                       fltSerRet: Double;
                                       strNoReSe: String;
                                       fltPeSgSo,
                                       fltVlSgSo,
                                       fltIrPrRt,
                                       fltIrPrDv,
                                       fltIrSeRt,
                                       fltIrSeDv,
                                       fltPiPrRt,
                                       fltPiPrDv,
                                       fltPiSeRt,
                                       fltPiSeDv,
                                       fltCoPrRt,
                                       fltCoPrDv,
                                       fltCoSeRt,
                                       fltCoSeDv,
                                       fltCsPrRt,
                                       fltCsPrDv,
                                       fltCsSeRt,
                                       fltCsSeDv: Double;
                                       strOrdPro: String): Boolean;
  Var
    strSQL: String;
    qryTblMovGer: TUniQuery;
Begin

  Result := True;

  If strNomeTabela = 'MOVGER' Then
    qryTblMovGer := qryMovGer
  Else
    qryTblMovGer := qryMovGerX;

  Try

//    If (fRetornaQtdRegistros(strNomeTabela) > 30) Then
//    Begin
//      Raise Exception.Create('O sistema excedeu o limite máximo de vendas!');
//    End;

    strAutInc := fRetAutoIncrem(strNomeTabela, strCodEmp);

    With qryTblMovGer Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('AUTOINCREM').AsString   := strAutInc;
      FieldByName('GER_NUMDOC').AsString   := strNumDoc;
      FieldByName('GER_SERIE_').AsString   := strSerie;
      FieldByName('GER_ESPDOC').AsString   := strEspDoc;
      FieldByName('GER_CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strCodTra) Then
        FieldByName('GER_CODTRA').Value    := Null
      Else
        FieldByName('GER_CODTRA').AsString := strCodTra;

      If fEmptyStr(strCodVen) Then
        FieldByName('GER_CODVEN').Value    := Null
      Else
        FieldByName('GER_CODVEN').AsString := strCodVen;

      If fEmptyStr(strCodFor) Then
        FieldByName('GER_CODFOR').Value    := Null
      Else
        FieldByName('GER_CODFOR').AsString := strCodFor;

      If fEmptyStr(strCodCli) Then
        FieldByName('GER_CODCLI').Value    := Null
      Else
        FieldByName('GER_CODCLI').AsString := strCodCli;

      FieldByName('GER_TIP_FC').AsString   := strTip_Fc;

      If (dtaDtaEnt = 0) Then
        FieldByName('GER_DTAENT').Value      := Null
      Else
        FieldByName('GER_DTAENT').AsDateTime := dtaDtaEnt;

      If (tmrHorEnt = 0) Then
        FieldByName('GER_HORENT').Value      := Null
      Else
        FieldByName('GER_HORENT').AsDateTime := tmrHorEnt;

      If (dtaDtaDoc = 0) Then
        FieldByName('GER_DTADOC').Value      := Null
      Else
        FieldByName('GER_DTADOC').AsDateTime := dtaDtaDoc;

      If fEmptyStr(fTiraCaracEspeciais(strConPag)) Then
        FieldByName('GER_CONPAG').Value := Null
      Else
        FieldByName('GER_CONPAG').AsString := fTiraCaracEspeciais(strConPag);

      FieldByName('GER_ESTADO').AsString   := strEstado;

      FieldByName('GER_NOMCON').AsString := strNomCon;
      If fEmptyStr(strNomCon) Then
//      If (fClienteConsumidor(strNomCon)) Then
      Begin
        FieldByName('GER_NOMCON').Value := Null;
        FieldByName('GER_ENDCON').Value := Null;
        FieldByName('GER_BAICON').Value := Null;
        FieldByName('GER_CEPCON').Value := Null;
        FieldByName('GER_CIDCON').Value := Null;
        FieldByName('GER_ESTCON').Value := Null;
        FieldByName('GER_TELCON').Value := Null;
        FieldByName('GER_CGCCPF').Value := Null;
        FieldByName('GER_CGCCON').Value := Null;
        FieldByName('GER_IESCON').Value := Null;
        FieldByName('GER_R_GCON').Value := Null;
      End
      Else
      Begin
        FieldByName('GER_NOMCON').AsString := strNomCon;
        FieldByName('GER_ENDCON').AsString := strEndCon;
        FieldByName('GER_BAICON').AsString := strBaiCon;
        FieldByName('GER_CEPCON').AsString := strCepCon;
        FieldByName('GER_CIDCON').AsString := strCidCon;
        FieldByName('GER_ESTCON').AsString := strEstCon;
        FieldByName('GER_TELCON').AsString := strTelCon;
        FieldByName('GER_CGCCPF').AsString := strCgcCpf;
        FieldByName('GER_CGCCON').AsString := strCgcCon;
        FieldByName('GER_IESCON').AsString := strIesCon;
        FieldByName('GER_R_GCON').AsString := strCli_Rg;
      End;

      FieldByName('GER_BASSIM').AsFloat    := fltBasSim;
      FieldByName('GER_BASIPI').AsFloat    := fltBasIpi;
      FieldByName('GER_ALQIPI').AsFloat    := fltAlqIpi;
      FieldByName('GER_TOTIPI').AsFloat    := fltTotIpi;
      FieldByName('GER_BASICM').AsFloat    := fltBasIcm;
      FieldByName('GER_ALQICM').AsFloat    := fltAlqIcm;
      FieldByName('GER_TOTICM').AsFloat    := fltTotIcm;
      FieldByName('GER_TOTRET').AsFloat    := fltTotRet;
      FieldByName('GER_ALQRET').AsFloat    := fltAlqRet;
      FieldByName('GER_BASRET').AsFloat    := fltBasRet;
      FieldByName('GER_DESESP').AsFloat    := fltDesEsp;
      FieldByName('GER_VLRCON').AsFloat    := fltVlrCon;
      FieldByName('GER_TOTPRO').AsFloat    := fltTotPro;
      FieldByName('GER_TOTCUS').AsFloat    := fltTotCus;
      FieldByName('GER_TOTMED').AsFloat    := fltTotMed;
      FieldByName('GER_TIPFRE').AsString   := strTipFre;
      FieldByName('GER_TOTFRE').AsFloat    := fltTotFre;
      FieldByName('GER_PESBRU').AsFloat    := fltPesBru;
      FieldByName('GER_PESLIQ').AsFloat    := fltPesLiq;
      FieldByName('GER_VOLUME').AsFloat    := fltVolume;
      FieldByName('GER_ESPECI').AsString   := strEspeci;
      FieldByName('GER_MARCA_').AsString   := strMarca;
      FieldByName('GER_MEN001').AsString   := strMen001;
      FieldByName('GER_MEN002').AsString   := strMen002;
      If blnJafatu Then
        FieldByName('GER_JAFATU').AsInteger := 1
      Else
        FieldByName('GER_JAFATU').AsInteger := 0;

      FieldByName('GER_TIPFAT').AsString   := strTipFat;
      FieldByName('GER_NUMFAT').AsString   := strNumFat;

      If (dtaDtaFat = 0) Then
        FieldByName('GER_DTAFAT').Value      := Null
      Else
        FieldByName('GER_DTAFAT').AsDateTime := dtaDtaFat;

      FieldByName('GER_VENFAT').AsString   := strVenFat;
      FieldByName('GER_CNDFAT').AsString   := strCndFat;
      FieldByName('GER_VALFAT').AsFloat    := fltValFat;
      FieldByName('GER_VPAR01').AsFloat    := fltVPar01;
      FieldByName('GER_VPAR02').AsFloat    := fltVPar02;
      FieldByName('GER_VPAR03').AsFloat    := fltVPar03;
      FieldByName('GER_VPAR04').AsFloat    := fltVPar04;
      FieldByName('GER_VPAR05').AsFloat    := fltVPar05;
      FieldByName('GER_VPAR06').AsFloat    := fltVPar06;
      FieldByName('GER_VPAR07').AsFloat    := fltVPar07;
      FieldByName('GER_VPAR08').AsFloat    := fltVPar08;
      FieldByName('GER_VPAR09').AsFloat    := fltVPar09;
      FieldByName('GER_VPAR10').AsFloat    := fltVPar10;
      FieldByName('GER_VPAR11').AsFloat    := fltVPar11;
      FieldByName('GER_VPAR12').AsFloat    := fltVPar12;
      FieldByName('GER_NOTESP').AsString   := strNotEsp;
      FieldByName('GER_CLAFIS').AsString   := IIF(Pos(strEspDoc, 'BR_PI_') > 0, '5999', strClaFis);
      FieldByName('GER_CLAFI2').AsString   := strClaFi2;
      FieldByName('GER_CLAFI3').AsString   := strClaFi3;
      FieldByName('GER_NATOPE').AsString   := strNatOpe;
      FieldByName('GER_PORDES').AsFloat    := fltPorDes;

      If (fEmptyStr(strCodDig)) Then
        FieldByName('GER_CODDIG').Value := Null
      Else
        FieldByName('GER_CODDIG').AsString   := strCodDig;

      If (fEmptyStr(strCodCnd)) Then
        FieldByName('GER_CODCND').Value := Null
      Else
        FieldByName('GER_CODCND').AsString   := strCodCnd;

      If (fEmptyStr(strCodFpg)) Then
        FieldByName('GER_CODFPG').Value := Null
      Else
        FieldByName('GER_CODFPG').AsString := strCodFpg;

      FieldByName('GER_FATNOT').AsFloat := fltFatNot;

      If (fEmptyStr(strCodS01)) Then
        FieldByName('GER_CODS01').Value := Null
      Else
        FieldByName('GER_CODS01').AsString := strCodS01;

      If (fEmptyStr(strCodS02)) Then
        FieldByName('GER_CODS02').Value := Null
      Else
        FieldByName('GER_CODS02').AsString := strCodS02;

      If (fEmptyStr(strCodS03)) Then
        FieldByName('GER_CODS03').Value := Null
      Else
        FieldByName('GER_CODS03').AsString := strCodS03;

      If (fEmptyStr(strCodS04)) Then
        FieldByName('GER_CODS04').Value := Null
      Else
        FieldByName('GER_CODS04').AsString := strCodS04;

      If (fEmptyStr(strCodS05)) Then
        FieldByName('GER_CODS05').Value := Null
      Else
        FieldByName('GER_CODS05').AsString := strCodS05;

      If (fEmptyStr(strCodS06)) Then
        FieldByName('GER_CODS06').Value := Null
      Else
        FieldByName('GER_CODS06').AsString := strCodS06;

      If (fEmptyStr(strDesS01)) Then
        FieldByName('GER_DESS01').Value := Null
      Else
        FieldByName('GER_DESS01').AsString := strDesS01;

      If (fEmptyStr(strDesS02)) Then
        FieldByName('GER_DESS02').Value := Null
      Else
        FieldByName('GER_DESS02').AsString := strDesS02;

      If (fEmptyStr(strDesS03)) Then
        FieldByName('GER_DESS03').Value := Null
      Else
        FieldByName('GER_DESS03').AsString := strDesS03;

      If (fEmptyStr(strDesS04)) Then
        FieldByName('GER_DESS04').Value := Null
      Else
        FieldByName('GER_DESS04').AsString := strDesS04;

      If (fEmptyStr(strDesS05)) Then
        FieldByName('GER_DESS05').Value := Null
      Else
        FieldByName('GER_DESS05').AsString := strDesS05;

      If (fEmptyStr(strDesS06)) Then
        FieldByName('GER_DESS06').Value := Null
      Else
        FieldByName('GER_DESS06').AsString := strDesS06;

      FieldByName('GER_VALS01').AsFloat   := fltValS01;
      FieldByName('GER_VALS02').AsFloat   := fltValS02;
      FieldByName('GER_VALS03').AsFloat   := fltValS03;
      FieldByName('GER_VALS04').AsFloat   := fltValS04;
      FieldByName('GER_VALS05').AsFloat   := fltValS05;
      FieldByName('GER_VALS06').AsFloat   := fltValS06;
      FieldByName('GER_PRAENT').AsInteger := intPraEnt;
      FieldByName('GER_TOTSER').AsFloat   := fltTotSer;
      FieldByName('GER_PERISS').AsFloat   := fltPerIss;
      FieldByName('GER_VALISS').AsFloat   := fltValIss;

      FieldByName('GER_DESACE').AsFloat   := fltDesAce;

      If (Not fEmptyStr(strOriDoc)) Then
        FieldByName('GER_ORIDOC').AsString := strOriDoc
      Else
        FieldByName('GER_ORIDOC').Value := Null;

      If (Not fEmptyStr(strOrdPro)) Then
        FieldByName('GER_ORDPRO').AsString := strOrdPro
      Else
        FieldByName('GER_ORDPRO').Value := Null;

      FieldByName('GER_CONENT').AsString  := strConEnt;
      FieldByName('GER_IMPRES').AsInteger := 0;
      FieldByName('GER_CODREP').AsString  := strCodRep;
      FieldByName('GER_VALROM').AsFloat   := 0.0;

      //************************************************//
      // ESSES CAMPOS REFERENTES A RETENÇÃO DE ALIQUOTA //
      //*********************************************MV*//
      FieldByName('GER_ALQIRF').AsFloat  := fltAlqIrf;
      FieldByName('GER_VALIRF').AsFloat  := fltValIrf;
      FieldByName('GER_ALQPIS').AsFloat  := fltAlqPis;
      FieldByName('GER_VALPIS').AsFloat  := fltValPis;   
      FieldByName('GER_ALQCOF').AsFloat  := fltAlqCof;
      FieldByName('GER_VALCOF').AsFloat  := fltValCof;
      FieldByName('GER_ALQCSL').AsFloat  := fltAlqCsl;
      FieldByName('GER_VALCSL').AsFloat  := fltValCsL;

      FieldByName('GER_IRFRET').AsFloat  := fltIrfRet;
      FieldByName('GER_PISRET').AsFloat  := fltPisRet;
      FieldByName('GER_COFRET').AsFloat  := fltCofRet;
      FieldByName('GER_CSLRET').AsFloat  := fltCslRet;
      FieldByName('GER_NOTRET').AsString := strNotRet;

      FieldByName('GER_ALIRFP').AsFloat  := fltAlIrfP;
      FieldByName('GER_ALPISP').AsFloat  := fltAlPisP;
      FieldByName('GER_ALCOFP').AsFloat  := fltAlCofP;
      FieldByName('GER_ALCSLP').AsFloat  := fltAlCslP;

      FieldByName('GER_SERRET').AsFloat  := fltSerRet;
      FieldByName('GER_NORESE').AsString := strNoReSe;

      FieldByName('GER_PESGSO').AsFloat  := fltPeSgSo;
      FieldByName('GER_VLSGSO').AsFloat  := fltVlSgSo;

      FieldByName('GER_IRPRRT').AsFloat  := fltIrPrRt;
      FieldByName('GER_IRPRDV').AsFloat  := fltIrPrDv;
      FieldByName('GER_IRSERT').AsFloat  := fltIrSeRt;
      FieldByName('GER_IRSEDV').AsFloat  := fltIrSeDv;
      FieldByName('GER_PIPRRT').AsFloat  := fltPiPrRt;
      FieldByName('GER_PIPRDV').AsFloat  := fltPiPrDv;
      FieldByName('GER_PISERT').AsFloat  := fltPiSeRt;
      FieldByName('GER_PISEDV').AsFloat  := fltPiSeDv;
      FieldByName('GER_COPRRT').AsFloat  := fltCoPrRt;
      FieldByName('GER_COPRDV').AsFloat  := fltCoPrDv;
      FieldByName('GER_COSERT').AsFloat  := fltCoSeRt;
      FieldByName('GER_COSEDV').AsFloat  := fltCoSeDv;
      FieldByName('GER_CSPRRT').AsFloat  := fltCsPrRt;
      FieldByName('GER_CSPRDV').AsFloat  := fltCsPrDv;
      FieldByName('GER_CSSERT').AsFloat  := fltCsSeRt;
      FieldByName('GER_CSSEDV').AsFloat  := fltCsSeDv;

      Post;

    End;


  Except
    On E: Exception Do
    Begin
      qryMovGer.Cancel;
      pMensagensErro(E.Message, '[fGravaMovGer]');
      Result := False;
    End;
  End;

End;

function TfrmModuloMovGer.fGravaMovDet(strNomeTabela: String;
                                       Var strAutInc: String;
                                       strSeqGer: String;
                                       strNumDoc,
                                       strEspDoc,
                                       strCodEmp,
                                       strCodIte,
                                       strCodVen,
                                       strCodDiv,
                                       strCodMar,
                                       strCodFor,
                                       strCodCli: String;
                                       dtaDtaEnt,
                                       dtaHorEnt,
                                       dtaDtaDoc: TDateTime;
                                       strConPag,
                                       strTip_Fc,
                                       strEstado,
                                       strDescri,
                                       strRefere,
                                       strUnidad,
                                       strForIte: String;
                                       fltQtdIte,
                                       fltUnitar,
                                       fltUniOri,
                                       fltTotIte,
                                       fltVlrCon,
                                       fltTotCus,
                                       fltTotMed,
                                       fltDesCon,
                                       fltTotFre,
                                       fltDesEsp: Double;
                                       strCodRep,
                                       strCodVe2: String;
                                       fltPerCom,
                                       fltTotCom,
                                       fltTotCo2: Double;
                                       strClaFis,
                                       strCodFis: String;
                                       fltValIpi,
                                       fltAlqIpi,
                                       fltBasIpi,
                                       fltValIcm,
                                       fltAlqIcm,
                                       fltBasIcm,
                                       fltValRet,
                                       fltAlqRet,
                                       fltBasRet,
                                       fltTotPes,
                                       fltPerBas,
                                       fltPerRed: Double;
                                       blnJafatu: Boolean;
                                       strTipFat,
                                       strNumFat: String;
                                       dtaDtaFat: TDateTime;
                                       strVenFat,
                                       strCndFat: String;
                                       fltValFat: Double;
                                       strIdePro,
                                       strIncPis,
                                       strSerie: String;
                                       fltDesAce: Double;
                                       strNotEsp,
                                       strDocDev,
                                       strEspDev,
                                       strEmpDev,
                                       strIteCha,
                                       strIteTin,
                                       strDesCor,
                                       strTipEmb: String;
                                       fltQtdEmb,
                                       fltPreEmb: Double;
                                       strTipPre: String;
                                       fltPrvTin,
                                       fltPrcTin,
                                       fltFatTin: Double;
                                       strProEmb,
                                       strCodDig,
                                       strCodCnd,
                                       strCodFpg,
                                       strIteEmb,
                                       strGruEmb: String;
                                       intLazQua: Integer;
                                       strPromoc,
                                       strSeqTin: String;
                                       fltQtdPul: Double;
                                       strPedCom,
                                       strOriDoc,
                                       strNum_Pd,
                                       strEsp_Pd,
                                       strEmp_Pd: String;
                                       intInd_Pd: Integer;
                                       strOrdPro: String): Boolean;
  Var
    strSQL: String;
    qryTblMovDet: TUniQuery;
Begin

  Result := True;

  If strNomeTabela = 'MOVDET' Then
    qryTblMovDet := qryMovDet
  Else
    qryTblMovDet := qryMovDetX;

  Try

    strAutInc := fRetAutoIncrem(strNomeTabela, strCodEmp);

    {*******************************************}
    {* QUANDO VAI GRAVAR O ITEM BASE DA TINTA  *}
    {* TIPO 2, PASSA O TIPTIN (TIPTIN = 2), P/ *}
    {* INDICAR QUE DEVE SER GRAVADO O AUTINC   *}
    {* NO SEQTIN                               *}
    {****************************************MV*}
    If (strSeqTin = '2') Then
    Begin
      strSeqTin := strAutInc;
    End;

    With qryTblMovDet Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('DET_SEQGER').AsString   := strSeqGer;
      FieldByName('DET_NUMDOC').AsString   := strNumDoc;
      FieldByName('DET_ESPDOC').AsString   := strEspDoc;
      FieldByName('DET_CODEMP').AsString   := strCodEmp;
      FieldByName('DET_CODITE').AsString   := strCodIte;

      If fEmptyStr(strCodVen) Then
        FieldByName('DET_CODVEN').Value      := Null
      Else
        FieldByName('DET_CODVEN').AsString   := strCodVen;

      If fEmptyStr(strCodDiv) Then
        FieldByName('DET_CODDIV').Value      := Null
      Else
        FieldByName('DET_CODDIV').AsString   := strCodDiv;

      If fEmptyStr(strCodMar) Then
        FieldByName('DET_CODMAR').Value      := Null
      Else
        FieldByName('DET_CODMAR').AsString   := strCodMar;

      If fEmptyStr(strCodFor) Then
        FieldByName('DET_CODFOR').Value      := Null
      Else
        FieldByName('DET_CODFOR').AsString   := strCodFor;

      If fEmptyStr(strCodCli) Then
        FieldByName('DET_CODCLI').Value      := Null
      Else
        FieldByName('DET_CODCLI').AsString   := strCodCli;

      FieldByName('DET_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('DET_HORENT').AsDateTime := dtaHorEnt;
      FieldByName('DET_DTADOC').AsDateTime := dtaDtaDoc;
      FieldByName('DET_CONPAG').AsString   := fTiraCaracEspeciais(strConPag);
      FieldByName('DET_TIP_FC').AsString   := strTip_Fc;
      FieldByName('DET_ESTADO').AsString   := strEstado;
      FieldByName('DET_DESCRI').AsString   := strDescri;
      FieldByName('DET_REFERE').AsString   := strRefere;
      FieldByName('DET_UNIDAD').AsString   := strUnidad;
      FieldByName('DET_FORITE').AsString   := strForIte;
      FieldByName('DET_QTDITE').AsFloat    := fltQtdIte;
      FieldByName('DET_UNITAR').AsFloat    := fltUnitar;
      FieldByName('DET_UNIORI').AsFloat    := fltUniOri;
      FieldByName('DET_TOTITE').AsFloat    := fltTotIte;
      FieldByName('DET_VLRCON').AsFloat    := fltVlrCon;
      FieldByName('DET_TOTCUS').AsFloat    := fltTotCus;
      FieldByName('DET_TOTMED').AsFloat    := fltTotMed;
      FieldByName('DET_DESCON').AsFloat    := fltDesCon;
      FieldByName('DET_TOTFRE').AsFloat    := fltTotFre;
      FieldByName('DET_DESESP').AsFloat    := fltDesEsp;
      FieldByName('DET_CODREP').AsString   := strCodRep;

      If fEmptyStr(strCodVe2) Then
        FieldByName('DET_CODVE2').AsVariant := Null
      Else
        FieldByName('DET_CODVE2').AsString := strCodVe2;

      FieldByName('DET_PERCOM').AsFloat    := fltPerCom;
      FieldByName('DET_TOTCOM').AsFloat    := fltTotCom;
      FieldByName('DET_TOTCO2').AsFloat    := fltTotCo2; 
      FieldByName('DET_CLAFIS').AsString   := strClaFis;
      FieldByName('DET_CODFIS').AsString   := strCodFis;
      FieldByName('DET_VALIPI').AsFloat    := fltValIpi;
      FieldByName('DET_ALQIPI').AsFloat    := fltAlqIpi;
      FieldByName('DET_BASIPI').AsFloat    := fltBasIpi;
      FieldByName('DET_VALICM').AsFloat    := fltValIcm;
      FieldByName('DET_ALQICM').AsFloat    := fltAlqIcm;
      FieldByName('DET_BASICM').AsFloat    := fltBasIcm;
      FieldByName('DET_VALRET').AsFloat    := fltValRet;
      FieldByName('DET_ALQRET').AsFloat    := fltAlqRet;
      FieldByName('DET_BASRET').AsFloat    := fltBasRet;
      FieldByName('DET_TOTPES').AsFloat    := fltTotPes;
      FieldByName('DET_PERBAS').AsFloat    := fltPerBas;
      FieldByName('DET_PERRED').AsFloat    := fltPerRed;

      If blnJaFatu Then
        FieldByName('DET_JAFATU').AsInteger  := 1
      Else
        FieldByName('DET_JAFATU').AsInteger  := 0;
        
      FieldByName('DET_TIPFAT').AsString   := strTipFat;
      FieldByName('DET_NUMFAT').AsString   := strNumFat;

      If (dtaDtaFat = 0) Then
        FieldByName('DET_DTAFAT').Value      := Null
      Else
        FieldByName('DET_DTAFAT').AsDateTime := dtaDtaFat;

      FieldByName('DET_VENFAT').AsString   := strVenFat;
      FieldByName('DET_CNDFAT').AsString   := strCndFat;
      FieldByName('DET_VALFAT').AsFloat    := fltValFat;
      FieldByName('DET_IDEPRO').AsString   := strIdePro;
      FieldByName('DET_INCPIS').AsString   := strIncPis;
      FieldByName('DET_SERIE_').AsString   := strSerie;
      FieldByName('DET_DESACE').AsFloat    := fltDesAce;
      FieldByName('DET_NOTESP').AsString   := strNotEsp;

      If (fEmptyStr(strDocDev)) Then
        FieldByName('DET_DOCDEV').Value    := Null
      Else
        FieldByName('DET_DOCDEV').AsString := strDocDev;

      If (fEmptyStr(strEspDev)) Then
        FieldByName('DET_ESPDEV').Value    := Null
      Else
        FieldByName('DET_ESPDEV').AsString := strEspDev;

      If (fEmptyStr(strEmpDev)) Then
        FieldByName('DET_EMPDEV').Value    := Null
      Else
        FieldByName('DET_EMPDEV').AsString := strEmpDev;

      FieldByName('DET_ITECHA').AsString   := strIteCha;
      FieldByName('DET_ITETIN').AsString   := strIteTin;
      FieldByName('DET_DESCOR').AsString   := strDesCor;

      FieldByName('DET_TIPEMB').AsString   := strTipEmb;
      FieldByName('DET_QTDEMB').AsFloat    := fltQtdEmb;
      FieldByName('DET_PREEMB').AsFloat    := fltPreEmb;
      FieldByName('DET_TIPPRE').AsString   := strTipPre;
      FieldByName('DET_PRVTIN').AsFloat    := fltPrvTin;
      FieldByName('DET_PRCTIN').AsFloat    := fltPrcTin;
      FieldByName('DET_FATTIN').AsFloat    := fltFatTin;
      FieldByName('DET_PROEMB').AsString   := strProEmb;

      If (fEmptyStr(strCodDig)) Then
        FieldByName('DET_CODDIG').Value := Null
      Else
        FieldByName('DET_CODDIG').AsString   := strCodDig;

      If (fEmptyStr(strCodCnd)) Then
        FieldByName('DET_CODCND').Value := Null
      Else
        FieldByName('DET_CODCND').AsString   := strCodCnd;

      If (fEmptyStr(strCodFpg)) Then
        FieldByName('DET_CODFPG').Value := Null
      Else
        FieldByName('DET_CODFPG').AsString   := strCodFpg;

      FieldByName('DET_ITEEMB').AsString  := strIteEmb;
      FieldByName('DET_GRUEMB').AsString  := strGruEmb;
      FieldByName('DET_LAZQUA').AsInteger := intLazQua;

      FieldByName('DET_PROMOC').AsString  := strPromoc;
      FieldByName('DET_SEQTIN').AsString  := strSeqTin;
      FieldByName('DET_QTDPUL').AsFloat   := fltQtdPul;

      If (fEmptyStr(strPedCom)) Then
        FieldByName('DET_PEDCOM').Value := Null
      Else
        FieldByName('DET_PEDCOM').AsString := strPedCom;

      If (fEmptyStr(strOriDoc)) Then
        FieldByName('DET_ORIDOC').Value := Null
      Else
        FieldByName('DET_ORIDOC').AsString := strOriDoc;

      If (Not fEmptyStr(strOrdPro)) Then
        FieldByName('DET_ORDPRO').AsString := strOrdPro
      Else
        FieldByName('DET_ORDPRO').Value := Null;

      FieldByName('DET_QTDROM').AsFloat  := 0.0;

      FieldByName('DET_NUM_PD').AsString  := strNum_Pd;
      FieldByName('DET_ESP_PD').AsString  := strEsp_Pd;
      FieldByName('DET_EMP_PD').AsString  := strEmp_Pd;
      FieldByName('DET_IND_PD').AsInteger := intInd_Pd;

      FieldByName('AUTOINCREM').AsString := strAutInc;

      Post;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      qryTblMovDet.Cancel;
      pMensagensErro(E.Message, '[fGravaMovDet]');
    End;
  End;

End;

{****************************}

{* IMPRESSÃO DO FATURAMENTO *}
{*************************AF*}
procedure TfrmModuloMovGer.pImprimeFatImp(strTabela, strNumDoc, strEspDoc, strCodEmp, strTip_Fc, strOriDoc: String;
  blnReimpressao: Boolean; strSaida: String = 'I'; intQtdImp: Integer = 1; blnComPre: Boolean = True;
  fltDebCli: Double = 0.0; blnDocSep: Boolean = False; blnTickIF: Boolean = False; blnIteRep: Boolean = False);
  Var
    strSQL      : String;
    strNomeFila : String;
    strTipImp   : String;
    strMeiaFolha: String;
    intContador : Integer;

    fltPerIss: Double;
    fltValIss: Double;
    fltTotSer: Double;
    blnTemServico: Boolean;
    impMatricial: TFatImpressao;
    strEspTeste: String;
    strColRel: String;
Begin

  Try

    If (VS_strMosDeb <> 'S') Then
      fltDebCli := 0.0;

    If (Pos(strEspDoc, 'MI_FF_TR_DV') <= 0) Then
      fltDebCli := 0.0;

    blnTemServico := fCarregaDadosServico(strTabela, strNumDoc, strEspDoc, strCodEmp, fltPerIss,
      fltValIss, fltTotSer);

    If Pos(strEspDoc,'PD_OR_') > 0 Then
    Begin

      If (Not blnIteRep) Then
      Begin

        strSQL := '';
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '   FDO_CODITE AS CODITE, ';
        strSQL := strSQL + '   FDO_DESCRI AS DESITE, ';
        strSQL := strSQL + '   FDO_QTDITE AS QTDITE, ';
        strSQL := strSQL + '   FDO_UNIDAD AS UNIDAD, ';
        strSQL := strSQL + '   (SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = FDO_UNIDAD) AS DESUNI, ';
        strSQL := strSQL + '   FDO_UNITAR AS VALUNI, ';
        strSQL := strSQL + '   FDO_VLRCON AS VALITE, ';
        strSQL := strSQL + '   FDO_ESPDOC, ';
        strSQL := strSQL + '   FDO_CODVEN, ';
        strSQL := strSQL + '   FDO_DTAENT, ';
        strSQL := strSQL + '   FDO_HORENT, ';
        strSQL := strSQL + '   FDO_CODEMP, ';
        strSQL := strSQL + '   MAR_DESMAR AS MARDES, ';
        strSQL := strSQL + '   CONCAT(FDO_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';
        strSQL := strSQL + '   FDO_CODFIS AS CODFIS ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + strTabela + ', ';
        strSQL := strSQL + ' CADMAR ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   FDO_CODMAR = MAR_CODMAR AND ';
        strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   FDO_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   FDO_PROEMB <> "S"    AND ';
        strSQL := strSQL + '   FDO_CODITE <> ' + QuotedStr(VS_strIteSer) + ' ';
        strSQL := strSQL + 'ORDER BY ';
        strSQL := strSQL + '  ' + strTabela + '.AUTOINCREM ) ';

        If (fTabelaExiste('TMP_SERVICOS')) Then
        Begin
          strSQL := strSQL + '   UNION ALL ';
          strSQL := strSQL + '(SELECT ';
          strSQL := strSQL + '   "", ';
          strSQL := strSQL + '   TMP_DESSER, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, '; // SE PRECISAR DO VALOR DO SERVIÇO COLOCAR AQUI
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL, ';
          strSQL := strSQL + '   NULL ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '   TMP_SERVICOS ) ';
        End;
      End
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '   R.ITE_CODITE AS CODITE, ';
        strSQL := strSQL + '   R.ITE_DESITE AS DESITE, ';
        strSQL := strSQL + '   R.ITE_QTDITE AS QTDITE, ';
        strSQL := strSQL + '   R.ITE_UNIDAD AS UNIDAD, ';
        strSQL := strSQL + '   (SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = ITE_UNIDAD) AS DESUNI, ';
        strSQL := strSQL + '   ITE_UNITAR AS VALUNI, ';
        strSQL := strSQL + '   ITE_TOTITE AS VALITE, ';
        strSQL := strSQL + '   ITE_ESPDOC AS FDO_ESPDOC, ';
        strSQL := strSQL + '   "" AS FDO_CODVEN, ';
        strSQL := strSQL + '   CURRENT_DATE AS FDO_DTAENT, ';
        strSQL := strSQL + '   CURRENT_TIME AS FDO_HORENT, ';
        strSQL := strSQL + '   R.ITE_CODEMP AS FDO_CODEMP, ';
        strSQL := strSQL + '   MAR_DESMAR AS MARDES, ';
        strSQL := strSQL + '   CONCAT(I.ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';
        strSQL := strSQL + '   "" AS CODFIS ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   ITEREP R, ';
        strSQL := strSQL + '   CADITE I, ';
        strSQL := strSQL + '   CADMAR ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   I.ITE_CODMAR = MAR_CODMAR AND ';
        strSQL := strSQL + '   I.ITE_CODITE = R.ITE_CODITE AND ';
        strSQL := strSQL + '   R.ITE_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '   R.ITE_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   R.ITE_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   R.ITE_CODITE <> ' + QuotedStr(VS_strIteSer) + ' ';
        strSQL := strSQL + 'ORDER BY ';
        strSQL := strSQL + '   R.AUTOINCREM ) ';
      End;

      If strEspDoc = 'OR' Then
        strMeiaFolha := VS_strLay_Or
      Else
        strMeiaFolha := VS_strLay_Pd;

    End
    Else
    Begin

      strSQL := '';
      strSQL := strSQL + ' (SELECT ';
      strSQL := strSQL + '   DET_CODITE AS CODITE, ';
      strSQL := strSQL + '   DET_DESCRI AS DESITE, ';
      strSQL := strSQL + '   DET_QTDITE AS QTDITE, ';
      strSQL := strSQL + '   DET_UNIDAD AS UNIDAD, ';
      strSQL := strSQL + '   (SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = DET_UNIDAD) AS DESUNI, ';
      strSQL := strSQL + '   DET_UNITAR AS VALUNI, ';
      strSQL := strSQL + '   DET_VLRCON AS VALITE, ';
      strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1) < 5,"ENT","SAI") AS ENTSAI, ';
      strSQL := strSQL + '   DET_ESPDOC, ';
      strSQL := strSQL + '   DET_CODVEN, ';
      strSQL := strSQL + '   DET_DTAENT, ';
      strSQL := strSQL + '   DET_HORENT, ';
      strSQL := strSQL + '   DET_CODEMP, ';
      strSQL := strSQL + '   MAR_DESMAR AS MARDES, ';
      strSQL := strSQL + '   CONCAT(DET_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';
      strSQL := strSQL + '   DET_CODFIS AS CODFIS ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + strTabela + ', ';
      strSQL := strSQL + '   CADMAR ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   DET_CODMAR = MAR_CODMAR AND ';
      strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';

      If Pos(strTabela,'NOTDET_NOTDETX_') <= 0 Then
      Begin
        strSQL := strSQL + '   DET_TIP_FC = :TIP_FC AND ';
      End;

      If (fEmptyStr(strOriDoc)) Then
        strSQL := strSQL + '   (DET_ORIDOC IS NULL OR DET_ORIDOC = "") AND '
      Else
        strSQL := strSQL + '   DET_ORIDOC = :ORIDOC AND ';

      strSQL := strSQL + '   DET_PROEMB <> "S"    AND ';
      strSQL := strSQL + '   DET_CODITE <> ' + QuotedStr(VS_strIteSer) + ' ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  ' + strTabela + '.AUTOINCREM )';

      If (fTabelaExiste('TMP_SERVICOS')) And (Not blnDocSep) Then
      Begin
        strSQL := strSQL + '   UNION ALL ';
        strSQL := strSQL + '(SELECT ';
        strSQL := strSQL + '   "", ';
        strSQL := strSQL + '   TMP_DESSER, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, '; // SE PRECISAR DO VALOR DO SERVIÇO COLOCAR AQUI
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL, ';
        strSQL := strSQL + '   NULL ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '   TMP_SERVICOS) ';
      End;

    End;

    With frmModuloSPR.qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodemp;

      If Pos(strEspDoc,'PD_OR_') <= 0 Then
      Begin

        If Pos(strTabela,'NOTDET_NOTDETX_') <= 0 Then
          ParamByName('TIP_FC').AsString := strTip_Fc;

        If (Not fEmptyStr(strOriDoc)) Then
          ParamByName('ORIDOC').AsString := strOriDoc;

      End;

      Open;

      strEspTeste := strEspDoc;
      If (blnDocSep) Then
        strEspTeste := 'SE';

      If (Pos(strEspTeste, VS_strEsp80c) > 0) Then
        strColRel := '80'
      Else If (Pos(strEspTeste, VS_strEsp40c) > 0) Then
        strColRel := '40'
      Else If (Pos(strEspTeste, VS_strEsp30c) > 0) Then
        strColRel := '30'
      Else If (VS_strModImp = '1') Then
        strColRel := '40'
      Else If (VS_strModImp = '2') Then
        strColRel := '80'
      Else If (VS_strModImp = '3') Then
        strColRel := '30'
      Else
        strColRel := '80';

      If (Not IsEmpty) Or ((VS_strUsaSer = 'S') And (Not blnIteRep)) Then
      Begin
        If (blnDocSep) Then
          frmModuloCfgRel.pCarregaConfImpr('frmFatVendas_SEP')
        Else
          frmModuloCfgRel.pCarregaConfImpr('frmFatVendas_' + strEspDoc);

        frmModuloCfgRel.fPreImpressao(strNomeFila,strTipImp,False);

        impMatricial := TFatImpressao.Create(strNomeFila);
        impMatricial.strColRel := strColRel;

        If (strTipImp = 'M') And (strSaida <> 'V') Then
        Begin

          For intContador := 1 To intQtdImp Do
          Begin

            If Pos(strEspDoc,'OR_PD_') > 0 Then //ALEXANDRE
            Begin

              //If (VS_strModImp = '2') Then
              If (strColRel = '80') Or  (strColRel = '40') Then
              Begin

                impMatricial.pImprime(frmModuloSPR.qryRelatorio, blnTemServico, strTabela,
                  strNumDoc, strEspDoc, strCodEmp, fltDebCli, blnReimpressao, False, blnComPre,
                  blnTickIF, blnIteRep);

              End
              //Else If VS_strModImp = '3' Then
              Else If (strColRel = '30') Then
              Begin

                Try
                  Application.CreateForm(TfrmQckFatImpPDOR30Col,frmQckFatImpPDOR30Col);
                  frmQckFatImpPDOR30Col.blnReimpressao := blnReimpressao;
                  frmQckFatImpPDOR30Col.blnComPre      := blnComPre;
                  frmQckFatImpPDOR30Col.blnIteRep      := blnIteRep;
                  If (blnTemServico) Then
                  Begin
                    frmQckFatImpPDOR30Col.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                    frmQckFatImpPDOR30Col.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                    frmQckFatImpPDOR30Col.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
                  End
                  Else
                  Begin
                    frmQckFatImpPDOR30Col.rlbTotaisServico.Visible := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME CABEÇALHO *}
                  {******************************AF*}
                  If Pos(strEspDoc,VS_strNaoCab) > 0 Then
                  Begin
                    frmQckFatImpPDOR30Col.rlbHeader1.Visible         := False;
                    frmQckFatImpPDOR30Col.rlbHeader2.Borders.DrawTop := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME DIGITADOR *}
                  {******************************AF*}
                  If VS_strUsaDig = 'S' Then
                  Begin
                    frmQckFatImpPDOR30Col.pnlDigitador.Visible   := True;
                    frmQckFatImpPDOR30Col.pnlDigitadorPD.Visible := True;
                  End
                  Else
                  Begin
                    frmQckFatImpPDOR30Col.pnlDigitador.Visible   := False;
                    frmQckFatImpPDOR30Col.pnlDigitadorPD.Visible := False;
                  End;

                  {************************************}
                  {* VERIFICA SE IMPRIME FORMA PGTO   *}
                  {*********************************AF*}
                  If VS_strUsaFpg = 'S' Then
                    frmQckFatImpPDOR30Col.pnlFormaPagto.Visible := True
                  Else
                    frmQckFatImpPDOR30Col.pnlFormaPagto.Visible := False;

                  frmQckFatImpPDOR30Col.strTabela    := strTabela;
                  frmQckFatImpPDOR30Col.strNumDoc    := strNumDoc;
                  frmQckFatImpPDOR30Col.strEspDoc    := strEspDoc;
                  frmQckFatImpPDOR30Col.strCodEmp    := strCodEmp;
                  frmQckFatImpPDOR30Col.qckPagina.PrintDialog := VS_blnDlgPri;

                  frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight - 67;
                  frmQckFatImpPDOR30Col.rlbSumario2.Height := 0;
                  frmQckFatImpPDOR30Col.rlbSumario3.Height := 0;

                  If strEspDoc = 'OR' Then
                  Begin
                    frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight + 41;
                    frmQckFatImpPDOR30Col.rlbSumario2.Height := 174;
                  End

                  Else If strEspDoc = 'PD' Then
                  Begin
                    frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight + 27;
                    frmQckFatImpPDOR30Col.rlbSumario3.Height := 112;
                  End;

                  {************************************}
                  {* AUMENTA A PAGINA DE ACORDO COM O *}
                  {* NUMERO DE REGISTROS              *}
                  {* 1 LINHA = 5                      *}
                  {* 1 REGISTRO = 8                   *}
                  {*********************************AF*}
                  If RecordCount > 1 Then
                    frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpPDOR30Col.qckPagina.PageSetup.PaperHeight + (8 * RecordCount);

                  frmQckFatImpPDOR30Col.qckPagina.Print;
                Finally
                  FreeAndNil(frmQckFatImpPDOR30Col);
                End;

              End;

            End

            Else If Pos(strEspDoc,'TR_DV_AJ_') > 0 Then
            Begin

              //If VS_strModImp = '2' Then
              If (strColRel = '80') Or (strColRel = '40') Then
              Begin

                impMatricial.pImprime(frmModuloSPR.qryRelatorio, blnTemServico, strTabela,
                  strNumDoc, strEspDoc, strCodEmp, fltDebCli, blnReimpressao);

              End
              Else If (strColRel = '30') Then
              Begin

                Try
                  Application.CreateForm(TfrmQckFatImpTRDV30Col,frmQckFatImpTRDV30Col);
                  frmQckFatImpTRDV30Col.blnReimpressao := blnReimpressao;
                  frmQckFatImpTRDV30Col.fltDebCli      := fltDebCli;
                  {*********************************}
                  {* VERIFICA SE IMPRIME CABEÇALHO *}
                  {******************************AF*}
                  If Pos(strEspDoc,VS_strNaoCab) > 0 Then
                  Begin
                    frmQckFatImpTRDV30Col.rlbHeader1.Visible         := False;
                    frmQckFatImpTRDV30Col.rlbHeader2.Borders.DrawTop := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME DIGITADOR *}
                  {******************************AF*}
                  If VS_strUsaDig = 'S' Then
                    frmQckFatImpTRDV30Col.pnlDigitador.Visible := True
                  Else
                    frmQckFatImpTRDV30Col.pnlDigitador.Visible := False;

                  {************************************}
                  {* VERIFICA SE IMPRIME FORMA PGTO   *}
                  {*********************************AF*}
                  If (VS_strUsaFpg = 'S') And (strEspDoc <> 'DV') Then
                    frmQckFatImpTRDV30Col.pnlFormaPagto.Visible := True
                  Else
                    frmQckFatImpTRDV30Col.pnlFormaPagto.Visible := False;


                  frmQckFatImpTRDV30Col.strTabela := strTabela;
                  frmQckFatImpTRDV30Col.strNumDoc := strNumDoc;
                  frmQckFatImpTRDV30Col.strEspDoc := strEspDoc;
                  frmQckFatImpTRDV30Col.strCodEmp := strCodEmp;
                  frmQckFatImpTRDV30Col.qckPagina.PrintDialog := VS_blnDlgPri;

                  {************************************}
                  {* AUMENTA A PAGINA DE ACORDO COM O *}
                  {* NUMERO DE REGISTROS              *}
                  {* 1 LINHA = 5                      *}
                  {* 1 REGISTRO = 8                   *}
                  {*********************************AF*}
                  If RecordCount > 1 Then
                    frmQckFatImpTRDV30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpTRDV30Col.qckPagina.PageSetup.PaperHeight + (8 * RecordCount);

                  frmQckFatImpTRDV30Col.qckPagina.Print;
                Finally
                  FreeAndNil(frmQckFatImpTRDV30Col);
                End;

              End;
            End


            //*************************************************//
            // FAZ A IMPRESSAO DO TICKET - CUPOM FISCAL        //
            //**********************************************ED*//
            Else If (Pos(strEspDoc,'IF') > 0) And (blnTickIF) Then
            Begin

              If (strColRel = '80') Or (strColRel = '40') Then
              Begin

                impMatricial.pImprime(frmModuloSPR.qryRelatorio,
                                      blnTemServico,
                                      strTabela,
                                      strNumDoc,
                                      strEspDoc,
                                      strCodEmp,
                                      fltDebCli,
                                      blnReimpressao,
                                      False,             // DOCUMENTO DE SEPARACAO
                                      False,             // COM PRECO
                                      True);             // IMPRESSAO DE TICKET 

              End
              Else If (strColRel = '30') Then
              Begin

                Try
                  Application.CreateForm(TfrmQckFatImpNF30Col,frmQckFatImpNF30Col);
                  frmQckFatImpNF30Col.blnReimpressao := blnReimpressao;
                  frmQckFatImpNF30Col.blnTickIF := blnTickIF;

                  If (blnTemServico) Then
                  Begin
                    frmQckFatImpNF30Col.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                    frmQckFatImpNF30Col.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                    frmQckFatImpNF30Col.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
                  End
                  Else
                  Begin
                    frmQckFatImpNF30Col.rlbTotaisServico.Visible := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME CABEÇALHO *}
                  {******************************AF*}
                  If Pos(strEspDoc,VS_strNaoCab) > 0 Then
                  Begin
                    frmQckFatImpNF30Col.rlbHeader1.Visible         := False;
                    frmQckFatImpNF30Col.rlbHeader2.Borders.DrawTop := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME DIGITADOR *}
                  {******************************AF*}
                  If VS_strUsaDig = 'S' Then
                    frmQckFatImpNF30Col.pnlDigitador.Visible := True
                  Else
                    frmQckFatImpNF30Col.pnlDigitador.Visible := False;

                  {************************************}
                  {* VERIFICA SE IMPRIME FORMA PGTO   *}
                  {*********************************AF*}
                  If (VS_strUsaFpg = 'S') And (Pos(strEspDoc,'TE_BR_') <= 0) Then
                    frmQckFatImpNF30Col.pnlFormaPagto.Visible := True
                  Else
                    frmQckFatImpNF30Col.pnlFormaPagto.Visible := False;

                  frmQckFatImpNF30Col.strTabela := strTabela;
                  frmQckFatImpNF30Col.strNumDoc := strNumDoc;
                  frmQckFatImpNF30Col.strEspDoc := strEspDoc;
                  frmQckFatImpNF30Col.strOriDoc := strOriDoc;
                  frmQckFatImpNF30Col.strCodEmp := strCodEmp;

                  //*************************************************//
                  // SE FOR A IMPRESSAO DO TICKET - CUPOM FISCAL     //
                  // ENTAO ESCONDE OS IMPOSTOS                       //
                  //**********************************************ED*//
                  frmQckFatImpNF30Col.rllBaseICMS.Visible    := False;
                  frmQckFatImpNF30Col.rllValBaseICMS.Visible := False;
                  frmQckFatImpNF30Col.rllIcms.Visible        := False;
                  frmQckFatImpNF30Col.rllValIcms.Visible     := False;
                  frmQckFatImpNF30Col.rllIcmSub.Visible      := False;
                  frmQckFatImpNF30Col.rllValIcmSub.Visible   := False;
                  frmQckFatImpNF30Col.rllFrete.Visible       := False;
                  frmQckFatImpNF30Col.rllValFrete.Visible    := False;
                  frmQckFatImpNF30Col.rllValIpi.Visible      := False;
                  frmQckFatImpNF30Col.rllValValIpi.Visible   := False;
                  frmQckFatImpNF30Col.rllTotPro.Visible      := False;
                  frmQckFatImpNF30Col.rllValTotPro.Visible   := False;

                  frmQckFatImpNF30Col.rlbSumario1.Height     := 53;
                  frmQckFatImpNF30Col.rllDescEsp.Top         := frmQckFatImpNF30Col.rllBaseICMS.Top;
                  frmQckFatImpNF30Col.rllValDescEsp.Top      := frmQckFatImpNF30Col.rllDescEsp.Top;
                  frmQckFatImpNF30Col.rllDescEsp.Caption     := 'Desc. Especial:';

                  frmQckFatImpNF30Col.rllTotPed.Top          := frmQckFatImpNF30Col.rllIcms.Top;
                  frmQckFatImpNF30Col.rllValTotPed.Top       := frmQckFatImpNF30Col.rllTotPed.Top;

                  frmQckFatImpNF30Col.qckPagina.PrintDialog := VS_blnDlgPri;

                  {************************************}
                  {* AUMENTA A PAGINA DE ACORDO COM O *}
                  {* NUMERO DE REGISTROS              *}
                  {* 1 LINHA = 5                      *}
                  {* 1 REGISTRO = 8                   *}
                  {*********************************AF*}
                  If RecordCount > 1 Then
                    frmQckFatImpNF30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpNF30Col.qckPagina.PageSetup.PaperHeight + (8 * RecordCount);

                  frmQckFatImpNF30Col.qckPagina.Print;
                Finally
                  FreeAndNil(frmQckFatImpNF30Col);
                End;

              End;
            End

            Else If (Pos(strEspDoc,'NF_IF') > 0) And (Not blnDocSep) Then
            Begin

              //If VS_strModImp = '2' Then
              If (strColRel = '80') Or (strColRel = '40') Then
              Begin

                impMatricial.pImprime(frmModuloSPR.qryRelatorio, blnTemServico, strTabela,
                  strNumDoc, strEspDoc, strCodEmp, fltDebCli, blnReimpressao);

              End
              //Else If VS_strModImp = '3' Then
              Else If (strColRel = '30') Then
              Begin

                Try
                  Application.CreateForm(TfrmQckFatImpNF30Col,frmQckFatImpNF30Col);
                  frmQckFatImpNF30Col.blnReimpressao := blnReimpressao;
                  If (blnTemServico) Then
                  Begin
                    frmQckFatImpNF30Col.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                    frmQckFatImpNF30Col.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                    frmQckFatImpNF30Col.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
                  End
                  Else
                  Begin
                    frmQckFatImpNF30Col.rlbTotaisServico.Visible := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME CABEÇALHO *}
                  {******************************AF*}
                  If Pos(strEspDoc,VS_strNaoCab) > 0 Then
                  Begin
                    frmQckFatImpNF30Col.rlbHeader1.Visible         := False;
                    frmQckFatImpNF30Col.rlbHeader2.Borders.DrawTop := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME DIGITADOR *}
                  {******************************AF*}
                  If VS_strUsaDig = 'S' Then
                    frmQckFatImpNF30Col.pnlDigitador.Visible := True
                  Else
                    frmQckFatImpNF30Col.pnlDigitador.Visible := False;

                  {************************************}
                  {* VERIFICA SE IMPRIME FORMA PGTO   *}
                  {*********************************AF*}
                  If (VS_strUsaFpg = 'S') And (Pos(strEspDoc,'TE_BR_') <= 0) Then
                    frmQckFatImpNF30Col.pnlFormaPagto.Visible := True
                  Else
                    frmQckFatImpNF30Col.pnlFormaPagto.Visible := False;

                  frmQckFatImpNF30Col.strTabela := strTabela;
                  frmQckFatImpNF30Col.strNumDoc := strNumDoc;
                  frmQckFatImpNF30Col.strEspDoc := strEspDoc;
                  frmQckFatImpNF30Col.strOriDoc := strOriDoc;
                  frmQckFatImpNF30Col.strCodEmp := strCodEmp;
                  frmQckFatImpNF30Col.qckPagina.PrintDialog := VS_blnDlgPri;

                  {************************************}
                  {* AUMENTA A PAGINA DE ACORDO COM O *}
                  {* NUMERO DE REGISTROS              *}
                  {* 1 LINHA = 5                      *}
                  {* 1 REGISTRO = 8                   *}
                  {*********************************AF*}
                  If RecordCount > 1 Then
                    frmQckFatImpNF30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImpNF30Col.qckPagina.PageSetup.PaperHeight + (8 * RecordCount);

                  frmQckFatImpNF30Col.qckPagina.Print;
                Finally
                  FreeAndNil(frmQckFatImpNF30Col);
                End;

              End;

            End
            Else If (Pos(strEspDoc,'FF_MI_TE_BR_PI_') > 0) Or (blnDocSep) Then
            Begin

              //If (VS_strModImp = '2') Or (blnDocSep) Then
              If (strColRel = '80') Or (strColRel = '40') Then
              Begin

                impMatricial.pImprime(frmModuloSPR.qryRelatorio, blnTemServico, strTabela,
                  strNumDoc, strEspDoc, strCodEmp, fltDebCli, blnReimpressao, blnDocSep);

              End
              //Else If VS_strModImp = '3' Then
              Else If (strColRel = '30') Then
              Begin

                Try
                  Application.CreateForm(TfrmQckFatImp30Col,frmQckFatImp30Col);

                  frmQckFatImp30Col.blnReimpressao := blnReimpressao;
                  frmQckFatImp30Col.blnDocSep      := blnDocSep;
                  frmQckFatImp30Col.fltDebCli      := fltDebCli;
                  If (blnTemServico) Then
                  Begin
                    frmQckFatImp30Col.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                    frmQckFatImp30Col.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                    frmQckFatImp30Col.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
                  End
                  Else
                  Begin
                    frmQckFatImp30Col.rlbTotaisServico.Visible := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME CABEÇALHO *}
                  {******************************AF*}
                  If Pos(strEspDoc,VS_strNaoCab) > 0 Then
                  Begin
                    frmQckFatImp30Col.rlbHeader1.Visible         := False;
                    frmQckFatImp30Col.rlbHeader2.Borders.DrawTop := False;
                  End;

                  {*********************************}
                  {* VERIFICA SE IMPRIME DIGITADOR *}
                  {******************************AF*}
                  If VS_strUsaDig = 'S' Then
                    frmQckFatImp30Col.pnlDigitador.Visible := True
                  Else
                    frmQckFatImp30Col.pnlDigitador.Visible := False;

                  {************************************}
                  {* VERIFICA SE IMPRIME FORMA PGTO   *}
                  {*********************************AF*}
                  If (VS_strUsaFpg = 'S') And (Pos(strEspDoc,'TE_BR_') <= 0) Then
                  Begin
                    frmQckFatImp30Col.pnlFormaPagto.Visible := True;
                  End
                  Else
                  Begin
                    frmQckFatImp30Col.pnlFormaPagto.Visible := False;
                    frmQckFatImp30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImp30Col.qckPagina.PageSetup.PaperHeight + 8;
                  End;

                  frmQckFatImp30Col.strTabela := strTabela;
                  frmQckFatImp30Col.strNumDoc := strNumDoc;
                  frmQckFatImp30Col.strEspDoc := strEspDoc;
                  frmQckFatImp30Col.strCodEmp := strCodEmp;
                  frmQckFatImp30Col.qckPagina.PrintDialog := VS_blnDlgPri;

                  {************************************}
                  {* AUMENTA A PAGINA DE ACORDO COM O *}
                  {* NUMERO DE REGISTROS              *}
                  {* 1 LINHA = 5                      *}
                  {* 1 REGISTRO = 8                   *}
                  {*********************************AF*}
                  If RecordCount > 1 Then
                    frmQckFatImp30Col.qckPagina.PageSetup.PaperHeight := frmQckFatImp30Col.qckPagina.PageSetup.PaperHeight + (8 * RecordCount);

                  frmQckFatImp30Col.qckPagina.Print;
                Finally
                  FreeAndNil(frmQckFatImp30Col);
                End;

              End;

            End;

          End;

        End
        Else
        Begin

          If Pos(strEspDoc,'PD_OR_') > 0 Then
          Begin

            Try
              Application.CreateForm(TfrmQckFatImpPDORJato,frmQckFatImpPDORJato);
              frmQckFatImpPDORJato.blnReimpressao := blnReimpressao;
              frmQckFatImpPDORJato.blnComPre      := blnComPre;
              frmQckFatImpPDORJato.blnIteRep      := blnIteRep;
              {*******************************************}
              {* VERIFICA SE IMPRIME SERVIÇO             *}
              {****************************************MV*}
              If blnTemServico Then
              Begin
                frmQckFatImpPDORJato.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                frmQckFatImpPDORJato.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                frmQckFatImpPDORJato.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
              End
              Else
              Begin
                frmQckFatImpPDORJato.rlbTotaisServico.Visible := False;
              End;

              frmQckFatImpPDORJato.blnTemServico := blnTemServico;

              {*********************************}
              {* VERIFICA SE IMPRIME CABEÇALHO *}
              {******************************AF*}
              If Pos(strEspDoc,VS_strNaoCab) > 0 Then
              Begin
                frmQckFatImpPDORJato.rlbHeader1.Visible         := False;
                frmQckFatImpPDORJato.rlbHeader2.Borders.DrawTop := False;
              End
              Else
              Begin
                frmQckFatImpPDORJato.rllNumVia.Visible := False;
                frmQckFatImpPDORJato.rllUltPag.Visible := False;
              End;

              {*********************************}
              {* VERIFICA SE IMPRIME DIGITADOR *}
              {******************************AF*}
              If VS_strUsaDig = 'S' Then
              Begin
                frmQckFatImpPDORJato.pnlDigitador.Visible   := True;
                frmQckFatImpPDORJato.pnlDigitadorPD.Visible := True;
              End
              Else
              Begin
                frmQckFatImpPDORJato.pnlDigitador.Visible   := False;
                frmQckFatImpPDORJato.pnlDigitadorPD.Visible := False;
              End;

              {************************************}
              {* VERIFICA SE IMPRIME FORMA PGTO   *}
              {*********************************AF*}
              If VS_strUsaFpg = 'S' Then
                frmQckFatImpPDORJato.pnlFormaPagto.Visible := True
              Else
                frmQckFatImpPDORJato.pnlFormaPagto.Visible := False;


              frmQckFatImpPDORJato.strTabela    := strTabela;
              frmQckFatImpPDORJato.strNumDoc    := strNumDoc;
              frmQckFatImpPDORJato.strEspDoc    := strEspDoc;
              frmQckFatImpPDORJato.strCodEmp    := strCodEmp;
              frmQckFatImpPDORJato.intRegCnt    := RecordCount;
              frmQckFatImpPDORJato.strMeiaFolha := strMeiaFolha;

              If strSaida = 'V' Then
                frmQckFatImpPDORJato.qckPagina.PreviewModal
              Else
              Begin
                frmQckFatImpPDORJato.qckPagina.PrintDialog := VS_blnDlgPri;
                frmQckFatImpPDORJato.qckPagina.Print;
              End;

            Finally
              FreeAndNil(frmQckFatImpPDORJato);
            End;

          End
          Else If Pos(strEspDoc,'TR_DV_AJ_') > 0 Then
          Begin

            Try
              Application.CreateForm(TfrmQckFatImpTRDVJato,frmQckFatImpTRDVJato);
              frmQckFatImpTRDVJato.blnReimpressao := blnReimpressao;
              frmQckFatImpTRDVJato.fltDebCli      := fltDebCli;
              {*********************************}
              {* VERIFICA SE IMPRIME CABEÇALHO *}
              {******************************AF*}
              If Pos(strEspDoc,VS_strNaoCab) > 0 Then
              Begin
                frmQckFatImpTRDVJato.rlbHeader1.Visible         := False;
                frmQckFatImpTRDVJato.rlbHeader2.Borders.DrawTop := False;
              End
              Else
              Begin
                frmQckFatImpTRDVJato.rllNumVia.Visible := False;
                frmQckFatImpTRDVJato.rllUltPag.Visible := False;
              End;

              {*********************************}
              {* VERIFICA SE IMPRIME DIGITADOR *}
              {******************************AF*}
              If VS_strUsaDig = 'S' Then
                frmQckFatImpTRDVJato.pnlDigitador.Visible := True
              Else
                frmQckFatImpTRDVJato.pnlDigitador.Visible := False;

              {************************************}
              {* VERIFICA SE IMPRIME FORMA PGTO   *}
              {*********************************AF*}
              If (VS_strUsaFpg = 'S') And (strEspDoc <> 'DV') Then
                frmQckFatImpTRDVJato.pnlFormaPagto.Visible := True
              Else
                frmQckFatImpTRDVJato.pnlFormaPagto.Visible := False;

              frmQckFatImpTRDVJato.strTabela := strTabela;
              frmQckFatImpTRDVJato.strNumDoc := strNumDoc;
              frmQckFatImpTRDVJato.strEspDoc := strEspDoc;
              frmQckFatImpTRDVJato.strCodEmp := strCodEmp;
              frmQckFatImpTRDVJato.intRegCnt := RecordCount;

              If strSaida = 'V' Then
                frmQckFatImpTRDVJato.qckPagina.PreviewModal
              Else
              Begin
                frmQckFatImpTRDVJato.qckPagina.PrintDialog := VS_blnDlgPri;
                frmQckFatImpTRDVJato.qckPagina.Print;
              End;

            Finally
              FreeAndNil(frmQckFatImpTRDVJato);
            End;

          End
          Else If (Pos(strEspDoc,'NF_IF') > 0) And (Not blnDocSep) Then
          Begin

            Try
              Application.CreateForm(TfrmQckFatImpNFJato,frmQckFatImpNFJato);
              frmQckFatImpNFJato.blnReimpressao := blnReimpressao;
              {*******************************************}
              {* VERIFICA SE IMPRIME SERVIÇO             *}
              {****************************************MV*}
              If blnTemServico Then
              Begin
                frmQckFatImpNFJato.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                frmQckFatImpNFJato.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                frmQckFatImpNFJato.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
              End
              Else
              Begin
                frmQckFatImpNFJato.rlbTotaisServico.Visible := False;
              End;

              frmQckFatImpNFJato.blnTemServico := blnTemServico;

              {*********************************}
              {* VERIFICA SE IMPRIME CABEÇALHO *}
              {******************************AF*}
              If Pos(strEspDoc,VS_strNaoCab) > 0 Then
              Begin
                frmQckFatImpNFJato.rlbHeader1.Visible         := False;
                frmQckFatImpNFJato.rlbHeader2.Borders.DrawTop := False;
              End
              Else
              Begin
                frmQckFatImpNFJato.rllNumVia.Visible := False;
                frmQckFatImpNFJato.rllUltPag.Visible := False;
              End;

              {*********************************}
              {* VERIFICA SE IMPRIME DIGITADOR *}
              {******************************AF*}
              If VS_strUsaDig = 'S' Then
                frmQckFatImpNFJato.pnlDigitador.Visible := True
              Else
                frmQckFatImpNFJato.pnlDigitador.Visible := False;

              {************************************}
              {* VERIFICA SE IMPRIME FORMA PGTO   *}
              {*********************************AF*}
              If VS_strUsaFpg = 'S' Then
                frmQckFatImpNFJato.pnlFormaPagto.Visible := True
              Else
                frmQckFatImpNFJato.pnlFormaPagto.Visible := False;

              frmQckFatImpNFJato.strTabela := strTabela;
              frmQckFatImpNFJato.strNumDoc := strNumDoc;
              frmQckFatImpNFJato.strEspDoc := strEspDoc;
              frmQckFatImpNFJato.strCodEmp := strCodEmp;
              frmQckFatImpNFJato.strOriDoc := strOriDoc;
              frmQckFatImpNFJato.intRegCnt := RecordCount;

              If strSaida = 'V' Then
                frmQckFatImpNFJato.qckPagina.PreviewModal
              Else
              Begin
                frmQckFatImpNFJato.qckPagina.PrintDialog := VS_blnDlgPri;
                frmQckFatImpNFJato.qckPagina.Print;
              End;

            Finally
              FreeAndNil(frmQckFatImpNFJato);
            End;

          End
          Else If (Pos(strEspDoc,'FF_MI_TE_BR_PI_') > 0) Or (blnDocSep) Then
          Begin

            Try
              Application.CreateForm(TfrmQckFatImpJato,frmQckFatImpJato);
              frmQckFatImpJato.blnReimpressao := blnReimpressao;
              frmQckFatImpJato.blnDocSep      := blnDocSep;
              frmQckFatImpJato.fltDebCli      := fltDebCli;
              {*******************************************}
              {* VERIFICA SE IMPRIME SERVIÇO             *}
              {****************************************MV*}
              If blnTemServico Then
              Begin
                frmQckFatImpJato.rllPerIss.Caption := FormatFloat('#,##0.00', fltPerIss);
                frmQckFatImpJato.rllValIss.Caption := FormatFloat('#,##0.00', fltValIss);
                frmQckFatImpJato.rllTotSer.Caption := FormatFloat('#,##0.00', fltTotSer);
              End
              Else
              Begin
                frmQckFatImpJato.rlbTotaisServico.Visible := False;
              End;

              frmQckFatImpJato.blnTemServico := blnTemServico;

              {*********************************}
              {* VERIFICA SE IMPRIME CABEÇALHO *}
              {******************************AF*}
              If Pos(strEspDoc,VS_strNaoCab) > 0 Then
              Begin
                frmQckFatImpJato.rlbHeader1.Visible         := False;
                frmQckFatImpJato.rlbHeader2.Borders.DrawTop := False;
              End
              Else
              Begin
                frmQckFatImpJato.rllNumVia.Visible := False;
                frmQckFatImpJato.rllUltPag.Visible := False;
              End;

              {*********************************}
              {* VERIFICA SE IMPRIME DIGITADOR *}
              {******************************AF*}
              If VS_strUsaDig = 'S' Then
                frmQckFatImpJato.pnlDigitador.Visible := True
              Else
                frmQckFatImpJato.pnlDigitador.Visible := False;

              {************************************}
              {* VERIFICA SE IMPRIME FORMA PGTO   *}
              {*********************************AF*}
              If (VS_strUsaFpg = 'S') And (Pos(strEspDoc,'TE_BR_') <= 0) Then
                frmQckFatImpJato.pnlFormaPagto.Visible := True
              Else
                frmQckFatImpJato.pnlFormaPagto.Visible := False;

              frmQckFatImpJato.strTabela := strTabela;
              frmQckFatImpJato.strNumDoc := strNumDoc;
              frmQckFatImpJato.strEspDoc := strEspDoc;
              frmQckFatImpJato.strCodEmp := strCodEmp;
              frmQckFatImpJato.intRegCnt := RecordCount;

              If strSaida = 'V' Then
                frmQckFatImpJato.qckPagina.PreviewModal
              Else
              Begin
                frmQckFatImpJato.qckPagina.PrintDialog := VS_blnDlgPri;
                frmQckFatImpJato.qckPagina.Print;
              End;

            Finally
              FreeAndNil(frmQckFatImpJato);
            End;

          End;

        End;

        If (VS_strIteRep = 'S') And (strEspDoc = 'PD') And (Not blnIteRep) Then
        Begin
          frmModuloMovGer.pImprimeFatImp(strTabela, strNumDoc,
            strEspDoc, strCodEmp, strTip_Fc, strOriDoc, False, strSaida, intQtdImp, blnComPre,
            0.0, blnDocSep, blnTickIF, True);
        End;

      End
      Else
      Begin
        If (Not blnIteRep) Then
          fMensagem('','Não há dados para gerar a impressão!!!',['&Ok']);
      End;

      Close;
    End;

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(impMatricial);

End;


function TfrmModuloMovGer.fCarregaDadosServico(strTabela, strNumDoc, strEspDoc, strCodEmp: String;

  Var fltPerIss, fltValIss, fltTotSer: Double): Boolean;
  Var
    intContador: Integer;
    strSQL: String;
begin

  Result := False;
  If (VS_strUsaSer <> 'S') Then
    Exit;

  If (fTabelaExiste('TMP_SERVICOS')) Then
    fDropTable('TMP_SERVICOS');

  If (strTabela = 'MOVDET') Then
    strTabela := 'MOVGER'
    
  Else If (strTabela = 'MOVDETX') Then
    strTabela := 'MOVGERX'

  Else If (strTabela = 'NOTDET') Then
    strTabela := 'NOTGER'

  Else If (strTabela = 'NOTDETX') Then
    strTabela := 'NOTGERX';


  If (Pos(strEspDoc, 'OR_PD_') > 0) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FGO_DESS01 AS DESS01, ';
    strSQL := strSQL + '  FGO_DESS02 AS DESS02, ';
    strSQL := strSQL + '  FGO_DESS03 AS DESS03, ';
    strSQL := strSQL + '  FGO_DESS04 AS DESS04, ';
    strSQL := strSQL + '  FGO_DESS05 AS DESS05, ';
    strSQL := strSQL + '  FGO_DESS06 AS DESS06, ';
    strSQL := strSQL + '  FGO_VALS01 AS VALS01, ';
    strSQL := strSQL + '  FGO_VALS02 AS VALS02, ';
    strSQL := strSQL + '  FGO_VALS03 AS VALS03, ';
    strSQL := strSQL + '  FGO_VALS04 AS VALS04, ';
    strSQL := strSQL + '  FGO_VALS05 AS VALS05, ';
    strSQL := strSQL + '  FGO_VALS06 AS VALS06, ';
    strSQL := strSQL + '  FGO_PERISS AS PERISS, ';
    strSQL := strSQL + '  FGO_VALISS AS VALISS, ';
    strSQL := strSQL + '  FGO_TOTSER AS TOTSER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP ';

  End
  Else
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_DESS01 AS DESS01, ';
    strSQL := strSQL + '  GER_DESS02 AS DESS02, ';
    strSQL := strSQL + '  GER_DESS03 AS DESS03, ';
    strSQL := strSQL + '  GER_DESS04 AS DESS04, ';
    strSQL := strSQL + '  GER_DESS05 AS DESS05, ';
    strSQL := strSQL + '  GER_DESS06 AS DESS06, ';
    strSQL := strSQL + '  GER_VALS01 AS VALS01, ';
    strSQL := strSQL + '  GER_VALS02 AS VALS02, ';
    strSQL := strSQL + '  GER_VALS03 AS VALS03, ';
    strSQL := strSQL + '  GER_VALS04 AS VALS04, ';
    strSQL := strSQL + '  GER_VALS05 AS VALS05, ';
    strSQL := strSQL + '  GER_VALS06 AS VALS06, ';
    strSQL := strSQL + '  GER_PERISS AS PERISS, ';
    strSQL := strSQL + '  GER_VALISS AS VALISS, ';
    strSQL := strSQL + '  GER_TOTSER AS TOTSER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' ' + strTabela + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP ';

  End;

  With frmModuloSPR.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (FieldByName('DESS01').IsNull) Then
    Begin
      Close;
      Exit;
    End;
  End;

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_SERVICOS ( ';
  strSQL := strSQL + '  TMP_DESSER VARCHAR(95), ';
  strSQL := strSQL + '  TMP_VALSER NUMERIC(12, 4)) ';

  With frmModuloSPR.qryGen002 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO TMP_SERVICOS VALUES (:DESSER, :VALSER) ';
  With frmModuloSPR.qryGen002 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  For intContador := 1 To 6 Do
  Begin

    If (fEmptyStr(frmModuloSPR.qryGen001.FieldByName('DESS' + fStrZero(intContador, 2)).AsString)) Then
      Continue;

    frmModuloSPR.qryGen002.ParamByName('DESSER').AsString := frmModuloSPR.qryGen001.FieldByName('DESS' + fStrZero(intContador, 2)).AsString;
    frmModuloSPR.qryGen002.ParamByName('VALSER').AsFloat  := frmModuloSPR.qryGen001.FieldByName('VALS' + fStrZero(intContador, 2)).AsFloat;
    frmModuloSPR.qryGen002.ExecSQL;
    frmModuloSPR.qryGen002.Close;

  End;

  fltPerIss := frmModuloSPR.qryGen001.FieldByName('PERISS').AsFloat;
  fltValIss := frmModuloSPR.qryGen001.FieldByName('VALISS').AsFloat;
  fltTotSer := frmModuloSPR.qryGen001.FieldByName('TOTSER').AsFloat;

  frmModuloSPR.qryGen001.Close;
end;

end.

