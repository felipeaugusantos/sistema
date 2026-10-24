inherited frmInfAdicEtiqItens: TfrmInfAdicEtiqItens
  Width = 454
  Height = 115
  Caption = 'Informa'#231#227'o Adicional Etiqueta de Itens'
  ExplicitWidth = 454
  ExplicitHeight = 115
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 44
    Width = 448
    TabOrder = 1
    ExplicitTop = 44
    ExplicitWidth = 448
    inherited FlwBotoes: TFlowPanel
      Width = 367
    end
    inherited btnSair: TBitBtnLocked
      Left = 369
      Top = 2
      Align = alRight
      ExplicitLeft = 369
      ExplicitTop = -2
    end
  end
  object edtInfAdi: TEditFocus [2]
    Tag = 99
    Left = 8
    Top = 8
    Width = 429
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 70
    Width = 448
    TabOrder = 2
    ExplicitTop = 70
    ExplicitWidth = 448
    inherited pnlNomeForm: TPanel
      Left = 277
      ExplicitLeft = 277
    end
    inherited pnlInfo: TPanel
      Width = 277
      ExplicitWidth = 277
    end
  end
end
