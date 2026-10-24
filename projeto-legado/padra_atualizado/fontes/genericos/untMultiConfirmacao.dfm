inherited frmMultiConfirmacao: TfrmMultiConfirmacao
  Width = 572
  Height = 323
  Caption = 'Observa'#231#245'es'
  OnActivate = FormActivate
  ExplicitWidth = 572
  ExplicitHeight = 323
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 251
    Width = 566
    TabOrder = 1
    ExplicitTop = 251
    ExplicitWidth = 566
    inherited btnSair: TBitBtnLocked
      Left = 483
      ExplicitLeft = 483
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 6
      ExplicitLeft = 6
    end
  end
  inherited pnlStatus: TPanel
    Top = 279
    Width = 566
    TabOrder = 2
    ExplicitTop = 279
    ExplicitWidth = 566
    inherited pnlNomeForm: TPanel
      Left = 395
      ExplicitLeft = 395
    end
    inherited pnlInfo: TPanel
      Width = 395
      ExplicitWidth = 395
    end
  end
  object memObs: TMemoFocus [2]
    Left = 0
    Top = 0
    Width = 566
    Height = 251
    Align = alClient
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
end
