inherited frmCadEmbSayerLack: TfrmCadEmbSayerLack
  Width = 615
  Height = 198
  Caption = 'Cadastro de Embalagens - Sayerlack'
  OnActivate = FormActivate
  ExplicitWidth = 615
  ExplicitHeight = 198
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 126
    Width = 609
    TabOrder = 2
    ExplicitTop = 126
    ExplicitWidth = 609
    DesignSize = (
      609
      28)
    inherited btnSair: TBitBtnLocked
      Left = 533
      ExplicitLeft = 533
    end
    inherited btnCancela: TBitBtnLocked
      TabOrder = 4
    end
    inherited btnExcluir: TBitBtnLocked
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 154
    Width = 609
    TabOrder = 3
    ExplicitTop = 154
    ExplicitWidth = 609
    inherited pnlNomeForm: TPanel
      Left = 262
      TabOrder = 1
      ExplicitLeft = 262
    end
    inherited pnlInfo: TPanel
      Width = 262
      TabOrder = 0
      ExplicitWidth = 262
    end
  end
  inherited pgcDados: TPageControl
    Width = 609
    Height = 126
    TabOrder = 1
    ExplicitWidth = 609
    ExplicitHeight = 126
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 601
      ExplicitHeight = 94
    end
  end
  object pnlCampos: TPanel [3]
    Left = 0
    Top = 0
    Width = 609
    Height = 126
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    object lblEmbalagem: TLabel
      Left = 26
      Top = 37
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Embalagem:'
    end
    object lblTamanho: TLabel
      Left = 37
      Top = 65
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tamanho:'
    end
    object lblUnidade: TLabel
      Left = 41
      Top = 94
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object dbeEmbalagem: TDBEditFocus
      Tag = 99
      Left = 89
      Top = 34
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_DESEMB'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTamanho: TDBEditFocus
      Tag = 99
      Left = 89
      Top = 62
      Width = 174
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EMB_EMBALA'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtUniDescri: TEditFocus
      Left = 160
      Top = 90
      Width = 342
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUniUni: TEditFocus
      Left = 496
      Top = 90
      Width = 57
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodUni: TDBEditFocus
      Tag = 99
      Left = 89
      Top = 90
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'EMB_CODUNI'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 2
      OnExit = dbeCodUniExit
      OnKeyPress = dbeCodUniKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 609
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Cadastro de Embalagens - Sayerlack '
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 48
  end
end
