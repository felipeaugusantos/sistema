inherited frmPedeCotacaoMoeda: TfrmPedeCotacaoMoeda
  Width = 535
  Height = 205
  Caption = 'Convers'#227'o de Moedas'
  ExplicitWidth = 535
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 14
  object lblCotDol: TLabel [0]
    Left = 151
    Top = 109
    Width = 86
    Height = 14
    Alignment = taRightJustify
    Caption = 'Cota'#231#227'o do D'#243'lar:'
  end
  inherited pnlBotoes: TPanel
    Top = 134
    Width = 529
    TabOrder = 2
    ExplicitTop = 134
    ExplicitWidth = 529
    inherited FlwBotoes: TFlowPanel
      Width = 525
      ExplicitTop = 2
      ExplicitWidth = 525
    end
    inherited btnSair: TBitBtnLocked
      Left = 449
      ExplicitLeft = 449
    end
  end
  inherited pnlStatus: TPanel
    Top = 160
    Width = 529
    TabOrder = 3
    ExplicitTop = 160
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 358
      ExplicitLeft = 358
    end
    inherited pnlInfo: TPanel
      Width = 358
      ExplicitWidth = 358
    end
  end
  object edtCotDol: TEditFocus [4]
    Tag = 99
    Left = 239
    Top = 102
    Width = 88
    Height = 22
    Alignment = taRightJustify
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 12
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 12
    TipoTexto = ttNumerico
  end
  object mmoNotifica: TMemo [5]
    Left = 0
    Top = 0
    Width = 529
    Height = 89
    TabStop = False
    Align = alTop
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 448
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 120
  end
end
