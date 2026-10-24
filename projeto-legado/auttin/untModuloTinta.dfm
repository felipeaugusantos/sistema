object frmModuloTinta: TfrmModuloTinta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 671
  Width = 1104
  object qryGla_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM GLA_CADNFM')
    Constraints = <>
    Left = 936
    Top = 272
    object qryGla_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 10
    end
    object qryGla_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qryGla_CadNfmNFM_DTACAD: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'NFM_DTACAD'
      EditMask = '99/99/9999'
    end
    object qryGla_CadNfmNFM_CODB01: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB01'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB01: TFloatField
      FieldName = 'NFM_QTDB01'
    end
    object qryGla_CadNfmNFM_CODB02: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB02'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB02: TFloatField
      FieldName = 'NFM_QTDB02'
    end
    object qryGla_CadNfmNFM_CODB03: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB03'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB03: TFloatField
      FieldName = 'NFM_QTDB03'
    end
    object qryGla_CadNfmNFM_CODB04: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB04'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB04: TFloatField
      FieldName = 'NFM_QTDB04'
    end
    object qryGla_CadNfmNFM_CODB05: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB05'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB05: TFloatField
      FieldName = 'NFM_QTDB05'
    end
    object qryGla_CadNfmNFM_CODB06: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB06'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB06: TFloatField
      FieldName = 'NFM_QTDB06'
    end
    object qryGla_CadNfmNFM_CODB07: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB07'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB07: TFloatField
      FieldName = 'NFM_QTDB07'
    end
    object qryGla_CadNfmNFM_CODB08: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB08'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB08: TFloatField
      FieldName = 'NFM_QTDB08'
    end
    object qryGla_CadNfmNFM_CODB09: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB09'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB09: TFloatField
      FieldName = 'NFM_QTDB09'
    end
    object qryGla_CadNfmNFM_CODB10: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB10'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB10: TFloatField
      FieldName = 'NFM_QTDB10'
    end
    object qryGla_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Visible = False
      Size = 3
    end
    object qryGla_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryGla_CadNfmNFM_CODB11: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB11'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB11: TFloatField
      FieldName = 'NFM_QTDB11'
    end
    object qryGla_CadNfmNFM_CODB12: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB12'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB12: TFloatField
      FieldName = 'NFM_QTDB12'
    end
    object qryGla_CadNfmNFM_CODB13: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB13'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB13: TFloatField
      FieldName = 'NFM_QTDB13'
    end
    object qryGla_CadNfmNFM_CODB14: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB14'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB14: TFloatField
      FieldName = 'NFM_QTDB14'
    end
    object qryGla_CadNfmNFM_CODB15: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB15'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB15: TFloatField
      FieldName = 'NFM_QTDB15'
    end
    object qryGla_CadNfmNFM_CODB16: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB16'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB16: TFloatField
      FieldName = 'NFM_QTDB16'
    end
    object qryGla_CadNfmNFM_CODB17: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB17'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB17: TFloatField
      FieldName = 'NFM_QTDB17'
    end
    object qryGla_CadNfmNFM_CODB18: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB18'
      Size = 30
    end
    object qryGla_CadNfmNFM_QTDB18: TFloatField
      FieldName = 'NFM_QTDB18'
    end
    object qryGla_CadNfmNFM_LINHA_: TStringField
      FieldName = 'NFM_LINHA_'
      Size = 15
    end
    object qryGla_CadNfmNFM_QTDD01: TFloatField
      FieldName = 'NFM_QTDD01'
    end
    object qryGla_CadNfmNFM_QTDD02: TFloatField
      FieldName = 'NFM_QTDD02'
    end
    object qryGla_CadNfmNFM_QTDD03: TFloatField
      FieldName = 'NFM_QTDD03'
    end
    object qryGla_CadNfmNFM_QTDD04: TFloatField
      FieldName = 'NFM_QTDD04'
    end
    object qryGla_CadNfmNFM_QTDD05: TFloatField
      FieldName = 'NFM_QTDD05'
    end
    object qryGla_CadNfmNFM_QTDD06: TFloatField
      FieldName = 'NFM_QTDD06'
    end
    object qryGla_CadNfmNFM_QTDD07: TFloatField
      FieldName = 'NFM_QTDD07'
    end
    object qryGla_CadNfmNFM_QTDD08: TFloatField
      FieldName = 'NFM_QTDD08'
    end
    object qryGla_CadNfmNFM_QTDD09: TFloatField
      FieldName = 'NFM_QTDD09'
    end
    object qryGla_CadNfmNFM_QTDD10: TFloatField
      FieldName = 'NFM_QTDD10'
    end
    object qryGla_CadNfmNFM_QTDD11: TFloatField
      FieldName = 'NFM_QTDD11'
    end
    object qryGla_CadNfmNFM_QTDD12: TFloatField
      FieldName = 'NFM_QTDD12'
    end
    object qryGla_CadNfmNFM_QTDD13: TFloatField
      FieldName = 'NFM_QTDD13'
    end
    object qryGla_CadNfmNFM_QTDD14: TFloatField
      FieldName = 'NFM_QTDD14'
    end
    object qryGla_CadNfmNFM_QTDD15: TFloatField
      FieldName = 'NFM_QTDD15'
    end
    object qryGla_CadNfmNFM_QTDD16: TFloatField
      FieldName = 'NFM_QTDD16'
    end
    object qryGla_CadNfmNFM_QTDD17: TFloatField
      FieldName = 'NFM_QTDD17'
    end
    object qryGla_CadNfmNFM_QTDD18: TFloatField
      FieldName = 'NFM_QTDD18'
    end
  end
  object dtsGla_CadNfm: TDataSource
    DataSet = qryGla_CadNfm
    Left = 216
    Top = 280
  end
  object dtsGla_CadBas: TDataSource
    DataSet = qryGla_CadBas
    Left = 40
    Top = 232
  end
  object qryGla_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM GLA_CADBAS')
    Constraints = <>
    Left = 928
    Top = 216
    object qryGla_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 30
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 30
    end
    object qryGla_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 40
    end
    object qryGla_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryGla_CadBasBAS_PESBAS: TFloatField
      DisplayLabel = 'Peso'
      FieldName = 'BAS_PESBAS'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryGla_CadBasBAS_VALBAS: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'BAS_VALBAS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryGla_CadBasBAS_CODEMP: TStringField
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qryGla_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryGla_CadBasBAS_EMBALA: TFloatField
      FieldName = 'BAS_EMBALA'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryGla_CadBasBAS_LINHA_: TStringField
      FieldName = 'BAS_LINHA_'
      Size = 12
    end
  end
  object qryLaz_MixFor: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LAZ_MIXFOR WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 568
    Top = 280
  end
  object dtsLaz_MixFor: TDataSource
    DataSet = qryLaz_MixFor
    Left = 304
    Top = 232
  end
  object dtsLaz_CadMix: TDataSource
    DataSet = qryLaz_CadMix
    Left = 744
    Top = 184
  end
  object qryLaz_CadMix: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LAZ_CADMIX WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 304
    Top = 328
  end
  object dtsLaz_CadBas: TDataSource
    DataSet = qryLaz_CadBas
    Left = 392
    Top = 280
  end
  object qryLaz_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LAZ_CADBAS WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 744
    Top = 280
    object qryLaz_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 10
    end
    object qryLaz_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryLaz_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Required = True
      Size = 40
    end
    object qryLaz_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object qryLaz_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryLaz_CadBasBAS_PRECUS: TFloatField
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLaz_CadBasBAS_MARGEM: TFloatField
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLaz_CadBasBAS_PREVEN: TFloatField
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLaz_CadBasBAS_EMBALA: TFloatField
      FieldName = 'BAS_EMBALA'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryLaz_CadBasBAS_PESESP: TFloatField
      FieldName = 'BAS_PESESP'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryLaz_CadBasBAS_DESCAM: TFloatField
      FieldName = 'BAS_DESCAM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLaz_CadBasBAS_DESCON: TFloatField
      FieldName = 'BAS_DESCON'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object qryBza_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM BZA_CADBAS')
    Constraints = <>
    Left = 656
    Top = 520
    object qryBza_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 7
    end
    object qryBza_CadBasBAS_CODEMP: TStringField
      FieldName = 'BAS_CODEMP'
      Required = True
      Size = 3
    end
    object qryBza_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryBza_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 40
    end
    object qryBza_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryBza_CadBasBAS_PESPEC: TFloatField
      DisplayLabel = 'Peso Esp.'
      FieldName = 'BAS_PESPEC'
    end
    object qryBza_CadBasBAS_PRECUS: TFloatField
      DisplayLabel = 'Pre. Custo'
      FieldName = 'BAS_PRECUS'
    end
    object qryBza_CadBasBAS_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
    end
    object qryBza_CadBasBAS_PREVEN: TFloatField
      DisplayLabel = 'Pre. Venda'
      FieldName = 'BAS_PREVEN'
    end
    object qryBza_CadBasBAS_EMBALA: TFloatField
      DisplayLabel = 'Embalagem'
      FieldName = 'BAS_EMBALA'
    end
  end
  object dtsBza_CadBas: TDataSource
    DataSet = qryBza_CadBas
    Left = 392
    Top = 232
  end
  object qryCorImo_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIMO_CADEMB')
    Constraints = <>
    Left = 480
    Top = 568
    object qryCorImo_CadEmbEMB_CODEMB: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object qryCorImo_CadEmbEMB_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryCorImo_CadEmbEMB_QTDEMB: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryCorImo_CadEmbEMB_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object qryCorImo_CadEmbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsCorImo_CadEmb: TDataSource
    DataSet = qryCorImo_CadEmb
    Left = 128
    Top = 280
  end
  object qryCorImo_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIMO_CADCOL')
    Constraints = <>
    Left = 744
    Top = 520
    object qryCorImo_CadColCOL_CODCOL: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object qryCorImo_CadColCOL_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryCorImo_CadColCOL_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'COL_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryCorImo_CadColCOL_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'COL_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryCorImo_CadColCOL_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryCorImo_CadColCOL_CODITE: TStringField
      DisplayLabel = 'Item Colorante'
      FieldName = 'COL_CODITE'
      Size = 5
    end
    object qryCorImo_CadColAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsCorImo_CadCol: TDataSource
    DataSet = qryCorImo_CadCol
    Left = 656
    Top = 184
  end
  object qryCorImo_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIMO_CADBAS')
    Constraints = <>
    Left = 656
    Top = 424
    object qryCorImo_CadBasBAS_BASE__: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object qryCorImo_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object qryCorImo_CadBasBAS_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object qryCorImo_CadBasBAS_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object qryCorImo_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qryCorImo_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryCorImo_CadBasBAS_PRECUS: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object qryCorImo_CadBasBAS_PREVEN: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object qryCorImo_CadBasBAS_MARGEM: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object dtsCorImo_CadBas: TDataSource
    DataSet = qryCorImo_CadBas
    Left = 216
    Top = 232
  end
  object qryCorImo_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIMO_CADNFM')
    Constraints = <>
    Left = 480
    Top = 424
    object qryCorImo_CadNfmNFM_CODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODIGO'
      Required = True
      Size = 10
    end
    object qryCorImo_CadNfmNFM_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Required = True
      Size = 3
    end
    object qryCorImo_CadNfmNFM_CODBAS: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_CODBAS'
      Size = 10
    end
    object qryCorImo_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 35
    end
    object qryCorImo_CadNfmNFM_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object qryCorImo_CadNfmNFM_CODEMB: TStringField
      DisplayLabel = 'Embalagem'
      FieldName = 'NFM_CODEMB'
      Size = 5
    end
    object qryCorImo_CadNfmNFM_FORM01: TStringField
      DisplayLabel = 'Colorante 01'
      FieldName = 'NFM_FORM01'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM02: TStringField
      DisplayLabel = 'Colorante 02'
      FieldName = 'NFM_FORM02'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM03: TStringField
      DisplayLabel = 'Colorante 03'
      FieldName = 'NFM_FORM03'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM04: TStringField
      DisplayLabel = 'Colorante 04'
      FieldName = 'NFM_FORM04'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM05: TStringField
      DisplayLabel = 'Colorante 05'
      FieldName = 'NFM_FORM05'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM06: TStringField
      DisplayLabel = 'Colorante 06'
      FieldName = 'NFM_FORM06'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM07: TStringField
      DisplayLabel = 'Colorante 07'
      FieldName = 'NFM_FORM07'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM08: TStringField
      DisplayLabel = 'Colorante 08'
      FieldName = 'NFM_FORM08'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM09: TStringField
      DisplayLabel = 'Colorante 09'
      FieldName = 'NFM_FORM09'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_FORM10: TStringField
      DisplayLabel = 'Colorante 10'
      FieldName = 'NFM_FORM10'
      Size = 6
    end
    object qryCorImo_CadNfmNFM_QTDC01: TFloatField
      DisplayLabel = 'Quantidade 01'
      FieldName = 'NFM_QTDC01'
    end
    object qryCorImo_CadNfmNFM_QTDC02: TFloatField
      DisplayLabel = 'Quantidade 02'
      FieldName = 'NFM_QTDC02'
    end
    object qryCorImo_CadNfmNFM_QTDC03: TFloatField
      DisplayLabel = 'Quantidade 03'
      FieldName = 'NFM_QTDC03'
    end
    object qryCorImo_CadNfmNFM_QTDC04: TFloatField
      DisplayLabel = 'Quantidade 04'
      FieldName = 'NFM_QTDC04'
    end
    object qryCorImo_CadNfmNFM_QTDC05: TFloatField
      DisplayLabel = 'Quantidade 05'
      FieldName = 'NFM_QTDC05'
    end
    object qryCorImo_CadNfmNFM_QTDC06: TFloatField
      DisplayLabel = 'Quantidade 06'
      FieldName = 'NFM_QTDC06'
    end
    object qryCorImo_CadNfmNFM_QTDC07: TFloatField
      DisplayLabel = 'Quantidade 07'
      FieldName = 'NFM_QTDC07'
    end
    object qryCorImo_CadNfmNFM_QTDC08: TFloatField
      DisplayLabel = 'Quantidade 08'
      FieldName = 'NFM_QTDC08'
    end
    object qryCorImo_CadNfmNFM_QTDC09: TFloatField
      DisplayLabel = 'Quantidade 09'
      FieldName = 'NFM_QTDC09'
    end
    object qryCorImo_CadNfmNFM_QTDC10: TFloatField
      DisplayLabel = 'Quantidade 10'
      FieldName = 'NFM_QTDC10'
    end
    object qryCorImo_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryCorImo_CadNfmNFM_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'NFM_CODITE'
      Size = 5
    end
  end
  object dtsCorImo_CadNfm: TDataSource
    DataSet = qryCorImo_CadNfm
    Left = 832
    Top = 184
  end
  object qryCorInd_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIND_CADEMB')
    Constraints = <>
    Left = 480
    Top = 472
    object StringField1: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField2: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField3: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object qryCorInd_CadEmbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsCorInd_CadEmb: TDataSource
    DataSet = qryCorInd_CadEmb
    Left = 304
    Top = 280
  end
  object qryCorInd_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIND_CADCOL')
    Constraints = <>
    Left = 216
    Top = 472
    object StringField4: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object StringField5: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField2: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'COL_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField3: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'COL_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField4: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField6: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'COL_CODITE'
      Size = 5
    end
    object qryCorInd_CadColAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsCorInd_CadCol: TDataSource
    DataSet = qryCorInd_CadCol
    Left = 832
    Top = 232
  end
  object qryCorInd_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIND_CADBAS')
    Constraints = <>
    Left = 304
    Top = 472
    object StringField7: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField8: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField10: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField11: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField12: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qryCorInd_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsCorInd_CadBas: TDataSource
    DataSet = qryCorInd_CadBas
    Left = 128
    Top = 88
  end
  object qryCorInd_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CORIND_CADNFM')
    Constraints = <>
    Left = 392
    Top = 472
    object StringField13: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODIGO'
      Required = True
      Size = 10
    end
    object StringField14: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Required = True
      Size = 3
    end
    object StringField15: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_CODBAS'
      Size = 10
    end
    object StringField16: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 35
    end
    object StringField17: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object StringField18: TStringField
      DisplayLabel = 'Embalagem'
      FieldName = 'NFM_CODEMB'
      Size = 5
    end
    object StringField20: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'NFM_CODITE'
      Size = 5
    end
    object StringField21: TStringField
      DisplayLabel = 'Colorante 01'
      FieldName = 'NFM_FORM01'
      Size = 6
    end
    object StringField22: TStringField
      DisplayLabel = 'Colorante 02'
      FieldName = 'NFM_FORM02'
      Size = 6
    end
    object StringField23: TStringField
      DisplayLabel = 'Colorante 03'
      FieldName = 'NFM_FORM03'
      Size = 6
    end
    object StringField24: TStringField
      DisplayLabel = 'Colorante 04'
      FieldName = 'NFM_FORM04'
      Size = 6
    end
    object StringField25: TStringField
      DisplayLabel = 'Colorante 05'
      FieldName = 'NFM_FORM05'
      Size = 6
    end
    object StringField26: TStringField
      DisplayLabel = 'Colorante 06'
      FieldName = 'NFM_FORM06'
      Size = 6
    end
    object StringField27: TStringField
      DisplayLabel = 'Colorante 07'
      FieldName = 'NFM_FORM07'
      Size = 6
    end
    object StringField28: TStringField
      DisplayLabel = 'Colorante 08'
      FieldName = 'NFM_FORM08'
      Size = 6
    end
    object StringField29: TStringField
      DisplayLabel = 'Colorante 09'
      FieldName = 'NFM_FORM09'
      Size = 6
    end
    object StringField30: TStringField
      DisplayLabel = 'Colorante 10'
      FieldName = 'NFM_FORM10'
      Size = 6
    end
    object FloatField5: TFloatField
      DisplayLabel = 'Quantidade 01'
      FieldName = 'NFM_QTDC01'
    end
    object FloatField6: TFloatField
      DisplayLabel = 'Quantidade 02'
      FieldName = 'NFM_QTDC02'
    end
    object FloatField7: TFloatField
      DisplayLabel = 'Quantidade 03'
      FieldName = 'NFM_QTDC03'
    end
    object FloatField8: TFloatField
      DisplayLabel = 'Quantidade 04'
      FieldName = 'NFM_QTDC04'
    end
    object FloatField9: TFloatField
      DisplayLabel = 'Quantidade 05'
      FieldName = 'NFM_QTDC05'
    end
    object FloatField10: TFloatField
      DisplayLabel = 'Quantidade 06'
      FieldName = 'NFM_QTDC06'
    end
    object FloatField11: TFloatField
      DisplayLabel = 'Quantidade 07'
      FieldName = 'NFM_QTDC07'
    end
    object FloatField12: TFloatField
      DisplayLabel = 'Quantidade 08'
      FieldName = 'NFM_QTDC08'
    end
    object FloatField13: TFloatField
      DisplayLabel = 'Quantidade 09'
      FieldName = 'NFM_QTDC09'
    end
    object FloatField14: TFloatField
      DisplayLabel = 'Quantidade 10'
      FieldName = 'NFM_QTDC10'
    end
    object qryCorInd_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsCorInd_CadNfm: TDataSource
    DataSet = qryCorInd_CadNfm
    Left = 216
    Top = 88
  end
  object qryLks_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKS_CADBAS WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 128
    Top = 472
    object qryLks_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 2
    end
    object qryLks_CadBasBAS_CODPRO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'BAS_CODPRO'
      Required = True
      Size = 2
    end
    object qryLks_CadBasBAS_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Required = True
      Size = 2
    end
    object qryLks_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryLks_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryLks_CadBasBAS_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object qryLks_CadBasAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsLks_CadBas: TDataSource
    DataSet = qryLks_CadBas
    Left = 832
    Top = 40
  end
  object qryLks_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKS_CADCOL WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 656
    Top = 472
    object qryLks_CadColCOL_CODCOL: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object qryLks_CadColCOL_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryLks_CadColCOL_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      DisplayWidth = 10
      FieldName = 'COL_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLks_CadColCOL_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o de Venda'
      DisplayWidth = 10
      FieldName = 'COL_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLks_CadColCOL_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      DisplayWidth = 10
      FieldName = 'COL_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLks_CadColCOL_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'COL_CODITE'
      Size = 5
    end
    object qryLks_CadColAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryLks_CadColCOL_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'COL_DESCRI'
    end
  end
  object dtsLks_CadCol: TDataSource
    DataSet = qryLks_CadCol
    Left = 40
    Top = 88
  end
  object qryLks_CadLks: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKS_CADLKS WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 744
    Top = 472
  end
  object dtsLks_CadLks: TDataSource
    DataSet = qryLks_CadLks
    Left = 304
    Top = 88
  end
  object qryLks_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKS_CADNFM WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 568
    Top = 472
    object qryLks_CadNfmNFM_CODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODIGO'
      Required = True
      Size = 10
    end
    object qryLks_CadNfmNFM_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryLks_CadNfmNFM_CODBAS: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_CODBAS'
      Size = 2
    end
    object qryLks_CadNfmNFM_CODPRO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'NFM_CODPRO'
      Size = 2
    end
    object qryLks_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 35
    end
    object qryLks_CadNfmNFM_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object qryLks_CadNfmAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryLks_CadNfmNFM_FORM01: TStringField
      DisplayLabel = 'Colorante 01'
      FieldName = 'NFM_FORM01'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC01: TFloatField
      DisplayLabel = 'Quantidade 01'
      FieldName = 'NFM_QTDC01'
    end
    object qryLks_CadNfmNFM_FORM02: TStringField
      DisplayLabel = 'Colorante 02'
      FieldName = 'NFM_FORM02'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC02: TFloatField
      DisplayLabel = 'Quantidade 02'
      FieldName = 'NFM_QTDC02'
    end
    object qryLks_CadNfmNFM_FORM03: TStringField
      DisplayLabel = 'Colorante 03'
      FieldName = 'NFM_FORM03'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC03: TFloatField
      DisplayLabel = 'Quantidade 03'
      FieldName = 'NFM_QTDC03'
    end
    object qryLks_CadNfmNFM_FORM04: TStringField
      DisplayLabel = 'Colorante 04'
      FieldName = 'NFM_FORM04'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC04: TFloatField
      DisplayLabel = 'Quantidade 04'
      FieldName = 'NFM_QTDC04'
    end
    object qryLks_CadNfmNFM_FORM05: TStringField
      DisplayLabel = 'Colorante 05'
      FieldName = 'NFM_FORM05'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC05: TFloatField
      DisplayLabel = 'Quantidade 05'
      FieldName = 'NFM_QTDC05'
    end
    object qryLks_CadNfmNFM_FORM06: TStringField
      DisplayLabel = 'Colorante 06'
      FieldName = 'NFM_FORM06'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC06: TFloatField
      DisplayLabel = 'Quantidade 06'
      FieldName = 'NFM_QTDC06'
    end
    object qryLks_CadNfmNFM_FORM07: TStringField
      DisplayLabel = 'Colorante 07'
      FieldName = 'NFM_FORM07'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC07: TFloatField
      DisplayLabel = 'Quantidade 07'
      FieldName = 'NFM_QTDC07'
    end
    object qryLks_CadNfmNFM_FORM08: TStringField
      DisplayLabel = 'Colorante 08'
      FieldName = 'NFM_FORM08'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC08: TFloatField
      DisplayLabel = 'Quantidade 08'
      FieldName = 'NFM_QTDC08'
    end
    object qryLks_CadNfmNFM_FORM09: TStringField
      DisplayLabel = 'Colorante 09'
      FieldName = 'NFM_FORM09'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC09: TFloatField
      DisplayLabel = 'Quantidade 09'
      FieldName = 'NFM_QTDC09'
    end
    object qryLks_CadNfmNFM_FORM10: TStringField
      DisplayLabel = 'Colorante 10'
      FieldName = 'NFM_FORM10'
      Size = 2
    end
    object qryLks_CadNfmNFM_QTDC10: TFloatField
      DisplayLabel = 'Quantidade 10'
      FieldName = 'NFM_QTDC10'
    end
  end
  object dtsLks_CadNfm: TDataSource
    DataSet = qryLks_CadNfm
    Left = 568
    Top = 88
  end
  object qryPpg_CadPpg: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM PPG_CADPPG WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 40
    Top = 472
    object qryPpg_CadPpgPPG_CODSEQ: TStringField
      FieldName = 'PPG_CODSEQ'
      Size = 6
    end
    object qryPpg_CadPpgPPG_DESCOR: TStringField
      FieldName = 'PPG_DESCOR'
      Size = 35
    end
    object qryPpg_CadPpgPPG_VEICUL: TStringField
      FieldName = 'PPG_VEICUL'
      Size = 35
    end
    object qryPpg_CadPpgPPG_MONTAD: TStringField
      FieldName = 'PPG_MONTAD'
      Size = 16
    end
    object qryPpg_CadPpgPPG_TIPO__: TStringField
      FieldName = 'PPG_TIPO__'
      Size = 9
    end
    object qryPpg_CadPpgPPG_A_N_O_: TStringField
      FieldName = 'PPG_A_N_O_'
      Size = 8
    end
    object qryPpg_CadPpgPPG_CODCOR: TStringField
      FieldName = 'PPG_CODCOR'
      Size = 250
    end
    object qryPpg_CadPpgPPG_CODATC: TStringField
      FieldName = 'PPG_CODATC'
      Size = 25
    end
    object qryPpg_CadPpgPPG_PRECUS: TFloatField
      FieldName = 'PPG_PRECUS'
    end
    object qryPpg_CadPpgPPG_PREVEN: TFloatField
      FieldName = 'PPG_PREVEN'
    end
    object qryPpg_CadPpgPPG_CODEMP: TStringField
      FieldName = 'PPG_CODEMP'
      Size = 3
    end
    object qryPpg_CadPpgAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
    end
  end
  object qryZyn_CadZyn: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM ZYN_CADZYN WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 216
    Top = 424
    object qryZyn_CadZynZYN_CODSEQ: TStringField
      FieldName = 'ZYN_CODSEQ'
      Size = 6
    end
    object qryZyn_CadZynZYN_DESCOR: TStringField
      FieldName = 'ZYN_DESCOR'
      Size = 35
    end
    object qryZyn_CadZynZYN_VEICUL: TStringField
      FieldName = 'ZYN_VEICUL'
      Size = 35
    end
    object qryZyn_CadZynZYN_MONTAD: TStringField
      FieldName = 'ZYN_MONTAD'
      Size = 16
    end
    object qryZyn_CadZynZYN_TIPO__: TStringField
      FieldName = 'ZYN_TIPO__'
      Size = 10
    end
    object qryZyn_CadZynZYN_A_N_O_: TStringField
      FieldName = 'ZYN_A_N_O_'
      Size = 8
    end
    object qryZyn_CadZynZYN_CODCOR: TStringField
      FieldName = 'ZYN_CODCOR'
      Size = 15
    end
    object qryZyn_CadZynZYN_CODATC: TStringField
      FieldName = 'ZYN_CODATC'
      Size = 25
    end
    object qryZyn_CadZynZYN_PRECUS: TFloatField
      FieldName = 'ZYN_PRECUS'
    end
    object qryZyn_CadZynZYN_PREVEN: TFloatField
      FieldName = 'ZYN_PREVEN'
    end
    object qryZyn_CadZynZYN_CODEMP: TStringField
      FieldName = 'ZYN_CODEMP'
      Size = 3
    end
    object qryZyn_CadZynAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
    end
  end
  object qrySta_CadSta: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM STA_CADSTA WHERE AUTOINCREM = -1')
    Constraints = <>
    Left = 304
    Top = 424
    object qrySta_CadStaSTA_CODSEQ: TStringField
      FieldName = 'STA_CODSEQ'
      Size = 6
    end
    object qrySta_CadStaSTA_NOMCOR: TStringField
      FieldName = 'STA_NOMCOR'
      Size = 45
    end
    object qrySta_CadStaSTA_ANOCOR: TStringField
      FieldName = 'STA_ANOCOR'
      Size = 4
    end
    object qrySta_CadStaSTA_CODLIN: TStringField
      FieldName = 'STA_CODLIN'
      Size = 3
    end
    object qrySta_CadStaSTA_CODMON: TStringField
      FieldName = 'STA_CODMON'
      Size = 3
    end
    object qrySta_CadStaSTA_UNIVER: TStringField
      FieldName = 'STA_UNIVER'
      Size = 12
    end
    object qrySta_CadStaSTA_UNIDAD: TStringField
      FieldName = 'STA_UNIDAD'
      Size = 2
    end
    object qrySta_CadStaSTA_CODB01: TStringField
      FieldName = 'STA_CODB01'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB01: TFloatField
      FieldName = 'STA_QTDB01'
    end
    object qrySta_CadStaSTA_CODB02: TStringField
      FieldName = 'STA_CODB02'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB02: TFloatField
      FieldName = 'STA_QTDB02'
    end
    object qrySta_CadStaSTA_CODB03: TStringField
      FieldName = 'STA_CODB03'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB03: TFloatField
      FieldName = 'STA_QTDB03'
    end
    object qrySta_CadStaSTA_CODB04: TStringField
      FieldName = 'STA_CODB04'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB04: TFloatField
      FieldName = 'STA_QTDB04'
    end
    object qrySta_CadStaSTA_CODB05: TStringField
      FieldName = 'STA_CODB05'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB05: TFloatField
      FieldName = 'STA_QTDB05'
    end
    object qrySta_CadStaSTA_CODB06: TStringField
      FieldName = 'STA_CODB06'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB06: TFloatField
      FieldName = 'STA_QTDB06'
    end
    object qrySta_CadStaSTA_CODB07: TStringField
      FieldName = 'STA_CODB07'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB07: TFloatField
      FieldName = 'STA_QTDB07'
    end
    object qrySta_CadStaSTA_CODB08: TStringField
      FieldName = 'STA_CODB08'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB08: TFloatField
      FieldName = 'STA_QTDB08'
    end
    object qrySta_CadStaSTA_CODB09: TStringField
      FieldName = 'STA_CODB09'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB09: TFloatField
      FieldName = 'STA_QTDB09'
    end
    object qrySta_CadStaSTA_CODB10: TStringField
      FieldName = 'STA_CODB10'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB10: TFloatField
      FieldName = 'STA_QTDB10'
    end
    object qrySta_CadStaSTA_CODB11: TStringField
      FieldName = 'STA_CODB11'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB11: TFloatField
      FieldName = 'STA_QTDB11'
    end
    object qrySta_CadStaSTA_CODB12: TStringField
      FieldName = 'STA_CODB12'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB12: TFloatField
      FieldName = 'STA_QTDB12'
    end
    object qrySta_CadStaSTA_CODB13: TStringField
      FieldName = 'STA_CODB13'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB13: TFloatField
      FieldName = 'STA_QTDB13'
    end
    object qrySta_CadStaSTA_CODB14: TStringField
      FieldName = 'STA_CODB14'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB14: TFloatField
      FieldName = 'STA_QTDB14'
    end
    object qrySta_CadStaSTA_CODB15: TStringField
      FieldName = 'STA_CODB15'
      Size = 8
    end
    object qrySta_CadStaSTA_QTDB15: TFloatField
      FieldName = 'STA_QTDB15'
    end
    object qrySta_CadStaSTA_PRECUS: TFloatField
      FieldName = 'STA_PRECUS'
    end
    object qrySta_CadStaSTA_PREVEN: TFloatField
      FieldName = 'STA_PREVEN'
    end
    object qrySta_CadStaAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object qryWan_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM WAN_CADBAS')
    Constraints = <>
    Left = 832
    Top = 520
    object qryWan_CadBasBAS_LINHA_: TStringField
      DisplayLabel = 'Linha'
      FieldName = 'BAS_LINHA_'
      Required = True
      Size = 3
    end
    object qryWan_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 15
    end
    object qryWan_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 40
    end
    object qryWan_CadBasBAS_PESBAS: TFloatField
      DisplayLabel = 'Peso Base'
      FieldName = 'BAS_PESBAS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryWan_CadBasBAS_VALBAS: TFloatField
      DisplayLabel = 'Valor Base'
      FieldName = 'BAS_VALBAS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryWan_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryWan_CadBasBAS_PESUNI: TFloatField
      DisplayLabel = 'Peso Unidade'
      FieldName = 'BAS_PESUNI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryWan_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qryWan_CadBasAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsWan_CadBas: TDataSource
    DataSet = qryWan_CadBas
    Left = 40
    Top = 40
  end
  object qryShe_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM SHE_CADBAS')
    Constraints = <>
    Left = 392
    Top = 568
    object qryShe_CadBasBAS_BASE__: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 2
    end
    object qryShe_CadBasBAS_PROKEY: TStringField
      DisplayLabel = 'Prod. Key'
      FieldName = 'BAS_PROKEY'
      Required = True
      Size = 2
    end
    object qryShe_CadBasBAS_SUBKEY: TStringField
      DisplayLabel = 'Sub. Key'
      FieldName = 'BAS_SUBKEY'
      Required = True
      Size = 2
    end
    object qryShe_CadBasBAS_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Required = True
      Size = 2
    end
    object qryShe_CadBasBAS_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 60
    end
    object qryShe_CadBasBAS_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryShe_CadBasBAS_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryShe_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryShe_CadBasBAS_MARGEM: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryShe_CadBasBAS_CODEMP: TStringField
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryShe_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsShe_CadBas: TDataSource
    DataSet = qryShe_CadBas
    Left = 128
    Top = 40
  end
  object qryShe_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM SHE_CADCOL')
    Constraints = <>
    Left = 216
    Top = 568
    object qryShe_CadColCOL_CODCOL: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object qryShe_CadColCOL_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'COL_DESCRI'
      Required = True
    end
    object qryShe_CadColCOL_CODITE: TStringField
      DisplayLabel = 'C'#243'digo Item'
      FieldName = 'COL_CODITE'
      Required = True
      Size = 5
    end
    object qryShe_CadColCOL_PRELIT: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'COL_PRELIT'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryShe_CadColCOL_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o de Venda'
      FieldName = 'COL_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryShe_CadColCOL_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryShe_CadColAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryShe_CadColCOL_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dtsShe_CadCol: TDataSource
    DataSet = qryShe_CadCol
    Left = 392
    Top = 40
  end
  object qryShe_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM SHE_CADEMB')
    Constraints = <>
    Left = 304
    Top = 568
    object qryShe_CadEmbEMB_CODEMB: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 2
    end
    object qryShe_CadEmbEMB_QTDEMB: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryShe_CadEmbEMB_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object qryShe_CadEmbEMB_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryShe_CadEmbAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsShe_CadEmb: TDataSource
    DataSet = qryShe_CadEmb
    Left = 656
    Top = 40
  end
  object qryShe_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM SHE_CADNFM')
    Constraints = <>
    Left = 128
    Top = 520
    object qryShe_CadNfmNFM_CODPRO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODPRO'
      Required = True
      Size = 10
    end
    object qryShe_CadNfmNFM_BASE__: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_BASE__'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL001: TStringField
      FieldName = 'NFM_COL001'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL002: TStringField
      FieldName = 'NFM_COL002'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL003: TStringField
      FieldName = 'NFM_COL003'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL004: TStringField
      FieldName = 'NFM_COL004'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL005: TStringField
      FieldName = 'NFM_COL005'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL006: TStringField
      FieldName = 'NFM_COL006'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL007: TStringField
      FieldName = 'NFM_COL007'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL008: TStringField
      FieldName = 'NFM_COL008'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL009: TStringField
      FieldName = 'NFM_COL009'
      Size = 2
    end
    object qryShe_CadNfmNFM_COL010: TStringField
      FieldName = 'NFM_COL010'
      Size = 2
    end
    object qryShe_CadNfmNFM_QTD001: TFloatField
      FieldName = 'NFM_QTD001'
    end
    object qryShe_CadNfmNFM_QTD002: TFloatField
      FieldName = 'NFM_QTD002'
    end
    object qryShe_CadNfmNFM_QTD003: TFloatField
      FieldName = 'NFM_QTD003'
    end
    object qryShe_CadNfmNFM_QTD004: TFloatField
      FieldName = 'NFM_QTD004'
    end
    object qryShe_CadNfmNFM_QTD005: TFloatField
      FieldName = 'NFM_QTD005'
    end
    object qryShe_CadNfmNFM_QTD006: TFloatField
      FieldName = 'NFM_QTD006'
    end
    object qryShe_CadNfmNFM_QTD007: TFloatField
      FieldName = 'NFM_QTD007'
    end
    object qryShe_CadNfmNFM_QTD008: TFloatField
      FieldName = 'NFM_QTD008'
    end
    object qryShe_CadNfmNFM_QTD009: TFloatField
      FieldName = 'NFM_QTD009'
    end
    object qryShe_CadNfmNFM_QTD010: TFloatField
      FieldName = 'NFM_QTD010'
    end
    object qryShe_CadNfmNFM_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object qryShe_CadNfmNFM_PROKEY: TStringField
      DisplayLabel = 'Prod. Key'
      FieldName = 'NFM_PROKEY'
      Size = 2
    end
    object qryShe_CadNfmNFM_SUBKEY: TStringField
      DisplayLabel = 'Sub. Key'
      FieldName = 'NFM_SUBKEY'
      Size = 2
    end
    object qryShe_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryShe_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryShe_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 50
    end
    object qryShe_CadNfmNFM_EMBALA: TFloatField
      FieldName = 'NFM_EMBALA'
    end
  end
  object dtsShe_CadNfm: TDataSource
    DataSet = qryShe_CadNfm
    Left = 744
    Top = 40
  end
  object qryFut_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM FUT_CADBAS')
    Constraints = <>
    Left = 216
    Top = 520
    object qryFut_CadBasBAS_CODFML: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODFML'
      Required = True
      Size = 10
    end
    object qryFut_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 10
    end
    object qryFut_CadBasBAS_CODUNI: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_CODUNI'
      Required = True
      Size = 2
    end
    object qryFut_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryFut_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object qryFut_CadBasBAS_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Required = True
      Size = 50
    end
    object qryFut_CadBasBAS_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'BAS_PRECUS'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFut_CadBasBAS_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'BAS_PREVEN'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFut_CadBasBAS_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFut_CadBasAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryFut_CadBasBAS_PRODUT: TStringField
      FieldName = 'BAS_PRODUT'
      Size = 25
    end
  end
  object dtsFut_CadBas: TDataSource
    DataSet = qryFut_CadBas
    Left = 480
    Top = 40
  end
  object qryFut_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM FUT_CADCOL')
    Constraints = <>
    Left = 40
    Top = 520
    object qryFut_CadColCOL_CODCOL: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object qryFut_CadColCOL_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryFut_CadColCOL_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'COL_PRECUS'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFut_CadColCOL_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'COL_PREVEN'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFut_CadColCOL_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryFut_CadColAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryFut_CadColCOL_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'COL_CODITE'
      Size = 5
    end
  end
  object dtsFut_CadCol: TDataSource
    DataSet = qryFut_CadCol
    Left = 568
    Top = 40
  end
  object qryFut_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM FUT_CADNFM')
    Constraints = <>
    Left = 480
    Top = 520
    object qryFut_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 10
    end
    object qryFut_CadNfmNFM_CODPRO: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'NFM_CODPRO'
      Size = 30
    end
    object qryFut_CadNfmNFM_BASE__: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_BASE__'
      Size = 1
    end
    object qryFut_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 25
    end
    object qryFut_CadNfmNFM_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM01: TStringField
      DisplayLabel = 'Colorante 01'
      FieldName = 'NFM_FORM01'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM02: TStringField
      DisplayLabel = 'Colorante 02'
      FieldName = 'NFM_FORM02'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM03: TStringField
      DisplayLabel = 'Colorante 03'
      FieldName = 'NFM_FORM03'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM04: TStringField
      DisplayLabel = 'Colorante 04'
      FieldName = 'NFM_FORM04'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM05: TStringField
      DisplayLabel = 'Colorante 05'
      FieldName = 'NFM_FORM05'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM06: TStringField
      DisplayLabel = 'Colorante 06'
      FieldName = 'NFM_FORM06'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM07: TStringField
      DisplayLabel = 'Colorante 07'
      FieldName = 'NFM_FORM07'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM08: TStringField
      DisplayLabel = 'Colorante 08'
      FieldName = 'NFM_FORM08'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM09: TStringField
      DisplayLabel = 'Colorante 09'
      FieldName = 'NFM_FORM09'
      Size = 2
    end
    object qryFut_CadNfmNFM_FORM10: TStringField
      DisplayLabel = 'Colorante 10'
      FieldName = 'NFM_FORM10'
      Size = 2
    end
    object qryFut_CadNfmNFM_QTDC01: TFloatField
      DisplayLabel = 'Quantidade 01'
      FieldName = 'NFM_QTDC01'
    end
    object qryFut_CadNfmNFM_QTDC02: TFloatField
      DisplayLabel = 'Quantidade 02'
      FieldName = 'NFM_QTDC02'
    end
    object qryFut_CadNfmNFM_QTDC03: TFloatField
      DisplayLabel = 'Quantidade 03'
      FieldName = 'NFM_QTDC03'
    end
    object qryFut_CadNfmNFM_QTDC04: TFloatField
      DisplayLabel = 'Quantidade 04'
      FieldName = 'NFM_QTDC04'
    end
    object qryFut_CadNfmNFM_QTDC05: TFloatField
      DisplayLabel = 'Quantidade 05'
      FieldName = 'NFM_QTDC05'
    end
    object qryFut_CadNfmNFM_QTDC06: TFloatField
      DisplayLabel = 'Quantidade 06'
      FieldName = 'NFM_QTDC06'
    end
    object qryFut_CadNfmNFM_QTDC07: TFloatField
      DisplayLabel = 'Quantidade 07'
      FieldName = 'NFM_QTDC07'
    end
    object qryFut_CadNfmNFM_QTDC08: TFloatField
      DisplayLabel = 'Quantidade 08'
      FieldName = 'NFM_QTDC08'
    end
    object qryFut_CadNfmNFM_QTDC09: TFloatField
      DisplayLabel = 'Quantidade 09'
      FieldName = 'NFM_QTDC09'
    end
    object qryFut_CadNfmNFM_QTDC10: TFloatField
      DisplayLabel = 'Quantidade 10'
      FieldName = 'NFM_QTDC10'
    end
    object qryFut_CadNfmNFM_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Visible = False
      Size = 3
    end
    object qryFut_CadNfmAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
    object qryFut_CadNfmNFM_PRODUT: TStringField
      FieldName = 'NFM_PRODUT'
      Size = 25
    end
    object qryFut_CadNfmNFM_SPRODU: TStringField
      FieldName = 'NFM_SPRODU'
      Size = 25
    end
    object qryFut_CadNfmNFM_DESBAS: TStringField
      FieldName = 'NFM_DESBAS'
      Size = 75
    end
  end
  object dtsFut_CadNfm: TDataSource
    DataSet = qryFut_CadNfm
    Left = 744
    Top = 88
  end
  object qryWanPro_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM WANPRO_CADBAS')
    Constraints = <>
    Left = 304
    Top = 520
    object qryWanPro_CadBasBAS_LINHA_: TStringField
      DisplayLabel = 'Linha'
      FieldName = 'BAS_LINHA_'
      Required = True
      Size = 3
    end
    object qryWanPro_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 15
    end
    object qryWanPro_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 70
    end
    object qryWanPro_CadBasBAS_PESESP: TFloatField
      DisplayLabel = 'Peso Espec'#237'fico'
      FieldName = 'BAS_PESESP'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryWanPro_CadBasBAS_EMBALA: TFloatField
      DisplayLabel = 'Embalagem'
      FieldName = 'BAS_EMBALA'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryWanPro_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryWanPro_CadBasBAS_CODEMP: TStringField
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qryWanPro_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryWanPro_CadBasBAS_PREVEN: TFloatField
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object dtsWanPro_CadBas: TDataSource
    DataSet = qryWanPro_CadBas
    Left = 40
    Top = 184
  end
  object qryKil_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM KIL_CADBAS')
    Constraints = <>
    Left = 392
    Top = 520
    object qryKil_CadBasBAS_CODFML: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODFML'
      Required = True
      Size = 15
    end
    object qryKil_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 15
    end
    object qryKil_CadBasBAS_CODUNI: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_CODUNI'
      Required = True
      Size = 2
    end
    object qryKil_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryKil_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qryKil_CadBasBAS_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Required = True
      Size = 25
    end
    object qryKil_CadBasBAS_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'BAS_PRECUS'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryKil_CadBasBAS_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'BAS_PREVEN'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryKil_CadBasBAS_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryKil_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsKil_CadBas: TDataSource
    DataSet = qryKil_CadBas
    Left = 128
    Top = 184
  end
  object qryKil_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM KIL_CADCOL')
    Constraints = <>
    Left = 832
    Top = 280
    object qryKil_CadColCOL_CODCOL: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object qryKil_CadColCOL_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryKil_CadColCOL_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'COL_PRECUS'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryKil_CadColCOL_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'COL_PREVEN'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryKil_CadColCOL_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      Required = True
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryKil_CadColAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryKil_CadColCOL_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'COL_CODITE'
      Size = 5
    end
  end
  object dtsKil_CadCol: TDataSource
    DataSet = qryKil_CadCol
    Left = 744
    Top = 136
  end
  object qryKil_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM KIL_CADNFM')
    Constraints = <>
    Left = 656
    Top = 280
    object qryKil_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 10
    end
    object qryKil_CadNfmNFM_CODPRO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'NFM_CODPRO'
      Size = 15
    end
    object qryKil_CadNfmNFM_BASE__: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_BASE__'
      Size = 15
    end
    object qryKil_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 25
    end
    object qryKil_CadNfmNFM_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM01: TStringField
      DisplayLabel = 'Colorante 01'
      FieldName = 'NFM_FORM01'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM02: TStringField
      DisplayLabel = 'Colorante 02'
      FieldName = 'NFM_FORM02'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM03: TStringField
      DisplayLabel = 'Colorante 03'
      FieldName = 'NFM_FORM03'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM04: TStringField
      DisplayLabel = 'Colorante 04'
      FieldName = 'NFM_FORM04'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM05: TStringField
      DisplayLabel = 'Colorante 05'
      FieldName = 'NFM_FORM05'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM06: TStringField
      DisplayLabel = 'Colorante 06'
      FieldName = 'NFM_FORM06'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM07: TStringField
      DisplayLabel = 'Colorante 07'
      FieldName = 'NFM_FORM07'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM08: TStringField
      DisplayLabel = 'Colorante 08'
      FieldName = 'NFM_FORM08'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM09: TStringField
      DisplayLabel = 'Colorante 09'
      FieldName = 'NFM_FORM09'
      Size = 2
    end
    object qryKil_CadNfmNFM_FORM10: TStringField
      DisplayLabel = 'Colorante 10'
      FieldName = 'NFM_FORM10'
      Size = 2
    end
    object qryKil_CadNfmNFM_QTDC01: TFloatField
      DisplayLabel = 'Quantidade 01'
      FieldName = 'NFM_QTDC01'
    end
    object qryKil_CadNfmNFM_QTDC02: TFloatField
      DisplayLabel = 'Quantidade 02'
      FieldName = 'NFM_QTDC02'
    end
    object qryKil_CadNfmNFM_QTDC03: TFloatField
      DisplayLabel = 'Quantidade 03'
      FieldName = 'NFM_QTDC03'
    end
    object qryKil_CadNfmNFM_QTDC04: TFloatField
      DisplayLabel = 'Quantidade 04'
      FieldName = 'NFM_QTDC04'
    end
    object qryKil_CadNfmNFM_QTDC05: TFloatField
      DisplayLabel = 'Quantidade 05'
      FieldName = 'NFM_QTDC05'
    end
    object qryKil_CadNfmNFM_QTDC06: TFloatField
      DisplayLabel = 'Quantidade 06'
      FieldName = 'NFM_QTDC06'
    end
    object qryKil_CadNfmNFM_QTDC07: TFloatField
      DisplayLabel = 'Quantidade 07'
      FieldName = 'NFM_QTDC07'
    end
    object qryKil_CadNfmNFM_QTDC08: TFloatField
      DisplayLabel = 'Quantidade 08'
      FieldName = 'NFM_QTDC08'
    end
    object qryKil_CadNfmNFM_QTDC09: TFloatField
      DisplayLabel = 'Quantidade 09'
      FieldName = 'NFM_QTDC09'
    end
    object qryKil_CadNfmNFM_QTDC10: TFloatField
      DisplayLabel = 'Quantidade 10'
      FieldName = 'NFM_QTDC10'
    end
    object qryKil_CadNfmNFM_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Visible = False
      Size = 3
    end
    object qryKil_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
  end
  object dtsKil_CadNfm: TDataSource
    DataSet = qryKil_CadNfm
    Left = 832
    Top = 136
  end
  object qrySal_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM SAL_CADNFM')
    Constraints = <>
    Left = 656
    Top = 376
    object qrySal_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 10
    end
    object qrySal_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qrySal_CadNfmNFM_DTACAD: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'NFM_DTACAD'
      EditMask = '99/99/9999'
    end
    object qrySal_CadNfmNFM_CODB01: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB01'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB01: TFloatField
      FieldName = 'NFM_QTDB01'
    end
    object qrySal_CadNfmNFM_CODB02: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB02'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB02: TFloatField
      FieldName = 'NFM_QTDB02'
    end
    object qrySal_CadNfmNFM_CODB03: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB03'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB03: TFloatField
      FieldName = 'NFM_QTDB03'
    end
    object qrySal_CadNfmNFM_CODB04: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB04'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB04: TFloatField
      FieldName = 'NFM_QTDB04'
    end
    object qrySal_CadNfmNFM_CODB05: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB05'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB05: TFloatField
      FieldName = 'NFM_QTDB05'
    end
    object qrySal_CadNfmNFM_CODB06: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB06'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB06: TFloatField
      FieldName = 'NFM_QTDB06'
    end
    object qrySal_CadNfmNFM_CODB07: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB07'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB07: TFloatField
      FieldName = 'NFM_QTDB07'
    end
    object qrySal_CadNfmNFM_CODB08: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB08'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB08: TFloatField
      FieldName = 'NFM_QTDB08'
    end
    object qrySal_CadNfmNFM_CODB09: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB09'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB09: TFloatField
      FieldName = 'NFM_QTDB09'
    end
    object qrySal_CadNfmNFM_CODB10: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB10'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB10: TFloatField
      FieldName = 'NFM_QTDB10'
    end
    object qrySal_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Visible = False
      Size = 3
    end
    object qrySal_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qrySal_CadNfmNFM_CODB11: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB11'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB11: TFloatField
      FieldName = 'NFM_QTDB11'
    end
    object qrySal_CadNfmNFM_CODB12: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB12'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB12: TFloatField
      FieldName = 'NFM_QTDB12'
    end
    object qrySal_CadNfmNFM_CODB13: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB13'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB13: TFloatField
      FieldName = 'NFM_QTDB13'
    end
    object qrySal_CadNfmNFM_CODB14: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB14'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB14: TFloatField
      FieldName = 'NFM_QTDB14'
    end
    object qrySal_CadNfmNFM_CODB15: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB15'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB15: TFloatField
      FieldName = 'NFM_QTDB15'
    end
    object qrySal_CadNfmNFM_CODB16: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB16'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB16: TFloatField
      FieldName = 'NFM_QTDB16'
    end
    object qrySal_CadNfmNFM_CODB17: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB17'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB17: TFloatField
      FieldName = 'NFM_QTDB17'
    end
    object qrySal_CadNfmNFM_CODB18: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB18'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB18: TFloatField
      FieldName = 'NFM_QTDB18'
    end
    object qrySal_CadNfmNFM_CODB19: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB19'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB19: TFloatField
      FieldName = 'NFM_QTDB19'
    end
    object qrySal_CadNfmNFM_CODB20: TStringField
      DisplayWidth = 30
      FieldName = 'NFM_CODB20'
      Size = 30
    end
    object qrySal_CadNfmNFM_QTDB20: TFloatField
      FieldName = 'NFM_QTDB20'
    end
    object qrySal_CadNfmNFM_LINHA_: TStringField
      FieldName = 'NFM_LINHA_'
    end
    object qrySal_CadNfmNFM_QTDD01: TFloatField
      FieldName = 'NFM_QTDD01'
    end
    object qrySal_CadNfmNFM_QTDD02: TFloatField
      FieldName = 'NFM_QTDD02'
    end
    object qrySal_CadNfmNFM_QTDD03: TFloatField
      FieldName = 'NFM_QTDD03'
    end
    object qrySal_CadNfmNFM_QTDD04: TFloatField
      FieldName = 'NFM_QTDD04'
    end
    object qrySal_CadNfmNFM_QTDD05: TFloatField
      FieldName = 'NFM_QTDD05'
    end
    object qrySal_CadNfmNFM_QTDD06: TFloatField
      FieldName = 'NFM_QTDD06'
    end
    object qrySal_CadNfmNFM_QTDD07: TFloatField
      FieldName = 'NFM_QTDD07'
    end
    object qrySal_CadNfmNFM_QTDD08: TFloatField
      FieldName = 'NFM_QTDD08'
    end
    object qrySal_CadNfmNFM_QTDD09: TFloatField
      FieldName = 'NFM_QTDD09'
    end
    object qrySal_CadNfmNFM_QTDD10: TFloatField
      FieldName = 'NFM_QTDD10'
    end
    object qrySal_CadNfmNFM_QTDD11: TFloatField
      FieldName = 'NFM_QTDD11'
    end
    object qrySal_CadNfmNFM_QTDD12: TFloatField
      FieldName = 'NFM_QTDD12'
    end
    object qrySal_CadNfmNFM_QTDD13: TFloatField
      FieldName = 'NFM_QTDD13'
    end
    object qrySal_CadNfmNFM_QTDD14: TFloatField
      FieldName = 'NFM_QTDD14'
    end
    object qrySal_CadNfmNFM_QTDD15: TFloatField
      FieldName = 'NFM_QTDD15'
    end
    object qrySal_CadNfmNFM_QTDD16: TFloatField
      FieldName = 'NFM_QTDD16'
    end
    object qrySal_CadNfmNFM_QTDD17: TFloatField
      FieldName = 'NFM_QTDD17'
    end
    object qrySal_CadNfmNFM_QTDD18: TFloatField
      FieldName = 'NFM_QTDD18'
    end
    object qrySal_CadNfmNFM_QTDD19: TFloatField
      FieldName = 'NFM_QTDD19'
    end
    object qrySal_CadNfmNFM_QTDD20: TFloatField
      FieldName = 'NFM_QTDD20'
    end
  end
  object dtsSal_CadNfm: TDataSource
    DataSet = qrySal_CadNfm
    Left = 216
    Top = 184
  end
  object dtsSal_CadBas: TDataSource
    DataSet = qrySal_CadBas
    Left = 480
    Top = 184
  end
  object qrySal_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM SAL_CADBAS')
    Constraints = <>
    Left = 648
    Top = 328
    object qrySal_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 30
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 30
    end
    object qrySal_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 40
    end
    object qrySal_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qrySal_CadBasBAS_PESBAS: TFloatField
      DisplayLabel = 'Peso'
      FieldName = 'BAS_PESBAS'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qrySal_CadBasBAS_VALBAS: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'BAS_VALBAS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qrySal_CadBasBAS_CODEMP: TStringField
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qrySal_CadBasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qrySal_CadBasBAS_EMBALA: TFloatField
      FieldName = 'BAS_EMBALA'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qrySal_CadBasBAS_LINHA_: TStringField
      FieldName = 'BAS_LINHA_'
    end
    object qrySal_CadBasBAS_QTDEMB: TStringField
      FieldName = 'BAS_QTDEMB'
      Size = 12
    end
  end
  object qryBza_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM BZA_CADNFM')
    Constraints = <>
    Left = 128
    Top = 328
    object qryBza_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 15
    end
    object qryBza_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qryBza_CadNfmNFM_DTACAD: TDateField
      FieldName = 'NFM_DTACAD'
    end
    object qryBza_CadNfmNFM_CODB01: TStringField
      FieldName = 'NFM_CODB01'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB01: TFloatField
      FieldName = 'NFM_QTDB01'
    end
    object qryBza_CadNfmNFM_CODB02: TStringField
      FieldName = 'NFM_CODB02'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB02: TFloatField
      FieldName = 'NFM_QTDB02'
    end
    object qryBza_CadNfmNFM_CODB03: TStringField
      FieldName = 'NFM_CODB03'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB03: TFloatField
      FieldName = 'NFM_QTDB03'
    end
    object qryBza_CadNfmNFM_CODB04: TStringField
      FieldName = 'NFM_CODB04'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB04: TFloatField
      FieldName = 'NFM_QTDB04'
    end
    object qryBza_CadNfmNFM_CODB05: TStringField
      FieldName = 'NFM_CODB05'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB05: TFloatField
      FieldName = 'NFM_QTDB05'
    end
    object qryBza_CadNfmNFM_CODB06: TStringField
      FieldName = 'NFM_CODB06'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB06: TFloatField
      FieldName = 'NFM_QTDB06'
    end
    object qryBza_CadNfmNFM_CODB07: TStringField
      FieldName = 'NFM_CODB07'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB07: TFloatField
      FieldName = 'NFM_QTDB07'
    end
    object qryBza_CadNfmNFM_CODB08: TStringField
      FieldName = 'NFM_CODB08'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB08: TFloatField
      FieldName = 'NFM_QTDB08'
    end
    object qryBza_CadNfmNFM_CODB09: TStringField
      FieldName = 'NFM_CODB09'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB09: TFloatField
      FieldName = 'NFM_QTDB09'
    end
    object qryBza_CadNfmNFM_CODB10: TStringField
      FieldName = 'NFM_CODB10'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB10: TFloatField
      FieldName = 'NFM_QTDB10'
    end
    object qryBza_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Size = 3
    end
    object qryBza_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryBza_CadNfmNFM_MONTAD: TStringField
      DisplayLabel = 'Montadora'
      FieldName = 'NFM_MONTAD'
      Size = 15
    end
    object qryBza_CadNfmNFM_A_N_O_: TStringField
      DisplayLabel = 'Ano'
      FieldName = 'NFM_A_N_O_'
      Size = 4
    end
    object qryBza_CadNfmNFM_CODUNI: TStringField
      DisplayLabel = 'C'#243'd. Universal'
      FieldName = 'NFM_CODUNI'
      Size = 15
    end
    object qryBza_CadNfmNFM_TIPO__: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'NFM_TIPO__'
      Size = 2
    end
    object qryBza_CadNfmNFM_CODB11: TStringField
      FieldName = 'NFM_CODB11'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB11: TFloatField
      FieldName = 'NFM_QTDB11'
    end
    object qryBza_CadNfmNFM_CODB12: TStringField
      FieldName = 'NFM_CODB12'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB12: TFloatField
      FieldName = 'NFM_QTDB12'
    end
    object qryBza_CadNfmNFM_CODB13: TStringField
      FieldName = 'NFM_CODB13'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB13: TFloatField
      FieldName = 'NFM_QTDB13'
    end
    object qryBza_CadNfmNFM_CODB14: TStringField
      FieldName = 'NFM_CODB14'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB14: TFloatField
      FieldName = 'NFM_QTDB14'
    end
    object qryBza_CadNfmNFM_CODB15: TStringField
      FieldName = 'NFM_CODB15'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB15: TFloatField
      FieldName = 'NFM_QTDB15'
    end
    object qryBza_CadNfmNFM_CODB16: TStringField
      FieldName = 'NFM_CODB16'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB16: TFloatField
      FieldName = 'NFM_QTDB16'
    end
    object qryBza_CadNfmNFM_CODB17: TStringField
      FieldName = 'NFM_CODB17'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB17: TFloatField
      FieldName = 'NFM_QTDB17'
    end
    object qryBza_CadNfmNFM_CODB18: TStringField
      FieldName = 'NFM_CODB18'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB18: TFloatField
      FieldName = 'NFM_QTDB18'
    end
    object qryBza_CadNfmNFM_CODB19: TStringField
      FieldName = 'NFM_CODB19'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB19: TFloatField
      FieldName = 'NFM_QTDB19'
    end
    object qryBza_CadNfmNFM_CODB20: TStringField
      FieldName = 'NFM_CODB20'
      Size = 8
    end
    object qryBza_CadNfmNFM_QTDB20: TFloatField
      FieldName = 'NFM_QTDB20'
    end
    object qryBza_CadNfmNFM_ACRMOB: TFloatField
      FieldName = 'NFM_ACRMOB'
      DisplayFormat = '#,#0.00'
      EditFormat = '#,#0.00'
    end
  end
  object dtsBza_CadNfm: TDataSource
    DataSet = qryBza_CadNfm
    Left = 568
    Top = 184
  end
  object qryDup_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM DUP_CADBAS')
    Constraints = <>
    Left = 480
    Top = 280
    object qryDup_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 7
    end
    object qryDup_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object qryDup_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object qryDup_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 40
    end
    object qryDup_CadBasBAS_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDup_CadBasBAS_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDup_CadBasBAS_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDup_CadBasAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryDup_CadBasBAS_EMBALA: TFloatField
      FieldName = 'BAS_EMBALA'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryDup_CadBasBAS_PESESP: TFloatField
      FieldName = 'BAS_PESESP'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryDup_CadBasBAS_PESGRA: TStringField
      FieldName = 'BAS_PESGRA'
      Size = 1
    end
  end
  object dtsDup_CadBas: TDataSource
    DataSet = qryDup_CadBas
    Left = 304
    Top = 184
  end
  object qryDup_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM DUP_CADNFM')
    Constraints = <>
    Left = 392
    Top = 328
    object qryDup_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 15
    end
    object qryDup_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qryDup_CadNfmNFM_DTACAD: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'NFM_DTACAD'
    end
    object qryDup_CadNfmNFM_CODB01: TStringField
      FieldName = 'NFM_CODB01'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC01: TFloatField
      FieldName = 'NFM_QTDC01'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD01: TFloatField
      FieldName = 'NFM_QTDD01'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB02: TStringField
      FieldName = 'NFM_CODB02'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC02: TFloatField
      FieldName = 'NFM_QTDC02'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD02: TFloatField
      FieldName = 'NFM_QTDD02'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB03: TStringField
      FieldName = 'NFM_CODB03'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC03: TFloatField
      FieldName = 'NFM_QTDC03'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD03: TFloatField
      FieldName = 'NFM_QTDD03'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB04: TStringField
      FieldName = 'NFM_CODB04'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC04: TFloatField
      FieldName = 'NFM_QTDC04'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD04: TFloatField
      FieldName = 'NFM_QTDD04'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB05: TStringField
      FieldName = 'NFM_CODB05'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC05: TFloatField
      FieldName = 'NFM_QTDC05'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD05: TFloatField
      FieldName = 'NFM_QTDD05'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB06: TStringField
      FieldName = 'NFM_CODB06'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC06: TFloatField
      FieldName = 'NFM_QTDC06'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD06: TFloatField
      FieldName = 'NFM_QTDD06'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB07: TStringField
      FieldName = 'NFM_CODB07'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC07: TFloatField
      FieldName = 'NFM_QTDC07'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD07: TFloatField
      FieldName = 'NFM_QTDD07'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB08: TStringField
      FieldName = 'NFM_CODB08'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC08: TFloatField
      FieldName = 'NFM_QTDC08'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD08: TFloatField
      FieldName = 'NFM_QTDD08'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB09: TStringField
      FieldName = 'NFM_CODB09'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC09: TFloatField
      FieldName = 'NFM_QTDC09'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD09: TFloatField
      FieldName = 'NFM_QTDD09'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB10: TStringField
      FieldName = 'NFM_CODB10'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC10: TFloatField
      FieldName = 'NFM_QTDC10'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD10: TFloatField
      FieldName = 'NFM_QTDD10'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODDIL: TStringField
      FieldName = 'NFM_CODDIL'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDDIL: TFloatField
      FieldName = 'NFM_QTDDIL'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODCAT: TStringField
      FieldName = 'NFM_CODCAT'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDCAT: TFloatField
      FieldName = 'NFM_QTDCAT'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Size = 3
    end
    object qryDup_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryDup_CadNfmNFM_LINHA_: TStringField
      FieldName = 'NFM_LINHA_'
      Size = 7
    end
    object qryDup_CadNfmNFM_QUALID: TStringField
      FieldName = 'NFM_QUALID'
      Size = 2
    end
    object qryDup_CadNfmNFM_ALTERN: TStringField
      FieldName = 'NFM_ALTERN'
      Size = 3
    end
    object qryDup_CadNfmNFM_CODB11: TStringField
      FieldName = 'NFM_CODB11'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC11: TFloatField
      FieldName = 'NFM_QTDC11'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD11: TFloatField
      FieldName = 'NFM_QTDD11'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB12: TStringField
      FieldName = 'NFM_CODB12'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC12: TFloatField
      FieldName = 'NFM_QTDC12'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD12: TFloatField
      FieldName = 'NFM_QTDD12'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB13: TStringField
      FieldName = 'NFM_CODB13'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC13: TFloatField
      FieldName = 'NFM_QTDC13'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD13: TFloatField
      FieldName = 'NFM_QTDD13'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB14: TStringField
      FieldName = 'NFM_CODB14'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC14: TFloatField
      FieldName = 'NFM_QTDC14'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD14: TFloatField
      FieldName = 'NFM_QTDD14'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB15: TStringField
      FieldName = 'NFM_CODB15'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC15: TFloatField
      FieldName = 'NFM_QTDC15'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD15: TFloatField
      FieldName = 'NFM_QTDD15'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_MONTAD: TStringField
      FieldName = 'NFM_MONTAD'
    end
    object qryDup_CadNfmNFM_CODB16: TStringField
      FieldName = 'NFM_CODB16'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC16: TFloatField
      FieldName = 'NFM_QTDC16'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD16: TFloatField
      FieldName = 'NFM_QTDD16'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB17: TStringField
      FieldName = 'NFM_CODB17'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC17: TFloatField
      FieldName = 'NFM_QTDC17'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD17: TFloatField
      FieldName = 'NFM_QTDD17'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB18: TStringField
      FieldName = 'NFM_CODB18'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC18: TFloatField
      FieldName = 'NFM_QTDC18'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD18: TFloatField
      FieldName = 'NFM_QTDD18'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB19: TStringField
      FieldName = 'NFM_CODB19'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC19: TFloatField
      FieldName = 'NFM_QTDC19'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD19: TFloatField
      FieldName = 'NFM_QTDD19'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_CODB20: TStringField
      FieldName = 'NFM_CODB20'
      Size = 8
    end
    object qryDup_CadNfmNFM_QTDC20: TFloatField
      FieldName = 'NFM_QTDC20'
      DisplayFormat = '#,###0.000'
      EditFormat = '#,###0.000'
    end
    object qryDup_CadNfmNFM_QTDD20: TFloatField
      FieldName = 'NFM_QTDD20'
    end
    object qryDup_CadNfmNFM_CATALI: TMemoField
      FieldName = 'NFM_CATALI'
      BlobType = ftMemo
    end
    object qryDup_CadNfmNFM_ATIVO_: TStringField
      FieldName = 'NFM_ATIVO_'
      Size = 1
    end
  end
  object dtsDup_CadNfm: TDataSource
    DataSet = qryDup_CadNfm
    Left = 392
    Top = 184
  end
  object qryGen001: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 480
    Top = 376
  end
  object qryGen002: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 568
    Top = 376
  end
  object qryWanPro_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM WANPRO_CADNFM')
    Constraints = <>
    Left = 216
    Top = 384
    object qryWanPro_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qryWanPro_CadNfmNFM_DTACAD: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'NFM_DTACAD'
    end
    object qryWanPro_CadNfmNFM_LINHA_: TStringField
      DisplayLabel = 'Linha'
      FieldName = 'NFM_LINHA_'
      Size = 4
    end
    object qryWanPro_CadNfmNFM_ALTERN: TStringField
      DisplayLabel = 'Alternativa'
      FieldName = 'NFM_ALTERN'
      Size = 3
    end
    object qryWanPro_CadNfmNFM_MONTAD: TStringField
      DisplayLabel = 'Montadora'
      FieldName = 'NFM_MONTAD'
    end
    object qryWanPro_CadNfmNFM_CODB01: TStringField
      FieldName = 'NFM_CODB01'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC01: TFloatField
      FieldName = 'NFM_QTDC01'
    end
    object qryWanPro_CadNfmNFM_QTDD01: TFloatField
      FieldName = 'NFM_QTDD01'
    end
    object qryWanPro_CadNfmNFM_QD4101: TFloatField
      FieldName = 'NFM_QD4101'
    end
    object qryWanPro_CadNfmNFM_CODB02: TStringField
      FieldName = 'NFM_CODB02'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC02: TFloatField
      FieldName = 'NFM_QTDC02'
    end
    object qryWanPro_CadNfmNFM_QTDD02: TFloatField
      FieldName = 'NFM_QTDD02'
    end
    object qryWanPro_CadNfmNFM_QD4102: TFloatField
      FieldName = 'NFM_QD4102'
    end
    object qryWanPro_CadNfmNFM_CODB03: TStringField
      FieldName = 'NFM_CODB03'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC03: TFloatField
      FieldName = 'NFM_QTDC03'
    end
    object qryWanPro_CadNfmNFM_QTDD03: TFloatField
      FieldName = 'NFM_QTDD03'
    end
    object qryWanPro_CadNfmNFM_QD4103: TFloatField
      FieldName = 'NFM_QD4103'
    end
    object qryWanPro_CadNfmNFM_CODB04: TStringField
      FieldName = 'NFM_CODB04'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC04: TFloatField
      FieldName = 'NFM_QTDC04'
    end
    object qryWanPro_CadNfmNFM_QTDD04: TFloatField
      FieldName = 'NFM_QTDD04'
    end
    object qryWanPro_CadNfmNFM_QD4104: TFloatField
      FieldName = 'NFM_QD4104'
    end
    object qryWanPro_CadNfmNFM_CODB05: TStringField
      FieldName = 'NFM_CODB05'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC05: TFloatField
      FieldName = 'NFM_QTDC05'
    end
    object qryWanPro_CadNfmNFM_QTDD05: TFloatField
      FieldName = 'NFM_QTDD05'
    end
    object qryWanPro_CadNfmNFM_QD4105: TFloatField
      FieldName = 'NFM_QD4105'
    end
    object qryWanPro_CadNfmNFM_CODB06: TStringField
      FieldName = 'NFM_CODB06'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC06: TFloatField
      FieldName = 'NFM_QTDC06'
    end
    object qryWanPro_CadNfmNFM_QTDD06: TFloatField
      FieldName = 'NFM_QTDD06'
    end
    object qryWanPro_CadNfmNFM_QD4106: TFloatField
      FieldName = 'NFM_QD4106'
    end
    object qryWanPro_CadNfmNFM_CODB07: TStringField
      FieldName = 'NFM_CODB07'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC07: TFloatField
      FieldName = 'NFM_QTDC07'
    end
    object qryWanPro_CadNfmNFM_QTDD07: TFloatField
      FieldName = 'NFM_QTDD07'
    end
    object qryWanPro_CadNfmNFM_QD4107: TFloatField
      FieldName = 'NFM_QD4107'
    end
    object qryWanPro_CadNfmNFM_CODB08: TStringField
      FieldName = 'NFM_CODB08'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC08: TFloatField
      FieldName = 'NFM_QTDC08'
    end
    object qryWanPro_CadNfmNFM_QTDD08: TFloatField
      FieldName = 'NFM_QTDD08'
    end
    object qryWanPro_CadNfmNFM_QD4108: TFloatField
      FieldName = 'NFM_QD4108'
    end
    object qryWanPro_CadNfmNFM_CODB09: TStringField
      FieldName = 'NFM_CODB09'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC09: TFloatField
      FieldName = 'NFM_QTDC09'
    end
    object qryWanPro_CadNfmNFM_QTDD09: TFloatField
      FieldName = 'NFM_QTDD09'
    end
    object qryWanPro_CadNfmNFM_QD4109: TFloatField
      FieldName = 'NFM_QD4109'
    end
    object qryWanPro_CadNfmNFM_CODB10: TStringField
      FieldName = 'NFM_CODB10'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC10: TFloatField
      FieldName = 'NFM_QTDC10'
    end
    object qryWanPro_CadNfmNFM_QTDD10: TFloatField
      FieldName = 'NFM_QTDD10'
    end
    object qryWanPro_CadNfmNFM_QD4110: TFloatField
      FieldName = 'NFM_QD4110'
    end
    object qryWanPro_CadNfmNFM_CODDIL: TStringField
      FieldName = 'NFM_CODDIL'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDDIL: TFloatField
      FieldName = 'NFM_QTDDIL'
    end
    object qryWanPro_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Size = 3
    end
    object qryWanPro_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryWanPro_CadNfmNFM_NOMLIN: TStringField
      FieldName = 'NFM_NOMLIN'
      Size = 25
    end
    object qryWanPro_CadNfmNFM_QTDDI4: TFloatField
      FieldName = 'NFM_QTDDI4'
    end
    object qryWanPro_CadNfmNFM_CODB11: TStringField
      FieldName = 'NFM_CODB11'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC11: TFloatField
      FieldName = 'NFM_QTDC11'
    end
    object qryWanPro_CadNfmNFM_QTDD11: TFloatField
      FieldName = 'NFM_QTDD11'
    end
    object qryWanPro_CadNfmNFM_QD4111: TFloatField
      FieldName = 'NFM_QD4111'
    end
    object qryWanPro_CadNfmNFM_CODB12: TStringField
      FieldName = 'NFM_CODB12'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC12: TFloatField
      FieldName = 'NFM_QTDC12'
    end
    object qryWanPro_CadNfmNFM_QTDD12: TFloatField
      FieldName = 'NFM_QTDD12'
    end
    object qryWanPro_CadNfmNFM_QD4112: TFloatField
      FieldName = 'NFM_QD4112'
    end
    object qryWanPro_CadNfmNFM_CODB13: TStringField
      FieldName = 'NFM_CODB13'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC13: TFloatField
      FieldName = 'NFM_QTDC13'
    end
    object qryWanPro_CadNfmNFM_QTDD13: TFloatField
      FieldName = 'NFM_QTDD13'
    end
    object qryWanPro_CadNfmNFM_QD4113: TFloatField
      FieldName = 'NFM_QD4113'
    end
    object qryWanPro_CadNfmNFM_CODB14: TStringField
      FieldName = 'NFM_CODB14'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC14: TFloatField
      FieldName = 'NFM_QTDC14'
    end
    object qryWanPro_CadNfmNFM_QTDD14: TFloatField
      FieldName = 'NFM_QTDD14'
    end
    object qryWanPro_CadNfmNFM_QD4114: TFloatField
      FieldName = 'NFM_QD4114'
    end
    object qryWanPro_CadNfmNFM_CODB15: TStringField
      FieldName = 'NFM_CODB15'
      Size = 15
    end
    object qryWanPro_CadNfmNFM_QTDC15: TFloatField
      FieldName = 'NFM_QTDC15'
    end
    object qryWanPro_CadNfmNFM_QTDD15: TFloatField
      FieldName = 'NFM_QTDD15'
    end
    object qryWanPro_CadNfmNFM_QD4115: TFloatField
      FieldName = 'NFM_QD4115'
    end
    object qryWanPro_CadNfmWAN_CAMADA: TIntegerField
      FieldName = 'WAN_CAMADA'
    end
  end
  object dtsWanPro_CadNfm: TDataSource
    DataSet = qryWanPro_CadNfm
    Left = 128
    Top = 136
  end
  object qrySta_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM STA_CADBAS')
    Constraints = <>
    Left = 832
    Top = 376
    object qrySta_CadBasBAS_CODBAS: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 8
    end
    object qrySta_CadBasBAS_DESBAS: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 45
    end
    object qrySta_CadBasBAS_VOLUME: TFloatField
      DisplayLabel = 'Volume'
      FieldName = 'BAS_VOLUME'
    end
    object qrySta_CadBasBAS_CODITE: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object qrySta_CadBasBAS_PESESP: TFloatField
      DisplayLabel = 'Peso Esp.'
      FieldName = 'BAS_PESESP'
    end
    object qrySta_CadBasBAS_PRECUS: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qrySta_CadBasBAS_MARGEM: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qrySta_CadBasBAS_PREVEN: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qrySta_CadBasBAS_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object qrySta_CadBasAUTOINCREM: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qrySta_CadBasBAS_CODSEQ: TStringField
      FieldName = 'BAS_CODSEQ'
      Size = 3
    end
  end
  object dtsSta_CadBas: TDataSource
    DataSet = qrySta_CadBas
    Left = 216
    Top = 136
  end
  object qrySta_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM STA_CADNFM')
    Constraints = <>
    Left = 40
    Top = 424
    object qrySta_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 10
    end
    object qrySta_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qrySta_CadNfmNFM_DTACAD: TDateField
      DisplayLabel = 'Data Cadastro'
      FieldName = 'NFM_DTACAD'
    end
    object qrySta_CadNfmNFM_CODB01: TStringField
      FieldName = 'NFM_CODB01'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB01: TFloatField
      FieldName = 'NFM_QTDB01'
    end
    object qrySta_CadNfmNFM_CODB02: TStringField
      FieldName = 'NFM_CODB02'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB02: TFloatField
      FieldName = 'NFM_QTDB02'
    end
    object qrySta_CadNfmNFM_CODB03: TStringField
      FieldName = 'NFM_CODB03'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB03: TFloatField
      FieldName = 'NFM_QTDB03'
    end
    object qrySta_CadNfmNFM_CODB04: TStringField
      FieldName = 'NFM_CODB04'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB04: TFloatField
      FieldName = 'NFM_QTDB04'
    end
    object qrySta_CadNfmNFM_CODB05: TStringField
      FieldName = 'NFM_CODB05'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB05: TFloatField
      FieldName = 'NFM_QTDB05'
    end
    object qrySta_CadNfmNFM_CODB06: TStringField
      FieldName = 'NFM_CODB06'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB06: TFloatField
      FieldName = 'NFM_QTDB06'
    end
    object qrySta_CadNfmNFM_CODB07: TStringField
      FieldName = 'NFM_CODB07'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB07: TFloatField
      FieldName = 'NFM_QTDB07'
    end
    object qrySta_CadNfmNFM_CODB08: TStringField
      FieldName = 'NFM_CODB08'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB08: TFloatField
      FieldName = 'NFM_QTDB08'
    end
    object qrySta_CadNfmNFM_CODB09: TStringField
      FieldName = 'NFM_CODB09'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB09: TFloatField
      FieldName = 'NFM_QTDB09'
    end
    object qrySta_CadNfmNFM_CODB10: TStringField
      FieldName = 'NFM_CODB10'
      Size = 8
    end
    object qrySta_CadNfmNFM_QTDB10: TFloatField
      FieldName = 'NFM_QTDB10'
    end
    object qrySta_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Visible = False
      Size = 3
    end
    object qrySta_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qrySta_CadNfmNFM_CODLIN: TStringField
      FieldName = 'NFM_CODLIN'
      Size = 3
    end
    object qrySta_CadNfmNFM_MONTAD: TStringField
      FieldName = 'NFM_MONTAD'
      Size = 35
    end
    object qrySta_CadNfmNFM_A_N_O_: TStringField
      FieldName = 'NFM_A_N_O_'
      Size = 4
    end
  end
  object dtsSta_CadNfm: TDataSource
    DataSet = qrySta_CadNfm
    Left = 832
    Top = 88
  end
  object qryLaz_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LAZ_CADNFM LIMIT 0')
    Constraints = <>
    Left = 744
    Top = 376
    object qryLaz_CadNfmNFM_CODNFM: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 15
    end
    object qryLaz_CadNfmNFM_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 40
    end
    object qryLaz_CadNfmNFM_DTACAD: TDateField
      DisplayLabel = 'Data de Cadastro'
      FieldName = 'NFM_DTACAD'
    end
    object qryLaz_CadNfmNFM_CODB01: TStringField
      FieldName = 'NFM_CODB01'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB01: TFloatField
      FieldName = 'NFM_QTDB01'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB02: TStringField
      FieldName = 'NFM_CODB02'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB02: TFloatField
      FieldName = 'NFM_QTDB02'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB03: TStringField
      FieldName = 'NFM_CODB03'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB03: TFloatField
      FieldName = 'NFM_QTDB03'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB04: TStringField
      FieldName = 'NFM_CODB04'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB04: TFloatField
      FieldName = 'NFM_QTDB04'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB05: TStringField
      FieldName = 'NFM_CODB05'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB05: TFloatField
      FieldName = 'NFM_QTDB05'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB06: TStringField
      FieldName = 'NFM_CODB06'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB06: TFloatField
      FieldName = 'NFM_QTDB06'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB07: TStringField
      FieldName = 'NFM_CODB07'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB07: TFloatField
      FieldName = 'NFM_QTDB07'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB08: TStringField
      FieldName = 'NFM_CODB08'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB08: TFloatField
      FieldName = 'NFM_QTDB08'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB09: TStringField
      FieldName = 'NFM_CODB09'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB09: TFloatField
      FieldName = 'NFM_QTDB09'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB10: TStringField
      FieldName = 'NFM_CODB10'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB10: TFloatField
      FieldName = 'NFM_QTDB10'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODEMP: TStringField
      FieldName = 'NFM_CODEMP'
      Size = 3
    end
    object qryLaz_CadNfmAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryLaz_CadNfmNFM_QTDD01: TFloatField
      FieldName = 'NFM_QTDD01'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD02: TFloatField
      FieldName = 'NFM_QTDD02'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD03: TFloatField
      FieldName = 'NFM_QTDD03'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD04: TFloatField
      FieldName = 'NFM_QTDD04'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD05: TFloatField
      FieldName = 'NFM_QTDD05'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD06: TFloatField
      FieldName = 'NFM_QTDD06'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD07: TFloatField
      FieldName = 'NFM_QTDD07'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD08: TFloatField
      FieldName = 'NFM_QTDD08'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD09: TFloatField
      FieldName = 'NFM_QTDD09'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD10: TFloatField
      FieldName = 'NFM_QTDD10'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_VOLCON: TFloatField
      FieldName = 'NFM_VOLCON'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryLaz_CadNfmNFM_VOLDIL: TFloatField
      FieldName = 'NFM_VOLDIL'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object qryLaz_CadNfmNFM_REFERE: TStringField
      FieldName = 'NFM_REFERE'
      Size = 15
    end
    object qryLaz_CadNfmNFM_MONTAD: TStringField
      FieldName = 'NFM_MONTAD'
      Size = 15
    end
    object qryLaz_CadNfmNFM_A_N_O_: TStringField
      FieldName = 'NFM_A_N_O_'
      Size = 4
    end
    object qryLaz_CadNfmNFM_QTDB11: TFloatField
      FieldName = 'NFM_QTDB11'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB11: TStringField
      FieldName = 'NFM_CODB11'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDD11: TFloatField
      FieldName = 'NFM_QTDD11'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB12: TStringField
      FieldName = 'NFM_CODB12'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB12: TFloatField
      FieldName = 'NFM_QTDB12'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD12: TFloatField
      FieldName = 'NFM_QTDD12'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB13: TStringField
      FieldName = 'NFM_CODB13'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB13: TFloatField
      FieldName = 'NFM_QTDB13'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD13: TFloatField
      FieldName = 'NFM_QTDD13'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB14: TStringField
      FieldName = 'NFM_CODB14'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB14: TFloatField
      FieldName = 'NFM_QTDB14'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD14: TFloatField
      FieldName = 'NFM_QTDD14'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB15: TStringField
      FieldName = 'NFM_CODB15'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDB15: TFloatField
      FieldName = 'NFM_QTDB15'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDD15: TFloatField
      FieldName = 'NFM_QTDD15'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB16: TStringField
      FieldName = 'NFM_CODB16'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDD16: TFloatField
      FieldName = 'NFM_QTDD16'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDB16: TFloatField
      FieldName = 'NFM_QTDB16'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB17: TStringField
      FieldName = 'NFM_CODB17'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDD17: TFloatField
      FieldName = 'NFM_QTDD17'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDB17: TFloatField
      FieldName = 'NFM_QTDB17'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB18: TStringField
      FieldName = 'NFM_CODB18'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDD18: TFloatField
      FieldName = 'NFM_QTDD18'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDB18: TFloatField
      FieldName = 'NFM_QTDB18'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB19: TStringField
      FieldName = 'NFM_CODB19'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDD19: TFloatField
      FieldName = 'NFM_QTDD19'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDB19: TFloatField
      FieldName = 'NFM_QTDB19'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_CODB20: TStringField
      FieldName = 'NFM_CODB20'
      Size = 8
    end
    object qryLaz_CadNfmNFM_QTDD20: TFloatField
      FieldName = 'NFM_QTDD20'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_QTDB20: TFloatField
      FieldName = 'NFM_QTDB20'
      DisplayFormat = '#,#0.0'
      EditFormat = '#,#0.0'
    end
    object qryLaz_CadNfmNFM_ACRMOB: TFloatField
      FieldName = 'NFM_ACRMOB'
      DisplayFormat = '#,#0.00'
      EditFormat = '#,#0.00'
    end
  end
  object dtsLaz_CadNfm: TDataSource
    DataSet = qryLaz_CadNfm
    Left = 40
    Top = 136
  end
  object qryLkd_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKD_CADBAS')
    Constraints = <>
    Left = 480
    Top = 328
    object StringField31: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 2
    end
    object StringField32: TStringField
      DisplayLabel = 'Prod. Key'
      FieldName = 'BAS_PROKEY'
      Required = True
      Size = 2
    end
    object StringField33: TStringField
      DisplayLabel = 'Sub. Key'
      FieldName = 'BAS_SUBKEY'
      Required = True
      Size = 2
    end
    object StringField34: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Required = True
      Size = 2
    end
    object StringField35: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 60
    end
    object FloatField15: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField16: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField36: TStringField
      DisplayLabel = 'C'#243'd. Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object FloatField17: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField38: TStringField
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object StringField39: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsLkd_CadBas: TDataSource
    DataSet = qryLkd_CadBas
    Left = 568
    Top = 136
  end
  object qryLkd_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKD_CADCOL')
    Constraints = <>
    Left = 568
    Top = 328
    object StringField40: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object StringField41: TStringField
      DisplayLabel = 'C'#243'digo Item'
      FieldName = 'COL_CODITE'
      Required = True
      Size = 5
    end
    object FloatField18: TFloatField
      DisplayLabel = 'Pre'#231'o de Custo'
      FieldName = 'COL_PRELIT'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField19: TFloatField
      DisplayLabel = 'Pre'#231'o de Venda'
      FieldName = 'COL_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField42: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object StringField43: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField20: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryLkd_CadColCOL_DESCRI: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'COL_DESCRI'
    end
  end
  object dtsLkd_CadCol: TDataSource
    DataSet = qryLkd_CadCol
    Left = 656
    Top = 136
  end
  object qryLkd_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKD_CADEMB')
    Constraints = <>
    Left = 120
    Top = 376
    object StringField44: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 2
    end
    object FloatField21: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField45: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField46: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object StringField47: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object dtsLkd_CadEmb: TDataSource
    DataSet = qryLkd_CadEmb
    Left = 392
    Top = 136
  end
  object qryLkd_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LKD_CADNFM')
    Constraints = <>
    Left = 832
    Top = 328
    object StringField48: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODPRO'
      Required = True
      Size = 15
    end
    object StringField49: TStringField
      DisplayLabel = 'Base'
      FieldName = 'NFM_BASE__'
      Size = 2
    end
    object StringField50: TStringField
      FieldName = 'NFM_COL001'
      Size = 2
    end
    object StringField51: TStringField
      FieldName = 'NFM_COL002'
      Size = 2
    end
    object StringField52: TStringField
      FieldName = 'NFM_COL003'
      Size = 2
    end
    object StringField53: TStringField
      FieldName = 'NFM_COL004'
      Size = 2
    end
    object StringField54: TStringField
      FieldName = 'NFM_COL005'
      Size = 2
    end
    object StringField55: TStringField
      FieldName = 'NFM_COL006'
      Size = 2
    end
    object StringField56: TStringField
      FieldName = 'NFM_COL007'
      Size = 2
    end
    object StringField57: TStringField
      FieldName = 'NFM_COL008'
      Size = 2
    end
    object StringField58: TStringField
      FieldName = 'NFM_COL009'
      Size = 2
    end
    object StringField59: TStringField
      FieldName = 'NFM_COL010'
      Size = 2
    end
    object FloatField22: TFloatField
      FieldName = 'NFM_QTD001'
    end
    object FloatField23: TFloatField
      FieldName = 'NFM_QTD002'
    end
    object FloatField24: TFloatField
      FieldName = 'NFM_QTD003'
    end
    object FloatField25: TFloatField
      FieldName = 'NFM_QTD004'
    end
    object FloatField26: TFloatField
      FieldName = 'NFM_QTD005'
    end
    object FloatField27: TFloatField
      FieldName = 'NFM_QTD006'
    end
    object FloatField28: TFloatField
      FieldName = 'NFM_QTD007'
    end
    object FloatField29: TFloatField
      FieldName = 'NFM_QTD008'
    end
    object FloatField30: TFloatField
      FieldName = 'NFM_QTD009'
    end
    object FloatField31: TFloatField
      FieldName = 'NFM_QTD010'
    end
    object StringField60: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'NFM_UNIDAD'
      Size = 2
    end
    object StringField61: TStringField
      DisplayLabel = 'Prod. Key'
      FieldName = 'NFM_PROKEY'
      Size = 2
    end
    object StringField62: TStringField
      DisplayLabel = 'Sub. Key'
      FieldName = 'NFM_SUBKEY'
      Size = 2
    end
    object StringField63: TStringField
      FieldName = 'NFM_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object StringField64: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object StringField65: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NFM_DESCRI'
      Size = 50
    end
    object FloatField32: TFloatField
      FieldName = 'NFM_EMBALA'
    end
  end
  object dtsLkd_CadNfm: TDataSource
    DataSet = qryLkd_CadNfm
    Left = 480
    Top = 136
  end
  object qryIqu_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM IQU_CADBAS')
    Constraints = <>
    Left = 576
    Top = 568
    object StringField9: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField19: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField37: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField66: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField67: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object StringField68: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField33: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object FloatField34: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object FloatField35: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object qryIqu_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM IQU_CADEMB')
    Constraints = <>
    Left = 656
    Top = 568
    object StringField69: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField70: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField36: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField71: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField72: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryLik_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LIK_CADEMB')
    Constraints = <>
    Left = 821
    Top = 567
    object StringField73: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField74: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField37: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField75: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField76: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryLik_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM LIK_CADBAS')
    Constraints = <>
    Left = 741
    Top = 567
    object StringField77: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField78: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField79: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField80: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField81: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object StringField82: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField38: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object FloatField39: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object FloatField40: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object qryRec_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM REC_CADEMB')
    Constraints = <>
    Left = 117
    Top = 615
    object StringField83: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField84: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField41: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField85: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField86: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryRec_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM REC_CADBAS')
    Constraints = <>
    Left = 37
    Top = 615
    object StringField87: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField88: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField89: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField90: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField91: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object StringField92: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField42: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object FloatField43: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object FloatField44: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object qryGlo_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM GLO_CADBAS')
    Constraints = <>
    Left = 213
    Top = 615
    object StringField93: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField94: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField95: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField96: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField97: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object StringField98: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField45: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object FloatField46: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object FloatField47: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object qryGlo_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM GLO_CADEMB')
    Constraints = <>
    Left = 293
    Top = 615
    object StringField99: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField100: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField48: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField101: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField102: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryRen_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM REN_CADEMB')
    Constraints = <>
    Left = 469
    Top = 615
    object StringField103: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField104: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField49: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField105: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField106: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryRen_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM REN_CADBAS')
    Constraints = <>
    Left = 389
    Top = 615
    object StringField107: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField108: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField109: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField110: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField111: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object StringField112: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField50: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object FloatField51: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object FloatField52: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object qryAnn_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM ANN_CADBAS')
    Constraints = <>
    Left = 580
    Top = 615
    object StringField113: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_BASE__'
      Required = True
      Size = 10
    end
    object StringField114: TStringField
      DisplayLabel = 'Item Base'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField115: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESCRI'
      Size = 40
    end
    object StringField116: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_UNIDAD'
      Size = 2
    end
    object StringField117: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Visible = False
      Size = 3
    end
    object StringField118: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField53: TFloatField
      FieldName = 'BAS_PRECUS'
    end
    object FloatField54: TFloatField
      FieldName = 'BAS_PREVEN'
    end
    object FloatField55: TFloatField
      FieldName = 'BAS_MARGEM'
    end
  end
  object qryAnn_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM ANN_CADEMB')
    Constraints = <>
    Left = 660
    Top = 615
    object StringField119: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 5
    end
    object StringField120: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField56: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField121: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object StringField122: TStringField
      FieldName = 'AUTOINCREM'
      Visible = False
    end
  end
  object qryDox_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM DOX_CADBAS')
    Constraints = <>
    Left = 344
    Top = 384
    object StringField123: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 10
    end
    object StringField124: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'BAS_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object StringField125: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Required = True
      Size = 5
    end
    object StringField126: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'BAS_DESBAS'
      Size = 40
    end
    object FloatField57: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField58: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField59: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField127: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object FloatField60: TFloatField
      FieldName = 'BAS_EMBALA'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object FloatField61: TFloatField
      FieldName = 'BAS_PESESP'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
    object StringField128: TStringField
      FieldName = 'BAS_PESGRA'
      Size = 1
    end
  end
  object qryMzi_CadBas: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM MZI_CADBAS')
    Constraints = <>
    Left = 936
    Top = 568
    object strngfld2: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BAS_CODBAS'
      Required = True
      Size = 10
    end
    object strngfld3: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'BAS_CODUNI'
      Required = True
      Size = 2
    end
    object strngfld5: TStringField
      DisplayLabel = 'Item'
      FieldName = 'BAS_CODITE'
      Size = 5
    end
    object fltfld1: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'BAS_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object fltfld3: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'BAS_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object fltfld2: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'BAS_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object strngfld7: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object qryMZI_CadBasBAS_CODEMP: TStringField
      FieldName = 'BAS_CODEMP'
      Size = 9
    end
    object QryMzi_CadBasBAS_DESCRI: TStringField
      FieldName = 'BAS_DESCRI'
      Size = 75
    end
    object qryMzi_CadBasBAS_PRODUT: TStringField
      FieldName = 'BAS_PRODUT'
      Size = 45
    end
  end
  object dtsMzi_CadBas: TDataSource
    DataSet = qryMzi_CadBas
    Left = 920
    Top = 40
  end
  object qryMzi_CadCol: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM MZI_CADCOL')
    Constraints = <>
    Left = 936
    Top = 512
    object StringField129: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COL_CODCOL'
      Required = True
      Size = 2
    end
    object StringField130: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'COL_CODEMP'
      Required = True
      Visible = False
      Size = 3
    end
    object FloatField62: TFloatField
      DisplayLabel = 'Pre'#231'o Custo'
      FieldName = 'COL_PRECUS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryMzi_CadColCOL_EMBALA: TFloatField
      DisplayLabel = 'Embalagem'
      FieldName = 'COL_EMBALA'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField63: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'COL_PREVEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object FloatField64: TFloatField
      DisplayLabel = 'Margem'
      FieldName = 'COL_MARGEM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object StringField131: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Visible = False
    end
    object StringField132: TStringField
      DisplayLabel = 'Item'
      FieldName = 'COL_CODITE'
      Size = 5
    end
  end
  object dtsMzi_CadCol: TDataSource
    DataSet = qryMzi_CadCol
    Left = 920
    Top = 88
  end
  object qryMzi_CadNfm: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM MZI_CADNFM')
    Constraints = <>
    Left = 936
    Top = 464
    object StringField149: TStringField
      DisplayLabel = 'Auto Incremento'
      FieldName = 'AUTOINCREM'
      Required = True
      Visible = False
    end
    object qryMzi_CadNfmNFM_COLNUM: TStringField
      DisplayLabel = 'N'#250'mero do Colorante'
      DisplayWidth = 15
      FieldName = 'NFM_COLNUM'
      Size = 15
    end
    object qryMzi_CadNfmNFM_COLNAM: TStringField
      DisplayLabel = 'Nome do Colorante'
      FieldName = 'NFM_COLNAM'
      Size = 50
    end
    object qryMzi_CadNfmNFM_CODBAS: TStringField
      DisplayLabel = 'C'#243'digo Base'
      FieldName = 'NFM_CODBAS'
      Size = 10
    end
    object StringField150: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'NFM_PRODUT'
      Size = 60
    end
    object qryMzi_CadNfmNFM_CODUNI: TStringField
      DisplayLabel = 'C'#243'd.Unidade'
      FieldName = 'NFM_CODUNI'
      Size = 2
    end
    object FloatField65: TFloatField
      DisplayLabel = 'Quantidade 01'
      FieldName = 'NFM_QTDC01'
    end
    object qryMzi_CadNfmNFM_CODC01: TStringField
      DisplayLabel = 'Colarante 01'
      FieldName = 'NFM_CODC01'
      Size = 3
    end
    object FloatField66: TFloatField
      DisplayLabel = 'Quantidade 02'
      FieldName = 'NFM_QTDC02'
    end
    object qryMzi_CadNfmNFM_CODC02: TStringField
      DisplayLabel = 'Colarante 02'
      FieldName = 'NFM_CODC02'
      Size = 3
    end
    object FloatField67: TFloatField
      DisplayLabel = 'Quantidade 03'
      FieldName = 'NFM_QTDC03'
    end
    object qryMzi_CadNfmNFM_CODC03: TStringField
      DisplayLabel = 'Colarante 03'
      FieldName = 'NFM_CODC03'
      Size = 3
    end
    object FloatField68: TFloatField
      DisplayLabel = 'Quantidade 04'
      FieldName = 'NFM_QTDC04'
    end
    object qryMzi_CadNfmNFM_CODC04: TStringField
      DisplayLabel = 'Colarante 04'
      FieldName = 'NFM_CODC04'
      Size = 3
    end
    object FloatField69: TFloatField
      DisplayLabel = 'Quantidade 05'
      FieldName = 'NFM_QTDC05'
    end
    object qryMzi_CadNfmNFM_CODC05: TStringField
      DisplayLabel = 'Colarante 05'
      FieldName = 'NFM_CODC05'
      Size = 3
    end
    object FloatField70: TFloatField
      DisplayLabel = 'Quantidade 06'
      FieldName = 'NFM_QTDC06'
    end
    object qryMzi_CadNfmNFM_CODC06: TStringField
      DisplayLabel = 'Colarante 06'
      FieldName = 'NFM_CODC06'
      Size = 3
    end
    object FloatField71: TFloatField
      DisplayLabel = 'Quantidade 07'
      FieldName = 'NFM_QTDC07'
    end
    object qryMzi_CadNfmNFM_CODC07: TStringField
      DisplayLabel = 'Colarante 07'
      FieldName = 'NFM_CODC07'
      Size = 3
    end
    object FloatField72: TFloatField
      DisplayLabel = 'Quantidade 08'
      FieldName = 'NFM_QTDC08'
    end
    object qryMzi_CadNfmNFM_CODC08: TStringField
      DisplayLabel = 'Colarante 08'
      FieldName = 'NFM_CODC08'
      Size = 3
    end
    object FloatField73: TFloatField
      DisplayLabel = 'Quantidade 09'
      FieldName = 'NFM_QTDC09'
    end
    object qryMzi_CadNfmNFM_CODC09: TStringField
      DisplayLabel = 'Colarante 09'
      FieldName = 'NFM_CODC09'
      Size = 3
    end
    object FloatField74: TFloatField
      DisplayLabel = 'Quantidade 10'
      FieldName = 'NFM_QTDC10'
    end
    object qryMzi_CadNfmNFM_CODC10: TStringField
      DisplayLabel = 'Colarante 10'
      FieldName = 'NFM_CODC10'
      Size = 3
    end
    object FloatField75: TFloatField
      DisplayLabel = 'Quantidade 11'
      FieldName = 'NFM_QTDC11'
    end
    object qryMzi_CadNfmNFM_CODC11: TStringField
      DisplayLabel = 'Colarante 11'
      FieldName = 'NFM_CODC11'
      Size = 3
    end
    object FloatField76: TFloatField
      DisplayLabel = 'Quantidade 12'
      FieldName = 'NFM_QTDC12'
    end
    object qryMzi_CadNfmNFM_CODC12: TStringField
      DisplayLabel = 'Colarante 12'
      FieldName = 'NFM_CODC12'
      Size = 3
    end
    object FloatField77: TFloatField
      DisplayLabel = 'Quantidade 13'
      FieldName = 'NFM_QTDC13'
    end
    object qryMzi_CadNfmNFM_CODC13: TStringField
      DisplayLabel = 'Colarante 13'
      FieldName = 'NFM_CODC13'
      Size = 3
    end
    object FloatField78: TFloatField
      DisplayLabel = 'Quantidade 14'
      FieldName = 'NFM_QTDC14'
    end
    object qryMzi_CadNfmNFM_CODC14: TStringField
      DisplayLabel = 'Colarante 14'
      FieldName = 'NFM_CODC14'
      Size = 3
    end
    object FloatField79: TFloatField
      DisplayLabel = 'Quantidade 15'
      FieldName = 'NFM_QTDC15'
    end
    object qryMzi_CadNfmNFM_CODC15: TStringField
      DisplayLabel = 'Colarante 15'
      FieldName = 'NFM_CODC15'
      Size = 3
    end
    object FloatField80: TFloatField
      DisplayLabel = 'Quantidade 16'
      FieldName = 'NFM_QTDC16'
    end
    object qryMzi_CadNfmNFM_CODC16: TStringField
      DisplayLabel = 'Colarante 16'
      FieldName = 'NFM_CODC16'
      Size = 3
    end
    object FloatField81: TFloatField
      DisplayLabel = 'Quantidade 17'
      FieldName = 'NFM_QTDC17'
    end
    object qryMzi_CadNfmNFM_CODC17: TStringField
      DisplayLabel = 'Colarante 17'
      FieldName = 'NFM_CODC17'
      Size = 3
    end
    object FloatField82: TFloatField
      DisplayLabel = 'Quantidade 18'
      FieldName = 'NFM_QTDC18'
    end
    object qryMzi_CadNfmNFM_CODC18: TStringField
      DisplayLabel = 'Colarante 18'
      FieldName = 'NFM_CODC18'
      Size = 3
    end
    object FloatField83: TFloatField
      DisplayLabel = 'Quantidade 19'
      FieldName = 'NFM_QTDC19'
    end
    object qryMzi_CadNfmNFM_CODC19: TStringField
      DisplayLabel = 'Colarante 19'
      FieldName = 'NFM_CODC19'
      Size = 3
    end
    object FloatField84: TFloatField
      DisplayLabel = 'Quantidade 20'
      FieldName = 'NFM_QTDC20'
    end
    object qryMzi_CadNfmNFM_CODC20: TStringField
      DisplayLabel = 'Colarante 20'
      FieldName = 'NFM_CODC20'
      Size = 3
    end
    object StringField133: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'NFM_CODNFM'
      Size = 15
    end
    object StringField148: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'NFM_CODEMP'
      Visible = False
      Size = 3
    end
    object qryMzi_CadNfmNFM_DTACAD: TDateField
      FieldName = 'NFM_DTACAD'
    end
  end
  object dtsMzi_CadNfm: TDataSource
    DataSet = qryMzi_CadNfm
    Left = 928
    Top = 152
  end
end
