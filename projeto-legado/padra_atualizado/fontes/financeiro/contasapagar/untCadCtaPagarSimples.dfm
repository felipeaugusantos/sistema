inherited frmCadCtaPagarSimples: TfrmCadCtaPagarSimples
  Height = 155
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeable
  Caption = 'Cadastro Conta a Pagar FLEX'
  ExplicitHeight = 155
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 473
    TabOrder = 1
    ExplicitTop = 74
    ExplicitWidth = 473
    inherited FlwBotoes: TFlowPanel
      Width = 469
      ExplicitWidth = 469
    end
    inherited btnSair: TBitBtnLocked
      Left = 393
      ExplicitLeft = 393
    end
  end
  inherited pnlStatus: TPanel
    Top = 100
    Width = 473
    TabOrder = 2
    ExplicitTop = 100
    ExplicitWidth = 473
    inherited pnlNomeForm: TPanel
      Left = 302
      ExplicitLeft = 302
    end
    inherited pnlInfo: TPanel
      Width = 302
      ExplicitWidth = 302
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 473
    Height = 74
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblVencimento: TLabel
      Left = 32
      Top = 32
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vencimento:'
    end
    object lblPortador: TLabel
      Left = 47
      Top = 55
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblPlanoContas: TLabel
      Left = 10
      Top = 10
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Plano de Contas:'
    end
    object edtNomCta: TEditFocus
      Left = 149
      Top = 5
      Width = 325
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomPor: TEditFocus
      Left = 149
      Top = 51
      Width = 325
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 93
      Top = 51
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object mskDtaVenc: TMaskEditFocus
      Tag = 99
      Left = 93
      Top = 28
      Width = 86
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodCta: TMaskEditFocus
      Tag = 99
      Left = 93
      Top = 5
      Width = 55
      Height = 22
      EditMask = '99.99.999;0;_'
      MaxLength = 9
      TabOrder = 0
      Text = ''
      OnKeyPress = edtCodCtaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
end
