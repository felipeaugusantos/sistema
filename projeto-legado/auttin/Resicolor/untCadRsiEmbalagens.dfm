inherited frmCadRsiEmbalagens: TfrmCadRsiEmbalagens
  Left = 239
  Top = 125
  Width = 526
  Height = 157
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Embalagens - Resicolor'
  ExplicitWidth = 526
  ExplicitHeight = 157
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 89
    Width = 520
    ExplicitTop = 86
    ExplicitWidth = 520
    inherited btnSair: TBitBtnLocked
      Left = 443
      ExplicitLeft = 443
    end
  end
  inherited pnlStatus: TPanel
    Top = 117
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
    Top = 23
    Width = 520
    Height = 66
    ExplicitTop = 23
    ExplicitWidth = 520
    ExplicitHeight = 63
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 512
      ExplicitHeight = 31
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 23
    Width = 520
    Height = 66
    Align = alClient
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 63
    object Label1: TLabel
      Left = 36
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 14
      Top = 36
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object Label3: TLabel
      Left = 174
      Top = 36
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object dbeCodEmb: TDBEditFocus
      Tag = 99
      Left = 75
      Top = 8
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_CODEMB'
      DataSource = dtsRsi_cadEmb
      TabOrder = 0
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
      Top = 32
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_QTDEMB'
      DataSource = dtsRsi_cadEmb
      TabOrder = 1
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
      Top = 32
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_UNIDAD'
      DataSource = dtsRsi_cadEmb
      TabOrder = 2
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
      Top = 36
      Width = 161
      Height = 17
      Caption = 'Utiliza esta embalagem?'
      DataField = 'EMB_USAEMB'
      DataSource = dtsRsi_cadEmb
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 520
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Cadastro de Embalagens - Resicolor '
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  object qryRsi_CadEmb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM RSI_CADEMB')
    Left = 360
    Top = 32
    object qryRsi_CadEmbEMB_CODEMB: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'EMB_CODEMB'
      Required = True
      Size = 2
    end
    object qryRsi_CadEmbEMB_QTDEMB: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'EMB_QTDEMB'
    end
    object qryRsi_CadEmbEMB_UNIDAD: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'EMB_UNIDAD'
      Size = 2
    end
    object qryRsi_CadEmbEMB_CODEMP: TStringField
      DisplayLabel = 'Empresa'
      FieldName = 'EMB_CODEMP'
      Required = True
      Size = 3
    end
    object qryRsi_CadEmbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object qryRsi_CadEmbEMB_USAEMB: TStringField
      FieldName = 'EMB_USAEMB'
      Size = 1
    end
  end
  object dtsRsi_cadEmb: TDataSource
    DataSet = qryRsi_CadEmb
    Left = 424
    Top = 32
  end
end
