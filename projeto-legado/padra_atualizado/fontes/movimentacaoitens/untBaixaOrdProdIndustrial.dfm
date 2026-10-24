inherited frmBaixaOrdProdIndustrial: TfrmBaixaOrdProdIndustrial
  Width = 1024
  Height = 768
  BorderStyle = bsSizeable
  Caption = 'Baixa de Ordem de Produ'#231#227'o'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitTop = -95
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  object splEnvasado: TSplitter [0]
    Left = 0
    Top = 551
    Width = 1008
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    Color = clInfoBk
    ParentColor = False
    ExplicitLeft = 8
    ExplicitTop = 556
  end
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 1008
    Height = 28
    TabOrder = 3
    ExplicitTop = 685
    ExplicitWidth = 1008
    ExplicitHeight = 28
    object lblComFra: TLabel [0]
      Left = 250
      Top = 7
      Width = 492
      Height = 14
      Caption = 
        '* Para corrigir as quantidades da composi'#231#227'o, clique duplo na co' +
        'luna do envase que necessita ajuste.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      Height = 24
      ExplicitWidth = 1004
      ExplicitHeight = 24
      inherited btnConfirma: TBitBtnLocked
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ModalResult = 0
        ExplicitHeight = 24
      end
      object btnHisBai: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 132
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = '&Hist'#243'rico da baixa'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000008916948C0C89061FFC68D5DFFC389
          59FFC08556FFBE8252FFBC7F4EFFBA7C4BFFB87947FF825631C3000000000000
          00050000000C000000110000001400000021CC9768FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB77947FF000000000227
          3F7B044B7CE505558CFF04528AFF054D82FFCF9A6CFFFFFFFFFFFFFFFFFFD59A
          6CFFD29667FFCF9262FFCA8E5EFFFFFFFFFFFFFFFFFFBA7C4AFF000000000551
          81E31A8EBEFF18B9E6FF16B3E2FF13A8D5FFD19D70FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBC7F4EFF000000000660
          97FF38CAEFFF1EBEE9FF1BB9E6FF16AFDAFFD4A073FFFFFFFFFFFFFFFFFFDEA3
          75FFDA9F72FFD89C6EFFD4986AFFFFFFFFFFFFFFFFFFBE8252FF000000000765
          9CFF49D1F3FF24C3EDFF20BFEAFF1DB5E0FFD5A376FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC18556FF00000000086A
          A0FF5AD8F6FF2AC9F1FF28C5EEFF23BDE6FFC58350FFDBAE85FFD09869FFCE96
          67FFCC9363FFCB9060FFC98D5DFFC88B5AFFC68857FFB87340FF000000000970
          A6FF73E0F9FF3BD0F5FF35CDF2FF2EC4EAFFC68452FFE6C29FFFE6C19DFFE4BE
          9AFFE2BB97FFE0B892FFDEB58EFFDBB089FFD9AC84FFBA7541FF000000000A76
          ACFF8EE8FCFF4FD9F9FF49D6F7FF41D0F2FFA29579FFC78452FFC58350FFC481
          4FFFC3804EFFC17E4BFFC07C4AFFBE7A48FFBC7845FF8A5732C3000000000B7C
          B2FFA7EEFDFF64E0FCFF5FDDFBFF56D9F8FF4CD4F5FF43CCEEFF3ABFE1FF34BB
          DFFF31C2E4FF2DC7EBFF06578CFF0000001F0000000800000006000000000C84
          B7FFBCF3FEFF7CE7FEFF75E5FDFF6ADCF5FF5AC3DDFF50B4D0FF49B7D3FF41BF
          DEFF39C6E7FF35CEF0FF085D93FF000000150000000000000000000000000E8B
          BEFFCFF7FFFF92ECFFFF78C8DBFF62A8BDFF5CA4B9FF59ABC3FF54B5CEFF4DBD
          D9FF44C6E4FF3CCDEFFF096297FF000000110000000000000000000000001092
          C4FFDFFAFFFFC1864BFFBE8146FFBC7D40FFB9793BFFB67636FFB47233FFB270
          30FFB06D2EFF44D1F1FF09679DFF0000000E000000000000000000000000119A
          CBFFEAFBFFFFE9C190FFE6BA87FFE2B47EFFDFAE75FFDCA86DFFD9A267FFD69E
          60FFBA7A3DFF4EDFFEFF086DA2FF0000000B000000000000000000000000118E
          B8E084CDE7FFEEFCFFFFEAFAFDFFF0D5B0FFEFCB9EFFECC595FFE5C294FFA9EF
          FDFF95EDFEFF46B0D5FF096594E300000007000000000000000000000000094A
          5F701291BBE013A2D1FF129CCDFF7CBCC8FFFCE5C2FFF0DBB9FF7EA4A4FF0E86
          BAFF0D82B6FF0B6F9CE105364D75000000030000000000000000}
        TabOrder = 1
        OnClick = btnHisBaiClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      Top = 3
      ExplicitLeft = 928
      ExplicitTop = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1008
    TabOrder = 4
    ExplicitTop = 713
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object prgProgre: TProgressBar [3]
    Left = 0
    Top = 672
    Width = 1008
    Height = 13
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1008
    Height = 104
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Ordem de Produ'#231#227'o:'
    end
    object Label2: TLabel
      Left = 17
      Top = 60
      Width = 148
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data / Hora In'#237'cio da Produ'#231#227'o:'
    end
    object Label3: TLabel
      Left = 273
      Top = 60
      Width = 146
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data / Hora Final da Produ'#231#227'o:'
    end
    object lblDtaBai: TLabel
      Left = 95
      Top = 84
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data da Baixa:'
    end
    object Label5: TLabel
      Left = 125
      Top = 37
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
    end
    object lblDtaVal: TLabel
      Left = 235
      Top = 84
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Validade:'
    end
    object mskDtaCad: TMaskEditFocus
      Tag = 99
      Left = 205
      Top = 11
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumOrd: TEditFocus
      Left = 168
      Top = 11
      Width = 36
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtNumOrdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 168
      Top = 58
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnDblClick = mskDtaIniDblClick
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskHorIni: TMaskEditFocus
      Tag = 99
      Left = 233
      Top = 58
      Width = 34
      Height = 22
      EditMask = '!99:99;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      Text = '  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 422
      Top = 58
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskHorFin: TMaskEditFocus
      Tag = 99
      Left = 487
      Top = 58
      Width = 34
      Height = 22
      EditMask = '!99:99;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 5
      Text = '  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaBai: TMaskEditFocus
      Tag = 99
      Left = 168
      Top = 81
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object dbeCodIte: TDBEditFocus
      Left = 168
      Top = 34
      Width = 50
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'CODITE'
      DataSource = dtsOrdPro
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesIte: TDBEditFocus
      Left = 220
      Top = 34
      Width = 278
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsOrdPro
      Enabled = False
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 537
      Top = 5
      Width = 456
      Height = 40
      Caption = 'Legendas do Envase'
      TabOrder = 11
      object Shape1: TShape
        Left = 13
        Top = 20
        Width = 12
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clWindow
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label6: TLabel
        Left = 31
        Top = 21
        Width = 130
        Height = 14
        Caption = 'Envasado igual ao previsto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape2: TShape
        Left = 167
        Top = 20
        Width = 12
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clYellow
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label7: TLabel
        Left = 185
        Top = 21
        Width = 92
        Height = 14
        Caption = 'Envasado a menos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape3: TShape
        Left = 283
        Top = 21
        Width = 12
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clRed
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label8: TLabel
        Left = 301
        Top = 22
        Width = 82
        Height = 14
        Caption = 'Envasado a mais'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
    object rdgTipBai: TRadioGroup
      Left = 537
      Top = 47
      Width = 209
      Height = 31
      Caption = 'Tipo da Baixa'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Total'
        'Parcial')
      TabOrder = 6
      OnClick = rdgTipBaiClick
    end
    object mskDtaVal: TMaskEditFocus
      Tag = 99
      Left = 322
      Top = 81
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object pnlLocFis: TPanel
      Left = 427
      Top = 82
      Width = 550
      Height = 25
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 12
      object Label9: TLabel
        Left = 18
        Top = 5
        Width = 147
        Height = 14
        Alignment = taRightJustify
        Caption = 'Localiza'#231#227'o f'#237'sica da amostra:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtLocFis: TEditFocus
        Tag = 99
        Left = 168
        Top = 0
        Width = 98
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 0
        OnEnter = edtLocFisEnter
        OnExit = edtLocFisExit
        OnKeyPress = edtLocFisKeyPress
        OnKeyUp = edtLocFisKeyUp
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesLocFis: TEditFocus
        Left = 268
        Top = 0
        Width = 270
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
  object Panel2: TPanel [5]
    Left = 0
    Top = 157
    Width = 1008
    Height = 394
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    object Label11: TLabel
      Left = 0
      Top = 0
      Width = 1008
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'CORRE'#199#213'ES DA ORDEM DE PRODU'#199#195'O'
      ExplicitWidth = 203
    end
    object sltLotesDistribuidos: TSplitter
      Left = 0
      Top = 226
      Width = 1008
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      Color = clInfoBk
      ParentColor = False
      ExplicitLeft = 3
      ExplicitTop = 166
    end
    object Panel7: TPanel
      Left = 0
      Top = 14
      Width = 1008
      Height = 212
      Align = alClient
      TabOrder = 0
      object pnlCorrecao: TPanel
        Left = 1
        Top = 183
        Width = 1006
        Height = 28
        Align = alBottom
        BevelInner = bvLowered
        Color = clGray
        ParentBackground = False
        TabOrder = 0
        object btnIncluir: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 87
          Height = 24
          Align = alLeft
          Caption = '[ F5] Incluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          OnClick = btnIncluirClick
        end
        object btnExcluir: TBitBtnLocked
          Left = 185
          Top = 2
          Width = 104
          Height = 24
          Align = alLeft
          Caption = '[ F7 ] Excluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnExcluirClick
        end
        object btnAlterar: TBitBtnLocked
          Left = 89
          Top = 2
          Width = 96
          Height = 24
          Align = alLeft
          Caption = '[ F6 ] Alterar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
            CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
            A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
            820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
            860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
            C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
            D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
            9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 1
          OnClick = btnAlterarClick
        end
      end
      object cxgCorrecoes: TcxGrid
        Left = 1
        Top = 1
        Width = 1006
        Height = 182
        Align = alClient
        TabOrder = 1
        object cxgCorrecoesViewMATBOPNao: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          object cxgCorrecoesViewMATBOPNaoColumn1: TcxGridDBColumn
            Caption = 'IT'
            DataBinding.FieldName = 'DMT_SEQUEN'
            HeaderAlignmentHorz = taCenter
            SortIndex = 0
            SortOrder = soAscending
            Width = 46
          end
          object cxgCorrecoesViewMATBOPNaoColumn2: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DMT_ITESUB'
            HeaderAlignmentHorz = taCenter
            Width = 59
          end
          object cxgCorrecoesViewMATBOPNaoColumn3: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'DMT_REFERE'
            Width = 242
          end
          object cxgCorrecoesQTDITE: TcxGridDBColumn
            Caption = 'Quantidade (KG)'
            DataBinding.FieldName = 'DMT_QTDITE'
            HeaderAlignmentHorz = taRightJustify
            Width = 92
          end
          object cxgCorrecoesViewMATBOPNaoColumn5: TcxGridDBColumn
            Caption = 'Observa'#231#245'es'
            DataBinding.FieldName = 'DMT_OBSERV'
            OnGetDataText = cxgCorrecoesViewMATBOPNaoColumn5GetDataText
            OnGetDisplayText = cxgCorrecoesViewMATBOPNaoColumn5GetDisplayText
            Width = 334
          end
        end
        object cxgCorrecoesViewMATBOPSim: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgCorrecoesViewMATBOPSimCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          object cxgCorrecoesViewMATBOPSimIT: TcxGridDBColumn
            Caption = 'IT'
            DataBinding.FieldName = 'DMT_SEQUEN'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Options.Focusing = False
            Width = 26
          end
          object cxgCorrecoesViewMATBOPSimDESCRICAO: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DMT_REFERE'
            Options.Editing = False
            Options.Focusing = False
            Width = 353
          end
          object cxgCorrecoesViewMATBOPSimREFERENCIA: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERENCIA'
            Options.Editing = False
            Options.Focusing = False
            Width = 240
          end
          object cxgCorrecoesViewMATBOPSimQTDOP: TcxGridDBColumn
            Caption = 'Qtd. OP'
            DataBinding.FieldName = 'QTD_OP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Options.Focusing = False
            Width = 80
          end
          object cxgCorrecoesViewMATBOPSimQTDUTILIZADA: TcxGridDBColumn
            Caption = 'Qtd. Utilizada'
            DataBinding.FieldName = 'QTD_UTILIZADA'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            Properties.OnEditValueChanged = cxgCorrecoesViewMATBOPSimQTDUTILIZADAPropertiesEditValueChanged
            HeaderAlignmentHorz = taRightJustify
            Width = 80
          end
          object cxgCorrecoesViewMATBOPSimCORRECAO: TcxGridDBColumn
            Caption = 'Corre'#231#227'o'
            DataBinding.FieldName = 'DMT_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            Properties.OnEditValueChanged = cxgCorrecoesViewMATBOPSimCORRECAOPropertiesEditValueChanged
            HeaderAlignmentHorz = taRightJustify
            Width = 80
          end
          object cxgCorrecoesViewMATBOPSimExcluir: TcxGridDBColumn
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Glyph.SourceDPI = 96
                Glyph.SourceHeight = 10
                Glyph.SourceWidth = 10
                Glyph.Data = {
                  89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                  6100000029744558745469746C650052656D6F76653B44656C6574653B426172
                  733B526962626F6E3B5374616E646172643B635648300000026449444154785E
                  A551494C5351146568194A2B583746627F458902118892AAB811369246043462
                  8556D032A82D831664486D8C3FB40B8128E3C68998A289625720314469022591
                  26566BC484681C22C6012B5A1556C7F73EBF507FDCF193F3DFBBE7DC7BDE7BF7
                  86005811B820E80B2310F16B6880E4F7E10462AAF3F1B2014F889E961FBB307D
                  AAE2EBC8FEDC137C72280FB1AB546BA0DAE4F11296C491940F36089F2CD5593F
                  DFE8C682771453E71B31909D6D207C044D76166B8C339D1789E6C4A76B5D18D7
                  15D9A869B04184A744E7FBED72C03FD08EF9B13BF09CADC1F50C55CDE08182DA
                  B7ED562CB807E1BFDB06FF701F3C47753E52131D6C20B2EFCA343C31EAF1D3D1
                  89B93E167F1EF5E37155255ED92C989F70E0C74D96E3C734F9B89498749A1E2A
                  EC41644F4A6AF5B8F6107C7D2D98ED6D847FE80A7EDDBF8A6FBD4D98ED69C088
                  3A0BD678A589E44A843D089844DB141B4D0FF3D5F8D251878FAC9EA08C5B87F6
                  EC44B37C6D23C991F2530AF99F81E472BAAA7E42AFC307B612EFEA0E2FC1A52D
                  446B5A4633C991090D968A5B93D24D4EAD06336DF5982E5363BA9C07D9BF674F
                  62B4F020AC9B53976EF1CF145A36249B1EE4E5E28DA5022F8AB23045706B1383
                  DB498974CFE1F599620CAB736061B63409A720ED5624CFBD341E81B760379EE5
                  65A23F410183487ACE208EB1F42728E1CDCFE4F0BC641FBA9894395213176C10
                  655EA3EC706CDF06778E0A76C57A5447C8E87B63298C91B166BB92817BEF0EDC
                  4BDB8A0639D34DF8986083309A58278BEFB0C631BEAAC5E255940F6886A8D566
                  A27DAF95ADEB22B15CD883808984208E209A8F859A9C6F6078F0145684BF98E8
                  BFC080A205F60000000049454E44AE426082}
                Kind = bkGlyph
                Width = 20
              end>
            Properties.ViewStyle = vsButtonsOnly
            Properties.OnButtonClick = cxgCorrecoesViewMATBOPSimExcluirPropertiesButtonClick
            Options.ShowEditButtons = isebAlways
            Width = 25
            IsCaptionAssigned = True
          end
        end
        object cxgCorrecoesLevel1: TcxGridLevel
          GridView = cxgCorrecoesViewMATBOPSim
        end
      end
    end
    object pnlLotesDistribuidos: TPanel
      Left = 0
      Top = 230
      Width = 1008
      Height = 164
      Align = alBottom
      TabOrder = 1
      object Panel6: TPanel
        Left = 1
        Top = 144
        Width = 1006
        Height = 19
        Align = alBottom
        Padding.Left = 5
        Padding.Right = 2
        Padding.Bottom = 2
        TabOrder = 0
        object Label10: TLabel
          Left = 210
          Top = 1
          Width = 179
          Height = 15
          Align = alLeft
          Caption = '[Delete] - Para remover lote         '
          ExplicitHeight = 14
        end
        object Label16: TLabel
          Left = 6
          Top = 1
          Width = 204
          Height = 15
          Align = alLeft
          Caption = '[INSERT] - Para adicionar novo lote      '
          ExplicitHeight = 14
        end
        object Shape4: TShape
          Left = 389
          Top = 1
          Width = 14
          Height = 15
          Align = alLeft
          Brush.Color = clMoneyGreen
          ExplicitTop = 2
          ExplicitHeight = 14
        end
        object Label17: TLabel
          Left = 403
          Top = 1
          Width = 126
          Height = 15
          Align = alLeft
          Caption = ' Sugerido pelo Autcom'
          ExplicitHeight = 14
        end
      end
      object cxgLotes: TcxGridCitel
        Left = 1
        Top = 1
        Width = 1006
        Height = 143
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvLotes: TcxGridDBTableViewCitel
          OnKeyDown = cxvLotesKeyDown
          OnKeyPress = cxvLotesKeyPress
          Navigator.Buttons.CustomButtons = <>
          OnCanFocusRecord = cxvLotesCanFocusRecord
          OnCustomDrawCell = cxvLotesCustomDrawCell
          OnEditKeyPress = cxvLotesEditKeyPress
          DataController.DataSource = dtsLotes
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '0.0000'
              Kind = skSum
              FieldName = 'QTDUTI'
              Column = cxvQuantidade
            end>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxvItens: TcxGridDBColumn
            Caption = 'Item'
            DataBinding.FieldName = 'ITESUB'
            Options.Editing = False
            Width = 63
          end
          object cxvDescri: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            Width = 250
          end
          object cxvNumLot: TcxGridDBColumn
            Caption = 'Lote'
            DataBinding.FieldName = 'NUMLOT'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.CharCase = ecUpperCase
            Properties.OnValidate = cxvNumLotPropertiesValidate
            Width = 155
          end
          object cxvSaldos: TcxGridDBColumn
            Caption = 'Saldo'
            DataBinding.FieldName = 'SALLOT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 105
          end
          object cxvSaldis: TcxGridDBColumn
            Caption = 'Saldo Dispon'#237'vel'
            DataBinding.FieldName = 'SALDIS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 105
          end
          object cxvQuantidade: TcxGridDBColumn
            Caption = 'Qtd. Utilizada'
            DataBinding.FieldName = 'QTDUTI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = '0.0000'
            Properties.OnValidate = cxvQuantidadePropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 105
            OnCustomDrawFooterCell = cxvQuantidadeCustomDrawFooterCell
          end
          object cxvLotesDESACA: TcxGridDBColumn
            DataBinding.FieldName = 'ACADES'
            Visible = False
            GroupIndex = 0
            Width = 345
            IsCaptionAssigned = True
          end
          object cxvLotesITEACA: TcxGridDBColumn
            Caption = 'Item. Acab'
            DataBinding.FieldName = 'ITEACA'
            Visible = False
            Width = 83
          end
          object cxvLotesORIFDO: TcxGridDBColumn
            DataBinding.FieldName = 'ORIFDO'
            Visible = False
          end
        end
        object cxlLotes: TcxGridLevel
          GridView = cxvLotes
        end
      end
    end
  end
  object pnlEnvase: TPanel [6]
    Left = 0
    Top = 555
    Width = 1008
    Height = 117
    Align = alBottom
    ParentColor = True
    TabOrder = 5
    object lblInfoLotesAuto: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 102
      Width = 1000
      Height = 14
      Align = alBottom
      Caption = 
        '  Sistema est'#225' configurado para gerar lotes automaticamente para' +
        ' os produtos acabados com quantidade envasada maior que zero'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitWidth = 635
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 1006
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Caption = 'QUANTIDADES ENVASADAS'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object cxgItens: TcxGrid
      Left = 1
      Top = 21
      Width = 1006
      Height = 78
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgItensView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxgItensViewCellClick
        OnCellDblClick = cxgItensViewCellDblClick
        OnCustomDrawCell = cxgItensViewCustomDrawCell
        OnFocusedItemChanged = cxgItensViewFocusedItemChanged
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgItensORDITE: TcxGridDBColumn
          Caption = 'IT'
          DataBinding.FieldName = 'ORDITE'
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 47
        end
        object cxgItensDESITE: TcxGridDBColumn
          Caption = 'Embalagem'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Width = 195
        end
        object cxgItensSIGUNI: TcxGridDBColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'SIGUNI'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Width = 50
        end
        object cxgItensQTDPRO: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'ORD_QTDPRO'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 67
        end
        object cxgItensViewColumn4: TcxGridDBColumn
          Caption = 'Volume (LT)'
          DataBinding.FieldName = 'VOLACA'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 80
        end
        object cxgItensPESUNI: TcxGridDBColumn
          Caption = 'Peso (KG)'
          DataBinding.FieldName = 'PESACA'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 80
        end
        object cxgItensQtdBai: TcxGridDBColumn
          Caption = 'Baixa Parcial'
          DataBinding.FieldName = 'QTDBAI'
          Options.Editing = False
          Options.Focusing = False
          Width = 83
        end
        object cxgItensQTDENV: TcxGridDBColumn
          Caption = 'Envasado'
          DataBinding.FieldName = 'ORD_QTDENV'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = '0.000'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 77
        end
        object cxgItensNUMLOT: TcxGridDBColumn
          Caption = 'Lote'
          DataBinding.FieldName = 'NUMLOT'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Action = LoteRapido
              Default = True
              Kind = bkText
            end
            item
              Action = PesqLotes
              Kind = bkText
            end>
          Properties.OnValidate = cxgItensNUMLOTPropertiesValidate
          Width = 120
        end
        object cxgItensViewSITFRA: TcxGridDBColumn
          Caption = 'Status da Composi'#231#227'o'
          DataBinding.FieldName = 'SITFRA'
          OnGetDisplayText = cxgItensViewSITFRAGetDisplayText
          Options.Editing = False
          Width = 138
        end
      end
      object cxgItensLevel1: TcxGridLevel
        GridView = cxgItensView
      end
    end
  end
  object pnlModel9: TPanel [7]
    Left = 0
    Top = 104
    Width = 1008
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label12: TLabel
      Left = 124
      Top = 4
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qu'#237'mico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 504
      Top = 6
      Width = 129
      Height = 14
      Alignment = taRightJustify
      Caption = 'Encarregado de Produ'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 523
      Top = 29
      Width = 109
      Height = 14
      Alignment = taRightJustify
      Caption = 'Controle de Qualidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 65
      Top = 28
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Limpeza/Sanitiza'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodQui: TEditFocus
      Tag = 99
      Left = 168
      Top = 0
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = edtCodQuiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomQui: TEditFocus
      Left = 226
      Top = 0
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodEnc: TEditFocus
      Tag = 99
      Left = 635
      Top = 2
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEncKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEnc: TEditFocus
      Left = 693
      Top = 2
      Width = 272
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomQua: TEditFocus
      Left = 693
      Top = 25
      Width = 272
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
    object edtCodQua: TEditFocus
      Tag = 99
      Left = 635
      Top = 25
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      OnKeyPress = edtCodQuaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomLim: TEditFocus
      Left = 226
      Top = 24
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodLim: TEditFocus
      Tag = 99
      Left = 168
      Top = 24
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodLimKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 600
    Top = 168
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 52
  end
  object dtsOrdPro: TDataSource
    Left = 672
    Top = 168
  end
  object ActionList1: TActionList
    Left = 288
    Top = 264
    object LoteRapido: TAction
      Caption = 'Cadastrar Lote'
      OnExecute = LoteRapidoExecute
    end
    object PesqLotes: TAction
      Caption = 'Carregar Lote'
      OnExecute = PesqLotesExecute
    end
    object Action1: TAction
      Caption = 'Action1'
      OnExecute = Action1Execute
    end
    object PesqLotesMP: TAction
      Caption = 'Carregar Lote'
    end
  end
  object dtsLotes: TDataSource
    Left = 432
    Top = 232
  end
end
