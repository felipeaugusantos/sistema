inherited frmSelModoRecalculo: TfrmSelModoRecalculo
  Width = 468
  Height = 209
  Caption = 'Tipo Recalculo'
  ExplicitWidth = 468
  ExplicitHeight = 209
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 138
    Width = 462
    ExplicitTop = 70
    ExplicitWidth = 462
    inherited FlwBotoes: TFlowPanel
      Width = 458
      ExplicitWidth = 458
    end
    inherited btnSair: TBitBtnLocked
      Left = 382
      ExplicitLeft = 382
    end
  end
  inherited pnlStatus: TPanel
    Top = 164
    Width = 462
    ExplicitTop = 96
    ExplicitWidth = 462
    inherited pnlNomeForm: TPanel
      Left = 291
      ExplicitLeft = 291
    end
    inherited pnlInfo: TPanel
      Width = 291
      ExplicitWidth = 291
    end
  end
  object rdgTipAltGer: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 462
    Height = 65
    Align = alTop
    Caption = 'Tipo de Altera'#231#227'o'
    ItemIndex = 1
    Items.Strings = (
      'Alterar Pre'#231'o de Venda mantendo a margem'
      'Alterar Margem de Lucro mantendo o pre'#231'o de venda')
    TabOrder = 2
    ExplicitWidth = 461
  end
  object rdgOpcRecalc: TRadioGroup [3]
    Left = 0
    Top = 65
    Width = 462
    Height = 65
    Align = alTop
    Caption = 'Op'#231#227'o de Recalculo'
    ItemIndex = 0
    Items.Strings = (
      'Todas as tabelas de pre'#231'o'
      'Apenas tabelas com pre'#231'o ativo no cadastro de produto')
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 71
    ExplicitWidth = 461
  end
end
