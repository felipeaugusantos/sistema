inherited frmTabelaPrecoSelec: TfrmTabelaPrecoSelec
  Width = 415
  Height = 203
  Caption = 'Selecione as Tabelas de Pre'#231'o que ser'#227'o alteradas'
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 415
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 132
    Width = 409
    ExplicitTop = 132
    ExplicitWidth = 409
    inherited FlwBotoes: TFlowPanel
      Width = 405
      ExplicitWidth = 405
    end
    inherited btnSair: TBitBtnLocked
      Left = 326
      ExplicitLeft = 326
    end
  end
  inherited pnlStatus: TPanel
    Top = 158
    Width = 409
    ExplicitTop = 158
    ExplicitWidth = 409
    inherited pnlNomeForm: TPanel
      Left = 238
      ExplicitLeft = 238
    end
    inherited pnlInfo: TPanel
      Width = 238
      ExplicitWidth = 238
    end
  end
  object cklTabelas: TCheckListBox [2]
    Left = 161
    Top = 16
    Width = 89
    Height = 105
    ItemHeight = 14
    Items.Strings = (
      'Tabela 1'
      'Tabela 2'
      'Tabela 3'
      'Tabela 4'
      'Tabela 5'
      'Tabela 6'
      'Tabela 7')
    TabOrder = 2
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 432
    Top = 56
  end
end
