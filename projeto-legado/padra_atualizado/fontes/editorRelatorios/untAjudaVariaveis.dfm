inherited frmAjudaVariaveis: TfrmAjudaVariaveis
  Width = 1027
  Height = 640
  Caption = 'Vari'#225'veis dispon'#237'veis para utiliza'#231#227'o na instru'#231#227'o SQL'
  ExplicitWidth = 1027
  ExplicitHeight = 640
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 567
    Width = 1021
    ExplicitTop = 567
    ExplicitWidth = 1021
    inherited FlwBotoes: TFlowPanel
      Width = 1017
      ExplicitWidth = 1017
    end
    inherited btnSair: TBitBtnLocked
      Left = 932
      Caption = 'Sair'
      ExplicitLeft = 932
    end
  end
  inherited pnlStatus: TPanel
    Top = 595
    Width = 1021
    ExplicitTop = 595
    ExplicitWidth = 1021
    inherited pnlNomeForm: TPanel
      Left = 850
      ExplicitLeft = 850
    end
    inherited pnlInfo: TPanel
      Width = 850
      ExplicitWidth = 850
    end
  end
  object pgcInfo: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1021
    Height = 567
    Align = alClient
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 920
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 928
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 392
  end
end
