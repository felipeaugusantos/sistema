inherited frmCadEstruturasIndustrialDF: TfrmCadEstruturasIndustrialDF
  Left = 207
  Top = 209
  Width = 1024
  Height = 768
  Caption = 'Desenvolvimento de F'#243'rmulas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitTop = -221
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 697
    Width = 1018
    Height = 26
    TabOrder = 2
    ExplicitTop = 697
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 936
      Height = 22
      ExplicitLeft = 932
      ExplicitTop = 2
      ExplicitWidth = 28
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 99
        Height = 22
        Caption = '[ F10 ] Fechamento'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnApaga: TBitBtnLocked
        Left = 99
        Top = 0
        Width = 94
        Height = 22
        Caption = '[ F2 ] Apaga Estr.'
        TabOrder = 1
        OnClick = btnApagaClick
      end
      object btnEstrutura: TBitBtnLocked
        Left = 193
        Top = 0
        Width = 95
        Height = 22
        Caption = '[ F3 ] Mostra Estr.'
        TabOrder = 2
        OnClick = btnEstruturaClick
      end
      object btnComentario: TBitBtnLocked
        Left = 288
        Top = 0
        Width = 103
        Height = 22
        Caption = '[ Insert ] Comentario'
        TabOrder = 3
        OnClick = btnComentarioClick
      end
      object btnMoveCima: TBitBtnLocked
        Left = 391
        Top = 0
        Width = 95
        Height = 22
        Caption = 'Move Item p/ Cima'
        TabOrder = 4
        OnClick = btnMoveCimaClick
      end
      object btnMoveBaixo: TBitBtnLocked
        Left = 486
        Top = 0
        Width = 95
        Height = 22
        Caption = 'Move Item p/ Baixo'
        TabOrder = 5
        OnClick = btnMoveBaixoClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 581
        Top = 0
        Width = 74
        Height = 22
        Caption = '[ F5 ] Imprimir'
        TabOrder = 6
        OnClick = btnImprimirClick
      end
      object btnSubstituir: TBitBtnLocked
        Left = 655
        Top = 0
        Width = 79
        Height = 22
        Caption = '[ F6 ] Substituir'
        TabOrder = 7
        OnClick = btnSubstituirClick
      end
      object btnImpFor: TBitBtnLocked
        Left = 734
        Top = 0
        Width = 77
        Height = 22
        Caption = 'Imp. &F'#243'rm.'
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 8
        OnClick = btnImpForClick
      end
      object btnAtivaDesenvolvimento: TBitBtnLocked
        Left = 811
        Top = 0
        Width = 114
        Height = 22
        Caption = 'Efetivar F'#243'rmula'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000030000000A0000000F0000000900000002000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000010000000B50453CB86D5D52F1372E288B00000009000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000003100E0C3489766BFFD4C0BBFF6E5D54EE0000000D000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000073F36318CAE9C94FFBCAAA1FF4F453CB10000000A000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000C72635BDCD4C3BAFF9F8E83FF25201D5B00000004000000000000
          000000000002000000060000000B0000000D0000000D00000009000000000000
          00031817143C8E8D7FFFDDCEC7FF7F6F66EE0201011300000002000000030000
          000803080624113023891D5039D127694EF8276B4FFD1B4A36BA000000000000
          00061B4636945CA587FF86AF9AFF26523FB80205041F02050418091B14501743
          31AD246C4EFA29805CFF2B986EFF2EAA7DFF47A081FF1537298C000000010000
          000A2F795EE541B48CFF3A9777FF307F61FF2B785AFF2C785BFF2E8464FF2E93
          6CFF298E65FF2E9D71FF2EA87BFF41BC91FF338063FC040B0826000000020E22
          1B48569F84FF39B78EFF439A7BFF4ABF9AFF60CDAAFF4DC49FFF38B086FF2D9B
          70FF2A9068FF30A478FF2FAD7FFF4FB593FF225542B200000008000000042359
          469F60B597FF46B38FFF48AA8AFF54C7A4FF69D3B3FF44C095FF35AD81FF2A8F
          67FF2F9A6FFF31A97DFF3BB88DFF48A080FF0E221B4C000000030102020A3B91
          73EF4AC5A0FF54B093FF4DBC9AFF63D0B1FF62D1B0FF3FB990FF32A57AFF298A
          64FF32A479FF32AF82FF51BF9CFF357E63D90000000800000001132F265364B0
          95FF4EC9A6FF5AB498FF55C9A6FF77DBBFFF53C9A5FF3AB48AFF2D956DFF2D93
          6BFF34AA80FF37B58AFF57B798FF1D43357500000003000000002B6B56AA6EC6
          AAFF5CC7A9FF59BFA0FF62D2B1FF7CDCC2FF46C29AFF46B590FF3A9170FF51AF
          8EFF66C6A9FF69D2B3FF49A382F5030806140000000100000000409E7FEE63D7
          B8FF6CC5AAFF5ACBAAFF81DFC6FF84DFC6FF6FCFB4FF4FA988FF368966FF398D
          69FF3F9974FF50B18DFF2F67529B0000000300000000000000001E4C3E7446AD
          8CFD5CBCA0FF98E6D2FFACE9DAFF76D0B4FF4DAA87FF28654BB70E281C540713
          0E260000000509151122060D0A16000000010000000000000000000000021E3D
          325457A98DDC6BC8A7FF54A287D32F64518D08130F2200000002000000010000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 9
        OnClick = btnAtivaDesenvolvimentoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      Top = 2
      Width = 78
      Align = alRight
      ExplicitLeft = 938
      ExplicitTop = 2
      ExplicitWidth = 78
    end
  end
  object pnlProdutos: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 101
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 9
      Width = 87
      Height = 14
      Caption = 'Produto Estrutura:'
    end
    object Label5: TLabel
      Left = 40
      Top = 32
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label10: TLabel
      Left = 232
      Top = 32
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label8: TLabel
      Left = 76
      Top = 55
      Width = 20
      Height = 14
      Caption = 'Cor:'
    end
    object Label9: TLabel
      Left = 4
      Top = 78
      Width = 92
      Height = 14
      Caption = 'C'#243'digo da F'#243'rmula:'
    end
    object Label15: TLabel
      Left = 223
      Top = 78
      Width = 354
      Height = 13
      Caption = '(Deixar esse campo vazio para o cadastro de uma nova f'#243'rmula.)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object lblDataDesenvolvimento: TLabel
      Left = 645
      Top = 35
      Width = 107
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Desenvolvimento'
    end
    object edtDesProduto: TEditFocus
      Left = 151
      Top = 5
      Width = 610
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
    object edtProdutos: TEditFocus
      Tag = 99
      Left = 99
      Top = 5
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtProdutosExit
      OnKeyPress = edtProdutosKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtReferencia: TEditFocus
      Left = 99
      Top = 28
      Width = 118
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 275
      Top = 28
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCor: TEditFocus
      Tag = 99
      Left = 99
      Top = 51
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 4
      OnExit = edtCorExit
      OnKeyPress = edtCorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesCor: TEditFocus
      Left = 151
      Top = 51
      Width = 488
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtCodFormula: TEditFocus
      Tag = 99
      Left = 99
      Top = 74
      Width = 118
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDataDesenvolvimento: TDateEditFocus
      Left = 645
      Top = 51
      AutoSize = False
      Properties.Alignment.Horz = taCenter
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000806040FFC080
        60FFC08060FFC08060FFC08060FFC08060FFC08060FFC08060FFC08060FFC080
        60FFC08060FFC08060FFC08060FF806040FF0000000000000000C08060FFFFFF
        FFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
        FFFFF0FBFFFFF0FBFFFFF0FBFFFFC08060FF0000000000000000C08080FFFFFF
        FFFFFFFFFFFFC0A080FFC0DCC0FFC0A080FFC0DCC0FFC0A080FFC0DCC0FFC0A0
        80FFC0DCC0FFC0A080FFF0FBFFFFC08060FF0000000000000000C08080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFFF0FBFFFFC0DC
        C0FFC0DCC0FFC0DCC0FFF0FBFFFFC08080FF0000000000000000C08080FFFFFF
        FFFFFFFFFFFF8080C0FF4040C0FF4040C0FF4040A0FF8060C0FFFFFFFFFFC0A0
        80FFC0DCC0FFC0A080FFFFFFFFFFC08080FF0000000000000000C0A080FFFFFF
        FFFFFFFFFFFF4040C0FF4040C0FF4040C0FF4040C0FF4040A0FFFFFFFFFFF0FB
        FFFFF0FBFFFFF0FBFFFFFFFFFFFFC08080FF0000000000000000C0A080FFFFFF
        FFFFFFFFFFFF4060C0FF4060C0FFFFFFFFFF4040C0FF4040C0FFFFFFFFFFC0A0
        80FFF0FBFFFFC0A080FFFFFFFFFFC0A080FF0000000000000000C0A080FFFFFF
        FFFFFFFFFFFF4060C0FF4060C0FF4060C0FF4040C0FF4040C0FFFFFFFFFFF0FB
        FFFFF0FBFFFFF0FBFFFFFFFFFFFFC0A080FF0000000000000000C0A0A0FFFFFF
        FFFFFFFFFFFF8080E0FF4060C0FF4060C0FF4060C0FF8080C0FFFFFFFFFFC0A0
        A0FFF0FBFFFFC0A080FFFFFFFFFFC0A080FF0000000000000000C0A0A0FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0A0A0FF00000000000000004060C0FF80A0
        E0FF8080E0FF8080E0FF8080E0FF8080E0FF4080E0FF4060E0FF4060E0FF4060
        E0FF4060E0FF4060E0FF8060E0FF4040A0FF00000000000000004060C0FF80A0
        E0FF8080E0FF8080E0FF8080E0FF8080E0FF8080E0FF8080E0FF4060E0FF4060
        E0FF4060E0FF4060E0FF8080E0FF4040A0FF00000000000000004060C0FF80A0
        E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0
        E0FF8080E0FF8080E0FF8080E0FF4040A0FF00000000000000004040A0FF4060
        C0FF4060C0FF4060C0FF4040C0FF4040C0FF4040C0FF4040C0FF4040C0FF4040
        C0FF4040C0FF4040C0FF4040A0FF402080FF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 5
      Height = 22
      Width = 116
    end
  end
  object pnlForDes: TPanel [3]
    Left = 0
    Top = 533
    Width = 1018
    Height = 121
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 531
    object pnlTotais: TPanel
      Left = 161
      Top = 1
      Width = 856
      Height = 119
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        856
        119)
      object Label18: TLabel
        Left = 191
        Top = 10
        Width = 74
        Height = 14
        Alignment = taCenter
        Anchors = [akRight]
        AutoSize = False
        Caption = 'PVC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 262
        Top = 10
        Width = 74
        Height = 14
        Alignment = taCenter
        Anchors = [akRight]
        AutoSize = False
        Caption = 'CPVC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 340
        Top = 10
        Width = 74
        Height = 14
        Alignment = taCenter
        Anchors = [akRight]
        AutoSize = False
        Caption = 'PVC / CPVC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtPVC: TEditFocus
        Left = 183
        Top = 25
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taCenter
        Anchors = [akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtCPVC: TEditFocus
        Left = 262
        Top = 25
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taCenter
        Anchors = [akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtPVCCPVC: TEditFocus
        Left = 340
        Top = 25
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taCenter
        Anchors = [akRight]
        Color = 16768952
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object GroupBox1: TGroupBox
        Left = 183
        Top = 49
        Width = 231
        Height = 65
        Caption = 'S'#243'lidos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        DesignSize = (
          231
          65)
        object Label25: TLabel
          Left = 9
          Top = 17
          Width = 74
          Height = 14
          Alignment = taCenter
          Anchors = [akRight]
          AutoSize = False
          Caption = 'Massa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label26: TLabel
          Left = 88
          Top = 17
          Width = 74
          Height = 14
          Alignment = taCenter
          Anchors = [akRight]
          AutoSize = False
          Caption = 'Volume'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtMasSol: TEditFocus
          Left = 9
          Top = 32
          Width = 74
          Height = 22
          TabStop = False
          Alignment = taCenter
          Anchors = [akRight]
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtVolSol: TEditFocus
          Left = 88
          Top = 32
          Width = 74
          Height = 22
          TabStop = False
          Alignment = taCenter
          Anchors = [akRight]
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object Panel1: TPanel
        Left = 420
        Top = 0
        Width = 436
        Height = 119
        Align = alRight
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object pnlPesos: TPanel
          Left = 282
          Top = 0
          Width = 154
          Height = 119
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            154
            119)
          object Label16: TLabel
            Left = 75
            Top = 76
            Width = 74
            Height = 14
            Alignment = taCenter
            Anchors = [akRight]
            AutoSize = False
            Caption = 'PE REAL'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = -3
            Top = 76
            Width = 74
            Height = 14
            Alignment = taCenter
            Anchors = [akRight]
            AutoSize = False
            Caption = 'PE'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtPesRea: TEditFocus
            Tag = 99
            Left = 75
            Top = 93
            Width = 74
            Height = 22
            Alignment = taRightJustify
            Anchors = [akRight]
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            MaxLength = 10
            ParentFont = False
            TabOrder = 0
            OnChange = edtPesReaChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 10
            TipoTexto = ttNumerico
            EditFormat = '#,##0.0000'
          end
          object edtTotPes: TEditFocus
            Left = -1
            Top = 93
            Width = 74
            Height = 22
            TabStop = False
            Alignment = taCenter
            Anchors = [akRight]
            Color = 16768952
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            Text = 'edtTotPes'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
        object pnlCusKG: TPanel
          Left = 175
          Top = 0
          Width = 107
          Height = 119
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            107
            119)
          object lblTotCusKG: TLabel
            Left = 4
            Top = 76
            Width = 98
            Height = 14
            Alignment = taCenter
            Anchors = [akRight]
            AutoSize = False
            Caption = 'Total Custo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtTotCus: TEditFocus
            Left = 4
            Top = 93
            Width = 99
            Height = 22
            TabStop = False
            Alignment = taCenter
            Anchors = [akRight]
            Color = 16768952
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = 'edtTotCus'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
        object pnlCusLT: TPanel
          Left = 74
          Top = 0
          Width = 101
          Height = 119
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 2
          DesignSize = (
            101
            119)
          object Label12: TLabel
            Left = 3
            Top = 76
            Width = 99
            Height = 14
            Alignment = taCenter
            Anchors = [akRight]
            AutoSize = False
            Caption = 'Total Custo (LT)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtTotCusLT: TEditFocus
            Left = 3
            Top = 93
            Width = 99
            Height = 22
            TabStop = False
            Alignment = taCenter
            Anchors = [akRight]
            Color = 16768952
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = 'edtTotCus'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
        object pnlPercentualTotal: TPanel
          Left = -2
          Top = 0
          Width = 76
          Height = 119
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 3
          DesignSize = (
            76
            119)
          object Label13: TLabel
            Left = 3
            Top = 76
            Width = 74
            Height = 14
            Alignment = taCenter
            Anchors = [akRight]
            AutoSize = False
            Caption = '% Total'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtTotPer: TEditFocus
            Left = 3
            Top = 93
            Width = 74
            Height = 22
            TabStop = False
            Alignment = taCenter
            Anchors = [akRight]
            Color = 16768952
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = 'edtTotPer'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
      end
    end
  end
  object pnlFormulaReal: TPanel [4]
    Left = 0
    Top = 654
    Width = 1018
    Height = 43
    Align = alBottom
    Color = 16770261
    Enabled = False
    ParentBackground = False
    TabOrder = 5
    ExplicitTop = 652
    object Panel3: TPanel
      Left = 221
      Top = 1
      Width = 796
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label22: TLabel
        Left = 250
        Top = 17
        Width = 173
        Height = 14
        Caption = 'Informa'#231#245'es da F'#243'rmula Oficial:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlPesoOficial: TPanel
        Left = 639
        Top = 0
        Width = 157
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object Label21: TLabel
          Left = 78
          Top = 2
          Width = 74
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'PE REAL'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = 4
          Top = 2
          Width = 74
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'PE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtPesReaOfi: TEditFocus
          Tag = 99
          Left = 78
          Top = 17
          Width = 74
          Height = 22
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.0000'
        end
        object edtTotPesOfi: TEditFocus
          Left = 4
          Top = 17
          Width = 74
          Height = 22
          TabStop = False
          Alignment = taCenter
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object Panel2: TPanel
        Left = 535
        Top = 0
        Width = 104
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object lblCustoOfi: TLabel
          Left = 4
          Top = 4
          Width = 91
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Total Custo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTotCusOfi: TEditFocus
          Left = 4
          Top = 17
          Width = 99
          Height = 22
          TabStop = False
          Alignment = taCenter
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object pnlCusLTOfi: TPanel
        Left = 431
        Top = 0
        Width = 104
        Height = 41
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
        object Label19: TLabel
          Left = 4
          Top = 4
          Width = 91
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = 'Total Custo (LT)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTotCusLTOfi: TEditFocus
          Left = 4
          Top = 17
          Width = 99
          Height = 22
          TabStop = False
          Alignment = taCenter
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    TabOrder = 3
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pgcFormulacao: TPageControl [6]
    Left = 0
    Top = 101
    Width = 1018
    Height = 432
    ActivePage = tbsFormula
    Align = alClient
    TabOrder = 1
    OnEnter = pgcFormulacaoEnter
    ExplicitHeight = 430
    object tbsFormula: TTabSheet
      Caption = 'Formula'#231#227'o'
      ExplicitHeight = 401
      object pnlSubProdutos: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 80
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 30
          Top = 10
          Width = 65
          Height = 14
          Caption = 'Sub. Produto:'
        end
        object Label3: TLabel
          Left = 40
          Top = 33
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Referencia:'
        end
        object Label4: TLabel
          Left = 219
          Top = 33
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object Label6: TLabel
          Left = 44
          Top = 56
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual:'
        end
        object Label7: TLabel
          Left = 309
          Top = 33
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fase:'
        end
        object Label11: TLabel
          Left = 180
          Top = 56
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label17: TLabel
          Left = 329
          Top = 56
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sequ'#234'ncia Geral:'
        end
        object Label32: TLabel
          Left = 199
          Top = 56
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Toler'#226'ncia:'
        end
        object edtPerTol: TEditFocus
          Tag = 99
          Left = 255
          Top = 52
          Width = 68
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 10
          TabOrder = 3
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtDesSubProduto: TEditFocus
          Left = 151
          Top = 6
          Width = 490
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtSubProduto: TEditFocus
          Tag = 99
          Left = 99
          Top = 6
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtSubProdutoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtSubReferencia: TEditFocus
          Left = 99
          Top = 29
          Width = 118
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubUnidade: TEditFocus
          Left = 262
          Top = 29
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubQtdIte: TEditFocus
          Tag = 99
          Left = 99
          Top = 52
          Width = 78
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 10
          TabOrder = 2
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtCodFas: TEditFocus
          Tag = 99
          Left = 338
          Top = 29
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 1
          OnKeyPress = edtCodFasKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesFas: TEditFocus
          Left = 390
          Top = 29
          Width = 251
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 10
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAdicionar: TBitBtnLocked
          Left = 461
          Top = 52
          Width = 90
          Height = 22
          Caption = '&Confirma'
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
          TabOrder = 5
          OnClick = btnAdicionarClick
        end
        object btnCancelaItem: TBitBtnLocked
          Left = 552
          Top = 52
          Width = 90
          Height = 22
          Caption = 'C&ancelar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 9
          OnClick = btnCancelaItemClick
        end
        object edtSeq: TEditFocus
          Tag = 99
          Left = 413
          Top = 52
          Width = 41
          Height = 22
          Hint = 'N'#227'o Informe a Sequ'#234'ncia para Inserir ao Final da F'#243'rmula'
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
      end
      object dbgDados: TDBGridCitel
        Left = 0
        Top = 80
        Width = 1010
        Height = 323
        Align = alClient
        DataSource = dtsConsulta
        ImeName = ' '
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgDadosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_SEQUEN'
            Title.Caption = 'Seq. Geral'
            Width = 59
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_SEQITE'
            Title.Caption = 'Seq. Mat. Prima'
            Width = 83
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_ITESUB'
            Title.Caption = 'Codigo'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Width = 613
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_REFERE'
            Title.Caption = 'Referencia'
            Width = 122
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_QTDITE'
            Title.Alignment = taCenter
            Title.Caption = 'Quantidade'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_PERTOL'
            Title.Caption = '% Toler'#226'ncia'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_CUSCAL'
            Title.Alignment = taRightJustify
            Title.Caption = 'Custo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_CUS_LT'
            Title.Caption = 'Custo (LT)'
            Visible = False
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_REPCUS'
            Title.Alignment = taRightJustify
            Title.Caption = '% de repres. custo do produto'
            Width = 160
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FAS_DESFAS'
            Title.Caption = 'Fase'
            Width = 170
            Visible = True
          end>
      end
    end
    object tbsAnalise: TTabSheet
      Caption = 'An'#225'lise'
      ImageIndex = 1
      ExplicitHeight = 401
      object pnlAnalises: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 64
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label27: TLabel
          Left = 24
          Top = 12
          Width = 39
          Height = 14
          Caption = 'An'#225'lise:'
        end
        object edtCodAna: TEditFocus
          Tag = 99
          Left = 67
          Top = 8
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodAnaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesAna: TEditFocus
          Left = 119
          Top = 8
          Width = 591
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
        object btnConfirmaAnalise: TBitBtnLocked
          Left = 484
          Top = 36
          Width = 111
          Height = 22
          Caption = '&Confirma'
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
          TabOrder = 3
          OnClick = btnConfirmaAnaliseClick
        end
        object btnCancelaAnalise: TBitBtnLocked
          Left = 599
          Top = 36
          Width = 111
          Height = 22
          Caption = 'C&ancelar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnCancelaAnaliseClick
        end
        object pgcResultadoAnalise: TPageControl
          Tag = 99
          Left = 8
          Top = 30
          Width = 475
          Height = 33
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          ParentCustomHint = False
          ActivePage = tbsIntervaloValores
          Style = tsFlatButtons
          TabOrder = 2
          StyleElements = []
          OnEnter = pgcResultadoAnaliseEnter
          object tbsIntervaloValores: TTabSheet
            Caption = 'tbsIntervaloValores'
            TabVisible = False
            object Label28: TLabel
              Left = 17
              Top = 4
              Width = 35
              Height = 14
              Alignment = taRightJustify
              Caption = 'M'#237'nimo:'
            end
            object Label29: TLabel
              Left = 183
              Top = 4
              Width = 39
              Height = 14
              Alignment = taRightJustify
              Caption = 'M'#225'ximo:'
            end
            object Label30: TLabel
              Left = 344
              Top = -3
              Width = 113
              Height = 31
              AutoSize = False
              Caption = '*pgcResultadoAnalise Intervalo / Descri'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
              WordWrap = True
            end
            object edtAnaMin: TEditFocus
              Tag = 99
              Left = 55
              Top = 0
              Width = 106
              Height = 22
              Alignment = taRightJustify
              Color = clWhite
              MaxLength = 10
              TabOrder = 0
              Text = '0,00'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtAnaMax: TEditFocus
              Tag = 99
              Left = 223
              Top = 0
              Width = 106
              Height = 22
              Alignment = taRightJustify
              Color = clWhite
              MaxLength = 10
              TabOrder = 1
              Text = '0,00'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object tbsDescricaoAberta: TTabSheet
            Caption = 'tbsDescricaoAberta'
            ImageIndex = 1
            TabVisible = False
            object Label31: TLabel
              Left = 0
              Top = 4
              Width = 52
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descri'#231#227'o:'
            end
            object edtDescricaoResultadoAnalise: TEditFocus
              Tag = 99
              Left = 55
              Top = 0
              Width = 410
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 50
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object dbgAnalise: TDBGridCitel
        Left = 0
        Top = 64
        Width = 1010
        Height = 339
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgAnaliseDblClick
        OnKeyDown = dbgAnaliseKeyDown
        CorZebra = clMoneyGreen
        Zebra = True
        DestacarMouse = True
        Columns = <
          item
            Expanded = False
            FieldName = 'GAN_CODANA'
            Title.Caption = 'C'#243'digo'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ANA_DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Width = 365
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RESULTADOESPERADO'
            Title.Caption = 'Resultado Esperado'
            Width = 393
            Visible = True
          end>
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 448
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 648
    Top = 256
  end
  object frxPaginaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40456.592838541670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo6.Height    := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    DMPMemo9.Height    := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo6.Height    := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    DMPMemo9.Height    := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    DMPMemo8.Height    := 50;'
      '    DMPMemo6.Height    := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    DMPMemo9.Height    := 50;        '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 352
    Top = 216
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 241.299844160517300000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 892.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 547.200000000000100000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 892.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 547.200000000000100000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 364.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 153.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValIte: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 892.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 57.600000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 28.800000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 892.800000000000000000
        object rdbSumTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPaginaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40456.594720231480000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 40 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    Memo8.Height       := 16;'
      '    Memo6.Height       := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    Memo13.Height      := 16;'
      '    Shape2.Height      := 16;                                  '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 80 Then     ' +
        '                            '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo8.Height       := 33;'
      '    Memo6.Height       := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    Memo13.Height      := 33;'
      '    Shape2.Height      := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 80 Then     ' +
        '                            '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    Memo8.Height       := 50;'
      '    Memo6.Height       := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    Memo13.Height      := 50;'
      '    Shape2.Height      := 50;'
      '  End;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 385
    Top = 216
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 241.299844160000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 65.007903310000000000
        Top = 204.094620000000000000
        Width = 836.409399998044800000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 831.496600000000000000
          Height = 60.472465350000000000
        end
        object Memo6: TfrxMemoView
          Left = 535.779530000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 2.379530000000000000
          Top = 0.559060000000000000
          Width = 370.393744720000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
        end
        object Memo8: TfrxMemoView
          Left = 374.579530000000000000
          Top = 0.559060000000000000
          Width = 158.740137950000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
        end
        object rdbValIte: TfrxMemoView
          Left = 590.811380000000000000
          Width = 86.929133860000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
        object rdbValTot: TfrxMemoView
          Left = 681.520100000000000000
          Width = 86.929133860000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 771.379530000000000000
          Width = 58.204700000000000000
          Height = 52.913407800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 836.409399998044800000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999990000
          Width = 831.496600000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 535.779530000000000000
          Top = 1.779530000000000000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.379530000000000000
          Top = 1.779530000000000000
          Width = 370.393744720000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 374.579530000000000000
          Top = 1.779530000000000000
          Width = 158.740137950000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 771.379530000000000000
          Top = 1.779530000000000000
          Width = 58.204700000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 590.811380000000000000
          Top = 1.779530000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ITEM')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 681.520100000000000000
          Top = 1.779530000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. TOTAL')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322820000000000000
        Top = 18.897650000000000000
        Width = 836.409399998044800000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 29.404699999022400000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 173.404699999022400000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 701.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 18.481879999022400000
          Top = 55.000000000000000000
          Width = 799.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 291.023810000000000000
        Width = 836.409399998044800000
        object rdbSumTot: TfrxMemoView
          Left = 684.520100000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 593.811380000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 416
    Top = 216
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    Left = 176
    Top = 216
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 208
    Top = 216
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspConsulta'
    AfterScroll = cdsConsultaAfterScroll
    Left = 240
    Top = 216
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 272
    Top = 216
  end
  object frxSemPrecoM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40456.595127129630000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 50 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;      '
      '    DMPMemo6.Height    := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo9.Height    := 16;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 50 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo6.Height    := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo9.Height    := 33;        '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 352
    Top = 248
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 241.299844160517300000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 892.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 518.400000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 201.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 67.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 892.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 892.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 57.600000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 28.800000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
    end
  end
  object frxSemPrecoJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41127.590528506950000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 50 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;      '
      '    Memo6.Height       := 16;'
      '    Memo8.Height       := 16;'
      '    Shape2.Height      := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 50 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo6.Height       := 33;'
      '    Memo8.Height       := 33;'
      '    Shape2.Height      := 33;        '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 384
    Top = 248
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 241.299844160000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 42.330723310000000000
        Top = 204.094620000000000000
        Width = 836.409399998044800000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 831.496600000000000000
          Height = 37.795285350000000000
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 34.015757800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 60.379530000000000000
          Top = 0.559060000000000000
          Width = 468.056710000000000000
          Height = 34.015757800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
        end
        object Memo8: TfrxMemoView
          Left = 530.579530000000000000
          Top = 0.559060000000000000
          Width = 210.141707870000000000
          Height = 34.015757800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 836.409399998044800000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999994000
          Width = 831.496600000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 60.379530000000000000
          Top = 1.779530000000000000
          Width = 468.056710000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 530.579530000000000000
          Top = 1.779530000000000000
          Width = 210.141707870000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 744.379530000000000000
          Top = 1.779530000000000000
          Width = 84.661410000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322819999999990000
        Top = 18.897650000000000000
        Width = 836.409399998044800000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 29.404699999022400000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 173.404699999022400000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 701.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 18.481879999022550000
          Top = 55.000000000000000000
          Width = 799.445639999999700000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxPreCusM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40682.625273969890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo6.Height    := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    rdbValMed.Height   := 16;'
      '    rdbUltCom.Height   := 16;'
      '    DMPMemo9.Height    := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo6.Height    := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    rdbValMed.Height   := 33;'
      '    rdbUltCom.Height   := 33;'
      '    DMPMemo9.Height    := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    DMPMemo8.Height    := 50;'
      '    DMPMemo6.Height    := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    rdbValMed.Height   := 50;'
      '    rdbUltCom.Height   := 50;'
      '    DMPMemo9.Height    := 50;        '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 416
    Top = 248
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 297.179808071374000000
      PaperHeight = 242.887343135257600000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 1104.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 1104.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 67.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 364.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 144.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValIte: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValMed: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbUltCom: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1104.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1104.000000000000000000
        object rdbSumTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPreCusJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41127.498780081020000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin          '
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    Memo8.Height       := 16;'
      '    Memo6.Height       := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    Memo7.Height       := 16;'
      '    Memo15.Height      := 16;'
      '    Memo13.Height      := 16;'
      '    Shape2.Height      := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo8.Height       := 33;'
      '    Memo6.Height       := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    Memo7.Height       := 33;'
      '    Memo15.Height      := 33;'
      '    Memo13.Height      := 33;'
      '    Shape2.Height      := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    Memo8.Height       := 50;'
      '    Memo6.Height       := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    Memo7.Height       := 50;'
      '    Memo15.Height      := 50;'
      '    Memo13.Height      := 50;'
      '    Shape2.Height      := 50;        '
      '  End;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 449
    Top = 249
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 296.900000000000000000
      PaperHeight = 241.300000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 53.669313310000000000
        Top = 204.094620000000000000
        Width = 1046.551857000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 1039.370750000000000000
          Height = 49.133875350000000000
        end
        object Memo6: TfrxMemoView
          Left = 539.779530000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 1.852010000000000000
          Top = 0.559060000000000000
          Width = 366.614214720000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
        end
        object Memo8: TfrxMemoView
          Left = 371.579530000000000000
          Top = 0.559060000000000000
          Width = 166.299197950000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
        end
        object rdbValIte: TfrxMemoView
          Left = 593.811380000000000000
          Width = 86.929133860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
        object rdbValTot: TfrxMemoView
          Left = 683.520100000000000000
          Width = 90.708663860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 981.286580000000000000
          Width = 54.425170000000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 776.787880000000000000
          Width = 98.267723860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 878.394250000000000000
          Width = 98.267723860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 1046.551857000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779530000000000000
          Width = 1039.370750000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 539.779530000000000000
          Top = 1.779530000000000000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.379530000000000000
          Top = 1.779530000000000000
          Width = 366.614214720000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 371.579530000000000000
          Top = 1.779530000000000000
          Width = 166.299197950000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 980.286580000000000000
          Top = 1.779530000000000000
          Width = 58.204700000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 593.811380000000000000
          Top = 1.779530000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 683.520100000000000000
          Top = 1.779530000000000000
          Width = 90.708663860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 776.787880000000000000
          Top = 1.779530000000000000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 878.394250000000000000
          Top = 1.779530000000000000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.551857000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 134.475928500000000000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 278.475928500000000000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 914.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 123.553108500000000000
          Top = 55.000000000000000000
          Width = 799.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 279.685220000000000000
        Width = 1046.551857000000000000
        object rdbSumTot: TfrxMemoView
          Left = 683.520100000000000000
          Width = 90.708663860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 592.811380000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
    end
  end
  object frxPreCusLitroM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42927.709497037000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;'
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin'
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo6.Height    := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    rdbValMed.Height   := 16;'
      '    rdbUltCom.Height   := 16;'
      '    DMPMemo9.Height    := 16;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo6.Height    := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    rdbValMed.Height   := 33;'
      '    rdbUltCom.Height   := 33;'
      '    DMPMemo9.Height    := 33;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    DMPMemo8.Height    := 50;'
      '    DMPMemo6.Height    := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    rdbValMed.Height   := 50;'
      '    rdbUltCom.Height   := 50;'
      '    DMPMemo9.Height    := 50;'
      '  End;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 382
    Top = 302
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 297.179808071374000000
      PaperHeight = 242.887343135257600000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 1104.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL(KG)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL(LT)')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 1104.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 67.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 115.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValIte: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 134.400000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValMed: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbUltCom: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTotLT: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 134.400000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1104.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1104.000000000000000000
        object rdbSumTot: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbSumTotLT: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPreCusLitroJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42927.709299606500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;'
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin{  '
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin'
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    Memo8.Height       := 16;'
      '    Memo6.Height       := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    Memo7.Height       := 16;'
      '    Memo15.Height      := 16;'
      '    Memo13.Height      := 16;'
      '    Shape2.Height      := 16;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo8.Height       := 33;'
      '    Memo6.Height       := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    Memo7.Height       := 33;'
      '    Memo15.Height      := 33;'
      '    Memo13.Height      := 33;'
      '    Shape2.Height      := 33;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    Memo8.Height       := 50;'
      '    Memo6.Height       := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    Memo7.Height       := 50;'
      '    Memo15.Height      := 50;'
      '    Memo13.Height      := 50;'
      '    Shape2.Height      := 50;'
      '  End;}  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 430
    Top = 302
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 296.900000000000000000
      PaperHeight = 241.300000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 23.433073310000000000
        Top = 204.094620000000000000
        Width = 1046.551857000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 1039.370750000000000000
          Height = 18.897635349999990000
        end
        object Memo6: TfrxMemoView
          Left = 374.480210000000000000
          Top = 0.559059999999988100
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 1.852010000000000000
          Top = 0.559059999999988100
          Width = 222.992074720000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
        end
        object Memo8: TfrxMemoView
          Left = 228.957390000000000000
          Top = 0.559059999999988100
          Width = 143.622017950000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
        end
        object rdbValIte: TfrxMemoView
          Left = 428.512060000000000000
          Width = 86.929133859999990000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
        object rdbValTot: TfrxMemoView
          Left = 518.220780000000000000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 981.286580000000000000
          Width = 54.425170000000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 776.787880000000000000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 878.394250000000000000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          WordWrap = False
        end
        object rdbValTotLT: TfrxMemoView
          Left = 650.079160000000000000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft]
          HAlign = haRight
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 1046.551857000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999994000
          Width = 1039.370750000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 374.480209999999700000
          Top = 1.779529999999994000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.379530000000000000
          Top = 1.779529999999994000
          Width = 222.992074720000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 228.957390000000000000
          Top = 1.779529999999994000
          Width = 143.622017950000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 980.286580000000000000
          Top = 1.779529999999994000
          Width = 58.204700000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 428.512059999999800000
          Top = 1.779529999999994000
          Width = 86.929133859999990000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 518.220780000000000000
          Top = 1.779529999999994000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL (KG)')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 776.787880000000000000
          Top = 1.779529999999994000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 878.394250000000000000
          Top = 1.779529999999994000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 650.079160000000000000
          Top = 1.779529999999994000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL (LT)')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.551857000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 134.475928500000000000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 278.475928500000000000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 914.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 123.553108500000000000
          Top = 55.000000000000000000
          Width = 799.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 249.448980000000000000
        Width = 1046.551857000000000000
        object rdbSumTot: TfrxMemoView
          Left = 518.220780000000000000
          Top = 3.779530000000051000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 428.512060000000000000
          Top = 3.779530000000051000
          Width = 86.929133859999990000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object rdbSumTotLT: TfrxMemoView
          Left = 650.079160000000000000
          Top = 3.779530000000051000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
