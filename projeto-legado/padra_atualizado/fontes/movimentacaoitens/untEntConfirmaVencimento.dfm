inherited frmEntConfirmaVencimento: TfrmEntConfirmaVencimento
  Width = 611
  Height = 177
  Caption = 'Confirma'#231#227'o de Vencimento'
  ExplicitWidth = 611
  ExplicitHeight = 177
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 106
    Width = 605
    ExplicitTop = 106
    ExplicitWidth = 605
    inherited FlwBotoes: TFlowPanel
      Width = 601
      ExplicitWidth = 601
    end
    inherited btnSair: TBitBtnLocked
      Left = 523
      ExplicitLeft = 523
    end
  end
  inherited pnlStatus: TPanel
    Top = 132
    Width = 605
    ExplicitTop = 132
    ExplicitWidth = 605
    inherited pnlNomeForm: TPanel
      Left = 434
      ExplicitLeft = 434
    end
    inherited pnlInfo: TPanel
      Width = 434
      ExplicitWidth = 434
    end
  end
  object Memo1: TMemo [2]
    Left = 0
    Top = 0
    Width = 605
    Height = 106
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      
        'Aten'#231#227'o, existe(m) duplicata(s) de contas a pagar gerada(s) por ' +
        'esta nota fiscal, com'
      
        'vencimento anterior '#224' hoje, ocasionado pela data documento ser a' +
        'nterior '#224' data de entrada. '
      ''
      
        'Este procedimento '#233' permitido e a entrada ser'#225' confirmada, caben' +
        'do ao Sistema alertar o '
      'operador sobre este fato.')
    ParentFont = False
    TabOrder = 2
  end
end
