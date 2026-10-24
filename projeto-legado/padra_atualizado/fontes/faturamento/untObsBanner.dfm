inherited frmObsBanner: TfrmObsBanner
  Width = 547
  Height = 290
  Caption = ''
  ExplicitWidth = 547
  ExplicitHeight = 290
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 219
    Width = 541
    ExplicitTop = 219
    ExplicitWidth = 541
    inherited FlwBotoes: TFlowPanel
      Width = 537
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 458
      ExplicitLeft = 458
    end
  end
  inherited pnlStatus: TPanel
    Top = 245
    Width = 541
    ExplicitTop = 245
    ExplicitWidth = 541
    inherited pnlNomeForm: TPanel
      Left = 370
      ExplicitLeft = 370
    end
    inherited pnlInfo: TPanel
      Width = 370
      ExplicitWidth = 370
    end
  end
  object mmoObserv: TMemoFocus [3]
    Left = 0
    Top = 0
    Width = 541
    Height = 219
    Align = alClient
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    StyleElements = []
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
end
