inherited frmCrmSelCliente: TfrmCrmSelCliente
  Width = 594
  Height = 125
  Caption = 'Selecionar Cliente'
  ExplicitWidth = 594
  ExplicitHeight = 125
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 54
    Width = 588
    TabOrder = 1
    inherited FlwBotoes: TFlowPanel
      Width = 584
    end
    inherited btnSair: TBitBtnLocked
      Left = 508
    end
  end
  inherited pnlStatus: TPanel
    Top = 80
    Width = 588
    TabOrder = 2
    inherited pnlNomeForm: TPanel
      Left = 417
    end
    inherited pnlInfo: TPanel
      Width = 417
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 588
    Height = 54
    Align = alClient
    Color = 16770261
    TabOrder = 0
    ExplicitLeft = -102
    ExplicitWidth = 585
    ExplicitHeight = 55
    object lblCliente: TLabel
      Left = 6
      Top = 6
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 6
      Top = 21
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 80
      Top = 21
      Width = 498
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
end
