inherited frmAjudaCampos: TfrmAjudaCampos
  Width = 882
  Height = 449
  Caption = 'Comandos dispon'#237'veis para utiliza'#231#227'o no t'#237'tulo do campo'
  ExplicitWidth = 882
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 376
    Width = 876
    ExplicitTop = 376
    ExplicitWidth = 876
    inherited FlwBotoes: TFlowPanel
      Width = 872
      ExplicitWidth = 872
    end
    inherited btnSair: TBitBtnLocked
      Left = 796
      Caption = 'Sair'
      ExplicitLeft = 796
    end
  end
  inherited pnlStatus: TPanel
    Top = 404
    Width = 876
    ExplicitTop = 404
    ExplicitWidth = 876
    inherited pnlNomeForm: TPanel
      Left = 705
      ExplicitLeft = 705
    end
    inherited pnlInfo: TPanel
      Width = 705
      ExplicitWidth = 705
    end
  end
  object pgcInfo: TPageControl [2]
    Left = 0
    Top = 0
    Width = 876
    Height = 376
    Align = alClient
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 752
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 664
    Top = 192
  end
end
