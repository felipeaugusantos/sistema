inherited frmCadGlaBases: TfrmCadGlaBases
  Left = 224
  Top = 174
  Width = 530
  Height = 179
  BorderStyle = bsToolWindow
  Caption = 'Cadastro de Bases - Glasurit'
  ExplicitWidth = 530
  ExplicitHeight = 179
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 524
    ExplicitTop = 106
    ExplicitWidth = 524
    inherited FlwBotoes: TFlowPanel
      Width = 520
      ExplicitTop = 2
      ExplicitWidth = 520
    end
    inherited btnSair: TBitBtnLocked
      Left = 447
      ExplicitLeft = 447
    end
  end
  inherited pnlStatus: TPanel
    Top = 134
    Width = 524
    ExplicitTop = 134
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 177
      ExplicitLeft = 177
    end
    inherited pnlInfo: TPanel
      Width = 177
      ExplicitWidth = 177
    end
  end
  inherited pgcDados: TPageControl
    Width = 524
    Height = 106
    ExplicitWidth = 524
    ExplicitHeight = 106
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 516
      ExplicitHeight = 74
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 524
    Height = 106
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label2: TLabel
      Left = 40
      Top = 16
      Width = 28
      Height = 14
      Caption = 'Base:'
    end
    object Label3: TLabel
      Left = 16
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 336
      Top = 60
      Width = 28
      Height = 14
      Caption = 'Valor:'
    end
    object Label8: TLabel
      Left = 30
      Top = 81
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 18
      Top = 60
      Width = 51
      Height = 14
      Caption = 'Peso Esp.:'
    end
    object Label1: TLabel
      Left = 163
      Top = 60
      Width = 57
      Height = 14
      Caption = 'Embalagem:'
    end
    object Label5: TLabel
      Left = 336
      Top = 16
      Width = 29
      Height = 14
      Caption = 'Linha:'
    end
    object dbeCodBas: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 8
      Width = 89
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODBAS'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 30
      Width = 345
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_DESBAS'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValBas: TDBEditFocus
      Tag = 99
      Left = 368
      Top = 52
      Width = 49
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_VALBAS'
      TabOrder = 5
      OnExit = dbeValBasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 145
      Top = 74
      Width = 361
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodIte: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 74
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_CODITE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnKeyPress = dbeCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbePesBas: TDBEditFocus
      Tag = 99
      Left = 72
      Top = 52
      Width = 73
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAS_PESBAS'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeLinha_: TDBComboBoxFocus
      Tag = 99
      Left = 368
      Top = 8
      Width = 49
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'BAS_LINHA_'
      Enabled = False
      Items.Strings = (
        '22'
        '55'
        '90'
        '35'
        '30')
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeEmbala: TDBComboBoxFocus
      Tag = 99
      Left = 222
      Top = 52
      Width = 83
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'BAS_QTDEMB'
      Enabled = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 24
  end
end
