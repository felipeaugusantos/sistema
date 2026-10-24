inherited frmFatBaixaRomaneioObs: TfrmFatBaixaRomaneioObs
  Width = 570
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa de Romaneio - Observa'#231#245'es'
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  ExplicitWidth = 570
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 564
    TabOrder = 1
    ExplicitWidth = 564
    inherited btnSair: TBitBtnLocked
      Left = 473
      Width = 85
      TabOrder = 1
      ExplicitLeft = 473
      ExplicitWidth = 85
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 85
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Width = 564
    TabOrder = 2
    ExplicitWidth = 564
    inherited pnlNomeForm: TPanel
      Left = 393
      ExplicitLeft = 393
    end
    inherited pnlInfo: TPanel
      Width = 393
      ExplicitWidth = 393
    end
  end
  object memObserv: TMemoFocus [2]
    Left = 0
    Top = 0
    Width = 564
    Height = 190
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = memObservKeyDown
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 16
  end
end
