inherited frmFatFormulSelTintas: TfrmFatFormulSelTintas
  Width = 307
  Height = 322
  ActiveControl = chkLisTin
  Caption = 'Selecione as Tintas para a Baixa  da Formula'#231#227'o'
  ExplicitWidth = 307
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 250
    Width = 301
    ExplicitTop = 250
    ExplicitWidth = 301
    inherited btnSair: TBitBtnLocked
      Left = 218
      ExplicitLeft = 218
    end
  end
  inherited pnlStatus: TPanel
    Top = 278
    Width = 301
    ExplicitTop = 278
    ExplicitWidth = 301
    inherited pnlNomeForm: TPanel
      Left = 130
      ExplicitLeft = 130
    end
    inherited pnlInfo: TPanel
      Width = 130
      ExplicitWidth = 130
    end
  end
  object chkLisTin: TCheckListBox [2]
    Left = 0
    Top = 0
    Width = 301
    Height = 250
    Align = alClient
    ItemHeight = 14
    TabOrder = 2
  end
end
