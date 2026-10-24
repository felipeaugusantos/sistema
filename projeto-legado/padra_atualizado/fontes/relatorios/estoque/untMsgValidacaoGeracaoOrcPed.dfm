inherited frmMsgValidacaoGeraOrdOp: TfrmMsgValidacaoGeraOrdOp
  Width = 537
  Height = 303
  Caption = 'Valida'#231#245'es Para Gerar OP'
  Position = poMainFormCenter
  ExplicitWidth = 537
  ExplicitHeight = 303
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 230
    Width = 531
    ExplicitTop = 231
    ExplicitWidth = 531
    inherited btnSair: TBitBtnLocked
      Left = 450
      ExplicitLeft = 450
    end
  end
  object mmoMsg: TMemo [2]
    Left = 0
    Top = 0
    Width = 531
    Height = 230
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      ''
      '')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  inherited pnlStatus: TPanel
    Top = 258
    Width = 531
    ExplicitTop = 259
    ExplicitWidth = 531
    inherited pnlNomeForm: TPanel
      Left = 360
      ExplicitLeft = 360
    end
    inherited pnlInfo: TPanel
      Width = 360
      ExplicitWidth = 360
    end
  end
end
