inherited frmMsgValidacaoContabil: TfrmMsgValidacaoContabil
  Width = 861
  Height = 440
  Caption = 'Valida'#231#227'o do Valor Cont'#225'bil'
  ExplicitWidth = 861
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 367
    Width = 855
    ExplicitTop = 291
    ExplicitWidth = 855
    inherited FlwBotoes: TFlowPanel
      Width = 851
      ExplicitWidth = 851
    end
    inherited btnSair: TBitBtnLocked
      Left = 772
      Caption = 'Sair'
      ExplicitLeft = 772
    end
  end
  object mmoMsg: TMemo [2]
    Left = 0
    Top = 0
    Width = 855
    Height = 367
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
    TabOrder = 2
    ExplicitHeight = 291
  end
  inherited pnlStatus: TPanel
    Top = 395
    Width = 855
    ExplicitTop = 319
    ExplicitWidth = 855
    inherited pnlNomeForm: TPanel
      Left = 684
      ExplicitLeft = 684
    end
    inherited pnlInfo: TPanel
      Width = 684
      ExplicitWidth = 684
    end
  end
end
