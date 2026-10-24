inherited frmCadAdvCorEmbalagens: TfrmCadAdvCorEmbalagens
  Left = 239
  Top = 125
  Width = 526
  Height = 154
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Embalagens - Advance'
  ExplicitWidth = 526
  ExplicitHeight = 154
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 86
    Width = 520
    ExplicitTop = 86
    ExplicitWidth = 520
    inherited btnSair: TBitBtnLocked
      Left = 443
      ExplicitLeft = 443
    end
  end
  inherited pnlStatus: TPanel
    Top = 114
    Width = 520
    ExplicitTop = 114
    ExplicitWidth = 520
    inherited pnlNomeForm: TPanel
      Left = 173
      ExplicitLeft = 173
    end
    inherited pnlInfo: TPanel
      Width = 173
      ExplicitWidth = 173
    end
  end
  inherited pgcDados: TPageControl
    Width = 520
    Height = 86
    ExplicitWidth = 520
    ExplicitHeight = 86
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 512
      ExplicitHeight = 54
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 520
    Height = 86
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
      Width = 518
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Embalagens - Advance'
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
      DataSource = dtsAdv_cadEmb
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
      DataSource = dtsAdv_cadEmb
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
      DataSource = dtsAdv_cadEmb
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
      DataSource = dtsAdv_cadEmb
      TabOrder = 4
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object qryAdv_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM ADVCOR_CADEMB')
    Left = 360
    Top = 32
    object qryAdv_CadEmbEMB_CODEMB: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 2
    end
    object qryAdv_CadEmbEMB_QTDEMB: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
    end
    object qryAdv_CadEmbEMB_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object qryAdv_CadEmbEMB_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Size = 3
    end
    object qryAdv_CadEmbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryAdv_CadEmbEMB_USAEMB: TStringField
      FieldName = 'EMB_USAEMB'
      Size = 1
    end
  end
  object dtsAdv_cadEmb: TDataSource
    DataSet = qryAdv_CadEmb
    Left = 424
    Top = 32
  end
end
