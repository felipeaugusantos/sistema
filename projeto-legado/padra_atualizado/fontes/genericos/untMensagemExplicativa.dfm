inherited frmMensagemExplicativa: TfrmMensagemExplicativa
  Width = 706
  Height = 333
  BorderStyle = bsDialog
  Caption = 'Instru'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 706
  ExplicitHeight = 333
  PixelsPerInch = 96
  TextHeight = 14
  object RitchObservacao: TRichEdit [0]
    Left = 0
    Top = 0
    Width = 700
    Height = 260
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Consolas'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Visible = False
    Zoom = 100
  end
  inherited pnlBotoes: TPanel
    Top = 260
    Width = 700
    ExplicitTop = 260
    ExplicitWidth = 700
    inherited FlwBotoes: TFlowPanel
      Width = 696
      ExplicitWidth = 696
      object btnAuxiliar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 87
        Height = 23
        Caption = 'btnAuxiliar'
        TabOrder = 0
        Visible = False
        OnClick = btnAuxiliarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 617
      ExplicitLeft = 617
    end
  end
  inherited pnlStatus: TPanel
    Top = 288
    Width = 700
    ExplicitTop = 288
    ExplicitWidth = 700
    inherited pnlNomeForm: TPanel
      Left = 529
      ExplicitLeft = 529
    end
    inherited pnlInfo: TPanel
      Width = 529
      ExplicitWidth = 529
    end
  end
  object mmoInstru: TMemo [3]
    Left = 0
    Top = 0
    Width = 700
    Height = 260
    Align = alClient
    Color = clCream
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
