inherited frmEntPreNotaEntradaMotivoLib: TfrmEntPreNotaEntradaMotivoLib
  Caption = 'Motivo da Libera'#231#227'o'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    inherited FlwBotoes: TFlowPanel
      Width = 402
      ExplicitTop = 2
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Align = alRight
    end
  end
  object mmoMotivo: TMemoFocus [2]
    Left = 8
    Top = 8
    Width = 467
    Height = 172
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    OnKeyPress = mmoMotivoKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    StringQuebra = '<<csq>>'
  end
end
