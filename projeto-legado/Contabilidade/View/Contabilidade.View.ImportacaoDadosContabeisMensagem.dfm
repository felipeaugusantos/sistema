inherited frmImportacoesContabeisMensagem: TfrmImportacoesContabeisMensagem
  Width = 988
  Height = 298
  Caption = 'Mensagens'
  Position = poMainFormCenter
  ExplicitWidth = 988
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 225
    Width = 982
    inherited FlwBotoes: TFlowPanel
      Width = 978
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 902
    end
  end
  inherited pnlStatus: TPanel
    Top = 253
    Width = 982
    inherited pnlNomeForm: TPanel
      Left = 811
    end
    inherited pnlInfo: TPanel
      Width = 811
    end
  end
  object mmMensagens: TMemo [3]
    Left = 0
    Top = 0
    Width = 982
    Height = 225
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    Lines.Strings = (
      'mmMensagens')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
  end
end
