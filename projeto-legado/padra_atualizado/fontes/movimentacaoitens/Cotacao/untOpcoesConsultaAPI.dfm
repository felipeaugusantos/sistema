inherited frmOpcoesConsultaAPI: TfrmOpcoesConsultaAPI
  Height = 153
  Caption = 'Op'#231#245'es'
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  ExplicitHeight = 153
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Left = 5
    Top = 82
    Width = 473
    inherited FlwBotoes: TFlowPanel
      Width = 469
    end
    inherited btnSair: TBitBtnLocked
      Left = 393
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Left = 5
    Top = 108
    Width = 473
    inherited pnlNomeForm: TPanel
      Left = 302
    end
    inherited pnlInfo: TPanel
      Width = 302
    end
  end
  object RadioGroup1: TRadioGroup [2]
    Left = 5
    Top = 5
    Width = 473
    Height = 55
    Align = alTop
    Caption = 'Quais fornecedores deseja processar?'
    Items.Strings = (
      'Apenas fornecedor selecionado'
      'Todos os fornecedores')
    TabOrder = 2
    ExplicitLeft = 23
    ExplicitTop = -16
    ExplicitWidth = 185
    ExplicitHeight = 105
  end
  object CheckBox1: TCheckBox [3]
    Left = 5
    Top = 60
    Width = 473
    Height = 22
    Align = alClient
    Caption = 'Reiniciar Processo'
    TabOrder = 3
    ExplicitHeight = 35
  end
end
