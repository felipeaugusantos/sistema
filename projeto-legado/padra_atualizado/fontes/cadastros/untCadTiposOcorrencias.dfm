inherited frmCadTiposOcorrencias: TfrmCadTiposOcorrencias
  Width = 751
  Height = 360
  Caption = 'Cadastro de Tipos de Ocorr'#234'ncias'
  ExplicitWidth = 751
  ExplicitHeight = 360
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 290
    Width = 745
    Height = 25
    ExplicitTop = 290
    ExplicitWidth = 745
    ExplicitHeight = 25
    DesignSize = (
      745
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 741
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 741
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        ExplicitWidth = 83
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        ExplicitLeft = 83
        ExplicitWidth = 83
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        ExplicitLeft = 166
        ExplicitWidth = 83
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        ExplicitLeft = 249
        ExplicitWidth = 83
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 86
        ExplicitLeft = 332
        ExplicitWidth = 86
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 418
        Width = 86
        ExplicitLeft = 418
        ExplicitWidth = 86
      end
      object btnImportar: TBitBtnLocked
        Left = 504
        Top = 0
        Width = 83
        Height = 20
        Anchors = [akLeft, akBottom]
        Caption = 'I&magem'
        Glyph.Data = {
          06030000424D0603000000000000060200002800000010000000100000000100
          08000000000000010000120B0000120B0000740000007400000000000000FFFF
          FF00FF00FF00E3462E00EE483200F34A3500F24A3500F04B3500F4533B00DE43
          2700D8422300D3412300E54A2D00E9583A00F8654500BD3E1F00D0462300EB5A
          3900F05E3E00F86C4900FA6E4B00BF3B1600B23B1C00ED664000811E0000BF3A
          1200B03F1C00E15D35007E230300932A0700B5370C00C74D220096452800982F
          0300982F0400AB350700B03E1000BB451800AA481A00B0A7A300AA4F2100805B
          4500DDB69E00F8F0EB003980A400075C8C00B0C4D0000246740002436F00083B
          5C00275E82000C3F64000D304B001A22280001244100022D5000022A4B00032D
          500007335700093962000C416C0016599100237AC400319EFB0033A0FB00011F
          3A00011E3700022341001B6CB8002077C4002D98FB002E99FB002E9AFB002D97
          FA00309CFB00053A6F0005396D000A417800115190002890FA002891FA002992
          FA002A92FA002A93FA002B95FA001437580004356800042B5400094583001C79
          E1002389FA002287F800248AFA00268CFA00288FFA001D7DF4001A72DA001F80
          F6002083F8002184F8002387FA00073D8300094289001D7AF2000D4EAB00186D
          E600186BE500186CE5001869DC001A72EB001A70EA000C48A5000E4EB0001663
          DC001154C700FFFFFF0002020218181818181818182102020202020218230A04
          05081115060B180202020202181E09070E141F2810030F180202020218190C13
          1417262B240D1618020202022118121414242A0124141A18020202020221181B
          20292E2725141D22020202020202353466706F65551C2102020202020242576C
          6D6E6A71725602020202020202436063645B62676B68020202020202424D5D50
          52515E5A61694B0202020202424E5446484749515C5F4C02020202024242363C
          3F3F4A494F594B0202020202422F303B40403F4853584B020202020202422D31
          3A3D3E4544390202020202020242422C32333738414202020202020202020242
          42424241420202020202}
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        OnClick = btnImportarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 664
      Width = 71
      Height = 20
      ExplicitLeft = 664
      ExplicitWidth = 71
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 315
    Width = 745
    ExplicitTop = 315
    ExplicitWidth = 745
    inherited pnlNomeForm: TPanel
      Left = 555
      Width = 190
      ExplicitLeft = 555
      ExplicitWidth = 190
    end
    inherited pnlInfo: TPanel
      Width = 555
      ExplicitWidth = 555
    end
  end
  inherited pgcDados: TPageControl
    Width = 745
    Height = 290
    ExplicitWidth = 745
    ExplicitHeight = 290
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 737
      ExplicitHeight = 258
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 745
    Height = 290
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 200
      Top = 22
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 184
      Top = 46
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 146
      Top = 70
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Ocorr'#234'ncia:'
    end
    object Label4: TLabel
      Left = 208
      Top = 95
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo:'
    end
    object ColorLabel22: TColorLabel
      Left = 281
      Top = 95
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 113
      Top = 167
      Width = 123
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tempo limite p/ resolu'#231#227'o:'
    end
    object Label6: TLabel
      Left = 297
      Top = 167
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Horas/Minutos'
    end
    object Label7: TLabel
      Left = 56
      Top = 118
      Width = 180
      Height = 14
      Alignment = taRightJustify
      Caption = 'Enviar ocorr'#234'ncia por e-mail - Cliente:'
    end
    object ColorLabel1: TColorLabel
      Left = 281
      Top = 118
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblEmailDestino: TLabel
      Left = 12
      Top = 142
      Width = 224
      Height = 14
      Alignment = taRightJustify
      Caption = 'Enviar ocorr'#234'ncia por e-mail - Usu'#225'rio Destino:'
    end
    object lblDescEmailDestino: TColorLabel
      Left = 281
      Top = 142
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblSolTempAtendimento: TLabel
      Left = 44
      Top = 240
      Width = 187
      Height = 14
      Alignment = taRightJustify
      Caption = 'Solicitar Temperatura do Atendimento ?'
    end
    object lblIdentSolTempAtendimento: TColorLabel
      Left = 282
      Top = 240
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblGerCom: TLabel
      Left = 129
      Top = 265
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Gerar Compromisso?'
    end
    object cllGerCom: TColorLabel
      Left = 282
      Top = 265
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeCodGoc: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 67
      Width = 63
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_CODGOC'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnExit = dbeCodGocExit
      OnKeyPress = dbeCodGocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtDesCodGoc: TEditFocus
      Tag = 99
      Left = 302
      Top = 67
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlImgPro: TPanel
      Left = 629
      Top = 22
      Width = 105
      Height = 67
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 7
      object imgPro: TImage
        Left = 4
        Top = 4
        Width = 93
        Height = 55
        Align = alClient
        Center = True
        IncrementalDisplay = True
        Proportional = True
        Stretch = True
        ExplicitLeft = 9
      end
    end
    object dbeDesToc: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 43
      Width = 381
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_DESTOC'
      DataSource = dtsCadToc
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 18
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_CODTOC'
      DataSource = dtsCadToc
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeAtivo: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 91
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_ATIVO_'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeTmpLim: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 163
      Width = 54
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_TMPLIM'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object grbUsarEm: TGroupBox
      Left = 237
      Top = 191
      Width = 422
      Height = 39
      Caption = 'Permitir utilizar em:'
      TabOrder = 9
      object dbcUsaCli: TDBCheckBox
        Left = 8
        Top = 16
        Width = 55
        Height = 17
        Caption = 'Cliente'
        DataField = 'TOC_USACLI'
        DataSource = dtsCadToc
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcUsaPro: TDBCheckBox
        Tag = 1
        Left = 73
        Top = 16
        Width = 71
        Height = 17
        Caption = 'Prospecto'
        DataField = 'TOC_USAPRO'
        DataSource = dtsCadToc
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcUsaFor: TDBCheckBox
        Tag = 2
        Left = 154
        Top = 16
        Width = 79
        Height = 17
        Caption = 'Fornecedor'
        DataField = 'TOC_USAFOR'
        DataSource = dtsCadToc
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbcUsaGlo: TDBCheckBox
        Tag = 2
        Left = 241
        Top = 16
        Width = 176
        Height = 17
        Caption = 'Gera'#231#227'o Global de Ocorr'#234'ncias'
        DataField = 'TOC_USAGLO'
        DataSource = dtsCadToc
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object dbeEnvEma: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 115
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_ENVEMA'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeEnvEmaDest: TDBEditFocus
      Tag = 99
      Left = 238
      Top = 139
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_EMADES'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeSolTempAtend: TDBEditFocus
      Tag = 99
      Left = 237
      Top = 237
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_TMPATD'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeGerCom: TDBEditFocus
      Tag = 99
      Left = 237
      Top = 262
      Width = 39
      Height = 22
      CharCase = ecUpperCase
      DataField = 'TOC_GERCOM'
      DataSource = dtsCadToc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 88
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 88
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 8
  end
  object dtsCadToc: TDataSource
    Left = 32
    Top = 56
  end
  object SalvaImagem: TSavePictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg'
    Left = 696
    Top = 104
  end
end
