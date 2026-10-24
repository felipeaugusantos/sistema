inherited fmrConfirmaCTP117: TfmrConfirmaCTP117
  Width = 593
  Height = 164
  Caption = 'Aten'#231#227'o!'
  ExplicitWidth = 593
  ExplicitHeight = 164
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 93
    Width = 587
    inherited FlwBotoes: TFlowPanel
      Width = 583
      inherited btnConfirma: TBitBtnLocked
        Caption = '&Sim'
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 508
      Top = 2
      Caption = '&N'#227'o'
      ExplicitLeft = 663
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 119
    Width = 587
    inherited pnlNomeForm: TPanel
      Left = 416
    end
    inherited pnlInfo: TPanel
      Width = 416
    end
  end
  object memPergunta: TMemo [2]
    Left = 0
    Top = 0
    Width = 587
    Height = 93
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Pitch = fpVariable
    Font.Style = []
    Lines.Strings = (
      'Esta nota fiscal '#233' de baixa de entrega futura.'
      
        'CFOP ( x117, x116 ) n'#227'o est'#227'o programadas para gravar Contas a P' +
        'agar.'
      
        'Contudo, foi detectado que este fornecedor enviou TAGs de boleto' +
        ' neste documento. '
      
        'Pode ser ST ou IPI que est'#225' sendo cobrado na circula'#231#227'o da merca' +
        'doria.'
      'Deseja gravar contas a pagar destes tiulos? '
      'Vencimentos - Valores:')
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 742
    ExplicitHeight = 97
  end
end
