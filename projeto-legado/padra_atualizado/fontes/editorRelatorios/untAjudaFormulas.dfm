inherited frmAjudaFormulas: TfrmAjudaFormulas
  Width = 826
  Height = 640
  Caption = 'Fun'#231#245'es dispon'#237'veis para utiliza'#231#227'o nas f'#243'rmulas'
  ExplicitWidth = 826
  ExplicitHeight = 640
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 567
    Width = 820
    ExplicitTop = 567
    ExplicitWidth = 820
    inherited FlwBotoes: TFlowPanel
      Width = 816
      ExplicitWidth = 816
    end
    inherited btnSair: TBitBtnLocked
      Left = 737
      Caption = 'Sair'
      ExplicitLeft = 737
    end
  end
  inherited pnlStatus: TPanel
    Top = 595
    Width = 820
    ExplicitTop = 595
    ExplicitWidth = 820
    inherited pnlNomeForm: TPanel
      Left = 649
      ExplicitLeft = 649
    end
    inherited pnlInfo: TPanel
      Width = 649
      ExplicitWidth = 649
    end
  end
  object pgcInfo: TPageControl [2]
    Left = 0
    Top = 0
    Width = 820
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
