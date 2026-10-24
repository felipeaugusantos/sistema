inherited frmCadGrupoOcorrencias: TfrmCadGrupoOcorrencias
  Width = 685
  Height = 192
  Caption = 'Cadastro de Grupos de Ocorr'#234'ncias'
  ExplicitWidth = 685
  ExplicitHeight = 192
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 119
    Width = 679
    ExplicitTop = 119
    ExplicitWidth = 679
    inherited FlwBotoes: TFlowPanel
      Width = 438
      ExplicitLeft = -4
      ExplicitTop = -2
      ExplicitWidth = 438
      inherited btnIncluir: TBitBtnLocked
        Width = 70
        Height = 24
        Align = alLeft
        ExplicitWidth = 70
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Left = 70
        Width = 70
        Height = 24
        Align = alLeft
        ExplicitLeft = 70
        ExplicitWidth = 70
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 140
        Width = 70
        Height = 24
        Align = alLeft
        ExplicitLeft = 140
        ExplicitWidth = 70
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 210
        Width = 70
        Height = 24
        Align = alLeft
        ExplicitLeft = 210
        ExplicitWidth = 70
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Left = 280
        Width = 70
        Height = 24
        Align = alLeft
        ExplicitLeft = 280
        ExplicitWidth = 70
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 350
        Width = 76
        Height = 24
        Align = alLeft
        ExplicitLeft = 350
        ExplicitWidth = 76
        ExplicitHeight = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 611
      Width = 66
      Height = 24
      Align = alRight
      TabOrder = 3
      ExplicitLeft = 611
      ExplicitWidth = 66
      ExplicitHeight = 24
    end
    object btnImportar: TBitBtnLocked
      Left = 539
      Top = 2
      Width = 72
      Height = 24
      Align = alRight
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
      TabOrder = 2
      OnClick = btnImportarClick
    end
    object btnDirAce: TBitBtnLocked
      Left = 440
      Top = 2
      Width = 99
      Height = 24
      Align = alRight
      Caption = 'Direito de Acesso'
      Enabled = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = btnDirAceClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 679
    Height = 119
    ExplicitWidth = 679
    ExplicitHeight = 119
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 671
      ExplicitHeight = 87
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 679
    Height = 119
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 32
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 16
      Top = 41
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object pnlImgPro: TPanel
      Left = 510
      Top = 7
      Width = 143
      Height = 93
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object imgPro: TImage
        Left = 4
        Top = 4
        Width = 131
        Height = 81
        Align = alClient
        Center = True
        IncrementalDisplay = True
        Proportional = True
        Stretch = True
        ExplicitLeft = 9
        ExplicitWidth = 93
        ExplicitHeight = 55
      end
    end
    object dbeDesGoc: TDBEditFocus
      Tag = 99
      Left = 69
      Top = 37
      Width = 420
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GOC_DESGOC'
      DataSource = dtsCadGoc
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
      Left = 69
      Top = 13
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GOC_CODGOC'
      DataSource = dtsCadGoc
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object grbUsarEm: TGroupBox
      Left = 69
      Top = 61
      Width = 372
      Height = 39
      Caption = 'Permitir utilizar em:'
      TabOrder = 3
      object dbcUsaCli: TDBCheckBox
        Left = 8
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Cliente'
        DataField = 'GOC_USACLI'
        DataSource = dtsCadGoc
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dbcUsaCliClick
      end
      object dbcUsaPro: TDBCheckBox
        Tag = 1
        Left = 142
        Top = 16
        Width = 97
        Height = 17
        Caption = 'Prospecto'
        DataField = 'GOC_USAPRO'
        DataSource = dtsCadGoc
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dbcUsaCliClick
      end
      object dbcUsaFor: TDBCheckBox
        Tag = 2
        Left = 276
        Top = 16
        Width = 77
        Height = 17
        Caption = 'Fornecedor'
        DataField = 'GOC_USAFOR'
        DataSource = dtsCadGoc
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dbcUsaCliClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 147
    Width = 679
    ExplicitTop = 147
    ExplicitWidth = 679
    inherited pnlNomeForm: TPanel
      Left = 464
      Width = 215
      ExplicitLeft = 464
      ExplicitWidth = 215
    end
    inherited pnlInfo: TPanel
      Width = 464
      ExplicitWidth = 332
    end
  end
  object dtsCadGoc: TDataSource
    Left = 248
  end
  object SalvaImagem: TSavePictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg'
    Left = 344
  end
end
