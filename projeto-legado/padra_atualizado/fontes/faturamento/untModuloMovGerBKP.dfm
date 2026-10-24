object frmModuloMovGer: TfrmModuloMovGer
  OldCreateOrder = False
  Left = 432
  Top = 323
  Height = 313
  Width = 411
  object qryMovGer: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM MOVGER WHERE AUTOINCREM = -1')
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 24
    Top = 16
    object qryMovGerGER_CODEMP: TStringField
      FieldName = 'GER_CODEMP'
      Required = True
      Size = 3
    end
    object qryMovGerGER_NUMDOC: TStringField
      FieldName = 'GER_NUMDOC'
      Required = True
      Size = 6
    end
    object qryMovGerGER_ESPDOC: TStringField
      FieldName = 'GER_ESPDOC'
      Required = True
      Size = 2
    end
    object qryMovGerGER_CODVEN: TStringField
      FieldName = 'GER_CODVEN'
      Size = 3
    end
    object qryMovGerGER_CODTRA: TStringField
      FieldName = 'GER_CODTRA'
      Size = 5
    end
    object qryMovGerGER_CODFOR: TStringField
      FieldName = 'GER_CODFOR'
      Size = 8
    end
    object qryMovGerGER_CODCLI: TStringField
      FieldName = 'GER_CODCLI'
      Size = 8
    end
    object qryMovGerGER_TIP_FC: TStringField
      FieldName = 'GER_TIP_FC'
      Size = 1
    end
    object qryMovGerGER_SERIE_: TStringField
      FieldName = 'GER_SERIE_'
      Size = 3
    end
    object qryMovGerGER_DTAENT: TDateField
      FieldName = 'GER_DTAENT'
    end
    object qryMovGerGER_HORENT: TTimeField
      FieldName = 'GER_HORENT'
    end
    object qryMovGerGER_DTADOC: TDateField
      FieldName = 'GER_DTADOC'
    end
    object qryMovGerGER_CONPAG: TStringField
      FieldName = 'GER_CONPAG'
      Size = 38
    end
    object qryMovGerGER_ESTADO: TStringField
      FieldName = 'GER_ESTADO'
      Size = 2
    end
    object qryMovGerGER_NOMCON: TStringField
      FieldName = 'GER_NOMCON'
      Size = 40
    end
    object qryMovGerGER_ENDCON: TStringField
      FieldName = 'GER_ENDCON'
      Size = 40
    end
    object qryMovGerGER_BAICON: TStringField
      FieldName = 'GER_BAICON'
      Size = 30
    end
    object qryMovGerGER_CEPCON: TStringField
      FieldName = 'GER_CEPCON'
      Size = 8
    end
    object qryMovGerGER_CIDCON: TStringField
      FieldName = 'GER_CIDCON'
      Size = 5
    end
    object qryMovGerGER_ESTCON: TStringField
      FieldName = 'GER_ESTCON'
      Size = 2
    end
    object qryMovGerGER_TELCON: TStringField
      FieldName = 'GER_TELCON'
      Size = 11
    end
    object qryMovGerGER_CGCCPF: TLargeintField
      FieldName = 'GER_CGCCPF'
    end
    object qryMovGerGER_CGCCON: TStringField
      FieldName = 'GER_CGCCON'
      Size = 18
    end
    object qryMovGerGER_IESCON: TStringField
      FieldName = 'GER_IESCON'
      Size = 18
    end
    object qryMovGerGER_BASSIM: TFloatField
      FieldName = 'GER_BASSIM'
    end
    object qryMovGerGER_BASIPI: TFloatField
      FieldName = 'GER_BASIPI'
    end
    object qryMovGerGER_ALQIPI: TFloatField
      FieldName = 'GER_ALQIPI'
    end
    object qryMovGerGER_TOTIPI: TFloatField
      FieldName = 'GER_TOTIPI'
    end
    object qryMovGerGER_BASICM: TFloatField
      FieldName = 'GER_BASICM'
    end
    object qryMovGerGER_ALQICM: TFloatField
      FieldName = 'GER_ALQICM'
    end
    object qryMovGerGER_TOTICM: TFloatField
      FieldName = 'GER_TOTICM'
    end
    object qryMovGerGER_TOTRET: TFloatField
      FieldName = 'GER_TOTRET'
    end
    object qryMovGerGER_ALQRET: TFloatField
      FieldName = 'GER_ALQRET'
    end
    object qryMovGerGER_BASRET: TFloatField
      FieldName = 'GER_BASRET'
    end
    object qryMovGerGER_DESESP: TFloatField
      FieldName = 'GER_DESESP'
    end
    object qryMovGerGER_VLRCON: TFloatField
      FieldName = 'GER_VLRCON'
    end
    object qryMovGerGER_TOTPRO: TFloatField
      FieldName = 'GER_TOTPRO'
    end
    object qryMovGerGER_TOTCUS: TFloatField
      FieldName = 'GER_TOTCUS'
    end
    object qryMovGerGER_TOTMED: TFloatField
      FieldName = 'GER_TOTMED'
    end
    object qryMovGerGER_TIPFRE: TStringField
      FieldName = 'GER_TIPFRE'
      Size = 1
    end
    object qryMovGerGER_TOTFRE: TFloatField
      FieldName = 'GER_TOTFRE'
    end
    object qryMovGerGER_PESBRU: TFloatField
      FieldName = 'GER_PESBRU'
    end
    object qryMovGerGER_PESLIQ: TFloatField
      FieldName = 'GER_PESLIQ'
    end
    object qryMovGerGER_VOLUME: TFloatField
      FieldName = 'GER_VOLUME'
    end
    object qryMovGerGER_ESPECI: TStringField
      FieldName = 'GER_ESPECI'
      Size = 10
    end
    object qryMovGerGER_MARCA_: TStringField
      FieldName = 'GER_MARCA_'
      Size = 10
    end
    object qryMovGerGER_MEN001: TStringField
      FieldName = 'GER_MEN001'
      Size = 70
    end
    object qryMovGerGER_MEN002: TStringField
      FieldName = 'GER_MEN002'
      Size = 70
    end
    object qryMovGerGER_JAFATU: TSmallintField
      FieldName = 'GER_JAFATU'
    end
    object qryMovGerGER_TIPFAT: TStringField
      FieldName = 'GER_TIPFAT'
      Size = 2
    end
    object qryMovGerGER_NUMFAT: TStringField
      FieldName = 'GER_NUMFAT'
      Size = 6
    end
    object qryMovGerGER_DTAFAT: TDateField
      FieldName = 'GER_DTAFAT'
    end
    object qryMovGerGER_VENFAT: TStringField
      FieldName = 'GER_VENFAT'
      Size = 3
    end
    object qryMovGerGER_CNDFAT: TStringField
      FieldName = 'GER_CNDFAT'
      Size = 38
    end
    object qryMovGerGER_VALFAT: TFloatField
      FieldName = 'GER_VALFAT'
    end
    object qryMovGerGER_VPAR01: TFloatField
      FieldName = 'GER_VPAR01'
    end
    object qryMovGerGER_VPAR02: TFloatField
      FieldName = 'GER_VPAR02'
    end
    object qryMovGerGER_VPAR03: TFloatField
      FieldName = 'GER_VPAR03'
    end
    object qryMovGerGER_VPAR04: TFloatField
      FieldName = 'GER_VPAR04'
    end
    object qryMovGerGER_VPAR05: TFloatField
      FieldName = 'GER_VPAR05'
    end
    object qryMovGerGER_VPAR06: TFloatField
      FieldName = 'GER_VPAR06'
    end
    object qryMovGerGER_VPAR07: TFloatField
      FieldName = 'GER_VPAR07'
    end
    object qryMovGerGER_VPAR08: TFloatField
      FieldName = 'GER_VPAR08'
    end
    object qryMovGerGER_VPAR09: TFloatField
      FieldName = 'GER_VPAR09'
    end
    object qryMovGerGER_VPAR10: TFloatField
      FieldName = 'GER_VPAR10'
    end
    object qryMovGerGER_VPAR11: TFloatField
      FieldName = 'GER_VPAR11'
    end
    object qryMovGerGER_VPAR12: TFloatField
      FieldName = 'GER_VPAR12'
    end
    object qryMovGerGER_NOTESP: TStringField
      FieldName = 'GER_NOTESP'
      Size = 1
    end
    object qryMovGerGER_CLAFIS: TStringField
      FieldName = 'GER_CLAFIS'
      Size = 4
    end
    object qryMovGerGER_CODDIG: TStringField
      FieldName = 'GER_CODDIG'
      Size = 3
    end
    object qryMovGerGER_PORDES: TFloatField
      FieldName = 'GER_PORDES'
    end
    object qryMovGerGER_R_GCON: TStringField
      FieldName = 'GER_R_GCON'
      Size = 18
    end
    object qryMovGerGER_CODCND: TStringField
      FieldName = 'GER_CODCND'
      Size = 3
    end
    object qryMovGerGER_CODFPG: TStringField
      FieldName = 'GER_CODFPG'
      Size = 3
    end
    object qryMovGerAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
    object qryMovGerGER_FATNOT: TFloatField
      FieldName = 'GER_FATNOT'
    end
    object qryMovGerGER_CODS01: TStringField
      FieldName = 'GER_CODS01'
      Size = 5
    end
    object qryMovGerGER_CODS02: TStringField
      FieldName = 'GER_CODS02'
      Size = 5
    end
    object qryMovGerGER_CODS03: TStringField
      FieldName = 'GER_CODS03'
      Size = 5
    end
    object qryMovGerGER_CODS04: TStringField
      FieldName = 'GER_CODS04'
      Size = 5
    end
    object qryMovGerGER_CODS05: TStringField
      FieldName = 'GER_CODS05'
      Size = 5
    end
    object qryMovGerGER_CODS06: TStringField
      FieldName = 'GER_CODS06'
      Size = 5
    end
    object qryMovGerGER_DESS01: TStringField
      DisplayWidth = 95
      FieldName = 'GER_DESS01'
      Size = 95
    end
    object qryMovGerGER_DESS02: TStringField
      DisplayWidth = 95
      FieldName = 'GER_DESS02'
      Size = 95
    end
    object qryMovGerGER_DESS03: TStringField
      DisplayWidth = 95
      FieldName = 'GER_DESS03'
      Size = 95
    end
    object qryMovGerGER_DESS04: TStringField
      DisplayWidth = 95
      FieldName = 'GER_DESS04'
      Size = 95
    end
    object qryMovGerGER_DESS05: TStringField
      DisplayWidth = 95
      FieldName = 'GER_DESS05'
      Size = 95
    end
    object qryMovGerGER_DESS06: TStringField
      DisplayWidth = 95
      FieldName = 'GER_DESS06'
      Size = 95
    end
    object qryMovGerGER_VALS01: TFloatField
      FieldName = 'GER_VALS01'
    end
    object qryMovGerGER_VALS02: TFloatField
      FieldName = 'GER_VALS02'
    end
    object qryMovGerGER_VALS03: TFloatField
      FieldName = 'GER_VALS03'
    end
    object qryMovGerGER_VALS04: TFloatField
      FieldName = 'GER_VALS04'
    end
    object qryMovGerGER_VALS05: TFloatField
      FieldName = 'GER_VALS05'
    end
    object qryMovGerGER_VALS06: TFloatField
      FieldName = 'GER_VALS06'
    end
    object qryMovGerGER_PRAENT: TIntegerField
      FieldName = 'GER_PRAENT'
    end
    object qryMovGerGER_TOTSER: TFloatField
      FieldName = 'GER_TOTSER'
    end
    object qryMovGerGER_PERISS: TFloatField
      FieldName = 'GER_PERISS'
    end
    object qryMovGerGER_VALISS: TFloatField
      FieldName = 'GER_VALISS'
    end
    object qryMovGerGER_CLAFI2: TStringField
      FieldName = 'GER_CLAFI2'
      Size = 4
    end
    object qryMovGerGER_CLAFI3: TStringField
      FieldName = 'GER_CLAFI3'
      Size = 4
    end
    object qryMovGerGER_NATOPE: TStringField
      FieldName = 'GER_NATOPE'
      Size = 30
    end
    object qryMovGerGER_DESACE: TFloatField
      FieldName = 'GER_DESACE'
    end
    object qryMovGerGER_ORIDOC: TStringField
      FieldName = 'GER_ORIDOC'
      Size = 1
    end
    object qryMovGerGER_DTAROM: TDateField
      FieldName = 'GER_DTAROM'
    end
    object qryMovGerGER_HORROM: TTimeField
      FieldName = 'GER_HORROM'
    end
    object qryMovGerGER_OPEROM: TStringField
      FieldName = 'GER_OPEROM'
      Size = 3
    end
    object qryMovGerGER_NUMROM: TStringField
      FieldName = 'GER_NUMROM'
      Size = 6
    end
    object qryMovGerGER_CONENT: TStringField
      FieldName = 'GER_CONENT'
      Size = 6
    end
    object qryMovGerGER_IMPRES: TSmallintField
      FieldName = 'GER_IMPRES'
    end
    object qryMovGerGER_CODREP: TStringField
      FieldName = 'GER_CODREP'
      Size = 3
    end
    object qryMovGerGER_VALROM: TFloatField
      FieldName = 'GER_VALROM'
    end
    object qryMovGerGER_ALQIRF: TFloatField
      FieldName = 'GER_ALQIRF'
    end
    object qryMovGerGER_VALIRF: TFloatField
      FieldName = 'GER_VALIRF'
    end
    object qryMovGerGER_ALQPIS: TFloatField
      FieldName = 'GER_ALQPIS'
    end
    object qryMovGerGER_VALPIS: TFloatField
      FieldName = 'GER_VALPIS'
    end
    object qryMovGerGER_ALQCOF: TFloatField
      FieldName = 'GER_ALQCOF'
    end
    object qryMovGerGER_VALCOF: TFloatField
      FieldName = 'GER_VALCOF'
    end
    object qryMovGerGER_ALQCSL: TFloatField
      FieldName = 'GER_ALQCSL'
    end
    object qryMovGerGER_VALCSL: TFloatField
      FieldName = 'GER_VALCSL'
    end
    object qryMovGerGER_IRFRET: TFloatField
      FieldName = 'GER_IRFRET'
    end
    object qryMovGerGER_PISRET: TFloatField
      FieldName = 'GER_PISRET'
    end
    object qryMovGerGER_COFRET: TFloatField
      FieldName = 'GER_COFRET'
    end
    object qryMovGerGER_CSLRET: TFloatField
      FieldName = 'GER_CSLRET'
    end
    object qryMovGerGER_SERRET: TFloatField
      FieldName = 'GER_SERRET'
    end
    object qryMovGerGER_NOTRET: TStringField
      FieldName = 'GER_NOTRET'
      Size = 50
    end
    object qryMovGerGER_NORESE: TStringField
      FieldName = 'GER_NORESE'
      Size = 50
    end
    object qryMovGerGER_ALIRFP: TFloatField
      FieldName = 'GER_ALIRFP'
    end
    object qryMovGerGER_ALPISP: TFloatField
      FieldName = 'GER_ALPISP'
    end
    object qryMovGerGER_ALCOFP: TFloatField
      FieldName = 'GER_ALCOFP'
    end
    object qryMovGerGER_ALCSLP: TFloatField
      FieldName = 'GER_ALCSLP'
    end
    object qryMovGerGER_PESGSO: TFloatField
      FieldName = 'GER_PESGSO'
    end
    object qryMovGerGER_VLSGSO: TFloatField
      FieldName = 'GER_VLSGSO'
    end
    object qryMovGerGER_IRPRRT: TFloatField
      FieldName = 'GER_IRPRRT'
    end
    object qryMovGerGER_IRPRDV: TFloatField
      FieldName = 'GER_IRPRDV'
    end
    object qryMovGerGER_IRSERT: TFloatField
      FieldName = 'GER_IRSERT'
    end
    object qryMovGerGER_IRSEDV: TFloatField
      FieldName = 'GER_IRSEDV'
    end
    object qryMovGerGER_PIPRRT: TFloatField
      FieldName = 'GER_PIPRRT'
    end
    object qryMovGerGER_PIPRDV: TFloatField
      FieldName = 'GER_PIPRDV'
    end
    object qryMovGerGER_PISERT: TFloatField
      FieldName = 'GER_PISERT'
    end
    object qryMovGerGER_PISEDV: TFloatField
      FieldName = 'GER_PISEDV'
    end
    object qryMovGerGER_COPRRT: TFloatField
      FieldName = 'GER_COPRRT'
    end
    object qryMovGerGER_COPRDV: TFloatField
      FieldName = 'GER_COPRDV'
    end
    object qryMovGerGER_COSERT: TFloatField
      FieldName = 'GER_COSERT'
    end
    object qryMovGerGER_COSEDV: TFloatField
      FieldName = 'GER_COSEDV'
    end
    object qryMovGerGER_CSPRRT: TFloatField
      FieldName = 'GER_CSPRRT'
    end
    object qryMovGerGER_CSPRDV: TFloatField
      FieldName = 'GER_CSPRDV'
    end
    object qryMovGerGER_CSSERT: TFloatField
      FieldName = 'GER_CSSERT'
    end
    object qryMovGerGER_CSSEDV: TFloatField
      FieldName = 'GER_CSSEDV'
    end
    object qryMovGerGER_ORDPRO: TStringField
      FieldName = 'GER_ORDPRO'
      Size = 6
    end
  end
  object qryMovGerX: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM MOVGERX WHERE AUTOINCREM = -1')
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 96
    Top = 16
    object qryMovGerXGER_CODEMP: TStringField
      FieldName = 'GER_CODEMP'
      Required = True
      Size = 3
    end
    object qryMovGerXGER_NUMDOC: TStringField
      FieldName = 'GER_NUMDOC'
      Required = True
      Size = 6
    end
    object qryMovGerXGER_ESPDOC: TStringField
      FieldName = 'GER_ESPDOC'
      Required = True
      Size = 2
    end
    object qryMovGerXGER_CODTRA: TStringField
      FieldName = 'GER_CODTRA'
      Size = 5
    end
    object qryMovGerXGER_CODVEN: TStringField
      FieldName = 'GER_CODVEN'
      Size = 3
    end
    object qryMovGerXGER_CODFOR: TStringField
      FieldName = 'GER_CODFOR'
      Size = 8
    end
    object qryMovGerXGER_CODCLI: TStringField
      FieldName = 'GER_CODCLI'
      Size = 8
    end
    object qryMovGerXGER_TIP_FC: TStringField
      FieldName = 'GER_TIP_FC'
      Size = 1
    end
    object qryMovGerXGER_SERIE_: TStringField
      FieldName = 'GER_SERIE_'
      Size = 3
    end
    object qryMovGerXGER_DTAENT: TDateField
      FieldName = 'GER_DTAENT'
    end
    object qryMovGerXGER_HORENT: TTimeField
      FieldName = 'GER_HORENT'
    end
    object qryMovGerXGER_DTADOC: TDateField
      FieldName = 'GER_DTADOC'
    end
    object qryMovGerXGER_CONPAG: TStringField
      FieldName = 'GER_CONPAG'
      Size = 38
    end
    object qryMovGerXGER_ESTADO: TStringField
      FieldName = 'GER_ESTADO'
      Size = 2
    end
    object qryMovGerXGER_NOMCON: TStringField
      FieldName = 'GER_NOMCON'
      Size = 40
    end
    object qryMovGerXGER_ENDCON: TStringField
      FieldName = 'GER_ENDCON'
      Size = 40
    end
    object qryMovGerXGER_BAICON: TStringField
      FieldName = 'GER_BAICON'
      Size = 30
    end
    object qryMovGerXGER_CEPCON: TStringField
      FieldName = 'GER_CEPCON'
      Size = 8
    end
    object qryMovGerXGER_CIDCON: TStringField
      FieldName = 'GER_CIDCON'
      Size = 5
    end
    object qryMovGerXGER_ESTCON: TStringField
      FieldName = 'GER_ESTCON'
      Size = 2
    end
    object qryMovGerXGER_TELCON: TStringField
      FieldName = 'GER_TELCON'
      Size = 11
    end
    object qryMovGerXGER_CGCCPF: TLargeintField
      FieldName = 'GER_CGCCPF'
    end
    object qryMovGerXGER_CGCCON: TStringField
      FieldName = 'GER_CGCCON'
      Size = 18
    end
    object qryMovGerXGER_IESCON: TStringField
      FieldName = 'GER_IESCON'
      Size = 18
    end
    object qryMovGerXGER_BASSIM: TFloatField
      FieldName = 'GER_BASSIM'
    end
    object qryMovGerXGER_BASIPI: TFloatField
      FieldName = 'GER_BASIPI'
    end
    object qryMovGerXGER_ALQIPI: TFloatField
      FieldName = 'GER_ALQIPI'
    end
    object qryMovGerXGER_TOTIPI: TFloatField
      FieldName = 'GER_TOTIPI'
    end
    object qryMovGerXGER_BASICM: TFloatField
      FieldName = 'GER_BASICM'
    end
    object qryMovGerXGER_ALQICM: TFloatField
      FieldName = 'GER_ALQICM'
    end
    object qryMovGerXGER_TOTICM: TFloatField
      FieldName = 'GER_TOTICM'
    end
    object qryMovGerXGER_TOTRET: TFloatField
      FieldName = 'GER_TOTRET'
    end
    object qryMovGerXGER_ALQRET: TFloatField
      FieldName = 'GER_ALQRET'
    end
    object qryMovGerXGER_BASRET: TFloatField
      FieldName = 'GER_BASRET'
    end
    object qryMovGerXGER_DESESP: TFloatField
      FieldName = 'GER_DESESP'
    end
    object qryMovGerXGER_VLRCON: TFloatField
      FieldName = 'GER_VLRCON'
    end
    object qryMovGerXGER_TOTPRO: TFloatField
      FieldName = 'GER_TOTPRO'
    end
    object qryMovGerXGER_TOTCUS: TFloatField
      FieldName = 'GER_TOTCUS'
    end
    object qryMovGerXGER_TOTMED: TFloatField
      FieldName = 'GER_TOTMED'
    end
    object qryMovGerXGER_TIPFRE: TStringField
      FieldName = 'GER_TIPFRE'
      Size = 1
    end
    object qryMovGerXGER_TOTFRE: TFloatField
      FieldName = 'GER_TOTFRE'
    end
    object qryMovGerXGER_PESBRU: TFloatField
      FieldName = 'GER_PESBRU'
    end
    object qryMovGerXGER_PESLIQ: TFloatField
      FieldName = 'GER_PESLIQ'
    end
    object qryMovGerXGER_VOLUME: TFloatField
      FieldName = 'GER_VOLUME'
    end
    object qryMovGerXGER_ESPECI: TStringField
      FieldName = 'GER_ESPECI'
      Size = 10
    end
    object qryMovGerXGER_MARCA_: TStringField
      FieldName = 'GER_MARCA_'
      Size = 10
    end
    object qryMovGerXGER_MEN001: TStringField
      FieldName = 'GER_MEN001'
      Size = 70
    end
    object qryMovGerXGER_MEN002: TStringField
      FieldName = 'GER_MEN002'
      Size = 70
    end
    object qryMovGerXGER_JAFATU: TSmallintField
      FieldName = 'GER_JAFATU'
    end
    object qryMovGerXGER_TIPFAT: TStringField
      FieldName = 'GER_TIPFAT'
      Size = 2
    end
    object qryMovGerXGER_NUMFAT: TStringField
      FieldName = 'GER_NUMFAT'
      Size = 6
    end
    object qryMovGerXGER_DTAFAT: TDateField
      FieldName = 'GER_DTAFAT'
    end
    object qryMovGerXGER_VENFAT: TStringField
      FieldName = 'GER_VENFAT'
      Size = 3
    end
    object qryMovGerXGER_CNDFAT: TStringField
      FieldName = 'GER_CNDFAT'
      Size = 38
    end
    object qryMovGerXGER_VALFAT: TFloatField
      FieldName = 'GER_VALFAT'
    end
    object qryMovGerXGER_VPAR01: TFloatField
      FieldName = 'GER_VPAR01'
    end
    object qryMovGerXGER_VPAR02: TFloatField
      FieldName = 'GER_VPAR02'
    end
    object qryMovGerXGER_VPAR03: TFloatField
      FieldName = 'GER_VPAR03'
    end
    object qryMovGerXGER_VPAR04: TFloatField
      FieldName = 'GER_VPAR04'
    end
    object qryMovGerXGER_VPAR05: TFloatField
      FieldName = 'GER_VPAR05'
    end
    object qryMovGerXGER_VPAR06: TFloatField
      FieldName = 'GER_VPAR06'
    end
    object qryMovGerXGER_VPAR07: TFloatField
      FieldName = 'GER_VPAR07'
    end
    object qryMovGerXGER_VPAR08: TFloatField
      FieldName = 'GER_VPAR08'
    end
    object qryMovGerXGER_VPAR09: TFloatField
      FieldName = 'GER_VPAR09'
    end
    object qryMovGerXGER_VPAR10: TFloatField
      FieldName = 'GER_VPAR10'
    end
    object qryMovGerXGER_VPAR11: TFloatField
      FieldName = 'GER_VPAR11'
    end
    object qryMovGerXGER_VPAR12: TFloatField
      FieldName = 'GER_VPAR12'
    end
    object qryMovGerXGER_NOTESP: TStringField
      FieldName = 'GER_NOTESP'
      Size = 1
    end
    object qryMovGerXGER_CLAFIS: TStringField
      FieldName = 'GER_CLAFIS'
      Size = 4
    end
    object qryMovGerXGER_CODDIG: TStringField
      FieldName = 'GER_CODDIG'
      Size = 3
    end
    object qryMovGerXGER_PORDES: TFloatField
      FieldName = 'GER_PORDES'
    end
    object qryMovGerXGER_R_GCON: TStringField
      FieldName = 'GER_R_GCON'
      Size = 18
    end
    object qryMovGerXGER_CODCND: TStringField
      FieldName = 'GER_CODCND'
      Size = 3
    end
    object qryMovGerXGER_CODFPG: TStringField
      FieldName = 'GER_CODFPG'
      Size = 3
    end
    object qryMovGerXAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
    object qryMovGerXGER_FATNOT: TFloatField
      FieldName = 'GER_FATNOT'
    end
    object qryMovGerXGER_CODS01: TStringField
      FieldName = 'GER_CODS01'
      Size = 5
    end
    object qryMovGerXGER_CODS02: TStringField
      FieldName = 'GER_CODS02'
      Size = 5
    end
    object qryMovGerXGER_CODS03: TStringField
      FieldName = 'GER_CODS03'
      Size = 5
    end
    object qryMovGerXGER_CODS04: TStringField
      FieldName = 'GER_CODS04'
      Size = 5
    end
    object qryMovGerXGER_CODS05: TStringField
      FieldName = 'GER_CODS05'
      Size = 5
    end
    object qryMovGerXGER_CODS06: TStringField
      FieldName = 'GER_CODS06'
      Size = 5
    end
    object qryMovGerXGER_DESS01: TStringField
      FieldName = 'GER_DESS01'
      Size = 95
    end
    object qryMovGerXGER_DESS02: TStringField
      FieldName = 'GER_DESS02'
      Size = 95
    end
    object qryMovGerXGER_DESS03: TStringField
      FieldName = 'GER_DESS03'
      Size = 95
    end
    object qryMovGerXGER_DESS04: TStringField
      FieldName = 'GER_DESS04'
      Size = 95
    end
    object qryMovGerXGER_DESS05: TStringField
      FieldName = 'GER_DESS05'
      Size = 95
    end
    object qryMovGerXGER_DESS06: TStringField
      FieldName = 'GER_DESS06'
      Size = 95
    end
    object qryMovGerXGER_VALS01: TFloatField
      FieldName = 'GER_VALS01'
    end
    object qryMovGerXGER_VALS02: TFloatField
      FieldName = 'GER_VALS02'
    end
    object qryMovGerXGER_VALS03: TFloatField
      FieldName = 'GER_VALS03'
    end
    object qryMovGerXGER_VALS04: TFloatField
      FieldName = 'GER_VALS04'
    end
    object qryMovGerXGER_VALS05: TFloatField
      FieldName = 'GER_VALS05'
    end
    object qryMovGerXGER_VALS06: TFloatField
      FieldName = 'GER_VALS06'
    end
    object qryMovGerXGER_PRAENT: TIntegerField
      FieldName = 'GER_PRAENT'
    end
    object qryMovGerXGER_TOTSER: TFloatField
      FieldName = 'GER_TOTSER'
    end
    object qryMovGerXGER_PERISS: TFloatField
      FieldName = 'GER_PERISS'
    end
    object qryMovGerXGER_VALISS: TFloatField
      FieldName = 'GER_VALISS'
    end
    object qryMovGerXGER_CLAFI2: TStringField
      FieldName = 'GER_CLAFI2'
      Size = 4
    end
    object qryMovGerXGER_CLAFI3: TStringField
      FieldName = 'GER_CLAFI3'
      Size = 4
    end
    object qryMovGerXGER_NATOPE: TStringField
      FieldName = 'GER_NATOPE'
      Size = 30
    end
    object qryMovGerXGER_DESACE: TFloatField
      FieldName = 'GER_DESACE'
    end
    object qryMovGerXGER_ORIDOC: TStringField
      FieldName = 'GER_ORIDOC'
      Size = 1
    end
    object qryMovGerXGER_DTAROM: TDateField
      FieldName = 'GER_DTAROM'
    end
    object qryMovGerXGER_HORROM: TTimeField
      FieldName = 'GER_HORROM'
    end
    object qryMovGerXGER_OPEROM: TStringField
      FieldName = 'GER_OPEROM'
      Size = 3
    end
    object qryMovGerXGER_NUMROM: TStringField
      FieldName = 'GER_NUMROM'
      Size = 6
    end
    object qryMovGerXGER_CONENT: TStringField
      FieldName = 'GER_CONENT'
      Size = 6
    end
    object qryMovGerXGER_IMPRES: TSmallintField
      FieldName = 'GER_IMPRES'
    end
    object qryMovGerXGER_CODREP: TStringField
      FieldName = 'GER_CODREP'
      Size = 3
    end
    object qryMovGerXGER_VALROM: TFloatField
      FieldName = 'GER_VALROM'
    end
    object qryMovGerXGER_ALQIRF: TFloatField
      FieldName = 'GER_ALQIRF'
    end
    object qryMovGerXGER_VALIRF: TFloatField
      FieldName = 'GER_VALIRF'
    end
    object qryMovGerXGER_ALQPIS: TFloatField
      FieldName = 'GER_ALQPIS'
    end
    object qryMovGerXGER_VALPIS: TFloatField
      FieldName = 'GER_VALPIS'
    end
    object qryMovGerXGER_ALQCOF: TFloatField
      FieldName = 'GER_ALQCOF'
    end
    object qryMovGerXGER_VALCOF: TFloatField
      FieldName = 'GER_VALCOF'
    end
    object qryMovGerXGER_ALQCSL: TFloatField
      FieldName = 'GER_ALQCSL'
    end
    object qryMovGerXGER_VALCSL: TFloatField
      FieldName = 'GER_VALCSL'
    end
    object qryMovGerXGER_IRFRET: TFloatField
      FieldName = 'GER_IRFRET'
    end
    object qryMovGerXGER_PISRET: TFloatField
      FieldName = 'GER_PISRET'
    end
    object qryMovGerXGER_COFRET: TFloatField
      FieldName = 'GER_COFRET'
    end
    object qryMovGerXGER_CSLRET: TFloatField
      FieldName = 'GER_CSLRET'
    end
    object qryMovGerXGER_SERRET: TFloatField
      FieldName = 'GER_SERRET'
    end
    object qryMovGerXGER_NOTRET: TStringField
      FieldName = 'GER_NOTRET'
      Size = 50
    end
    object qryMovGerXGER_NORESE: TStringField
      FieldName = 'GER_NORESE'
      Size = 50
    end
    object qryMovGerXGER_ALIRFP: TFloatField
      FieldName = 'GER_ALIRFP'
    end
    object qryMovGerXGER_ALPISP: TFloatField
      FieldName = 'GER_ALPISP'
    end
    object qryMovGerXGER_ALCOFP: TFloatField
      FieldName = 'GER_ALCOFP'
    end
    object qryMovGerXGER_ALCSLP: TFloatField
      FieldName = 'GER_ALCSLP'
    end
    object qryMovGerXGER_PESGSO: TFloatField
      FieldName = 'GER_PESGSO'
    end
    object qryMovGerXGER_VLSGSO: TFloatField
      FieldName = 'GER_VLSGSO'
    end
    object qryMovGerXGER_IRPRRT: TFloatField
      FieldName = 'GER_IRPRRT'
    end
    object qryMovGerXGER_IRPRDV: TFloatField
      FieldName = 'GER_IRPRDV'
    end
    object qryMovGerXGER_IRSERT: TFloatField
      FieldName = 'GER_IRSERT'
    end
    object qryMovGerXGER_IRSEDV: TFloatField
      FieldName = 'GER_IRSEDV'
    end
    object qryMovGerXGER_PIPRRT: TFloatField
      FieldName = 'GER_PIPRRT'
    end
    object qryMovGerXGER_PIPRDV: TFloatField
      FieldName = 'GER_PIPRDV'
    end
    object qryMovGerXGER_PISERT: TFloatField
      FieldName = 'GER_PISERT'
    end
    object qryMovGerXGER_PISEDV: TFloatField
      FieldName = 'GER_PISEDV'
    end
    object qryMovGerXGER_COPRRT: TFloatField
      FieldName = 'GER_COPRRT'
    end
    object qryMovGerXGER_COPRDV: TFloatField
      FieldName = 'GER_COPRDV'
    end
    object qryMovGerXGER_COSERT: TFloatField
      FieldName = 'GER_COSERT'
    end
    object qryMovGerXGER_COSEDV: TFloatField
      FieldName = 'GER_COSEDV'
    end
    object qryMovGerXGER_CSPRRT: TFloatField
      FieldName = 'GER_CSPRRT'
    end
    object qryMovGerXGER_CSPRDV: TFloatField
      FieldName = 'GER_CSPRDV'
    end
    object qryMovGerXGER_CSSERT: TFloatField
      FieldName = 'GER_CSSERT'
    end
    object qryMovGerXGER_CSSEDV: TFloatField
      FieldName = 'GER_CSSEDV'
    end
    object qryMovGerXGER_ORDPRO: TStringField
      FieldName = 'GER_ORDPRO'
      Size = 6
    end
  end
  object qryMovDet: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM MOVDET WHERE AUTOINCREM = -1')
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 24
    Top = 80
    object qryMovDetDET_CODEMP: TStringField
      FieldName = 'DET_CODEMP'
      Required = True
      Size = 3
    end
    object qryMovDetDET_CODITE: TStringField
      FieldName = 'DET_CODITE'
      Required = True
      Size = 5
    end
    object qryMovDetDET_CODVEN: TStringField
      FieldName = 'DET_CODVEN'
      Size = 3
    end
    object qryMovDetDET_CODDIV: TStringField
      FieldName = 'DET_CODDIV'
      Size = 8
    end
    object qryMovDetDET_CODMAR: TStringField
      FieldName = 'DET_CODMAR'
      Size = 3
    end
    object qryMovDetDET_CODFOR: TStringField
      FieldName = 'DET_CODFOR'
      Size = 8
    end
    object qryMovDetDET_CODCLI: TStringField
      FieldName = 'DET_CODCLI'
      Size = 8
    end
    object qryMovDetDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Size = 6
    end
    object qryMovDetDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Size = 2
    end
    object qryMovDetDET_SERIE_: TStringField
      FieldName = 'DET_SERIE_'
      Size = 3
    end
    object qryMovDetDET_DTAENT: TDateField
      FieldName = 'DET_DTAENT'
    end
    object qryMovDetDET_HORENT: TTimeField
      FieldName = 'DET_HORENT'
    end
    object qryMovDetDET_DTADOC: TDateField
      FieldName = 'DET_DTADOC'
    end
    object qryMovDetDET_CONPAG: TStringField
      FieldName = 'DET_CONPAG'
      Size = 38
    end
    object qryMovDetDET_TIP_FC: TStringField
      FieldName = 'DET_TIP_FC'
      Size = 1
    end
    object qryMovDetDET_ESTADO: TStringField
      FieldName = 'DET_ESTADO'
      Size = 2
    end
    object qryMovDetDET_DESCRI: TStringField
      FieldName = 'DET_DESCRI'
      Size = 57
    end
    object qryMovDetDET_UNIDAD: TStringField
      FieldName = 'DET_UNIDAD'
      Size = 2
    end
    object qryMovDetDET_FORITE: TStringField
      FieldName = 'DET_FORITE'
      Size = 8
    end
    object qryMovDetDET_QTDITE: TFloatField
      FieldName = 'DET_QTDITE'
    end
    object qryMovDetDET_UNITAR: TFloatField
      FieldName = 'DET_UNITAR'
    end
    object qryMovDetDET_UNIORI: TFloatField
      FieldName = 'DET_UNIORI'
    end
    object qryMovDetDET_TOTITE: TFloatField
      FieldName = 'DET_TOTITE'
    end
    object qryMovDetDET_VLRCON: TFloatField
      FieldName = 'DET_VLRCON'
    end
    object qryMovDetDET_TOTCUS: TFloatField
      FieldName = 'DET_TOTCUS'
    end
    object qryMovDetDET_TOTMED: TFloatField
      FieldName = 'DET_TOTMED'
    end
    object qryMovDetDET_DESCON: TFloatField
      FieldName = 'DET_DESCON'
    end
    object qryMovDetDET_TOTFRE: TFloatField
      FieldName = 'DET_TOTFRE'
    end
    object qryMovDetDET_DESESP: TFloatField
      FieldName = 'DET_DESESP'
    end
    object qryMovDetDET_DESACE: TFloatField
      FieldName = 'DET_DESACE'
    end
    object qryMovDetDET_CODREP: TStringField
      FieldName = 'DET_CODREP'
      Size = 3
    end
    object qryMovDetDET_PERCOM: TFloatField
      FieldName = 'DET_PERCOM'
    end
    object qryMovDetDET_TOTCOM: TFloatField
      FieldName = 'DET_TOTCOM'
    end
    object qryMovDetDET_CLAFIS: TStringField
      FieldName = 'DET_CLAFIS'
      Size = 4
    end
    object qryMovDetDET_CODFIS: TStringField
      FieldName = 'DET_CODFIS'
      Size = 3
    end
    object qryMovDetDET_VALIPI: TFloatField
      FieldName = 'DET_VALIPI'
    end
    object qryMovDetDET_ALQIPI: TFloatField
      FieldName = 'DET_ALQIPI'
    end
    object qryMovDetDET_BASIPI: TFloatField
      FieldName = 'DET_BASIPI'
    end
    object qryMovDetDET_VALICM: TFloatField
      FieldName = 'DET_VALICM'
    end
    object qryMovDetDET_ALQICM: TFloatField
      FieldName = 'DET_ALQICM'
    end
    object qryMovDetDET_BASICM: TFloatField
      FieldName = 'DET_BASICM'
    end
    object qryMovDetDET_VALRET: TFloatField
      FieldName = 'DET_VALRET'
    end
    object qryMovDetDET_ALQRET: TFloatField
      FieldName = 'DET_ALQRET'
    end
    object qryMovDetDET_BASRET: TFloatField
      FieldName = 'DET_BASRET'
    end
    object qryMovDetDET_TOTPES: TFloatField
      FieldName = 'DET_TOTPES'
    end
    object qryMovDetDET_PERBAS: TFloatField
      FieldName = 'DET_PERBAS'
    end
    object qryMovDetDET_PERRED: TFloatField
      FieldName = 'DET_PERRED'
    end
    object qryMovDetDET_JAFATU: TSmallintField
      FieldName = 'DET_JAFATU'
    end
    object qryMovDetDET_TIPFAT: TStringField
      FieldName = 'DET_TIPFAT'
      Size = 2
    end
    object qryMovDetDET_NUMFAT: TStringField
      FieldName = 'DET_NUMFAT'
      Size = 6
    end
    object qryMovDetDET_DTAFAT: TDateField
      FieldName = 'DET_DTAFAT'
    end
    object qryMovDetDET_VENFAT: TStringField
      FieldName = 'DET_VENFAT'
      Size = 3
    end
    object qryMovDetDET_CNDFAT: TStringField
      FieldName = 'DET_CNDFAT'
      Size = 38
    end
    object qryMovDetDET_VALFAT: TFloatField
      FieldName = 'DET_VALFAT'
    end
    object qryMovDetDET_IDEPRO: TStringField
      FieldName = 'DET_IDEPRO'
      Size = 3
    end
    object qryMovDetDET_INCPIS: TStringField
      FieldName = 'DET_INCPIS'
      Size = 1
    end
    object qryMovDetDET_NOTESP: TStringField
      FieldName = 'DET_NOTESP'
      Size = 1
    end
    object qryMovDetDET_REFERE: TStringField
      FieldName = 'DET_REFERE'
      Size = 16
    end
    object qryMovDetDET_DOCDEV: TStringField
      FieldName = 'DET_DOCDEV'
      Size = 6
    end
    object qryMovDetDET_ESPDEV: TStringField
      FieldName = 'DET_ESPDEV'
      Size = 6
    end
    object qryMovDetDET_EMPDEV: TStringField
      FieldName = 'DET_EMPDEV'
      Size = 6
    end
    object qryMovDetDET_ITETIN: TStringField
      FieldName = 'DET_ITETIN'
      Size = 50
    end
    object qryMovDetDET_ITECHA: TStringField
      FieldName = 'DET_ITECHA'
      Size = 5
    end
    object qryMovDetDET_DESCOR: TStringField
      FieldName = 'DET_DESCOR'
      Size = 15
    end
    object qryMovDetDET_TIPEMB: TStringField
      FieldName = 'DET_TIPEMB'
      Size = 2
    end
    object qryMovDetDET_QTDEMB: TFloatField
      FieldName = 'DET_QTDEMB'
    end
    object qryMovDetDET_PREEMB: TFloatField
      FieldName = 'DET_PREEMB'
    end
    object qryMovDetDET_TIPPRE: TStringField
      FieldName = 'DET_TIPPRE'
      Size = 1
    end
    object qryMovDetDET_PRVTIN: TFloatField
      FieldName = 'DET_PRVTIN'
    end
    object qryMovDetDET_PRCTIN: TFloatField
      FieldName = 'DET_PRCTIN'
    end
    object qryMovDetDET_FATTIN: TFloatField
      FieldName = 'DET_FATTIN'
    end
    object qryMovDetDET_PROEMB: TStringField
      FieldName = 'DET_PROEMB'
      Size = 1
    end
    object qryMovDetDET_CODDIG: TStringField
      FieldName = 'DET_CODDIG'
      Size = 3
    end
    object qryMovDetDET_CODCND: TStringField
      FieldName = 'DET_CODCND'
      Size = 3
    end
    object qryMovDetDET_CODFPG: TStringField
      FieldName = 'DET_CODFPG'
      Size = 3
    end
    object qryMovDetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
    object qryMovDetDET_SEQGER: TStringField
      FieldName = 'DET_SEQGER'
      Required = True
      Visible = False
    end
    object qryMovDetDET_ITEEMB: TStringField
      FieldName = 'DET_ITEEMB'
      Size = 5
    end
    object qryMovDetDET_GRUEMB: TStringField
      FieldName = 'DET_GRUEMB'
      Size = 4
    end
    object qryMovDetDET_LAZQUA: TIntegerField
      FieldName = 'DET_LAZQUA'
    end
    object qryMovDetDET_PROMOC: TStringField
      FieldName = 'DET_PROMOC'
      Size = 1
    end
    object qryMovDetDET_SEQTIN: TStringField
      FieldName = 'DET_SEQTIN'
    end
    object qryMovDetDET_CODVE2: TStringField
      FieldName = 'DET_CODVE2'
      Size = 3
    end
    object qryMovDetDET_TOTCO2: TFloatField
      FieldName = 'DET_TOTCO2'
    end
    object qryMovDetDET_QTDPUL: TFloatField
      FieldName = 'DET_QTDPUL'
    end
    object qryMovDetDET_PEDCOM: TStringField
      FieldName = 'DET_PEDCOM'
      Size = 6
    end
    object qryMovDetDET_ORIDOC: TStringField
      FieldName = 'DET_ORIDOC'
      Size = 1
    end
    object qryMovDetDET_IMPRES: TSmallintField
      FieldName = 'DET_IMPRES'
    end
    object qryMovDetDET_QTDROM: TFloatField
      FieldName = 'DET_QTDROM'
    end
    object qryMovDetDET_NUM_PD: TStringField
      FieldName = 'DET_NUM_PD'
      Size = 6
    end
    object qryMovDetDET_ESP_PD: TStringField
      FieldName = 'DET_ESP_PD'
      Size = 2
    end
    object qryMovDetDET_EMP_PD: TStringField
      FieldName = 'DET_EMP_PD'
      Size = 3
    end
    object qryMovDetDET_IND_PD: TIntegerField
      FieldName = 'DET_IND_PD'
    end
    object qryMovDetDET_ORDPRO: TStringField
      FieldName = 'DET_ORDPRO'
      Size = 6
    end
  end
  object qryMovDetX: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM MOVDETX WHERE AUTOINCREM = -1')
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 104
    Top = 80
    object qryMovDetXDET_CODEMP: TStringField
      FieldName = 'DET_CODEMP'
      Required = True
      Size = 3
    end
    object qryMovDetXDET_CODVEN: TStringField
      FieldName = 'DET_CODVEN'
      Required = True
      Size = 3
    end
    object qryMovDetXDET_CODITE: TStringField
      FieldName = 'DET_CODITE'
      Required = True
      Size = 5
    end
    object qryMovDetXDET_CODDIV: TStringField
      FieldName = 'DET_CODDIV'
      Size = 8
    end
    object qryMovDetXDET_CODMAR: TStringField
      FieldName = 'DET_CODMAR'
      Size = 3
    end
    object qryMovDetXDET_CODFOR: TStringField
      FieldName = 'DET_CODFOR'
      Size = 8
    end
    object qryMovDetXDET_CODCLI: TStringField
      FieldName = 'DET_CODCLI'
      Size = 8
    end
    object qryMovDetXDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Size = 6
    end
    object qryMovDetXDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Size = 2
    end
    object qryMovDetXDET_SERIE_: TStringField
      FieldName = 'DET_SERIE_'
      Size = 3
    end
    object qryMovDetXDET_DTAENT: TDateField
      FieldName = 'DET_DTAENT'
    end
    object qryMovDetXDET_HORENT: TTimeField
      FieldName = 'DET_HORENT'
    end
    object qryMovDetXDET_DTADOC: TDateField
      FieldName = 'DET_DTADOC'
    end
    object qryMovDetXDET_CONPAG: TStringField
      FieldName = 'DET_CONPAG'
      Size = 38
    end
    object qryMovDetXDET_TIP_FC: TStringField
      FieldName = 'DET_TIP_FC'
      Size = 1
    end
    object qryMovDetXDET_ESTADO: TStringField
      FieldName = 'DET_ESTADO'
      Size = 2
    end
    object qryMovDetXDET_DESCRI: TStringField
      FieldName = 'DET_DESCRI'
      Size = 57
    end
    object qryMovDetXDET_REFERE: TStringField
      FieldName = 'DET_REFERE'
      Size = 16
    end
    object qryMovDetXDET_UNIDAD: TStringField
      FieldName = 'DET_UNIDAD'
      Size = 2
    end
    object qryMovDetXDET_FORITE: TStringField
      FieldName = 'DET_FORITE'
      Size = 8
    end
    object qryMovDetXDET_QTDITE: TFloatField
      FieldName = 'DET_QTDITE'
    end
    object qryMovDetXDET_UNITAR: TFloatField
      FieldName = 'DET_UNITAR'
    end
    object qryMovDetXDET_UNIORI: TFloatField
      FieldName = 'DET_UNIORI'
    end
    object qryMovDetXDET_TOTITE: TFloatField
      FieldName = 'DET_TOTITE'
    end
    object qryMovDetXDET_VLRCON: TFloatField
      FieldName = 'DET_VLRCON'
    end
    object qryMovDetXDET_TOTCUS: TFloatField
      FieldName = 'DET_TOTCUS'
    end
    object qryMovDetXDET_TOTMED: TFloatField
      FieldName = 'DET_TOTMED'
    end
    object qryMovDetXDET_DESCON: TFloatField
      FieldName = 'DET_DESCON'
    end
    object qryMovDetXDET_TOTFRE: TFloatField
      FieldName = 'DET_TOTFRE'
    end
    object qryMovDetXDET_DESESP: TFloatField
      FieldName = 'DET_DESESP'
    end
    object qryMovDetXDET_DESACE: TFloatField
      FieldName = 'DET_DESACE'
    end
    object qryMovDetXDET_CODREP: TStringField
      FieldName = 'DET_CODREP'
      Size = 3
    end
    object qryMovDetXDET_PERCOM: TFloatField
      FieldName = 'DET_PERCOM'
    end
    object qryMovDetXDET_TOTCOM: TFloatField
      FieldName = 'DET_TOTCOM'
    end
    object qryMovDetXDET_CLAFIS: TStringField
      FieldName = 'DET_CLAFIS'
      Size = 4
    end
    object qryMovDetXDET_CODFIS: TStringField
      FieldName = 'DET_CODFIS'
      Size = 3
    end
    object qryMovDetXDET_VALIPI: TFloatField
      FieldName = 'DET_VALIPI'
    end
    object qryMovDetXDET_ALQIPI: TFloatField
      FieldName = 'DET_ALQIPI'
    end
    object qryMovDetXDET_BASIPI: TFloatField
      FieldName = 'DET_BASIPI'
    end
    object qryMovDetXDET_VALICM: TFloatField
      FieldName = 'DET_VALICM'
    end
    object qryMovDetXDET_ALQICM: TFloatField
      FieldName = 'DET_ALQICM'
    end
    object qryMovDetXDET_BASICM: TFloatField
      FieldName = 'DET_BASICM'
    end
    object qryMovDetXDET_VALRET: TFloatField
      FieldName = 'DET_VALRET'
    end
    object qryMovDetXDET_ALQRET: TFloatField
      FieldName = 'DET_ALQRET'
    end
    object qryMovDetXDET_BASRET: TFloatField
      FieldName = 'DET_BASRET'
    end
    object qryMovDetXDET_TOTPES: TFloatField
      FieldName = 'DET_TOTPES'
    end
    object qryMovDetXDET_PERBAS: TFloatField
      FieldName = 'DET_PERBAS'
    end
    object qryMovDetXDET_PERRED: TFloatField
      FieldName = 'DET_PERRED'
    end
    object qryMovDetXDET_JAFATU: TSmallintField
      FieldName = 'DET_JAFATU'
    end
    object qryMovDetXDET_TIPFAT: TStringField
      FieldName = 'DET_TIPFAT'
      Size = 2
    end
    object qryMovDetXDET_NUMFAT: TStringField
      FieldName = 'DET_NUMFAT'
      Size = 6
    end
    object qryMovDetXDET_DTAFAT: TDateField
      FieldName = 'DET_DTAFAT'
    end
    object qryMovDetXDET_VENFAT: TStringField
      FieldName = 'DET_VENFAT'
      Size = 3
    end
    object qryMovDetXDET_CNDFAT: TStringField
      FieldName = 'DET_CNDFAT'
      Size = 38
    end
    object qryMovDetXDET_VALFAT: TFloatField
      FieldName = 'DET_VALFAT'
    end
    object qryMovDetXDET_IDEPRO: TStringField
      FieldName = 'DET_IDEPRO'
      Size = 3
    end
    object qryMovDetXDET_INCPIS: TStringField
      FieldName = 'DET_INCPIS'
      Size = 1
    end
    object qryMovDetXDET_NOTESP: TStringField
      FieldName = 'DET_NOTESP'
      Size = 1
    end
    object qryMovDetXDET_DOCDEV: TStringField
      FieldName = 'DET_DOCDEV'
      Size = 6
    end
    object qryMovDetXDET_ESPDEV: TStringField
      FieldName = 'DET_ESPDEV'
      Size = 6
    end
    object qryMovDetXDET_EMPDEV: TStringField
      FieldName = 'DET_EMPDEV'
      Size = 6
    end
    object qryMovDetXDET_ITETIN: TStringField
      FieldName = 'DET_ITETIN'
      Size = 50
    end
    object qryMovDetXDET_ITECHA: TStringField
      FieldName = 'DET_ITECHA'
      Size = 5
    end
    object qryMovDetXDET_DESCOR: TStringField
      FieldName = 'DET_DESCOR'
      Size = 15
    end
    object qryMovDetXDET_TIPEMB: TStringField
      FieldName = 'DET_TIPEMB'
      Size = 2
    end
    object qryMovDetXDET_QTDEMB: TFloatField
      FieldName = 'DET_QTDEMB'
    end
    object qryMovDetXDET_PREEMB: TFloatField
      FieldName = 'DET_PREEMB'
    end
    object qryMovDetXDET_TIPPRE: TStringField
      FieldName = 'DET_TIPPRE'
      Size = 1
    end
    object qryMovDetXDET_PRVTIN: TFloatField
      FieldName = 'DET_PRVTIN'
    end
    object qryMovDetXDET_PRCTIN: TFloatField
      FieldName = 'DET_PRCTIN'
    end
    object qryMovDetXDET_FATTIN: TFloatField
      FieldName = 'DET_FATTIN'
    end
    object qryMovDetXDET_PROEMB: TStringField
      FieldName = 'DET_PROEMB'
      Size = 1
    end
    object qryMovDetXDET_CODDIG: TStringField
      FieldName = 'DET_CODDIG'
      Size = 3
    end
    object qryMovDetXDET_CODCND: TStringField
      FieldName = 'DET_CODCND'
      Size = 3
    end
    object qryMovDetXDET_CODFPG: TStringField
      FieldName = 'DET_CODFPG'
      Size = 3
    end
    object qryMovDetXAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
    object qryMovDetXDET_SEQGER: TStringField
      FieldName = 'DET_SEQGER'
      Required = True
      Visible = False
    end
    object qryMovDetXDET_ITEEMB: TStringField
      FieldName = 'DET_ITEEMB'
      Size = 5
    end
    object qryMovDetXDET_GRUEMB: TStringField
      FieldName = 'DET_GRUEMB'
      Size = 4
    end
    object qryMovDetXDET_LAZQUA: TIntegerField
      FieldName = 'DET_LAZQUA'
    end
    object qryMovDetXDET_PROMOC: TStringField
      FieldName = 'DET_PROMOC'
      Size = 1
    end
    object qryMovDetXDET_SEQTIN: TStringField
      FieldName = 'DET_SEQTIN'
    end
    object qryMovDetXDET_CODVE2: TStringField
      FieldName = 'DET_CODVE2'
      Size = 3
    end
    object qryMovDetXDET_TOTCO2: TFloatField
      FieldName = 'DET_TOTCO2'
    end
    object qryMovDetXDET_QTDPUL: TFloatField
      FieldName = 'DET_QTDPUL'
    end
    object qryMovDetXDET_PEDCOM: TStringField
      FieldName = 'DET_PEDCOM'
      Size = 6
    end
    object qryMovDetXDET_ORIDOC: TStringField
      FieldName = 'DET_ORIDOC'
      Size = 1
    end
    object qryMovDetXDET_IMPRES: TSmallintField
      FieldName = 'DET_IMPRES'
    end
    object qryMovDetXDET_QTDROM: TFloatField
      FieldName = 'DET_QTDROM'
    end
    object qryMovDetXDET_NUM_PD: TStringField
      FieldName = 'DET_NUM_PD'
      Size = 6
    end
    object qryMovDetXDET_ESP_PD: TStringField
      FieldName = 'DET_ESP_PD'
      Size = 2
    end
    object qryMovDetXDET_EMP_PD: TStringField
      FieldName = 'DET_EMP_PD'
      Size = 3
    end
    object qryMovDetXDET_IND_PD: TIntegerField
      FieldName = 'DET_IND_PD'
    end
    object qryMovDetXDET_ORDPRO: TStringField
      FieldName = 'DET_ORDPRO'
      Size = 6
    end
  end
end
