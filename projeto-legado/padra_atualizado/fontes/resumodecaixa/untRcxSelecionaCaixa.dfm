inherited frmRcxSelecionaCaixa: TfrmRcxSelecionaCaixa
  Width = 529
  Height = 121
  Caption = 'Selecione o Caixa de Destino'
  ExplicitWidth = 529
  ExplicitHeight = 121
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 50
    Width = 523
    TabOrder = 1
    ExplicitTop = 50
    ExplicitWidth = 523
    inherited FlwBotoes: TFlowPanel
      Width = 519
      ExplicitTop = 2
      ExplicitWidth = 519
    end
    inherited btnSair: TBitBtnLocked
      Left = 443
      ExplicitLeft = 443
    end
  end
  inherited pnlStatus: TPanel
    Top = 76
    Width = 523
    TabOrder = 2
    ExplicitTop = 76
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 352
      ExplicitLeft = 352
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 523
    Height = 50
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 16
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Caixa Destino:'
    end
    object edtCodigoCaixa: TEditFocus
      Tag = 99
      Left = 87
      Top = 13
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodigoCaixaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDescricaoCaixa: TEditFocus
      Left = 155
      Top = 13
      Width = 350
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
