inherited frmCadCorIndEmbalagens: TfrmCadCorIndEmbalagens
  Left = 273
  Top = 238
  Width = 526
  Height = 154
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Embalagens - Coral Industrial'
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
      Top = 40
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 14
      Top = 62
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
      Caption = 'Cadastro de Embalagens - Coral Industrial'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
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
      Top = 54
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_QTDEMB'
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
      Top = 52
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_UNIDAD'
      TabOrder = 3
      OnKeyPress = dbeUnidadKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
