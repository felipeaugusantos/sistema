inherited frmFatPerguntaOrdPro: TfrmFatPerguntaOrdPro
  Left = 337
  Top = 377
  Width = 390
  Height = 131
  ActiveControl = chkImpOrd
  Caption = 'Ordem de Produ'#231#227'o'
  ExplicitWidth = 390
  ExplicitHeight = 131
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 59
    Width = 384
    ExplicitTop = 59
    ExplicitWidth = 384
    inherited btnSair: TBitBtnLocked
      Left = 301
      Caption = '&Confirma'
      Glyph.Data = {00000000}
      ModalResult = 1
      ExplicitLeft = 301
    end
  end
  inherited pnlStatus: TPanel
    Top = 87
    Width = 384
    ExplicitTop = 87
    ExplicitWidth = 384
    inherited pnlNomeForm: TPanel
      Left = 213
      ExplicitLeft = 213
    end
    inherited pnlInfo: TPanel
      Width = 213
      ExplicitWidth = 213
    end
  end
  object chkImpOrd: TCheckBox [2]
    Left = 16
    Top = 16
    Width = 337
    Height = 17
    Caption = 'chkImpOrd'
    TabOrder = 2
  end
  object prgProgresso: TProgressBar [3]
    Left = 0
    Top = 43
    Width = 384
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 3
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 24
  end
end
