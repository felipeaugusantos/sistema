inherited frmSolicitaLocalizacaoFisicaTransitoria: TfrmSolicitaLocalizacaoFisicaTransitoria
  Width = 692
  Height = 186
  Caption = 'Localiza'#231#227'o F'#237'sica Transit'#243'ria'
  ExplicitWidth = 692
  ExplicitHeight = 186
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 115
    Width = 686
    TabOrder = 2
    ExplicitTop = 115
    ExplicitWidth = 686
    inherited FlwBotoes: TFlowPanel
      Width = 682
      ExplicitTop = 2
      ExplicitWidth = 682
    end
    inherited btnSair: TBitBtnLocked
      Left = 606
      ExplicitLeft = 606
    end
  end
  inherited pnlStatus: TPanel
    Top = 141
    Width = 686
    TabOrder = 3
    ExplicitTop = 141
    ExplicitWidth = 686
    inherited pnlNomeForm: TPanel
      Left = 515
      ExplicitLeft = 515
    end
    inherited pnlInfo: TPanel
      Width = 515
      ExplicitWidth = 515
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 686
    Height = 36
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblMensagem: TLabel
      Left = 1
      Top = 1
      Width = 684
      Height = 34
      Align = alClient
      Caption = 
        '     Informe a localiza'#231#227'o f'#237'sica transit'#243'ria para transfer'#234'ncia' +
        ' dos produtos separados'
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 483
      ExplicitHeight = 15
    end
  end
  object pnlLocalizacao: TPanel [4]
    Left = 0
    Top = 36
    Width = 686
    Height = 79
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 30
      Width = 92
      Height = 14
      Caption = 'Localiza'#231#227'o F'#237'sica:'
    end
    object edtCodigoLocalizacaoFisica: TEditFocus
      Tag = 99
      Left = 110
      Top = 27
      Width = 134
      Height = 22
      HelpType = htKeyword
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 0
      OnKeyPress = edtCodigoLocalizacaoFisicaKeyPress
      OnKeyUp = edtCodigoLocalizacaoFisicaKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescricaoLocalizacaoFisica: TEditFocus
      Left = 246
      Top = 27
      Width = 423
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
