inherited frmAgrupamentoDeOndaDeSeparacaoImpressaoVias: TfrmAgrupamentoDeOndaDeSeparacaoImpressaoVias
  Width = 385
  Height = 164
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 385
  ExplicitHeight = 164
  PixelsPerInch = 96
  TextHeight = 14
  object lblSaidaVideoImpressora: TColorLabel [0]
    Left = 175
    Top = 48
    Width = 117
    Height = 14
    Caption = '(V) V'#237'deo (I) Impressora'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    CorDestaque = clRed
  end
  object lblSaida: TLabel [1]
    Left = 122
    Top = 49
    Width = 30
    Height = 14
    Alignment = taRightJustify
    Caption = 'Sa'#237'da:'
  end
  object lblQtdVias: TLabel [2]
    Left = 104
    Top = 25
    Width = 48
    Height = 14
    Alignment = taRightJustify
    Caption = 'Qtd. Vias:'
  end
  object edtSaida: TEditFocus [3]
    Tag = 99
    Left = 154
    Top = 44
    Width = 15
    Height = 22
    Alignment = taCenter
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 1
    ParentFont = False
    TabOrder = 1
    Text = 'I'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 1
    TipoTexto = ttAlfabetico
  end
  object edtQtdVias: TEditFocus [4]
    Tag = 99
    Left = 154
    Top = 20
    Width = 71
    Height = 22
    Alignment = taRightJustify
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ParentFont = False
    TabOrder = 0
    Text = '1'
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttInteiro
    EditFormat = '#,##0.00'
  end
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 379
    TabOrder = 2
    ExplicitTop = 93
    ExplicitWidth = 379
    inherited FlwBotoes: TFlowPanel
      Width = 375
      ExplicitWidth = 375
    end
    inherited btnSair: TBitBtnLocked
      Left = 299
      ExplicitLeft = 299
    end
  end
  inherited pnlStatus: TPanel
    Top = 119
    Width = 379
    TabOrder = 3
    ExplicitTop = 119
    ExplicitWidth = 379
    inherited pnlNomeForm: TPanel
      Left = 79
      Width = 300
      ExplicitLeft = 163
      ExplicitWidth = 300
    end
    inherited pnlInfo: TPanel
      Width = 79
      ExplicitWidth = 79
    end
  end
end
