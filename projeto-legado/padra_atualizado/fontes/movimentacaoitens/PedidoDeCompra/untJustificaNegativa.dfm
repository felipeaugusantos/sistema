inherited frmJustificaNegativa: TfrmJustificaNegativa
  Width = 546
  Height = 318
  HorzScrollBar.Visible = False
  Caption = 'Justifique a negativa da requisi'#231#227'o de compra'
  ExplicitWidth = 546
  ExplicitHeight = 318
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 245
    Width = 540
    TabOrder = 2
    ExplicitWidth = 540
    inherited btnSair: TBitBtnLocked
      Left = 459
      ExplicitLeft = 459
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 273
    Width = 540
    TabOrder = 3
    ExplicitWidth = 540
    inherited pnlNomeForm: TPanel
      Left = 369
      ExplicitLeft = 369
    end
    inherited pnlInfo: TPanel
      Width = 369
      ExplicitWidth = 369
    end
  end
  object pnlJustif: TPanel [3]
    Left = 0
    Top = 73
    Width = 540
    Height = 172
    Align = alClient
    BorderWidth = 2
    TabOrder = 1
    ExplicitTop = 65
    ExplicitWidth = 333
    ExplicitHeight = 180
    object mmoJUSTIF: TMemoFocus
      Left = 3
      Top = 3
      Width = 534
      Height = 166
      Align = alClient
      BorderStyle = bsNone
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Courier'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 331
      ExplicitHeight = 178
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 540
    Height = 73
    Align = alTop
    BorderWidth = 2
    TabOrder = 0
    object rdgMotNeg: TRadioGroup
      Left = 3
      Top = 3
      Width = 534
      Height = 67
      Align = alClient
      Caption = 'Motivo para negar a requisi'#231#227'o:'
      ItemIndex = 0
      Items.Strings = (
        'N'#227'o ir'#225' comprar a mercadoria por motivo de for'#231'a maior'
        'Produto j'#225' possui saldo em estoque')
      TabOrder = 0
      OnClick = rdgMotNegClick
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 536
      ExplicitHeight = 82
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 440
    Top = 64
  end
end
