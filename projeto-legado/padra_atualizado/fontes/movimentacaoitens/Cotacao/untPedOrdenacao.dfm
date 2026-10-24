inherited frmPedOrdenacao: TfrmPedOrdenacao
  Width = 391
  Height = 167
  Caption = 'Exporta'#231#227'o de Cota'#231#227'o'
  ExplicitWidth = 391
  ExplicitHeight = 167
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 95
    Width = 385
    TabOrder = 1
    inherited btnSair: TBitBtnLocked
      Left = 304
      ExplicitLeft = 304
    end
  end
  inherited pnlStatus: TPanel
    Top = 123
    Width = 385
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 214
    end
    inherited pnlInfo: TPanel
      Width = 214
    end
  end
  object rdgOrdenacao: TRadioGroup [2]
    Left = 8
    Top = 8
    Width = 369
    Height = 73
    Caption = 'Ordena'#231#227'o:'
    ItemIndex = 0
    Items.Strings = (
      'C'#243'digo do Item'
      'Descri'#231#227'o do Item'
      'Marca + Descri'#231#227'o do Item')
    TabOrder = 0
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 16
  end
end
