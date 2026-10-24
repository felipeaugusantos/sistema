inherited frmCadMetMix: TfrmCadMetMix
  Width = 542
  Height = 148
  Caption = 'Cadastro de Meta Mix'
  OnDestroy = FormDestroy
  ExplicitWidth = 542
  ExplicitHeight = 148
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 78
    Width = 536
    Height = 25
    TabOrder = 3
    ExplicitTop = 78
    ExplicitWidth = 536
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 447
      Align = alNone
      ExplicitTop = 2
      ExplicitWidth = 447
      inherited btnPesquisa: TBitBtnLocked
        Width = 81
        ExplicitWidth = 81
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 464
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 464
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 103
    Width = 536
    TabOrder = 4
    ExplicitTop = 103
    ExplicitWidth = 536
    inherited pnlNomeForm: TPanel
      Left = 189
      Caption = 'frmCadMetMix'
      ExplicitLeft = 189
    end
    inherited pnlInfo: TPanel
      Width = 189
      ExplicitWidth = 189
    end
  end
  inherited pgcDados: TPageControl
    Width = 536
    Height = 78
    TabOrder = 5
    ExplicitWidth = 536
    ExplicitHeight = 78
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 528
      ExplicitHeight = 46
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 536
    Height = 78
    Align = alClient
    TabOrder = 6
    object lblEmp: TLabel
      Left = 23
      Top = 14
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label1: TLabel
      Left = 23
      Top = 43
      Width = 45
      Height = 14
      Caption = 'Meta Mix:'
    end
    object lblPorcentagem: TLabel
      Left = 143
      Top = 43
      Width = 12
      Height = 16
      Caption = '%'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object edtPerMet: TEditFocus [4]
    Tag = 99
    Left = 74
    Top = 40
    Width = 66
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    TabOrder = 2
    Text = '0,00'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.00'
  end
  object edtCodEmp: TEditFocus [5]
    Tag = 99
    Left = 74
    Top = 11
    Width = 66
    Height = 22
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    ParentFont = False
    TabOrder = 0
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtDesEmp: TEditFocus [6]
    Left = 143
    Top = 11
    Width = 346
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 1
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 24
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 0
    Top = 168
  end
end
