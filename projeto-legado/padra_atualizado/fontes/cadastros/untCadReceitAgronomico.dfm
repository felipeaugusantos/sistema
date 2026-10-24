inherited frmCadReceitAgronomico: TfrmCadReceitAgronomico
  Left = 269
  Top = 124
  Width = 940
  Height = 570
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Receitu'#225'rio Agron'#244'mico'
  Position = poMainFormCenter
  ExplicitWidth = 940
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 525
    Width = 934
    ExplicitTop = 525
    ExplicitWidth = 934
    DesignSize = (
      934
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 930
      ExplicitWidth = 930
    end
    inherited btnSair: TBitBtnLocked
      Left = 686
      Top = -166
      ExplicitLeft = 686
      ExplicitTop = -166
    end
  end
  inherited pnlStatus: TPanel
    Top = 525
    Width = 934
    ExplicitTop = 525
    ExplicitWidth = 934
    inherited pnlNomeForm: TPanel
      Left = 763
      ExplicitLeft = 763
    end
    inherited pnlInfo: TPanel
      Width = 763
      ExplicitWidth = 763
    end
  end
  inherited pgcDados: TPageControl
    Width = 934
    Height = 525
    ExplicitWidth = 934
    ExplicitHeight = 525
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 926
      ExplicitHeight = 493
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 934
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object lblNumero: TLabel
      Left = 627
      Top = 233
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero:'
    end
    object lblCodVen: TLabel
      Left = 88
      Top = 20
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblCodPdc: TLabel
      Left = 91
      Top = 44
      Width = 37
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cultura:'
    end
    object lbl1: TLabel
      Left = 373
      Top = 46
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Art. Nro.:'
    end
    object lbl2: TLabel
      Left = 69
      Top = 89
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Diagn'#243'stico:'
    end
    object lbl5: TLabel
      Left = 48
      Top = 113
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome Comercial:'
    end
    object lbl6: TLabel
      Left = 54
      Top = 137
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo Qu'#237'mico:'
    end
    object lbl7: TLabel
      Left = 569
      Top = 137
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Classe Toxicol'#243'gica:'
    end
    object lbl8: TLabel
      Left = 36
      Top = 233
      Width = 92
      Height = 14
      Alignment = taRightJustify
      Caption = #193'rea de Aplica'#231#227'o:'
    end
    object lbl9: TLabel
      Left = 567
      Top = 185
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de Car'#234'ncia:'
    end
    object lbl10: TLabel
      Left = 22
      Top = 321
      Width = 106
      Height = 14
      Alignment = taRightJustify
      Caption = 'Manejo Integr. Pragas:'
    end
    object lbl11: TLabel
      Left = 57
      Top = 161
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Concentra'#231#227'o:'
    end
    object lbl12: TLabel
      Left = 69
      Top = 185
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Formula'#231#227'o:'
    end
    object lbl13: TLabel
      Left = 711
      Top = 233
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total a Adquirir:'
    end
    object lbl3: TLabel
      Left = 30
      Top = 209
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dosagem Aplica'#231#227'o:'
    end
    object lbl4: TLabel
      Left = 565
      Top = 113
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Intervalo / Apl.Padra.:'
    end
    object lbl14: TLabel
      Left = 21
      Top = 258
      Width = 107
      Height = 14
      Alignment = taRightJustify
      Caption = 'Modalidade Aplica'#231#227'o:'
    end
    object lbl15: TLabel
      Left = 30
      Top = 282
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = #201'poca de Aplica'#231#227'o:'
    end
    object Bevel1: TBevel
      Left = 10
      Top = 72
      Width = 910
      Height = 1
    end
    object lblPriAti: TLabel
      Left = 597
      Top = 161
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Princ'#237'pio Ativo:'
    end
    object btnTotAdq: TSpeedButton
      Left = 896
      Top = 230
      Width = 21
      Height = 22
      Hint = 'Calcular Total a Adquirir'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
        0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
        9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000080808080808
        0808080808080808080808080808080808080808080808080808080101010101
        0101010101010101010805090909090909090909090909090901050C09090B09
        090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
        090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
        0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
        0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
        0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
        0808080808080808080808080808080808080808080808080808}
      ParentShowHint = False
      ShowHint = True
      OnClick = btnTotAdqClick
    end
    object Label4: TLabel
      Left = 602
      Top = 209
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Especificada:'
    end
    object pnlButtons: TPanel
      Left = 0
      Top = 495
      Width = 934
      Height = 30
      Align = alBottom
      BevelOuter = bvLowered
      BorderWidth = 3
      Color = clGray
      ParentBackground = False
      TabOrder = 23
      ExplicitLeft = 6
      ExplicitTop = 525
      object FlwPnlButtons: TFlowPanel
        Left = 4
        Top = 4
        Width = 610
        Height = 22
        Align = alLeft
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object btnConfirmar: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 85
          Height = 22
          Align = alLeft
          Caption = '[ F10 ] Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
        end
        object btnPesquisar: TBitBtnLocked
          Left = 85
          Top = 0
          Width = 75
          Height = 22
          Align = alLeft
          Caption = '&Pesquisar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
            CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
            1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
            D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
            7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
            E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
            EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
            8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 1
          OnClick = btnPesquisarClick
        end
        object btnImprimir: TBitBtnLocked
          Left = 160
          Top = 0
          Width = 75
          Height = 22
          Align = alLeft
          Caption = '[ F7 ] Imprimir'
          TabOrder = 2
          Visible = False
          OnClick = btnImprimirClick
        end
        object btnReimprimir: TBitBtnLocked
          Left = 235
          Top = 0
          Width = 85
          Height = 22
          Align = alLeft
          Caption = '[ F8 ] Reimprimir'
          TabOrder = 3
          OnClick = btnReimprimirClick
        end
        object btnExpCrea: TBitBtnLocked
          Left = 320
          Top = 0
          Width = 125
          Height = 22
          Align = alLeft
          Caption = '[ F2 ] Exportar CREA-SP'
          TabOrder = 4
          OnClick = btnExpCreaClick
        end
        object btnExpFitoSan: TBitBtnLocked
          Left = 445
          Top = 0
          Width = 155
          Height = 22
          Align = alLeft
          Caption = '[ F3 ] Exportar FITOSANITARIO'
          TabOrder = 5
          OnClick = btnExpFitoSanClick
        end
      end
      object BitBtn1: TBitBtnLocked
        Left = 862
        Top = 4
        Width = 68
        Height = 22
        Align = alRight
        Caption = '&Sair'
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100000001000000520000006B
          0000006B0800106B0800008C080000940800007B100000731800087B180008A5
          1800089C21001094290010A529001084310010A5310018A5310010A539001884
          4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
          4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
          5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
          AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
          BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
          CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
          D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
          DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
          F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
          FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
          FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
          5959595959595959595932514E32323232325959595959595959325266655F5F
          5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
          1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
          21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
          44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
          372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
          4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
          6A4A231B59595959595959592626262626262359595959595959}
        TabOrder = 1
        OnClick = btnSairClick
      end
    end
    object edtNumApl: TEditFocus
      Tag = 99
      Left = 673
      Top = 229
      Width = 30
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 134
      Top = 16
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnEnter = edtCodIteEnter
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 198
      Top = 16
      Width = 294
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtCultur: TEditFocus
      Tag = 99
      Left = 134
      Top = 40
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 3
      OnEnter = edtCulturEnter
      OnKeyPress = edtCulturKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
    object edtArtigo: TEditFocus
      Tag = 99
      Left = 423
      Top = 42
      Width = 198
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
    object pnlNovReg: TPanel
      Left = 498
      Top = 16
      Width = 123
      Height = 22
      BevelInner = bvLowered
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object lblNovaOrdem: TLabel
        Left = 10
        Top = 2
        Width = 103
        Height = 18
        Caption = 'Novo Registro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
    end
    object edtDiagno: TEditFocus
      Tag = 99
      Left = 134
      Top = 85
      Width = 763
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 100
      TipoTexto = ttAlfanumerico
    end
    object edtNomCom: TEditFocus
      Tag = 99
      Left = 134
      Top = 109
      Width = 420
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 16
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 16
      TipoTexto = ttAlfanumerico
    end
    object edtGruQui: TEditFocus
      Tag = 99
      Left = 134
      Top = 133
      Width = 420
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 50
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 50
      TipoTexto = ttAlfanumerico
    end
    object edtClaTox: TEditFocus
      Tag = 99
      Left = 673
      Top = 133
      Width = 224
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtAreRec: TEditFocus
      Tag = 99
      Left = 134
      Top = 229
      Width = 486
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 80
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 80
      TipoTexto = ttAlfanumerico
    end
    object edtPerCar: TEditFocus
      Tag = 99
      Left = 673
      Top = 181
      Width = 224
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 40
      TipoTexto = ttAlfanumerico
    end
    object edtManPra: TEditFocus
      Tag = 99
      Left = 134
      Top = 317
      Width = 763
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      TabOrder = 21
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 40
      TipoTexto = ttAlfanumerico
    end
    object edtConcen: TEditFocus
      Tag = 99
      Left = 134
      Top = 157
      Width = 420
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 30
      TipoTexto = ttAlfanumerico
    end
    object edtFormul: TEditFocus
      Tag = 99
      Left = 134
      Top = 181
      Width = 420
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 30
      TipoTexto = ttAlfanumerico
    end
    object edtTotAdq: TEditFocus
      Tag = 99
      Left = 791
      Top = 229
      Width = 106
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 18
      OnExit = edtTotAdqExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.000'
    end
    object edtDosApl: TEditFocus
      Tag = 99
      Left = 134
      Top = 205
      Width = 420
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 60
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 60
      TipoTexto = ttAlfanumerico
    end
    object edtIntApl: TEditFocus
      Tag = 99
      Left = 673
      Top = 109
      Width = 224
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 15
      TipoTexto = ttAlfanumerico
    end
    object edtModApl: TEditFocus
      Tag = 99
      Left = 134
      Top = 254
      Width = 763
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 100
      TipoTexto = ttAlfanumerico
    end
    object mmoEpoApl: TMemoFocus
      Tag = 99
      Left = 134
      Top = 278
      Width = 763
      Height = 37
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 200
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtPriAti: TEditFocus
      Tag = 99
      Left = 673
      Top = 157
      Width = 224
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 30
      TipoTexto = ttAlfanumerico
    end
    object grpDadosAdd: TGroupBox
      Left = 18
      Top = 341
      Width = 879
      Height = 145
      Caption = 'Dados Adicionais'
      TabOrder = 22
      DesignSize = (
        879
        145)
      object Label1: TLabel
        Left = 17
        Top = 24
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sintomas / Alarmes:'
      end
      object Label2: TLabel
        Left = 6
        Top = 62
        Width = 106
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ant'#237'doto / Tratamento:'
      end
      object Label3: TLabel
        Left = 43
        Top = 101
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Observa'#231#245'es:'
      end
      object mmoAlarme: TMemoFocus
        Left = 116
        Top = 24
        Width = 747
        Height = 35
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object mmoAntido: TMemoFocus
        Left = 116
        Top = 62
        Width = 747
        Height = 35
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object mmoObserv: TMemoFocus
        Left = 116
        Top = 101
        Width = 747
        Height = 35
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
    object edtDosEsp: TEditFocus
      Tag = 99
      Left = 673
      Top = 205
      Width = 224
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 20
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 640
    Top = 8
  end
end
