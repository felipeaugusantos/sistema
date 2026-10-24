inherited frmCadAnjoSinteticaEmbalagens: TfrmCadAnjoSinteticaEmbalagens
  Height = 172
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Embalagens - Anjo Sint'#233'tica'
  ExplicitHeight = 172
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 104
    ExplicitTop = 104
  end
  inherited pnlStatus: TPanel
    Top = 132
    ExplicitTop = 132
  end
  inherited pgcDados: TPageControl
    Height = 104
    ExplicitHeight = 104
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 72
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 104
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 36
      Top = 36
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 14
      Top = 60
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label3: TLabel
      Left = 174
      Top = 60
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Embalagens - Anjo Sint'#233'tica'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object dbeCodEmb: TDBEditFocus
      Tag = 99
      Left = 75
      Top = 32
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_CODEMB'
      DataSource = dtsAja_cadEmb
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeQtdEmb: TDBEditFocus
      Tag = 99
      Left = 75
      Top = 56
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_QTDEMB'
      DataSource = dtsAja_cadEmb
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeUnidad: TDBEditFocus
      Tag = 99
      Left = 219
      Top = 56
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_UNIDAD'
      DataSource = dtsAja_cadEmb
      TabOrder = 3
      OnKeyPress = dbeUnidadKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkUsaEmb: TDBCheckBox
      Left = 304
      Top = 60
      Width = 161
      Height = 17
      Caption = 'Utiliza esta embalagem?'
      DataField = 'EMB_USAEMB'
      DataSource = dtsAja_cadEmb
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object dtsAja_cadEmb: TDataSource
    DataSet = qryAja_CadEmb
    Left = 424
    Top = 32
  end
  object qryAja_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM AJA_CADEMB')
    Left = 360
    Top = 32
    object qryAja_CadEmbEMB_CODEMB: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 2
    end
    object qryAja_CadEmbEMB_QTDEMB: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
    end
    object qryAja_CadEmbEMB_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object qryAja_CadEmbEMB_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Size = 3
    end
    object qryAja_CadEmbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryAja_CadEmbEMB_USAEMB: TStringField
      FieldName = 'EMB_USAEMB'
      Size = 1
    end
  end
end
