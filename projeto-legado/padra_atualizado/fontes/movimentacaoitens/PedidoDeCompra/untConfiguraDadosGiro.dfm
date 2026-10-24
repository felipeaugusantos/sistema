inherited frmConfiguraDadosGiro: TfrmConfiguraDadosGiro
  Width = 969
  Height = 569
  Caption = 'Configure as informa'#231#245'es para o c'#225'lculo do giro'
  ExplicitWidth = 969
  ExplicitHeight = 569
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 498
    Width = 963
    TabOrder = 2
    ExplicitTop = 498
    ExplicitWidth = 963
    inherited FlwBotoes: TFlowPanel
      Width = 959
      ExplicitTop = 2
      ExplicitWidth = 959
    end
    inherited btnSair: TBitBtnLocked
      Left = 880
      ExplicitLeft = 880
    end
  end
  inherited pnlStatus: TPanel
    Top = 524
    Width = 963
    TabOrder = 3
    ExplicitTop = 524
    ExplicitWidth = 963
    inherited pnlNomeForm: TPanel
      Left = 792
      ExplicitLeft = 792
    end
    inherited pnlInfo: TPanel
      Width = 792
      ExplicitWidth = 792
    end
  end
  object pnlSugestao: TPanel [3]
    Left = 0
    Top = 0
    Width = 963
    Height = 200
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Configura'#231#245'es da Sugest'#227'o'
    TabOrder = 0
  end
  object pnlCalculo: TPanel [4]
    Left = 0
    Top = 200
    Width = 963
    Height = 208
    Align = alTop
    BevelOuter = bvLowered
    Caption = 'Configura'#231#245'es do C'#225'lculo'
    TabOrder = 1
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 696
    Top = 176
  end
  object dtsCFGSIS: TDataSource
    Left = 672
    Top = 96
  end
end
