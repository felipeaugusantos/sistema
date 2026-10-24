inherited frmPedeObserv: TfrmPedeObserv
  Height = 132
  Caption = 'Informe a observa'#231#227'o'
  ExplicitHeight = 132
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 61
    TabOrder = 1
    ExplicitTop = 61
    inherited FlwBotoes: TFlowPanel
      Width = 402
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
  inherited pnlStatus: TPanel
    Top = 87
    TabOrder = 2
  end
  object edtObserv: TEditFocus [3]
    Left = 19
    Top = 16
    Width = 441
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 50
    TipoTexto = ttAlfanumerico
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 96
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 104
  end
end
