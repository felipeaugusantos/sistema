inherited frmFatVendas: TfrmFatVendas
  Left = 86
  Top = 70
  Width = 1036
  Height = 825
  Caption = 'Vendas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1036
  ExplicitHeight = 825
  PixelsPerInch = 96
  TextHeight = 14
  object lblInformacaoGrid: TLabel [0]
    Left = 0
    Top = 619
    Width = 1030
    Height = 14
    Align = alBottom
    Alignment = taCenter
    Caption = 'Alterando Produto...'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    ExplicitWidth = 110
  end
  object pgbProgresso: TProgressBar [1]
    Left = 0
    Top = 770
    Width = 1030
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 8
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 619
    Width = 1030
    Color = 16770261
    TabOrder = 9
    ExplicitTop = 619
    ExplicitWidth = 1030
    DesignSize = (
      1030
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1026
      ExplicitWidth = 1026
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 780
    Width = 1030
    Color = 16770261
    ExplicitTop = 780
    ExplicitWidth = 1030
    inherited pnlNomeForm: TPanel
      Left = 930
      Width = 100
      ExplicitLeft = 930
      ExplicitWidth = 100
    end
    inherited pnlInfo: TPanel
      Width = 736
      ExplicitWidth = 736
    end
    inherited pnlBotoesTrace: TPanel
      TabOrder = 3
    end
    object pnlInfo2: TPanel
      Left = 736
      Top = 0
      Width = 194
      Height = 16
      Align = alRight
      BevelInner = bvLowered
      ParentBackground = False
      TabOrder = 2
    end
  end
  inherited pgcDados: TPageControl
    Top = 553
    Width = 1030
    Height = 66
    Visible = False
    ExplicitTop = 553
    ExplicitWidth = 1030
    ExplicitHeight = 66
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1022
      ExplicitHeight = 34
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 1030
    Height = 237
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    OnEnter = pnlCabecalhoEnter
    object pnlCliente: TPanel
      Left = 1
      Top = 35
      Width = 1028
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object lblCliFor: TLabel
        Left = 29
        Top = 9
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lblLimite: TLabel
        Left = 882
        Top = 9
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lim.Cr'#233'dito:'
        Visible = False
      end
      object lblPreVis: TLabel
        Left = 742
        Top = 9
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Previs'#227'o:'
        Visible = False
      end
      object lblTabPreco: TLabel
        Left = 651
        Top = 9
        Width = 51
        Height = 14
        Caption = 'Tab.Pre'#231'o:'
      end
      object lblMargem: TLabel
        Left = 3
        Top = 32
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marg. Lucro:'
      end
      object lblMarPer: TLabel
        Left = 132
        Top = 32
        Width = 10
        Height = 14
        Alignment = taRightJustify
        Caption = '%'
      end
      object lblTotCre: TLabel
        Left = 849
        Top = 32
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total dos Cr'#233'ditos:'
        Visible = False
      end
      object lblOprFlj: TLabel
        Left = 259
        Top = 32
        Width = 140
        Height = 14
        Alignment = taRightJustify
        Caption = 'Gerar produ'#231#227'o fora da loja?'
        Visible = False
      end
      object btnPreVis: TSpeedButton
        Left = 849
        Top = 5
        Width = 27
        Height = 22
        Hint = 'Hor'#225'rios Programa'#231#227'o de Produ'#231#227'o'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
          300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
          330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
          333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
          339977FF777777773377000BFB03333333337773FF733333333F333000333333
          3300333777333333337733333333333333003333333333333377333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        Visible = False
        OnClick = btnPreVisClick
      end
      object lblDesPro: TLabel
        Left = 3
        Top = 32
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desc. Prof.:'
        Visible = False
      end
      object lblUtiNps: TLabel
        Left = 66
        Top = 49
        Width = 165
        Height = 13
        Cursor = crHandPoint
        Caption = 'Clique aqui caso deseje Netpoints.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = [fsUnderline]
        ParentFont = False
        Visible = False
        OnClick = lblUtiNpsClick
      end
      object lblCshBck: TLabel
        Left = 1019
        Top = 32
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cashback'
        Visible = False
      end
      object edtDesPro: TEditFocus
        Left = 66
        Top = 28
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 66
        Top = 5
        Width = 65
        Height = 22
        Hint = 'Pressione INSERT para inserir um novo cliente'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnExit = edtCodCliExit
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
        Tag = 99
        Left = 132
        Top = 5
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        OnExit = edtNomCliExit
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtLimCre: TEditFocus
        Left = 939
        Top = 5
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskPreVis: TMaskEditFocus
        Tag = 99
        Left = 787
        Top = 5
        Width = 61
        Height = 22
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object cbTabPreco: TComboBoxFocus
        Tag = 99
        Left = 704
        Top = 5
        Width = 36
        Height = 22
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Sorted = True
        TabOrder = 4
        OnExit = cbTabPrecoExit
        OnSelect = cbTabPrecoSelect
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtTotCre: TEditFocus
        Left = 939
        Top = 28
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 13
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtOprFlj: TEditFocus
        Tag = 99
        Left = 400
        Top = 28
        Width = 32
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 10
        Text = 'N'
        Visible = False
        OnChange = edtOprFljChange
        OnExit = edtOprFljExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object pnlPrecoTE: TPanel
        Left = 144
        Top = 28
        Width = 115
        Height = 22
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 9
        Visible = False
        object Label1: TLabel
          Left = 3
          Top = 4
          Width = 31
          Height = 14
          Caption = 'Pre'#231'o:'
        end
        object cbxPreTEs: TComboBoxFocus
          Left = 35
          Top = 0
          Width = 77
          Height = 22
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnChange = cbxPreTesChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object cbbComInd: TComboBoxFocus
        Left = 434
        Top = 28
        Width = 105
        Height = 22
        Style = csDropDownList
        BiDiMode = bdRightToLeftNoAlign
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 11
        Text = 'Comercializa'#231#227'o'
        OnExit = cbbComIndExit
        Items.Strings = (
          'Comercializa'#231#227'o'
          'Industrializa'#231#227'o')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbbUsoConsRev: TComboBoxFocus
        Left = 541
        Top = 28
        Width = 105
        Height = 22
        Style = csDropDownList
        BiDiMode = bdRightToLeftNoAlign
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 12
        Text = 'Uso/Consumo'
        Visible = False
        OnExit = cbbUsoConsRevExit
        Items.Strings = (
          'Uso/Consumo'
          'Revenda'
          'Industrializa'#231#227'o')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cbbClienteEstaNaLoja: TComboBoxFocus
        Tag = 99
        Left = 511
        Top = 5
        Width = 136
        Height = 22
        Style = csDropDownList
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnExit = cbbClienteEstaNaLojaExit
        Items.Strings = (
          'Cliente est'#225' na loja!'
          'Cliente n'#227'o est'#225' na loja!')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object pnlCampanha: TPanel
        Left = 646
        Top = 29
        Width = 197
        Height = 21
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 14
        Visible = False
        object lblCampanha: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 191
          Height = 15
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          Alignment = taCenter
          Anchors = []
          Caption = 'CLIENTE EM CAMPANHA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 128
          ExplicitHeight = 14
        end
      end
      object edtMargem: TEditFocus
        Tag = 99
        Left = 66
        Top = 28
        Width = 65
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
        ParentFont = False
        TabOrder = 15
        OnExit = edtMargemExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '##0.00'
      end
      object btnConsultaFit: TBitBtnLocked
        Left = 0
        Top = 5
        Width = 27
        Height = 22
        Hint = 'Consulta Dados Cadastrais do CNPJ.'
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          1800000000000006000000000000000000000000000000000000A449A3DC7D47
          D35C18D55D18D35C18D15B17D35C18C35516F1AA81CA5817D55D18D35C18D35C
          18D35C18F0A173A449A3A449A3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFA449A3DA7B44DC6019
          D35C18E97837F9DDCDE97939C65616F1AB83FDF2ECEF9C6CCF5A17DC6019DC60
          19DC6019DC6019F5C2A5C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3C3C3C3C3C3C3
          C3C3FFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E76A22D15B17
          EA7E40DA5F18E36319FAE2D4FBE8DDC15416FBE5D8FAE2D4E8722ED15B17DA5F
          18DA5F18DA5F18F1AB82C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFC3
          C3C3FFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3F1A87ECE5A17
          F8D4BFE76B24EC8D56E97736F9DAC8CA5817FDF1EAFDF1EAFADFCFE76C25D55D
          18DC6019DC6019F1AB83C3C3C3C3C3C3FFFFFFC3C3C3C3C3C3C3C3C3FFFFFFC3
          C3C3FFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3F0A173F7CEB7
          F6C8ADE76A22F9DBC9EA7D3FC15416FDF3EDFDF1EAFDF1EAFCEEE6FDF1EAF9D9
          C6E76920DC6019F1AB83C3C3C3FFFFFFC3C3C3C3C3C3FFFFFFC3C3C3C3C3C3FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3FFFFFFEF9F71F4BB9B
          F8D6C2E76D27F5BFA0E97939C35516FDF2ECFBE8DDFCEBE1FDF2ECFCEDE4FDF2
          ECEF9F71DC6019F1AB83C3C3C3C3C3C3FFFFFFC3C3C3FFFFFFC3C3C3C3C3C3FF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C85716D75E18
          D35C18DC6019D15B17E16219F7D0B9CE5A17E97736E97736C65616FDF2ECFDF1
          EAFAE0D1D35C18F1AB83C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3
          C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFC3C3C3C3C3C3D15B17CC5917
          E76D27CE5A17F3B795FDF2ECF6C8AEDE6119EC8A51ED905BED935FFDF1EAFCEE
          E6FDF1EAE16219F2AD85C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFC3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFC3C3C3FFFFFFCE5A17EC8A52
          FBE5D8F1A97FFDF2ECFDF1EAF8D3BDDC6019EE9866E06219C35516FDF2ECFCED
          E4FCEEE6F5C2A4F1A87EC3C3C3C3C3C3FFFFFFC3C3C3FFFFFFFFFFFFFFFFFFC3
          C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C35516FDF2EC
          FCEDE4FCEEE6FCEDE4FCEDE4FDF1EAE97532E56319CC5917EE9664FCEFE8FCED
          E4FCEDE4FDF2ECF0A579C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3
          C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFC3C3C3D15B17CF5A17
          FCEBE1FCEFE8FCEDE4FCEDE4FCEDE4FDF1EAFDF2ECFDF2ECFDF1EAFDF1EAFCEF
          E8FBE8DDDA5F18F2AD85C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3FFFFFFD15B17CE5A17
          FAE1D2FDF1EAFCEDE4FCEDE4FCEDE4FCEDE4FBE9DFF6C6ABFCEDE4F6C5A9EB82
          46E8702BD85E18F2AD85C3C3C3C3C3C3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3D35C18D55D18
          F6CAB0F2AE87F9DCCBFCEDE4F8D1BBFCEFE8FDF2ECE97736CA5817DA5F18E062
          19E06219E06219F2AD85C3C3C3C3C3C3FFFFFFC3C3C3FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3D35C18E06219
          DE6119D55D18F4BB9BFBE6DAE8712DED905AF2AE87E76A22D85E18E16219E062
          19E06219E06219F2AD85C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFFFFFFFC3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E08049E16219
          E16219E16219D75E18E06219E16219E16219DE6119E16219E06219E06219E062
          19E06219E16219F6C8ADC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3FFFFFFA449A3EE9561
          E56319E56319E56319E56319E56319E56319E56319E56319E56319E56319E563
          19E56319F4B997A449A3A449A3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
          C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3A449A3}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 17
        TabStop = False
        Visible = False
        OnClick = btnConsultaFitClick
      end
      object ckbAbCrAu: TCheckBox
        Left = 1018
        Top = 5
        Width = 266
        Height = 17
        Caption = 'Utilizar abatimento autom'#225'tico de cr'#233'dito pendente'
        Enabled = False
        TabOrder = 7
        OnClick = ckbAbCrAuClick
      end
      object btnCliOutroVendedor: TBitBtnLocked
        Left = 375
        Top = 4
        Width = 136
        Height = 24
        Caption = 'Cliente de &outro vendedor'
        TabOrder = 2
        TabStop = False
        Visible = False
        OnClick = btnCliOutroVendedorClick
      end
      object edtCshBck: TEditFocus
        Left = 1068
        Top = 28
        Width = 74
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 16
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlForPag: TPanel
      Left = 1
      Top = 145
      Width = 1028
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      object Label2: TLabel
        Left = 4
        Top = 4
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Form. Pagto:'
      end
      object edtForPag: TEditFocus
        Tag = 99
        Left = 66
        Top = 0
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnChange = edtForPagChange
        OnKeyPress = edtForPagKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesForPag: TEditFocus
        Left = 132
        Top = 0
        Width = 881
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
    end
    object pnlCndPag: TPanel
      Left = 1
      Top = 122
      Width = 1028
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object lblCndPag: TLabel
        Left = 3
        Top = 4
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagto:'
      end
      object edtCodCnd: TEditFocus
        Tag = 99
        Left = 66
        Top = 0
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnChange = edtCodCndChange
        OnExit = edtCodCndExit
        OnKeyPress = edtCodCndKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object mskCndPag: TMaskEditFocus
        Tag = 99
        Left = 132
        Top = 0
        Width = 526
        Height = 22
        CharCase = ecUpperCase
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        TabOrder = 2
        Text = ''
        OnChange = mskCndPagChange
        OnEnter = mskCndPagEnter
        OnExit = mskCndPagExit
        OnKeyDown = mskCndPagKeyDown
        OnKeyPress = mskCndPagKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesCndPag: TEditFocus
        Left = 659
        Top = 0
        Width = 353
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
    end
    object pnlVendedor: TPanel
      Left = 1
      Top = 168
      Width = 1028
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
      object Label3: TLabel
        Left = 14
        Top = 4
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblEntrega: TLabel
        AlignWithMargins = True
        Left = 701
        Top = 5
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Entrega:'
      end
      object edtNomVen: TEditFocus
        Left = 132
        Top = 0
        Width = 433
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
      object edtSenVen: TEditFocus
        Tag = 99
        Left = 66
        Top = 0
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 0
        OnExit = edtSenVenExit
        OnKeyPress = edtSenVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlFlexVend: TPanel
        Left = 785
        Top = 0
        Width = 228
        Height = 23
        Alignment = taRightJustify
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        Visible = False
        object lblSldFle: TLabel
          Left = 76
          Top = -2
          Width = 142
          Height = 14
          Alignment = taRightJustify
          Caption = 'SALDO FLEX: R$ 999.999,99'
        end
        object lblFleAtu: TLabel
          Left = 4
          Top = 10
          Width = 214
          Height = 14
          Alignment = taRightJustify
          Caption = 'SALDO FLEX ATUALIZADO: R$ 999.999,99'
          Visible = False
        end
      end
      object edtEntrega: TEditFocus
        Tag = 99
        AlignWithMargins = True
        Left = 745
        Top = 0
        Width = 34
        Height = 22
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 10
        Margins.Bottom = 1
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 3
        Text = 'N'
        OnChange = edtEntregaChange
        OnExit = edtEntregaExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object chkReutilOrc: TCheckBox
        AlignWithMargins = True
        Left = 569
        Top = 4
        Width = 131
        Height = 17
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = 'Reutilizar Or'#231'amento?'
        TabOrder = 4
        WordWrap = True
      end
    end
    object pnlDigitador: TPanel
      Left = 1
      Top = 214
      Width = 1028
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 6
      object lblDigita: TLabel
        Left = 19
        Top = 4
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Digitador:'
      end
      object edtSenDig: TEditFocus
        Tag = 99
        Left = 66
        Top = 0
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        PasswordChar = '*'
        TabOrder = 0
        OnEnter = edtSenDigEnter
        OnExit = edtSenDigExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomDig: TEditFocus
        Left = 132
        Top = 0
        Width = 881
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
    end
    object pnlRepresentante: TPanel
      Left = 1
      Top = 191
      Width = 1028
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object Label4: TLabel
        Left = 5
        Top = 4
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor 2:'
      end
      object edtCodRep: TEditFocus
        Tag = 99
        Left = 66
        Top = 0
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodRepKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtDesRep: TEditFocus
        Left = 132
        Top = 0
        Width = 881
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
    end
    object pnlEmprestimoPlaca: TPanel
      Left = 1
      Top = 1
      Width = 1028
      Height = 34
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      Visible = False
      object pnlTipEmp: TPanel
        Left = 1
        Top = 1
        Width = 299
        Height = 32
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object rdgTipEmp: TRadioGroup
          Tag = 99
          Left = 66
          Top = -1
          Width = 217
          Height = 31
          Caption = 'Tipo de Empr'#233'stimo'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Entrada'
            'Sa'#237'da')
          TabOrder = 0
          OnClick = rdgTipEmpClick
          OnExit = rdgTipEmpExit
        end
      end
      object pnlPlacaVeiculo: TPanel
        Left = 300
        Top = 1
        Width = 727
        Height = 32
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        Visible = False
        object RxLabel2: TLabel
          Left = 639
          Top = 7
          Width = 61
          Height = 19
          Caption = 'KILOM.:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object edtDesVei: TEditFocus
          Left = 207
          Top = 2
          Width = 429
          Height = 26
          TabStop = False
          Alignment = taLeftJustify
          AutoSize = False
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
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
        object edtKM_Vei: TEditFocus
          Tag = 99
          Left = 702
          Top = 2
          Width = 140
          Height = 27
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -20
          Font.Name = 'Courier'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 10
          TipoTexto = ttInteiro
        end
        object pnlPlaVei: TPanel
          Left = 0
          Top = 0
          Width = 207
          Height = 32
          Align = alLeft
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          OnExit = pnlPlaVeiExit
          object RxLabel1: TLabel
            Left = -1
            Top = 7
            Width = 61
            Height = 19
            Caption = 'PLACA:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object mskPlaVei: TMaskEditFocus
            Tag = 99
            Left = 64
            Top = 2
            Width = 109
            Height = 27
            Hint = 'Pressione INSERT para inserir um novo Ve'#237'culo'
            AutoSelect = False
            AutoSize = False
            CharCase = ecUpperCase
            EditMask = 'aaa-9a99;0; '
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -20
            Font.Name = 'Courier'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Text = ''
            OnChange = mskPlaVeiChange
            OnKeyPress = mskPlaVeiKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object btnCadVei: TBitBtnLocked
            Left = 175
            Top = 1
            Width = 32
            Height = 29
            Hint = 'Cadastro de Ve'#237'culos'
            Glyph.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7BA41FFE5B73AFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCF6FFE3B2
              2AFFEAC45CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF0D6FFE1AB19FFE1AC1AFFFAF0
              D3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E2B3FFE2AD
              1FFFE1A914FFFEFCF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF7E8FFE2AE1FFFE2AE1FFFFCF7
              E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E9C6FFE3AF
              23FFE2AC1CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF3DDFFE5B536FFE2AE21FFE2AE20FFE7BB
              46FFE7BD4AFFE7BC49FFE7BC49FFE7BC49FFE7BC49FFE7BD4BFFE6BA41FFE2AD
              1FFFE3AF23FFE5B73AFFFAF2DCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF1D6FFE0A70EFFF5E3B3FFF6E5B9FFE2AE
              20FFE4B32EFFE4B32EFFE4B32EFFE4B32EFFE4B32EFFE4B32DFFE3AF23FFF9EE
              D3FFF1D997FFE0A810FFFAF1D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF1D9FFDFA406FFFFFFFFFFFFFFFFFFE3B0
              25FFE4B432FFE5B533FFE5B533FFE5B533FFE5B533FFE4B32FFFE7BA41FFFFFF
              FFFFFFFFFFFFDFA405FFFAF1DAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5B432FFE5B637FFE6B941FFE2AD
              1EFFE3AF24FFE3AF24FFE3AF24FFE3AF24FFE3AF24FFE3AF24FFE1AC1BFFE8BF
              4FFFE3B22BFFE5B534FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6BBFFF6E5B9FFF7E8
              BFFFF7E8BFFFF7E8BFFFF7E8BFFFF7E8BFFFF7E8BFFFF7E8BFFFF7E8BFFFF6E5
              B7FFF6E6BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECC869FFE6B93EFFE7BB
              44FFE7BB44FFE7BB44FFE7BB44FFE7BB44FFE7BB44FFE7BB44FFE7BB44FFE6B9
              3EFFECC869FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E6BCFFE2AD1DFFE4B3
              2FFFE4B32FFFE4B32FFFE4B32FFFE4B32FFFE4B32FFFE4B32FFFE4B32FFFE2AD
              1DFFF6E6BCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3AF22FFE4B3
              2FFFE4B431FFE4B431FFE4B431FFE4B431FFE4B431FFE4B431FFE4B32FFFE3AF
              22FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEED284FFE2AE
              1FFFE3B129FFE3B129FFE3B129FFE3B129FFE3B129FFE3B129FFE2AE1FFFEED2
              84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            TabStop = False
            OnClick = btnCadVeiClick
          end
        end
      end
    end
    object pnlClubeFidelidade_Sinaleiro: TPanel
      Left = 1
      Top = 99
      Width = 1028
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 7
      Visible = False
      object lblTotalPontosAdesao: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 3
        Width = 342
        Height = 16
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Alignment = taCenter
        Caption = 'Cliente pertence ao clube fidelidade - total de pontos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDataAdesao: TLabel
        AlignWithMargins = True
        Left = 426
        Top = 3
        Width = 107
        Height = 16
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Alignment = taCenter
        Caption = 'Data da ades'#227'o: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAnosAdesao: TLabel
        AlignWithMargins = True
        Left = 603
        Top = 3
        Width = 105
        Height = 16
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Alignment = taCenter
        Caption = '1 ano de ades'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSinaleiroDocAtual: TLabel
        Left = 730
        Top = 5
        Width = 99
        Height = 14
        Alignment = taRightJustify
        Caption = 'Sinaleiro: Doc. Atual:'
        Visible = False
      end
      object lblSinaleiroMesApuracao: TLabel
        Left = 864
        Top = 5
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Caption = 'M'#234's de Apura'#231#227'o:'
        Visible = False
      end
      object shpSinaleiroDocAtual: TShape
        Left = 832
        Top = 1
        Width = 27
        Height = 21
        Shape = stCircle
      end
      object shpSinaleiroMesApuracao: TShape
        Left = 956
        Top = 1
        Width = 27
        Height = 21
        Shape = stCircle
      end
      object edtTotPontosFidelidade: TEditFocus
        Left = 353
        Top = 0
        Width = 66
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDataAdesao: TMaskEditFocus
        Tag = 99
        Left = 536
        Top = 0
        Width = 61
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ReadOnly = True
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object bntSinaleiroInfo: TBitBtnLocked
        Left = 985
        Top = 1
        Width = 27
        Height = 21
        Caption = '?'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        TabStop = False
        OnClick = bntSinaleiroInfoClick
      end
    end
  end
  object pnlBotoesVenda: TPanel [6]
    Left = 0
    Top = 724
    Width = 1030
    Height = 46
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object FlwPnlBotoesVenda: TFlowPanel
      Left = 1
      Top = 0
      Width = 1028
      Height = 45
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object btnConfirma: TBitBtnLocked
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 121
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ F10 ] Fechamento'
        Enabled = False
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnPopMenu: TBitBtnLocked
        AlignWithMargins = True
        Left = 123
        Top = 1
        Width = 22
        Height = 20
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alTop
        Enabled = False
        Glyph.Data = {
          36060000424D3606000000000000360000002800000020000000100000000100
          18000000000000060000C40E0000C40E00000000000000000000000000000000
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
          0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
          000000000000000000000000000000000000000000000000000000000000001E
          1E1E1E1E1E000000000000000000000000000000000000000000000000000000
          0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
          000000000000000000000000000000000000000000000000000000001E1E1E3C
          3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000000000
          0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
          000000000000000000000000000000000000000000000000001E1E1E3C3C3C3C
          3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000
          0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
          000000000000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000
          0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
          1E0000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000
          1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C1E1E1E0000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C
          3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000}
        Margin = 0
        NumGlyphs = 2
        Spacing = 0
        TabOrder = 1
        OnClick = btnPopMenuClick
      end
      object btnCCCli: TBitBtnLocked
        AlignWithMargins = True
        Left = 146
        Top = 1
        Width = 109
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[F3] C./C.'
        TabOrder = 2
        Visible = False
        OnClick = btnCCCliClick
      end
      object btnResFin: TBitBtnLocked
        AlignWithMargins = True
        Left = 257
        Top = 1
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ F7 ] Resumo Financeiro'
        TabOrder = 3
        Visible = False
        OnClick = btnResFinClick
      end
      object btnMostraMargem: TBitBtnLocked
        AlignWithMargins = True
        Left = 402
        Top = 1
        Width = 105
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[F4] Margem/Lucro'
        TabOrder = 4
        Visible = False
        OnClick = btnMostraMargemClick
      end
      object btnMostraItens: TBitBtnLocked
        AlignWithMargins = True
        Left = 509
        Top = 1
        Width = 93
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[F5] Mostra Itens'
        TabOrder = 5
        Visible = False
        OnClick = btnMostraItensClick
      end
      object btnEstLoj: TBitBtnLocked
        AlignWithMargins = True
        Left = 604
        Top = 1
        Width = 106
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[F6] Estoque Lojas'
        TabOrder = 6
        OnClick = btnEstLojClick
      end
      object btnMnuVendas: TBitBtnLocked
        AlignWithMargins = True
        Left = 712
        Top = 1
        Width = 137
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = '[Alt + F3] Inf. de Vendas'
        TabOrder = 7
        OnClick = btnMnuVendasClick
      end
      object btnEndEnt: TBitBtnLocked
        AlignWithMargins = True
        Left = 851
        Top = 1
        Width = 129
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[F2] End. Entrega'
        TabOrder = 8
        OnClick = btnEndEntClick
      end
      object btnRelatorioPedidos: TBitBtnLocked
        AlignWithMargins = True
        Left = 1
        Top = 23
        Width = 109
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[Alt+F2] Ped.D'
        TabOrder = 9
        OnClick = btnRelatorioPedidosClick
      end
      object btnEntFut: TBitBtnLocked
        AlignWithMargins = True
        Left = 112
        Top = 23
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[Alt+F8] Ent. Futura'
        TabOrder = 10
        Visible = False
        OnClick = btnEntFutClick
      end
      object btnServico: TBitBtnLocked
        AlignWithMargins = True
        Left = 257
        Top = 23
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[Alt+F5] Servi'#231'os'
        TabOrder = 11
        OnClick = btnServicoClick
      end
      object btnFinan: TBitBtnLocked
        AlignWithMargins = True
        Left = 402
        Top = 23
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ Alt + F4 ] Financiamento'
        TabOrder = 12
        OnClick = btnFinanClick
      end
      object btnMsgPed: TBitBtnLocked
        AlignWithMargins = True
        Left = 547
        Top = 23
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = 'Mensagens do Pedido'
        TabOrder = 13
        Visible = False
        OnClick = btnMsgPedClick
      end
      object btnNotEnt: TBitBtnLocked
        AlignWithMargins = True
        Left = 692
        Top = 23
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = '[Alt+ F6] Itens Nota Ent.'
        TabOrder = 14
        Visible = False
        OnClick = btnNotEntClick
      end
      object btnCancelarVenda: TBitBtnLocked
        AlignWithMargins = True
        Left = 837
        Top = 23
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[ Esc ] Cancelar'
        TabOrder = 15
        OnClick = btnCancelarVendaClick
      end
      object btnTotalDesejadoVenda: TBitBtnLocked
        AlignWithMargins = True
        Left = 1
        Top = 45
        Width = 143
        Height = 20
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alTop
        Caption = '[Shift+F6] Total Desej. Venda'
        TabOrder = 16
        Visible = False
        OnClick = btnTotalDesejadoVendaClick
      end
    end
  end
  object pnlDadosAdicionais: TPanel [7]
    Left = 0
    Top = 649
    Width = 1030
    Height = 75
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object lblMarCam: TLabel
      Tag = 99
      Left = 1
      Top = 3
      Width = 327
      Height = 14
      AutoSize = False
      Caption = 
        '000000000 / 000000000 / 000000000 / 000000000 / 000000000 / 0000' +
        '00000 /'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label32: TLabel
      Left = 845
      Top = 7
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total dos Itens:'
    end
    object lblTotIpi: TLabel
      Left = 717
      Top = 7
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total c\ IPI:'
      Visible = False
    end
    object lblTotSer: TLabel
      Left = 557
      Top = 7
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total do Servi'#231'o:'
    end
    object lblSohIPI: TLabel
      Left = 418
      Top = 32
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total do IPI:'
    end
    object lblTotImp: TLabel
      Left = 863
      Top = 32
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object shpMargemDoc: TShape
      Left = 844
      Top = 31
      Width = 12
      Height = 12
      Brush.Color = clGreen
      Pen.Color = clGreen
      Visible = False
    end
    object lblInfFat: TLabel
      Tag = 99
      Left = 82
      Top = 34
      Width = 27
      Height = 12
      AutoSize = False
      Caption = 'MI/FF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblSohST: TLabel
      Left = 116
      Top = 32
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total do ST:'
    end
    object lblQtdPon: TLabel
      Left = 180
      Top = 13
      Width = 71
      Height = 14
      Caption = 'Total Pontos:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblPesTot: TLabel
      Left = 5
      Top = 13
      Width = 60
      Height = 14
      Caption = 'Peso Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotLitragem: TLabel
      Left = 5
      Top = 26
      Width = 76
      Height = 14
      Caption = 'Tot. Litragem:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSohFCP: TLabel
      Left = 253
      Top = 32
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total do FCP ST:'
    end
    object lbCobrancaYapay: TLabel
      Left = 333
      Top = 2
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cobran'#231'a Yapay:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblCreCli: TLabel
      Left = 1024
      Top = 6
      Width = 101
      Height = 14
      Caption = 'Tot. Cr'#233'ditos Cliente: '
    end
    object lblTotCBS: TLabel
      Left = 554
      Top = 32
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'CBS:'
      Visible = False
    end
    object lblTotIBS: TLabel
      Left = 658
      Top = 32
      Width = 19
      Height = 14
      Alignment = taRightJustify
      Caption = 'IBS:'
      Visible = False
    end
    object lblTotIS: TLabel
      Left = 755
      Top = 32
      Width = 12
      Height = 14
      Alignment = taRightJustify
      Caption = 'IS:'
      Visible = False
    end
    object edtTotGer: TEditFocus
      Left = 921
      Top = 3
      Width = 92
      Height = 22
      TabStop = False
      Alignment = taRightJustify
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
      TabOrder = 0
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotIpi: TEditFocus
      Left = 770
      Top = 3
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotSer: TEditFocus
      Left = 642
      Top = 3
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSohIPI: TEditFocus
      Left = 474
      Top = 26
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotImp: TEditFocus
      Left = 921
      Top = 26
      Width = 92
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      AutoSize = False
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSohST: TEditFocus
      Left = 176
      Top = 26
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlDadosFazenda: TPanel
      Left = 1
      Top = 46
      Width = 1028
      Height = 14
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = 'Aqui ser'#227'o exibidos os dados da Fazenda'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 7
    end
    object pnlEmbarcacao: TPanel
      Left = 1
      Top = 60
      Width = 1028
      Height = 14
      Align = alBottom
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 6
      Visible = False
      object lblEmbarcacao: TLabel
        Left = 0
        Top = 0
        Width = 1028
        Height = 14
        Align = alClient
        Caption = 'Aqui ser'#227'o exibidos os dados da Embarca'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 222
      end
    end
    object edtSohFCP: TEditFocus
      Left = 335
      Top = 26
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object lbLinkCobrancaYapay: TLinkLabel
      Left = 427
      Top = 2
      Width = 109
      Height = 18
      Caption = 'lbLinkCobrancaYapay'
      TabOrder = 9
      Visible = False
      OnLinkClick = lbLinkCobrancaYapayLinkClick
    end
    object edtTotCBS: TEditFocus
      Left = 581
      Top = 26
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
      Text = '0,00'
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotIBS: TEditFocus
      Left = 680
      Top = 26
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      Text = '0,00'
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotIS: TEditFocus
      Left = 770
      Top = 26
      Width = 71
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      Text = '0,00'
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlEntCD: TPanel [8]
    Left = 0
    Top = 237
    Width = 1030
    Height = 16
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object chkEntCD: TCheckBox
      AlignWithMargins = True
      Left = 295
      Top = 2
      Width = 130
      Height = 12
      Margins.Left = 66
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'Entrega Atrav'#233's do CD'
      TabOrder = 1
      OnClick = chkEntCDClick
    end
    object chkCamLim: TCheckBox
      AlignWithMargins = True
      Left = 67
      Top = 2
      Width = 161
      Height = 12
      Margins.Left = 66
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'Campanha Limitada no Brinde'
      TabOrder = 0
    end
    object chkDesmembrarNF_NS: TCheckBox
      AlignWithMargins = True
      Left = 492
      Top = 2
      Width = 358
      Height = 12
      Margins.Left = 66
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = 
        'Venda de Concreto - Desmembrar Nota Fiscal de Produtos e Servi'#231'o' +
        's'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = chkDesmembrarNF_NSClick
    end
  end
  object pnlLegendas: TFlowPanel [9]
    Left = 0
    Top = 633
    Width = 1030
    Height = 16
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 7
    object pnlSemEstoque: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 98
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 0
      Visible = False
      object shp1: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clRed
      end
      object lbl1: TLabel
        Left = 16
        Top = 1
        Width = 78
        Height = 12
        Caption = 'Itens sem estoque'
      end
    end
    object pnlOrdPro: TPanel
      AlignWithMargins = True
      Left = 101
      Top = 1
      Width = 102
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 1
      Visible = False
      object shpOrdPro: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clPurple
      end
      object lblOrdPro: TLabel
        Left = 15
        Top = 1
        Width = 82
        Height = 12
        Caption = 'Ordem de produ'#231#227'o'
      end
    end
    object pnlProdCampanha: TPanel
      AlignWithMargins = True
      Left = 205
      Top = 1
      Width = 63
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 2
      Visible = False
      object shp2: TShape
        Left = 1
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clBlue
      end
      object lbl2: TLabel
        Left = 13
        Top = 1
        Width = 45
        Height = 12
        Caption = 'Campanha'
      end
    end
    object pnlProdBonus: TPanel
      AlignWithMargins = True
      Left = 270
      Top = 1
      Width = 48
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 3
      Visible = False
      object shp3: TShape
        Left = 6
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clGreen
      end
      object lbl3: TLabel
        Left = 18
        Top = 1
        Width = 26
        Height = 12
        Caption = 'B'#244'nus'
      end
    end
    object pnlEscPrd: TPanel
      AlignWithMargins = True
      Left = 320
      Top = 1
      Width = 194
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 4
      Visible = False
      object shpEscPrd: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clMaroon
      end
      object lblEscPrd: TLabel
        Left = 16
        Top = 1
        Width = 172
        Height = 12
        Caption = 'Emp. Produ'#231#227'o [ESPA'#199'O] - Alt. Empresa'
      end
    end
    object pnlOutVen: TPanel
      AlignWithMargins = True
      Left = 516
      Top = 1
      Width = 234
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 5
      Visible = False
      object shp4: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clGray
      end
      object lbl4: TLabel
        Left = 15
        Top = 1
        Width = 214
        Height = 12
        Caption = 'Itens de outro Vendedor (N'#227'o podem ser alterados)'
      end
    end
    object pnlQtdEmbFec: TPanel
      AlignWithMargins = True
      Left = 752
      Top = 1
      Width = 97
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 6
      Visible = False
      object shp5: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clYellow
      end
      object lbl5: TLabel
        Left = 15
        Top = 1
        Width = 76
        Height = 12
        Caption = 'Qtd.Emb.Fechada'
      end
    end
    object pnlPromo: TPanel
      AlignWithMargins = True
      Left = 851
      Top = 1
      Width = 62
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 7
      Visible = False
      object Shape1: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clTeal
      end
      object Label6: TLabel
        Left = 15
        Top = 1
        Width = 42
        Height = 12
        Caption = 'Promo'#231#227'o'
      end
    end
    object pnlPromoUnitarMaior: TPanel
      AlignWithMargins = True
      Left = 915
      Top = 1
      Width = 105
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 8
      Visible = False
      object shpPromoUnitarMaior: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = 4227200
      end
      object lblPromoUnitarMaior: TLabel
        Left = 15
        Top = 1
        Width = 90
        Height = 12
        Caption = 'Promo'#231#227'o Unit. Maior'
      end
    end
    object pnlValFor: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 17
      Width = 172
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 9
      Visible = False
      object Shape2: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = clNavy
      end
      object Label7: TLabel
        Left = 15
        Top = 1
        Width = 152
        Height = 12
        Caption = 'Valid. Pre'#231'o Tabela Fornec. Expirada'
      end
    end
    object pnlAbastecimento: TPanel
      AlignWithMargins = True
      Left = 175
      Top = 17
      Width = 81
      Height = 12
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 10
      Visible = False
      object shpAbastecimento: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = 33023
      end
      object lblAbastecimento: TLabel
        Left = 15
        Top = 1
        Width = 62
        Height = 12
        Caption = 'Abastecimento'
      end
    end
    object pnlSobEncomenda: TPanel
      AlignWithMargins = True
      Left = 258
      Top = 17
      Width = 90
      Height = 14
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Anchors = []
      BevelOuter = bvNone
      Color = 16770261
      Ctl3D = False
      ParentBackground = False
      ParentCtl3D = False
      TabOrder = 11
      Visible = False
      object shpSobEncomenda: TShape
        Left = 3
        Top = 2
        Width = 10
        Height = 10
        Brush.Color = 8036607
      end
      object lblSobEncomenda: TLabel
        Left = 15
        Top = 1
        Width = 68
        Height = 12
        Caption = 'Sob Encomenda'
      end
    end
  end
  object pnlDadosItemFixo: TPanel [10]
    Left = 0
    Top = 301
    Width = 1030
    Height = 252
    Align = alTop
    ParentColor = True
    TabOrder = 4
    OnEnter = pnlDadosItemFixoEnter
    object ImgPnlDadosItem: TImage
      Left = 0
      Top = 0
      Width = 0
      Height = 0
    end
    object pnlDadosItem: TPanel
      Left = 1
      Top = 1
      Width = 1028
      Height = 247
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object pnlItemFim: TPanel
        Left = 0
        Top = 63
        Width = 1028
        Height = 161
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object pnlEntrega: TPanel
          Left = 0
          Top = 0
          Width = 1028
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object lblMotEntFut: TLabel
            Left = 360
            Top = 6
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Motivo:'
            Visible = False
          end
          object lblDatEnt: TLabel
            Left = 906
            Top = 6
            Width = 46
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Ent.:'
            Visible = False
          end
          object lblEntRet: TLabel
            Left = 25
            Top = 6
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'Destino:'
          end
          object lblCliBus: TLabel
            Left = 533
            Top = 6
            Width = 87
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cliente vai retirar?'
            Visible = False
          end
          object lblTurno: TLabel
            Left = 710
            Top = 6
            Width = 31
            Height = 14
            Alignment = taRightJustify
            Caption = 'Turno:'
            Visible = False
          end
          object lblDiaEnt: TLabel
            Left = 810
            Top = 6
            Width = 45
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Dias Ent.:'
          end
          object pnlTipEnt: TPanel
            Left = 138
            Top = -2
            Width = 219
            Height = 27
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            object lblTipEnt: TLabel
              Left = 2
              Top = 8
              Width = 63
              Height = 14
              Alignment = taRightJustify
              Caption = 'Tipo Entrega:'
              Visible = False
            end
            object cmbTipEnt: TComboBoxFocus
              Tag = 99
              Left = 65
              Top = 2
              Width = 152
              Height = 22
              Style = csDropDownList
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemIndex = 1
              ParentFont = False
              TabOrder = 0
              Text = 'IMEDIATA'
              Visible = False
              OnChange = cmbTipEntChange
              OnEnter = cmbTipEntEnter
              Items.Strings = (
                'FUTURA'
                'IMEDIATA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object pnlLocRet: TPanel
            Left = 138
            Top = -2
            Width = 219
            Height = 27
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            object lblLocRet: TLabel
              Left = 4
              Top = 8
              Width = 60
              Height = 14
              Alignment = taRightJustify
              Caption = 'Local Retira:'
            end
            object cmbLocRet: TComboBoxFocus
              Tag = 99
              Left = 65
              Top = 2
              Width = 152
              Height = 22
              Style = csDropDownList
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              OnChange = cmbLocRetChange
              Items.Strings = (
                'CAIXA'
                'EXPEDI'#199#195'O'
                'BALC'#195'O'
                'BALC'#195'O 2')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object cmbMotEntFut: TComboBoxFocus
            Tag = 99
            Left = 393
            Top = 0
            Width = 136
            Height = 22
            Style = csDropDownList
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            Visible = False
            OnChange = cmbMotEntFutChange
            Items.Strings = (
              'Falta Produto'
              'Aguardando Cliente'
              'Previs'#227'o de Entrega')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object mskDtaEnt: TMaskEditFocus
            Tag = 99
            Left = 952
            Top = 1
            Width = 61
            Height = 22
            CharCase = ecUpperCase
            EditMask = '99/99/9999'
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 7
            Text = '  /  /    '
            Visible = False
            OnChange = mskDtaEntChange
            OnExit = mskDtaEntExit
            OnKeyPress = mskDtaEntKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object cmbEntRet: TComboBoxFocus
            Tag = 99
            Left = 66
            Top = 0
            Width = 71
            Height = 22
            Style = csDropDownList
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemIndex = 1
            ParentFont = False
            TabOrder = 0
            Text = 'RETIRA'
            OnChange = cmbEntRetChange
            OnEnter = cmbEntRetEnter
            Items.Strings = (
              'ENTREGA'
              'RETIRA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmbCliBus: TComboBoxFocus
            Tag = 99
            Left = 621
            Top = 0
            Width = 46
            Height = 22
            Style = csDropDownList
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            Visible = False
            Items.Strings = (
              'N'#195'O'
              'SIM')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object cmbTurEnt: TComboBoxFocus
            Tag = 99
            Left = 742
            Top = 1
            Width = 60
            Height = 22
            Style = csDropDownList
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 5
            Visible = False
            Items.Strings = (
              'Manh'#227
              'Tarde'
              'Noite')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtDiaEnt: TEditFocus
            Tag = 99
            Left = 856
            Top = 1
            Width = 29
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 6
            OnEnter = edtDiaEntEnter
            OnExit = edtDiaEntExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 3
            TipoTexto = ttInteiro
          end
        end
        object pnlDadosItemInterno: TPanel
          Left = 0
          Top = 23
          Width = 979
          Height = 138
          Align = alLeft
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object pnlQuantidade: TPanel
            Left = 0
            Top = 46
            Width = 979
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 2
            object lblQuantidade: TLabel
              Left = 6
              Top = 4
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'Quantidade:'
            end
            object lblCodFab: TLabel
              Left = 359
              Top = 4
              Width = 64
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'd. F'#225'brica:'
            end
            object lblTipMov: TLabel
              Left = 714
              Top = 4
              Width = 54
              Height = 14
              Alignment = taRightJustify
              Caption = 'Movimento:'
              Visible = False
            end
            object lblTabPrecoItem: TLabel
              Left = 616
              Top = 4
              Width = 51
              Height = 14
              Caption = 'Tab.Pre'#231'o:'
              Visible = False
            end
            object btnNumSeries: TSpeedButton
              Left = 66
              Top = 0
              Width = 71
              Height = 22
              Hint = 'N'#250'meros de S'#233'rie do item'
              Caption = 'N'#250'ms. S'#233'rie'
              ParentShowHint = False
              ShowHint = True
              Visible = False
              OnClick = btnNumSeriesClick
            end
            object lblMulVen: TLabel
              Left = 163
              Top = 3
              Width = 44
              Height = 14
              Caption = 'Mult.Ven.'
            end
            object btnQbit: TImage
              Left = 137
              Top = 2
              Width = 21
              Height = 18
              Cursor = crHandPoint
              Hint = 'Ctrl+B'
              Center = True
              ParentShowHint = False
              Picture.Data = {
                0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                000000100803000000282D0F53000001E0504C54450000003091F83091F83091
                F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F830
                91F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F8
                3091F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091
                F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F830
                91F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F8
                3091F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091
                F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F830
                91F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F8
                3091F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091
                F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F830
                91F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F8
                3091F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091
                F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F830
                91F83091F83091F83091F83091F83091F83091F83091F83091F83091F83091F8
                3091F83091F83091F83091F83091F83091F83091F8C3525DE50000009F74524E
                53004EF9FCFCFCFDFCF9504FFCFFFFFC513DD1C3C6C6C1BFBFC1C6C6C3D23F00
                0394E1E19602000002010285C9C88602010200000190CCBFC6CACAC6BECE8302
                000117EFD69292D5E30C010455FA630B0B62FA4603039E835B5C8190040BE424
                9FA223DB0540E71005A1A3060FE6388AF422807F21F382CF7A0407070478CB35
                FCF952020250F9FA3383FCFFFEFEB57271B5FDFEFFFC82CEFDFEFDFFFDFEFDCF
                BA8C136A000000F34944415418D31D8D5543140000C646DC511ED2A580E4D129
                DD28DDDDDD9DD2218DA48020FDFD550EF6B6BD0CAC646D636B301A0DB676F672
                001CE5F4491F989CF5D9125C5CDDDC3D3CBDBC7D7CFDBE7CF5E79D8040BE0505
                87101AF6A1E1E68848A2A26362898B4F4884A464BEA7A4A6A567646665E7909B
                473E0585D28F9F45C5524929659453A1CA2AAA6BA8AD533D0D34D2A466686985
                36B5D3019D5DEA869E5EE853FF80E532A8A1614646C7C69998D494254C6B6616
                E6E6616151BFC0BC242DB3B2BAB6CE86B4095BDBD2EF1D76F7D83F900E8F38D6
                9F93D3B3F38BCBBF57D737FF74CB9DFEEBFE418F263D3DEB45AF6F15104A2D38
                9246F40000000049454E44AE426082}
              ShowHint = True
              Visible = False
              OnClick = btnQbitClick
            end
            object lblCxMaster: TLabel
              Left = 258
              Top = 6
              Width = 52
              Height = 14
              Caption = 'Cx. Master'
            end
            object edtQtdIte: TEditFocus
              Tag = 99
              Left = 66
              Top = 0
              Width = 71
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
              ParentFont = False
              TabOrder = 0
              OnEnter = edtQtdIteEnter
              OnExit = edtQtdIteExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtCodFab: TEditFocus
              Tag = 99
              Left = 425
              Top = 0
              Width = 186
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 25
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              NormalColor = 16768952
              FocusColor = clSilver
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 25
              TipoTexto = ttAlfanumerico
            end
            object cmbEntSai: TComboBoxFocus
              Tag = 99
              Left = 771
              Top = 0
              Width = 66
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemIndex = 1
              ParentFont = False
              TabOrder = 3
              Text = 'SAIDA'
              Visible = False
              OnChange = cmbEntSaiChange
              Items.Strings = (
                'ENTRADA'
                'SAIDA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cbTabPrecoItem: TComboBoxFocus
              Tag = 99
              Left = 672
              Top = 0
              Width = 35
              Height = 22
              Style = csDropDownList
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              Sorted = True
              TabOrder = 2
              Visible = False
              OnChange = cbTabPrecoItemChange
              OnEnter = cbTabPrecoItemEnter
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object chkPegou: TCheckBox
              Left = 843
              Top = 3
              Width = 60
              Height = 17
              Caption = 'Pegou?'
              TabOrder = 4
              Visible = False
              OnClick = chkPegouClick
            end
            object btnQtdPigmentos: TBitBtnLocked
              Left = 899
              Top = -1
              Width = 75
              Height = 25
              Hint = 'C'#225'lcula a quantidade de pigmentos'
              Caption = 'Qtd. Pigmento'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              TabStop = False
              Visible = False
              OnClick = btnQtdPigmentosClick
            end
            object edtMulVen: TEditFocus
              Left = 208
              Top = 0
              Width = 45
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              ReadOnly = True
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfabetico
            end
            object edtCxMaster: TEditFocus
              Left = 312
              Top = 0
              Width = 43
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              ReadOnly = True
              TabOrder = 7
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfabetico
            end
          end
          object pnlQtdMadeira: TPanel
            Left = 0
            Top = 0
            Width = 979
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 0
            object lblComPec: TLabel
              Left = 143
              Top = 5
              Width = 59
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Comprim.:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblLarPec: TLabel
              Left = 344
              Top = 5
              Width = 49
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Largura:'
            end
            object lblEspPec: TLabel
              Left = 551
              Top = 5
              Width = 55
              Height = 14
              Alignment = taRightJustify
              Caption = 'Espessura:'
            end
            object lblQtdMadeira: TLabel
              Left = 8
              Top = 5
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'Qtd. Pe'#231'as:'
            end
            object lblMedCom: TLabel
              Tag = 99
              Left = 265
              Top = 5
              Width = 16
              Height = 14
              Caption = 'mm'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object lblMedLar: TLabel
              Tag = 99
              Left = 456
              Top = 5
              Width = 16
              Height = 14
              Caption = 'mm'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object lblUntPec: TLabel
              Left = 671
              Top = 4
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vlr. Unit. Pe'#231'a:'
              Visible = False
            end
            object edtComPec: TEditFocus
              Tag = 99
              Left = 203
              Top = 0
              Width = 60
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
              ParentFont = False
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtLarPec: TEditFocus
              Tag = 99
              Left = 393
              Top = 0
              Width = 60
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
              ParentFont = False
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtEspPec: TEditFocus
              Tag = 99
              Left = 607
              Top = 0
              Width = 60
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
              ParentFont = False
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtQtdPec: TEditFocus
              Tag = 99
              Left = 66
              Top = 0
              Width = 71
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
              ParentFont = False
              TabOrder = 0
              OnExit = edtQtdPecExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtUntPec: TEditFocus
              Tag = 99
              Left = 742
              Top = 1
              Width = 60
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
              Color = 16768952
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
              Visible = False
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object pnlInfMadeira: TPanel
            Left = 0
            Top = 92
            Width = 979
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 3
            object Label19: TLabel
              Left = 5
              Top = 5
              Width = 59
              Height = 14
              Alignment = taRightJustify
              Caption = 'Aparelhada:'
            end
            object ColorLabel1: TColorLabel
              Left = 86
              Top = 4
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
            object Label20: TLabel
              Left = 160
              Top = 5
              Width = 42
              Height = 14
              Alignment = taRightJustify
              Caption = 'Acr. Ap.:'
            end
            object ColorLabel5: TColorLabel
              Left = 264
              Top = 5
              Width = 10
              Height = 14
              Caption = '%'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object Label21: TLabel
              Left = 358
              Top = 5
              Width = 59
              Height = 14
              Alignment = taRightJustify
              Caption = 'Beneficiam.:'
            end
            object ColorLabel3: TColorLabel
              Left = 439
              Top = 4
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
            object Label22: TLabel
              Left = 529
              Top = 5
              Width = 66
              Height = 14
              Alignment = taRightJustify
              Caption = 'Acr. Benefic.:'
            end
            object ColorLabel4: TColorLabel
              Left = 669
              Top = 6
              Width = 10
              Height = 14
              Caption = '%'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object edtAparel: TEditFocus
              Tag = 99
              Left = 66
              Top = 0
              Width = 15
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
              MaxLength = 1
              ParentFont = False
              TabOrder = 0
              Text = 'N'
              OnChange = edtAparelChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
            object edtPerApa: TEditFocus
              Tag = 99
              Left = 203
              Top = 0
              Width = 58
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
              ParentFont = False
              TabOrder = 1
              OnEnter = edtPerApaEnter
              OnExit = edtPerApaExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtBenefi: TEditFocus
              Tag = 99
              Left = 418
              Top = 0
              Width = 15
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
              MaxLength = 1
              ParentFont = False
              TabOrder = 2
              Text = 'N'
              OnChange = edtBenefiChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
            object edtPerBen: TEditFocus
              Tag = 99
              Left = 597
              Top = 0
              Width = 66
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
              ParentFont = False
              TabOrder = 3
              OnEnter = edtPerBenEnter
              OnExit = edtPerBenExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object pnlPrecoItem: TPanel
            Left = 0
            Top = 115
            Width = 979
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 4
            object lblVlrUnit: TLabel
              Left = 6
              Top = 5
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vlr. Unit'#225'rio:'
            end
            object lblDesCon: TLabel
              Left = 252
              Top = 5
              Width = 49
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto:'
            end
            object lblUniLiq: TLabel
              Left = 346
              Top = 5
              Width = 63
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vlr. Unit. L'#237'q.:'
              Visible = False
            end
            object Label15: TLabel
              Left = 599
              Top = 5
              Width = 53
              Height = 14
              Alignment = taRightJustify
              Caption = 'Valor Total:'
            end
            object lblVerStt: TLabel
              Left = 140
              Top = 0
              Width = 49
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Caption = 'Pre'#231'o     (Ver ST):   '
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object lblProdutoPromocao: TLabel
              Left = 925
              Top = -2
              Width = 52
              Height = 10
              Caption = 'Em Promo'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 10
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              Visible = False
            end
            object lblVrTotCImpostos: TLabel
              Left = 746
              Top = 0
              Width = 50
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Caption = 'Vr. Total c\ Impostos:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object lblUnitComImpostos: TLabel
              Left = 480
              Top = 0
              Width = 50
              Height = 23
              Alignment = taCenter
              AutoSize = False
              Caption = 'Vr. Unit. C\ Impostos:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object edtUnitar: TEditFocus
              Tag = 99
              Left = 66
              Top = 0
              Width = 71
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
              ParentFont = False
              TabOrder = 0
              OnChange = edtUnitarChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,####0.000000'
            end
            object edtDesCon: TEditFocus
              Tag = 99
              Left = 302
              Top = 0
              Width = 38
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
              ParentFont = False
              TabOrder = 2
              OnChange = edtDesConChange
              OnExit = edtDesConExit
              OnKeyPress = edtDesConKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtUniLiq: TEditFocus
              Tag = 99
              Left = 412
              Top = 0
              Width = 65
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
              ParentFont = False
              TabOrder = 3
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtTotIte: TEditFocus
              Tag = 99
              Left = 655
              Top = 0
              Width = 90
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              NormalColor = 16768952
              FocusColor = clSilver
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object chkBrinde: TCheckBox
              Left = 889
              Top = 6
              Width = 56
              Height = 16
              Caption = 'Brinde?'
              TabOrder = 7
              OnClick = chkBrindeClick
            end
            object edtVerStt: TEditFocus
              Tag = 99
              Left = 180
              Top = 0
              Width = 71
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
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
              OnChange = edtUnitarChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,####0.000000'
            end
            object edtVrTotCImpostos: TEditFocus
              Tag = 99
              Left = 797
              Top = 0
              Width = 90
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Color = 16768952
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 6
              Visible = False
              NormalColor = 16768952
              FocusColor = clSilver
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtUnitComImpostos: TEditFocus
              Tag = 99
              Left = 531
              Top = 0
              Width = 65
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
              ParentFont = False
              TabOrder = 4
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object pnlCotacaoDolar: TPanel
            Left = 0
            Top = 138
            Width = 979
            Height = 22
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 5
            object Label12: TLabel
              Left = 2
              Top = 5
              Width = 62
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vl.Unit.D'#243'lar:'
            end
            object Label13: TLabel
              Left = 171
              Top = 5
              Width = 90
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vlr. Cota'#231#227'o D'#243'lar:'
            end
            object Label14: TLabel
              Left = 371
              Top = 5
              Width = 83
              Height = 14
              Alignment = taRightJustify
              Caption = 'Data da Cota'#231#227'o:'
            end
            object edtUniDol: TEditFocus
              Tag = 99
              Left = 66
              Top = 0
              Width = 71
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              CharCase = ecUpperCase
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,####0.0000'
            end
            object edtVlCtVn: TEditFocus
              Left = 263
              Top = 0
              Width = 76
              Height = 22
              TabStop = False
              Alignment = taRightJustify
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
              EditFormat = '#,####0.0000'
            end
            object edtDtCtVn: TEditFocus
              Left = 456
              Top = 0
              Width = 74
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 2
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlUltVnd: TPanel
            Left = 0
            Top = 69
            Width = 979
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 6
            Visible = False
            object pnlUltVndDados: TPanel
              Left = 0
              Top = 0
              Width = 634
              Height = 23
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object lblUltVndTip: TLabel
                Left = 2
                Top = 4
                Width = 64
                Height = 14
                Alignment = taRightJustify
                Caption = 'Or'#231'amento:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDescUltVndQtd: TLabel
                Left = 138
                Top = 4
                Width = 29
                Height = 14
                Alignment = taRightJustify
                Caption = 'Qtde:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDescUltVndVal: TLabel
                Left = 228
                Top = 4
                Width = 38
                Height = 14
                Alignment = taRightJustify
                Caption = 'Vr.Unit:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDescUltVndVen: TLabel
                Left = 468
                Top = 4
                Width = 31
                Height = 14
                Alignment = taRightJustify
                Caption = 'Vend:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblUltVndDta: TLabel
                Left = 69
                Top = 4
                Width = 66
                Height = 14
                Caption = 'dd/mm/aaaa'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblUltVndQtd: TLabel
                Left = 168
                Top = 4
                Width = 21
                Height = 14
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblUltVndUni: TLabel
                Left = 268
                Top = 4
                Width = 21
                Height = 14
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblUltVndVen: TLabel
                Left = 502
                Top = 4
                Width = 91
                Height = 14
                AutoSize = False
                Caption = 'Nome Vendedor'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDescUltVndValLiq: TLabel
                Left = 341
                Top = 4
                Width = 54
                Height = 14
                Alignment = taRightJustify
                Caption = 'Vr.Un L'#237'q.:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblUltVndUniLiq: TLabel
                Left = 398
                Top = 4
                Width = 21
                Height = 14
                Caption = '0,00'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
            object pnlUltVndMot: TPanel
              Left = 634
              Top = 0
              Width = 178
              Height = 23
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 1
              object lblDescUltVndMot: TLabel
                Left = 2
                Top = 4
                Width = 40
                Height = 14
                Alignment = taRightJustify
                Caption = 'Motivo:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblUltVndMot: TLabel
                Left = 48
                Top = 4
                Width = 126
                Height = 14
                AutoSize = False
                Caption = 'Motivo'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
            object pnlUltVndBotoes: TPanel
              Left = 812
              Top = 0
              Width = 90
              Height = 23
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 2
              object imgUltVnd: TcxImage
                Left = 6
                Top = 0
                Hint = 'Houve altera'#231#227'o no custo deste produto em 99/99/9999'
                TabStop = False
                ParentShowHint = False
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF610000001974455874536F667477617265004164
                  6F626520496D616765526561647971C9653C0000001B744558745469746C6500
                  5761726E696E673B4E6F74696669636174696F6E3BB6E7798600000241494441
                  54785EA58F5F48536118C64FC5A02E9288EE2BA8816585ABFC83DA28EBA6CB6A
                  12CC300BA2024D27589A0CB4ADA4DC859995D36DD1A4CD5DA428E94636D7E98F
                  D236D79A04DBB42E14664E735B46E982A7F73BD448362FA40F7E9C87F77D7EE7
                  7C87F3EA8EFE179C475B98123A6BDC0F8F9410729657ECB91F1C4E8209439A82
                  3CCA7162C9DE949F4D3975F7DD5D69129D57F76F1A69967E9E1E7D8C90CB00CA
                  7E7D55665AAA2E37AC2958069DB5FCED7C63D0AAC6AF6F9F108F05101C508166
                  3AB64BEABF6ECC4BC0AE6EABCF29766AE588935C76A51AE5443CE287B3ED349E
                  37E4C8586799E368C84DD0A5906C1FAACF9D0FB98C589A0F407EE682C062D883
                  A9B76DA0DD9CA952B2F55F871BACCB12A83CBE4D64AB3DC87B9F5409C28F4907
                  2A2B140C217F9FE886C7580EEA0C49D337AFFBEB71D6EA03C2D57B15923A5E23
                  A32F8F233A66C042B01BFA961B30102C477D3A7A491FF8A693A06E0D7304F759
                  452667BEB8279B9E8B730107621F3B11713523EA6EC5F4700B43C8C2CCDB8E49
                  BE15AC4B4E1673B93BA776A6F55CDE17F49A9588BE6F4778508159470D621F1E
                  41A3563258A6592DC22FAAF0F58D1A23F74B418EBFF1C48E8D9CE57C86DE7E53
                  8688CF84195B19A6FB4A05623E230E498F31584ECCBF0C5CC20C7F0BD6EB85E8
                  3A97D1C1594A768527FA5588B8B59877DE436CCC44FF6AC3CFD028A2213F2253
                  5E2C8CF70BBBB9572A84EDD730FBB21EC15E2598CBE98AC43DE6E274A4C27276
                  AFC04AFB8E22F1538ECE16424CEC5E25E23F2E2722D6131B56097344BF0168AD
                  F1039DB8E68C0000000049454E44AE426082}
                ShowHint = True
                Style.BorderStyle = ebsNone
                StyleFocused.BorderStyle = ebsNone
                StyleHot.BorderStyle = ebsNone
                TabOrder = 0
                Transparent = True
                Height = 24
                Width = 24
              end
              object btnUltVnd: TBitBtnLocked
                Left = 31
                Top = 1
                Width = 54
                Height = 22
                Hint = 'Carrega o '#250'ltimo pre'#231'o praticado'
                Caption = 'Utilizar'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                TabStop = False
                OnClick = btnUltVndClick
              end
            end
          end
          object pnlQtdVariasChapasLote: TPanel
            Left = 0
            Top = 23
            Width = 979
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblQtdChapa: TLabel
              Left = 1
              Top = 4
              Width = 63
              Height = 14
              Alignment = taRightJustify
              Caption = 'Qtd. Chapas:'
            end
            object edtQtdChapas: TEditFocus
              Tag = 99
              Left = 66
              Top = 0
              Width = 71
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
              ParentFont = False
              TabOrder = 0
              OnExit = edtQtdChapasExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
        end
        object pnlBotoesItemGer: TPanel
          Left = 979
          Top = 23
          Width = 214
          Height = 138
          Align = alLeft
          BevelOuter = bvNone
          BorderWidth = 1
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object pnlBotoesItem: TPanel
            Left = 1
            Top = 92
            Width = 212
            Height = 45
            Align = alBottom
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 0
            object btnTintaMaquina: TSpeedButton
              Left = 106
              Top = 1
              Width = 104
              Height = 44
              Caption = '[F8] Tinta de'#13#10' M'#225'quina'
              Glyph.Data = {
                160C0000424D160C00000000000036000000280000001A000000260000000100
                180000000000E00B0000100B0000100B00000000000000000000E3F3F4E3F3F4
                E3F3F4E1F1F2515860353B40303D443E4950687A7AAFBFBDD6EAECE9F9FAE4F4
                F5E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3
                F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4B5C5CA40484F4E5360606070464E5441
                49531D242C232931414C4F5B676C7D8D8E8994998F999B8F999B9AA8A9C2D0D7
                E3F6F6E8F8F9E6F4F5E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4FFFFE3F3F4EAFAFB
                6C7682393C4A848A91A8B0B6A4B0B293A3A6737D8058646D3841512A37442A2E
                38363A452B3042282D402D30381F2A3137484B6E7F8A9EBABBDAE7E8DDEBEDE5
                F5F6E6F6F7E5F5F6FFFFC2D8DA545D6046475B4E535E7979849CA8AC9CABAE9C
                ABAE9CABAE9CAAAE9BAAAD97A5A967727A9CADB598A6A99AA9AC93A0A98C9B9D
                8E9AA49AA6B0868E98454D5A3A42522F36464044516F767EFFFFCFDDDD555A64
                44485B414757737B7D9DA7A99CABAE9CABAE9CABAE9CABAE9CABAE9CABAE6A76
                7DA1AEB29BAAAF99A9B79BA9AE98A9B59CABAE99A7AC97A5A8929EA897A6A89F
                A9B1969FABA0ADB8FFFFE3F3F4505564444A5C454C59787784A3ACAE9BABAE9C
                ABAE9CABAE9CABAE9CABAE9CABAE757E7E9FADB59BABB69DABB09AAAB29CABAC
                9CAAB19AA7AE96A4AB939CA496A0A698A5AB909FA19EA8ADFFFFE3F3F44F5561
                474D61484C58757C83A4ACB09CABAE9CABAE9CABAE9CABAE9CABAE9CABAE707B
                869CABAD92A6AA92A5AA99A8B19BA8AA99ABB79AA6B098A1AC9EA5A7969CA59A
                A8AB94A0ACA7B0B6FFFFE3F3F45056614046574F525D717684A2AEB2A1B0B39C
                ABAE9CABAE9CABAE9CABAE9CABAE7381849DACAF9CABAE91A5A999A8AB9AA8AA
                9CA9B399A5B098A6A98F9CA796A3A798A6A994A1A9A2B1B3FFFFE3F3F4505661
                494C5D515467767B83A4AFB19BAAB09CABAE9CABAE9CABAE9CABAE9CABAE7682
                839DACB19AAAAF9BA9AC9AA8AC9BAAAC9CABAD95A5AE93A6AF94A0AB95A3A597
                A3AA9CA5ABA2B0B8FFFFE3F3F44B515C494D6053566A767C83A0ADB29CAAB09C
                ABAE9DACAF9FADB09EADB09FABB06E7B839DADB39BA8AD9CABB09BAAB698A9B1
                9AA7B090A5A89FACB195A4A895A2AA99A5B099A7ACA7B5BCFFFFE3F3F44E576B
                4B4F6250566A777C83A1ACADA1ACB5A2ABAC9FADB09FADB09FADB09FADB0767C
                899DABB19AA8AB9AA8AA93A5A99BA8AB99A7AB96A4A796A8B59CA9B199A5B197
                A6AA9BA7B3ABBBBDFFFFE3F3F45359684B4F6550535F797984A2B2B5A1AAAAA1
                ADB79FADB09FADB09FADB09FADB0748386A1ADAF9BAAAD9BAAAD9CAAAD9DADB4
                91A4A99CA9B39FACAF9AA8AC9FADAF95A2AB9CA8B2AAB7BAFFFFE3F3F4555A6B
                494E65505A65747C7BA3B2B5A0ADB0A1AEAF9FAEB09FADB0A1B0B29FADB0727F
                81AAB7BEA4B1B9A6B1BD97A6AE9BAAB09DABAE9EABB29BABAE9BA8AF99A9B097
                A5AB9BA8B0ABBBBDFFFFE3F3F4505B6C4B506E4F5162737684A6B2B6A6B0B6A3
                ABB5A9B0B8A4AEB3A7B2B8A1AFB26B777AA3ADB592A4AD96A4AB99A2AA9EACB1
                A7B1B79CA7B1A5B1B79BA9AD9CABB095A3A89CA9B5AAB7B9FFFFE3F3F4565D6E
                4E52694F5363727E88A8B5B9A3B1B79FADB0A4ABB3A8B3B8A3B3B5A1ADB86975
                77252F373F454C484B57586469757F808896999CAAADA5B3BF9BA7B29CABAE9A
                A6B19BA8AFABBBBDFFFFE3F3F451586A4D516A54586A767C81B0B4BAA7B0B9A0
                ADB0AAB2B9B0B2B7ABB2BAA0ADB66876781D2A3A29364E4D5C6B3E475D33394B
                2632332E383F7D898C9CA9B49CABAE9AA8AB9EACAEABBBBDFFFFE3F3F4555A6A
                4E5371525563767C83ACB8BFA3B2B59FADB1A6B2B8A6B1B7A7B6BCA7B3B76E79
                7B12212F44505964777E4553622B3A4D1C2B3F2432467E8B98A1ADB49FACB79A
                A7AE9DACB4ACBABFFFFFE3F3F4545B744D5168545667777D84AAB4BFB1B8C29F
                ADB0AAB7C2AFB6BEABB5BFA6B3BF6574821E2D3A36455764738830455C2D3A53
                1C2A391D324A7A8A9C98ABB59AABAF9CAAAFA1B2BAABBABCFFFFE3F3F4545D70
                4F54715557697D8289B2BEC3AFB7C1A5B4B6ACBABEB3BAC2B0BCC1A6B2BD6F75
                837987956C7A8B6B7A8D6C7B8E626E804D5D6E445464828E9EA0ACB7A1ADB899
                ABB6A2AEB8A9BBC5FFFFE3F3F463667D4E546F56586A7D828AB2C0C0B0BABFAB
                B9BCBEC6CAB7BEC6ABBBB9ACBABD6876825E70866C8797627E8B708C9B7F8D93
                8F9BA78A9DAF9EABB6A6B4B7A2B0B5A2B1B6A6B2BEB0C0C2FFFFE3F3F45F657A
                575B7456586A82878EB6C0C4AFBABEBAC2C7B8C4C7B6BBC5AEBDBBAFBBBD6372
                7A3A5C73476D7D5076881B3B662732411729341F364B818F9AA5B2B8A9B9C2A2
                AFB7A3B5C0B3C0C8FFFFE3F3F45D677B555B7351545F7C8189B7C5C9B6C1C7B7
                C4C9B8C4C9B2C1C4BBC2CBB3C1C5676D783A6D9142688F5D89A414316C1D2E3B
                15223022334084939EA6B3BBA5B3B8A2AEB7AAB7BDB3BFC8FFFFE3F3F4616A7D
                575B7356586A7D828AB8C4C9B2C1C5BBC2CABAC2CAB2C1C5B5C1C6B3C1C55266
                6B5F758666748652606E3E5E95182235172432172A3886949FABB8C2ACB9C4A6
                B7C3A9B6BDB8C5CFFFFFE3F3F45C657D4A5167484E5F82888FBFC9CFB9C2C9C4
                D1D3C3D0D2B8C0C8BDCACDB9C1C9565F6C0437721478AF187EA51A3880202C39
                192C381C31478896A0AFBDC0AEBCC0ACB9C4B0C0C0BAC7CCFFFFE3F3F45B6473
                444C68464E5F858A93BBC7CAB4C3C5C1C9CDC1C9CCB3C1C5B9C7C7B4C2C65A64
                640840830F6BA2015CAD1645A11827390E203023344D8B99A6B0BEC3AFBDC1AE
                BCBFAABBC0B4C6D2FFFFE3F3F4535E6A43495C4D4E608C9297CCD6DECAD3DCC3
                CBD0C2CACFCFD8E4C3CACECED7E2565A67235E77366C833D7285297188253558
                1A2D42273F518FA2ABAFBEC1B3C1C5B0BEC1B2C0C3C1CFD4FFFFE3F3F4737C8C
                6E778B60687A656978B4BCCBB6BFD2BBC2CAB6BED0B3BECDAFBCC6ADB7C96176
                7F0F1D2D22344B4A5E704555633C50652A3950324251818E9B9AA6B1A2AEB89E
                A8B99CACB7B2BBBDFFFFE3F3F47F849A787F8F767A897A7E8EB0BECBB5C3CBB3
                C6D1BBC9CFB5C6CBBCCAD4B5C4C96074790D1F2D3649585268774F63773C576A
                29394B2F44557683939BA6B29EAAB69EADBBA2AFC0ABBCC8FFFFE3F3F48C9BA4
                606A7A59626F6E7B877C84905564716263785E69726F7981616D736269781C29
                310B1C294F5D6966767B657380617176ACB1BEE5F4F5EBFBFBE8F8F8E7F8F8E7
                F7F7E7F6F7E6F6F6FFFFE3F3F4E4F4F5E5F5F5E6F5F6E6F5F6E6F6F6CBD9DD67
                737B757A895E60786C7C91466170192C381524354E5F6B697C836E7E866C7882
                E8F9F9E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4
                E3F3F4E3F3F4E3F3F4E3F3F4CBD5DA65697874818A7C7B9060737B6A76811834
                44161E2E5965707E8B8E848E9278858DE7F7F8E3F3F4E3F3F4E3F3F4E3F3F4E3
                F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4CCDCDF60
                727C767F8875778463768065768656576126576E727D888C959995A1A9879197
                E7F7F7E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4
                E3F3F4E3F3F4E3F3F4E3F3F4CEDFE174777C74808D7D7E876E7E8A6C75879C9F
                A15D93AC99A7AFA0AEB1A7B4B894A3A5E6F6F7E3F3F4E3F3F4E3F3F4E3F3F4E3
                F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4D6E7E679
                798473808A6C76897D888C7E848BAFC2CBA9B7BD919EA7B8C7CCABB5B8A9B4BF
                E6F6F6E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4
                E3F3F4E3F3F4E3F3F4E3F3F4D7E8EAA291A4828E98797E913544461C303B3647
                562C3D4A2A2C39676A7A0F21334B515AE0F5F4E3F3F4E3F3F4E3F3F4E3F3F4E3
                F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4D5ECED8D
                9B9D8E97A18990955B66716468728A90A17C8E98708388707D856A7177949EA8
                97ABBBDEEFEFE3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4
                E3F3F4E3F3F4E3F3F4E3F3F4D6EDEE98A3AD919AAB8995A581868C9199A8D2E0
                EAC6D6D69DACB0767D7E5E666EB0C2C4CFDDE8DDEFEFE3F3F4E3F3F4E3F3F4E3
                F3F4E3F3F4E3F3F4FFFFE3F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4DBF2F293
                A0AAA1ADB89AA3AC86929C9DA4ACCBD4DEC3CFD7A3B2B5B4BCC37F868FB0BBCA
                CDE5E4C4E6E6E4F3F4E3F3F4E3F3F4E3F3F4E3F3F4E3F3F4FFFF}
              OnClick = btnTintaMaquinaClick
            end
            object btnExcluir: TBitBtnLocked
              Left = 106
              Top = 1
              Width = 104
              Height = 22
              Caption = '&Excluir'
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
              Visible = False
              OnClick = btnExcluirClick
            end
            object btnAdicionar: TBitBtnLocked
              Left = 0
              Top = 1
              Width = 104
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
              TabOrder = 0
              OnClick = btnAdicionarClick
            end
            object btnCancelaItem: TBitBtnLocked
              Left = 0
              Top = 23
              Width = 104
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
              TabOrder = 1
              OnClick = btnCancelaItemClick
            end
          end
        end
      end
      object pnlItemCodigo: TPanel
        Left = 0
        Top = 0
        Width = 1028
        Height = 39
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Label5: TLabel
          Left = 42
          Top = 20
          Width = 22
          Height = 14
          Alignment = taRightJustify
          Caption = 'Item:'
        end
        object Label26: TLabel
          Left = 862
          Top = 20
          Width = 42
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Unidade:'
        end
        object Label8: TLabel
          Left = 932
          Top = 20
          Width = 42
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Sigla:'
        end
        object btnInsPla: TSpeedButton
          Tag = 99
          Left = 8
          Top = 7
          Width = 29
          Height = 31
          Hint = 'Importar produtos'
          Flat = True
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFC76414E5B582DE9F63D4863FCB6D1F
            C25708BF4E01C76414FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC96718F4DDC2F6
            E3CAF4E0C2F2D5B1F2CB9DC79E81A17360D98435CC6F20C55E0FC05204BD4C00
            BD4C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFCC6918FFE3BDFCE3C0F7DCBAF4DAB6FADCB1F0D4AD0525F7FEDCA9EECC9EEB
            C592EABA7FCC96629A664DD57622C55D0DBF5003BD4C00BD4C00FF00FFFF00FF
            FF00FFFF00FFFF00FFAF581B9898C6F8E3CAF4DDC1F3DABCF2D7B6F2D5B10525
            F7F0D0A6F4D1A1F2CF9DF3CF99EEC7930525F7FACE8BE9BC80E5B06DE0A35CBD
            4D00FF00FFFF00FFFF00FFFF00FFFF00FFBB5F1B1B3AEE2544EF5066E2586BDE
            8089D39396CA0525F7D5C0B1F0CFA6EFCCA1F0CC99EDC7980525F7EBC48EEFC5
            89EEC587EFCA8EBD4D00FF00FFFF00FFFF00FF0E90C90E90C9CA691AACA0BDB2
            B5DC828EDA6E7EDC4F65E13651E50525F70A2AF30525F71A39EB2441E5495CD3
            0525F77E7FB88B87B0B29F9EC2A38CBD4D00FF00FFFF00FF0E90C94AB8E34CBB
            E6C76516E3C6B1FAEBD8F6E2C9F7E1C4F4DDC2F3DCBF0525F7FFE6ACF2D4AFBB
            ADB6AFA4B57E82C10525F7364DD52440DD2440E10E2DEEBD4D00FF00FF0E90C9
            76DDF87FD3F269C9EDCA6614E6C9B5FAEEDDF7E5D1F6E2CCF6E1C7F4DDC20525
            F7F2D8B8F2D7B4F0D4ADF0D0A9EFCFA40525F7FFD993FACF91F0C78EE3BA88BD
            4D00FF00FF0E90C984E3FC99DDF787D5F3AF561B193AF22646F35069EA596FE6
            828EDD979CD70525F7D8C9C1F2D9B7F2D5B2F0D3ADF0D0A70525F7FCD498EEC9
            97EEC792F0CC96BD4D00FF00FF0E90C992EBFFB4E9FBA5E1F8BC5E18B0A7C7B5
            BBED8392E66F82E55068E73753EA0525F70C2DF40525F71B3AEE2442E94A5EDA
            0525F77F82C48C8BBCB4A4ABDCC0A0BD4D00FF00FF0E90C996EDFFC5EFFFBFEB
            FEC96616FFF0DDFCF6EEFFF4D9F8EADAF7E7D5F7E3D00525F7F6DEC5F4DDC0BC
            B5C5B1ABC48086CB0525F74E62D53A52DC2441E50F2EEFBD4D00FF00FF0E90C9
            96EDFFC7F0FFCBF0FFC76516FAEFE2FBF3EBFAEFE2F8EADAFFEED4F7E7D40525
            F7F6E2C9FBE2BDFCE1B8FFE2B2F2D7B40525F7F0D1ABF0D0A5F0CFA1E6C197BD
            4D00FF00FF0E90C996EDFFC6F0FFCBF0FFC55F11F8EADCFBF6EEFBF3EBFBF3EB
            FFFAEAF8EAD80525F7FFF0D3F6E3CAF4E0C2F7DEBCF2D8B80525F7FFDDAAF4D3
            A6F4D1A1FAD8A4BD4D00FF00FF0E90C996EDFFC6F0FFCBF0FFBF4F02CA691CCE
            762BD18039D78A48DE9857BF8E6F0525F7F0C695EFCFACF2D7B8F7DCBAF3DCBD
            0525F7FFE7BDF3DCB8F3D8B2F3DCB5BD4D00FF00FF0E90C996EDFFC6F0FFCBF0
            FFBD4B00BC4700BB4600BB4600BA4300BA4300BC4700BD4B00BA4300BA4300BA
            4300BA4300BA4300BA4300BA4300BA4300BA4300BA4300BD4D00FF00FF0E90C9
            96EDFFC6F0FFCBF0FFBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4B
            00BC4A00BC4A00BC4A00BC4700BC4700C04800BA4300BB4600BC4A00BD4C00BD
            4D00FF00FF0E90C996EDFFC6F0FFCBF0FFBD4C00BD4C00BD4C00BD4C00BD4C00
            BD4C00BD4C00BD4C00BD4C00BD4C00BD4D00BD4D00BD4D00BD4D00BD4C00BD4C
            00BD4C00BD4B00BD4B00FF00FF0E90C99DF0FFD1F6FFD0F2FFB5EDFF81E6FE6B
            E3FF6FE6FF76EAFF0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C966D1F064C1E55BBC
            E253BAE243B8E13AB7E23BBAE551CEF00E90C9FF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C9
            73CBEA91DCF092E1F68BE1F87DDEF86BDAF458D3F044C4E90E90C9FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FF0E90C967CEED6FDAF666DCF75FDAF85CD8F64BC9EB0E90C9
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C90E90C90E90C90E90C90E
            90C90E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ParentShowHint = False
          ShowHint = True
          OnClick = btnInsPlaClick
        end
        object btnEstruturaVidro: TBitBtnLocked
          Left = 3
          Top = 16
          Width = 34
          Height = 22
          Hint = 'Informar sub-produtos da estrutura do vidro'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
            300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
            330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
            333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
            339977FF777777773377000BFB03333333337773FF733333333F333000333333
            3300333777333333337733333333333333003333333333333377333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Visible = False
          OnClick = btnEstruturaVidroClick
        end
        object edtDesIte: TEditFocus
          Tag = 99
          Left = 138
          Top = 16
          Width = 409
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 67
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtUnidad: TEditFocus
          Tag = 99
          Left = 907
          Top = 16
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 6
          OnKeyPress = edtUnidadKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSigla: TEditFocus
          Tag = 99
          Left = 976
          Top = 16
          Width = 37
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clSilver
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 66
          Top = 16
          Width = 71
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnEnter = edtCodIteEnter
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnDesnes: TBitBtnLocked
          Left = 828
          Top = 16
          Width = 27
          Height = 22
          Hint = 'Descri'#231#227'o do item (Textual)'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000000000000000000000000000000000000000000A0000
            000F000000110000001100000012000000120000001300000013000000130000
            001400000014000000150000001500000015000000140000000D81594BC1B37C
            68FFB37B67FFB27B66FFB27A66FFB27864FFB17965FFB17965FFB17765FFB177
            63FFB07664FFB07664FFAF7664FFAF7763FFAF7563FF7F5446C5B67F6BFFFDFB
            FAFFFBF7F4FFFBF6F2FFFBF5F2FFFAF5F1FFFBF4EFFFF9F3EEFFF9F2EEFFFAF2
            ECFFF8F0EBFFF9F0EAFFF7EFE9FFF8EFE8FFF8EEE6FFB07864FFB6816FFFFDFB
            FBFFC28D77FFC18B77FFC18C76FFC08B76FFC08A75FFC08975FFBF8974FFBF89
            74FFBF8874FFBE8873FFBE8872FFBE8872FFF9EEE9FFB27A66FFB98472FFFEFC
            FBFFF3E7DFFFF3E5DDFFF2E5DDFFF2E4DDFFF3E4DCFFF2E4DCFFF2E2DBFFF2E2
            DAFFF1E2DAFFF1E2DAFFF1E2DAFFF4E6DFFFF9F1EAFFB47D69FFBC8775FFFEFD
            FCFFC4907DFFC38F7CFFC4907BFFC4907BFFC38F7AFFC28E79FFC28E78FFC28D
            79FFC18D78FFC18C77FFC18C77FFC08B76FFF9F1ECFFB67E6DFFBE8B7AFFFCFB
            FAFFF2EBE7FFF2EBE6FFF7F0EBFFF6EDE8FFF0E8E2FFEFE8E2FFF8F0E9FFF3E6
            DEFFF3E6DDFFF2E4DDFFF2E4DCFFF4E9E3FFF9F3EEFFB8836FFFC1907FFFF7F7
            F6FF765031FF9D836FFFF3EDE7FFF0E9E5FF714F32FF90755FFFF9F0EBFFC591
            7EFFC4927DFFC5917CFFC3917CFFC4907BFFFAF4EFFFBA8573FFC49482FFF8F8
            F7FF9F8068FF79573EFFE8E3DEFFD8CDC5FF6D3D17FFBCAA9EFFF9F3EDFFF4E9
            E2FFF4E8E0FFF4E7E0FFF4E7E0FFF5ECE7FFFBF5F1FFBD8877FFC69787FFFBFB
            FBFFC9B8A9FF663714FF693915FF7B461FFF6C3B1BFFE4DDD7FFFAF4EFFFC899
            83FFC89883FFC89682FFC79681FFC79581FFFBF6F3FFC08D7BFFC99B8AFFFEFD
            FDFFEEE8E4FF84512AFFCCBCB1FFA98B71FF835F45FFF1E9E8FFFBF5F1FFF6EC
            E5FFF5ECE5FFF6EBE4FFF6EBE4FFF7EFEBFFFCF8F6FFC29280FFCBA08DFFFFFE
            FEFFF7F3F2FF947357FFAF937FFF8F6342FFAF9784FFF4EFEDFFFCF6F3FFCC9F
            8BFFCC9D88FFCB9D89FFCB9D89FFCB9B87FFFCF9F7FFC49584FFCDA191FFFFFF
            FEFFFAF9F5FFC1A999FF976C4AFF7A4823FFDCD0C8FFF8F3F1FFFBF7F5FFF6EE
            E9FFF7EEE8FFF6EEE7FFF7EDE8FFF8F1EEFFFDFAF8FFC89988FFCFA493FFFFFF
            FFFFFCFBFAFFEBE2DCFF885229FF865934FFF9F5F3FFFAF6F5FFFBF8F6FFCFA4
            8FFFCFA28FFFCFA28EFFCEA18EFFCEA18EFFFDFBFAFFCA9C8BFFD1A796FFFFFF
            FFFFFFFFFFFFFEFEFEFFFCFCFCFFFDFDFCFFFEFDFDFFFEFEFEFFFFFEFEFFFEFE
            FEFFFEFEFEFFFEFEFDFFFEFEFDFFFEFDFDFFFEFDFDFFCB9F8FFF9C7D71C0D2A8
            98FFD2A898FFD1A897FFD1A897FFD1A797FFD0A696FFD0A696FFD0A695FFD0A5
            95FFCFA595FFCFA494FFCEA394FFCEA393FFCEA392FF98786CC3}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          TabStop = False
          Visible = False
          OnClick = btnDesnesClick
        end
        object pnlItemCodigo_Cabecalho: TPanel
          Left = 0
          Top = 0
          Width = 1028
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object chkCheckOut: TCheckBox
            AlignWithMargins = True
            Left = 66
            Top = 1
            Width = 143
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Utilizar Fun'#231#227'o Check-Out'
            TabOrder = 0
            OnClick = chkCheckOutClick
          end
          object rdbCodFab: TRadioButton
            AlignWithMargins = True
            Left = 276
            Top = 1
            Width = 106
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'C'#243'digo da F'#225'brica'
            TabOrder = 1
            OnClick = rdbCodFabClick
          end
          object rdbCodIte: TRadioButton
            AlignWithMargins = True
            Left = 449
            Top = 1
            Width = 90
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'C'#243'digo do Item'
            Checked = True
            TabOrder = 2
            TabStop = True
            OnClick = rdbCodIteClick
          end
          object chkVenPre: TCheckBox
            AlignWithMargins = True
            Left = 816
            Top = 1
            Width = 122
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Venda Presencial?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnClick = chkVenPreClick
            OnEnter = chkVenPreEnter
            OnExit = chkVenPreExit
          end
          object chkFatTot: TCheckBox
            AlignWithMargins = True
            Left = 1005
            Top = 1
            Width = 235
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Obrigar Faturamento Total deste PD'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            OnClick = chkFatTotClick
          end
          object chkAVITRA: TCheckBox
            AlignWithMargins = True
            Left = 606
            Top = 1
            Width = 143
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Exibir aviso de trava'
            TabOrder = 5
            Visible = False
            OnClick = chkAVITRAClick
          end
          object chkBaseDeTroca: TCheckBox
            AlignWithMargins = True
            Left = 1307
            Top = 1
            Width = 204
            Height = 14
            Margins.Left = 66
            Margins.Top = 1
            Margins.Right = 1
            Margins.Bottom = 1
            Align = alLeft
            Caption = 'Gerar Recebimento a Base de Troca'
            TabOrder = 6
            Visible = False
          end
        end
        object cbbComple: TComboBoxFocus
          Tag = 99
          Left = 548
          Top = 16
          Width = 278
          Height = 22
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 60
          ParentFont = False
          TabOrder = 4
          OnExit = cbbCompleExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object pnlLoteEmpresaSaldo: TPanel
        Left = 0
        Top = 39
        Width = 1028
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        object pnlItemLote: TPanel
          Left = 672
          Top = 0
          Width = 343
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          Visible = False
          object lblNumLot: TLabel
            Left = 7
            Top = 4
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'd Armaz.:'
          end
          object edtNumLot: TEditFocus
            Tag = 99
            Left = 70
            Top = 1
            Width = 243
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 30
            TabOrder = 0
            OnEnter = edtNumLotEnter
            OnKeyPress = edtNumLotKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object btnLoteRapido: TBitBtnLocked
            Left = 316
            Top = 1
            Width = 27
            Height = 22
            Hint = 'Digita'#231#227'o r'#225'pida de lotes'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000020000000A170D0738542D1894814626D193502AEA924F2AE87F45
              25D0522C17931209053000000009000000010000000000000000000000000000
              00030201011159311B97A96239FAC58957FFD6A36DFFDDAF75FFDDAF74FFD6A4
              6BFFC58956FFA46137F53C2112730000000F0000000300000000000000020201
              0110744226B9BC7C4DFFDDAE77FFDEB076FFE2B782FFE3BB87FFE3BC86FFE1B7
              82FFDEAF74FFDBAB72FFBD7E4EFF6F3E24B50000001000000002000000085C36
              2095BE8053FFE0B37CFFDFB076FFDEB177FFB78254FFAA7144FFAB7245FFBC88
              59FFDFB279FFDFB277FFDEB077FFC08253FF55321D920000000A190F0932B070
              47FADFB27DFFDFB27AFFE0B37BFFE0B57DFFA56B3FFFF5EFEAFFF8F3EEFFAB72
              45FFE2B67EFFE0B47CFFE0B47BFFDEB079FFB3734AFB130B072F613C2795CD9B
              6FFFE2B780FFE5BD89FFE7C291FFE8C393FFA56B3FFFF1E6DEFFF9F5F1FFAA71
              44FFE8C494FFE8C393FFE5BF8CFFE1B77FFFD09C6EFF5434218B935E3DD2DCB3
              83FFE3B781FFBA8659FFA97043FFAB7245FFAC7346FFF5EDE6FFFAF6F3FFAD75
              47FFB0784AFFB17A4BFFC29162FFE4B983FFDEB17EFF8E5B3BD0B0744CF2E3BF
              8FFFE4BB84FFA56B3FFFF3EBE6FFFAF6F3FFF6EFE8FFF7F0EAFFFBF7F5FFFAF7
              F4FFFAF7F3FFFAF6F2FFAB7245FFE5BD87FFE5BE8BFFAB714CEEAE764FECE9C9
              A0FFE5BE89FFA56B3FFFE0D2CAFFE1D3CCFFE3D5CFFFF2EAE4FFF8F3EFFFEADF
              D9FFE6DAD4FFE9DED9FFAA7144FFE7C08CFFEACA9DFFAE764FEE9A6A49D0E9CD
              ACFFEAC796FFB78456FFA56B3FFFA56B3FFFA56B3FFFF1EAE5FFFAF6F3FFA56B
              3FFFA56B3FFFA56B3FFFB78457FFEACA99FFEBD1ADFF996A49D46E4E3697DDBB
              9DFFEED3A9FFEECFA2FFEED2A5FFF0D6A9FFA56B3FFFF0EAE7FFFDFCFBFFA56B
              3FFFF1D6AAFFF0D5A8FFEED2A5FFEFD4A7FFE0C2A2FF6246318F1C140E2BC794
              6CFCF5E8CCFFEFD6ABFFF1D8AEFFF2DAB0FFA56B3FFFDECFC9FFDFD1CBFFA56B
              3FFFF3DCB2FFF1DBB0FFF1D8ADFFF7EACDFFC69470FA1A120D2E000000036F52
              3C92D7B08CFFF8EFD3FFF3E0B9FFF3DFB7FFB98A5FFFA56B3FFFA56B3FFFBA8A
              5FFFF4E1B9FFF4E2BDFFFAF1D5FFD9B390FF664B368C00000006000000010202
              0107906C4EB8D9B38FFFF7EDD3FFF8EED0FFF7EBC9FFF6E8C4FFF6E8C5FFF7EC
              CAFFF8EED0FFF4E8CDFFD7AF8BFF88664AB30202010B00000001000000000000
              00010202010770543F8FCFA078FCE2C4A2FFEBD7B8FFF4E9CDFFF4EACEFFECD8
              B9FFE3C5A3FFC59973F24C392A67000000060000000100000000000000000000
              000000000001000000022019122C6C543E89A47E5FCCC59770F1C19570EEA47E
              60CD6C543F8B16110D2200000003000000010000000000000000}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            TabStop = False
            OnClick = btnLoteRapidoClick
          end
          object edtNomArm: TEditFocus
            Left = 156
            Top = 1
            Width = 157
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 30
            ReadOnly = True
            TabOrder = 2
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlEmpresa: TPanel
          Left = 357
          Top = 0
          Width = 315
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          Visible = False
          object Label11: TLabel
            Left = 11
            Top = 5
            Width = 26
            Height = 14
            Alignment = taRightJustify
            Caption = 'Emp.:'
          end
          object edtCodEmp: TEditFocus
            Tag = 99
            Left = 36
            Top = 1
            Width = 40
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnChange = edtCodEmpChange
            OnEnter = edtCodEmpEnter
            OnExit = edtCodEmpExit
            OnKeyPress = edtCodEmpKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
          object edtNomEmp: TEditFocus
            Left = 77
            Top = 1
            Width = 233
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
        end
        object pnlSaldoDisp: TPanel
          Left = 0
          Top = 0
          Width = 141
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object lbl6: TLabel
            Left = 7
            Top = 4
            Width = 57
            Height = 14
            Hint = 'Saldo Dispon'#237'vel'
            Alignment = taRightJustify
            Caption = 'Saldo Disp.:'
            ParentShowHint = False
            ShowHint = True
          end
          object edtSalDis: TEditFocus
            Tag = 99
            Left = 66
            Top = 1
            Width = 71
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clSilver
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
        object pnlLocFis: TPanel
          Left = 141
          Top = 0
          Width = 216
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object lblLocFis: TLabel
            Left = 6
            Top = 5
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Loc. F'#237'sica:'
          end
          object edtLocFis: TEditFocus
            Tag = 99
            Left = 62
            Top = 1
            Width = 152
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clSilver
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
        object pnlSaldoEmpresasPrioridade: TPanel
          Left = 1015
          Top = 0
          Width = 135
          Height = 24
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          Visible = False
          object Label9: TLabel
            Left = 9
            Top = -2
            Width = 49
            Height = 28
            Hint = 'Saldo Dispon'#237'vel'
            Alignment = taRightJustify
            Caption = 'Saldo Disp.Total:'
            ParentShowHint = False
            ShowHint = True
            WordWrap = True
          end
          object edtSaldoDispTotal: TEditFocus
            Tag = 99
            Left = 61
            Top = 1
            Width = 71
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clSilver
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
        end
      end
      object pnlAplicacao: TPanel
        Left = 0
        Top = 224
        Width = 1028
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object lblAplicacao: TLabel
          Left = 13
          Top = 6
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Aplica'#231#227'o:'
        end
        object edtAplica: TEditFocus
          Left = 66
          Top = 1
          Width = 947
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
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
  end
  object pnlItens: TPanel [11]
    Left = 0
    Top = 553
    Width = 1030
    Height = 66
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 10
    OnEnter = pnlItensEnter
    object pnlSubItens: TPanel
      Left = 0
      Top = 33
      Width = 1030
      Height = 33
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
      Visible = False
      object pnlTitSubItens: TPanel
        Left = 0
        Top = 0
        Width = 1030
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Sub. Produtos'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object dbgSubItens: TDBGridCitel
        Left = 0
        Top = 17
        Width = 1030
        Height = 16
        Align = alClient
        DataSource = dtsSubItens
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnColEnter = dbgSubItensColEnter
        OnKeyDown = dbgSubItensKeyDown
        OnKeyPress = dbgSubItensKeyPress
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'ITE_NOMVEN'
            ReadOnly = True
            Title.Caption = 'Ven'
            Width = 23
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITE_ORDITE'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'N'#186
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CODITE'
            ReadOnly = True
            Title.Caption = 'C'#243'digo'
            Width = 37
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_DESITE'
            ReadOnly = True
            Title.Caption = 'Descri'#231#227'o'
            Width = 210
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_EMPITE'
            ReadOnly = True
            Title.Caption = 'Emp.'
            Visible = False
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITE_ENTRET'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Ent.'
            Width = 23
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITE_MOTFUT'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Mot.'
            Width = 23
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITE_CLIBUS'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'C.Ret.'
            Width = 30
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITE_TABPRE'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'TP'
            Width = 15
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_QTDPEC'
            Title.Alignment = taRightJustify
            Title.Caption = 'Qtd. Pe'#195#167'as'
            Visible = False
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_COMPEC'
            Title.Alignment = taRightJustify
            Title.Caption = 'Metragem'
            Visible = False
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_QTDITE'
            Title.Alignment = taRightJustify
            Title.Caption = 'Quant.'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_ENTSAI'
            ReadOnly = True
            Title.Caption = 'E/S'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ITE_SIGUNI'
            ReadOnly = True
            Title.Caption = 'Unid.'
            Width = 25
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_PRETAB'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Pre'#231'o Tab.'
            Width = 60
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_UNIDIG'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Unit'#225'rio'
            Width = 60
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_TAXJUR'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Tax.Jur.(%)'
            Width = 60
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_DESCON'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Desc.(%)'
            Width = 60
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_UNITAR'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Unit. L'#237'quido'
            Width = 65
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_VARTAB'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'VT(%)'
            Width = 40
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'ITE_TOTITE'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Vlr. Total'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_IPISAI'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = '% IPI'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ITE_VALIPI'
            ReadOnly = True
            Title.Alignment = taRightJustify
            Title.Caption = 'Vlr. IPI'
            Visible = False
          end>
      end
    end
    object pnlTitItensVenda: TPanel
      Left = 0
      Top = 0
      Width = 1024
      Height = 17
      BevelOuter = bvNone
      Caption = 'Produtos da Venda'
      Color = 16770261
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object dbgItens: TDBGridCitel
      Left = 0
      Top = 33
      Width = 1030
      Height = 33
      Hint = 
        'ESC: Voltar ao c'#243'digo do item'#13#10'ENTER: Alterar Item'#13#10'DELETE: Dele' +
        'ta o item'#13#10'CTRL + CIMA: Mover item para cima'#13#10'CTRL + BAIXO: Move' +
        'r item para baixo'
      Align = alClient
      DataSource = dtsVenda
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
      PopupMenu = popGridItens
      ReadOnly = True
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgItensDrawColumnCell
      OnDblClick = dbgItensDblClick
      OnEnter = dbgItensEnter
      OnExit = dbgItensExit
      OnKeyDown = dbgItensKeyDown
      OnTitleClick = dbgItensTitleClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'ITE_NOMVEN'
          Title.Caption = 'Ven'
          Width = 23
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITE_ORDITE'
          Title.Alignment = taCenter
          Title.Caption = 'N'#186
          Width = 21
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_CODITE'
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_CODFAB'
          Title.Caption = 'C'#243'd.Fabrica'
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESITE'
          Title.Caption = 'Descri'#231#227'o'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_NUMLOT'
          Title.Caption = 'Armaz.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESMAR'
          Title.Caption = 'Marca'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_COMPLE'
          Title.Caption = 'Ambiente'
          Width = 200
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_EMPITE'
          Title.Caption = 'Emp.'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITE_ENTRET'
          Title.Alignment = taCenter
          Title.Caption = 'Ent.'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_PEGOU_'
          Title.Caption = 'Peg?'
          Width = 28
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITE_MOTFUT'
          Title.Alignment = taCenter
          Title.Caption = 'Mot.'
          Width = 23
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITE_CLIBUS'
          Title.Alignment = taCenter
          Title.Caption = 'C.Ret.'
          Width = 30
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITE_TABPRE'
          Title.Alignment = taCenter
          Title.Caption = 'TP'
          Width = 15
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDPEC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtd. Pe'#231'as'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_COMPEC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Metragem'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNTPEC'
          Title.Alignment = taRightJustify
          Title.Caption = 'Unit. Pe'#231'as'
          Width = 72
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Quant.'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_ENTSAI'
          Title.Caption = 'E/S'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_SIGUNI'
          Title.Caption = 'Unid.'
          Width = 25
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_VPEGOU'
          Title.Caption = 'J'#225' Pegou?'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_PRETAB'
          Title.Alignment = taRightJustify
          Title.Caption = 'Pre'#231'o Tab.'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNIDIG'
          Title.Alignment = taRightJustify
          Title.Caption = 'Unit'#225'rio'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_TAXJUR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Tax.Jur.(%)'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_DESCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Desc.(%)'
          Width = 60
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNITAR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Unit. L'#237'quido'
          Width = 65
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_UNICON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr.Unit.c/Imp'
          Width = 65
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VARTAB'
          Title.Alignment = taRightJustify
          Title.Caption = 'VT(%)'
          Width = 40
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_TOTITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. Total'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_IPISAI'
          Title.Alignment = taRightJustify
          Title.Caption = '% IPI'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_VALIPI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. IPI'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_VAL_ST'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. ST.'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_VFCPST'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. FCP ST'
          Visible = False
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALIBS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. IBS'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VALCBS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. CBS'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VAL_IS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vlr. IS'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_VLRCON'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Tot. c/ Imp.'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_MARCAT'
          Title.Caption = '% CAT Ressarcimento'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_SITUAC'
          Title.Alignment = taCenter
          Title.Caption = 'Situa'#231#227'o'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_MARLUC'
          Title.Caption = '%ML'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_COMVEN'
          Title.Caption = 'Vr.Comiss'#227'o'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_EMPSOL'
          Title.Caption = 'Emp. Transf.'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ITE_ITEEST'
          Title.Caption = 'C'#243'd. Estrutura'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_ESTQTD'
          Title.Caption = 'Quant. Estrutura'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_QTDCHA'
          Title.Caption = 'Qtd. Chapas'
          Visible = False
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ITE_SOBENC'
          Title.Caption = 'Sob Encomenda'
          Visible = True
        end>
    end
    object pnlPesquisarDescricao: TPanel
      Left = 0
      Top = 0
      Width = 1030
      Height = 33
      Align = alTop
      ParentColor = True
      TabOrder = 1
      object lblLocalizar: TLabel
        Left = 13
        Top = 11
        Width = 174
        Height = 14
        Caption = 'Localizar item por c'#243'digo/descri'#231#227'o:'
      end
      object Label10: TLabel
        Left = 798
        Top = 11
        Width = 216
        Height = 12
        Alignment = taRightJustify
        Caption = '[ TAB ] Altera'#231#227'o R'#225'pida da Quantidade do Produto.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtDescricaoLocalizar: TEditFocus
        Tag = 99
        Left = 189
        Top = 5
        Width = 359
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 67
        TabOrder = 0
        OnChange = edtDescricaoLocalizarChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnIniciaBusca: TBitBtnLocked
        Left = 551
        Top = 4
        Width = 113
        Height = 24
        Caption = 'Localizar o primeiro'
        TabOrder = 1
        TabStop = False
        OnClick = btnIniciaBuscaClick
      end
      object btnLocalizaProxima: TBitBtnLocked
        Left = 667
        Top = 4
        Width = 118
        Height = 24
        Caption = 'Localizar o pr'#243'ximo'
        TabOrder = 2
        TabStop = False
        OnClick = btnLocalizaProximaClick
      end
    end
  end
  object pnlEmpresaPrioridade: TPanel [12]
    Left = 0
    Top = 285
    Width = 1030
    Height = 16
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 12
    Visible = False
    object chkEmpresaPrioridade: TCheckBox
      AlignWithMargins = True
      Left = 67
      Top = 2
      Width = 234
      Height = 12
      Margins.Left = 66
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'Verificar prioridade das empresas no Pedido'
      TabOrder = 0
      OnClick = chkEmpresaPrioridadeClick
    end
  end
  object pnlUtiAbastDep: TPanel [13]
    Left = 0
    Top = 253
    Width = 1030
    Height = 16
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 11
    OnEnter = pnlUtiAbastDepEnter
    object chkUtiAbastDep: TCheckBox
      AlignWithMargins = True
      Left = 67
      Top = 2
      Width = 190
      Height = 12
      Margins.Left = 66
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'Utilizar Abastecimento por Dep'#243'sito'
      TabOrder = 0
      OnClick = chkUtiAbastDepClick
    end
  end
  object pnlRegEsp2: TPanel [14]
    Left = 0
    Top = 269
    Width = 1030
    Height = 16
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 13
    OnEnter = pnlUtiAbastDepEnter
    object chkRegEsp2: TCheckBox
      AlignWithMargins = True
      Left = 67
      Top = 2
      Width = 266
      Height = 12
      Margins.Left = 66
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alLeft
      Caption = 'Utilizar Regime especial ( faturamento duplo )'
      TabOrder = 0
      OnClick = chkRegEsp2Click
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 160
    object mnuCNF_NF: TMenuItem [0]
      Caption = 'Configurar CNF_NF'
      OnClick = mnuCNF_NFClick
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 672
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 160
  end
  object dtsVenda: TDataSource
    OnDataChange = dtsVendaDataChange
    Left = 768
    Top = 160
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    HintHidePause = 5000
    Left = 704
    Top = 160
  end
  object popBotoes: TPopupMenu
    Left = 640
    Top = 160
    object mnuAlterarPegPegGeral: TMenuItem
      Caption = 'Alterar Campo J'#225' Pegou (Geral) '
      ShortCut = 24694
      OnClick = mnuAlterarPegPegGeralClick
    end
    object mnuUltVen: TMenuItem
      Caption = #218'ltimas Vendas '
      ShortCut = 118
      OnClick = mnuUltVenClick
    end
    object mnuVenCli: TMenuItem
      Caption = 'Vendas por Cliente'
      ShortCut = 120
      OnClick = mnuVenCliClick
    end
    object mnuSisAnt: TMenuItem
      Caption = 'Vendas do Sistema Anterior'
      ShortCut = 32889
      OnClick = mnuSisAntClick
    end
    object mnuComVen: TMenuItem
      Caption = 'Comiss'#245'es do Vendedor'
      ShortCut = 32888
      OnClick = mnuComVenClick
    end
    object mnuFatAltComissaoVendedor: TMenuItem
      Caption = 'Manuten'#231#227'o da Comiss'#227'o'
      ShortCut = 16504
      OnClick = mnuFatAltComissaoVendedorClick
    end
    object mnuIteRep: TMenuItem
      Caption = 'Itens Representados'
      ShortCut = 122
      OnClick = mnuIteRepClick
    end
    object mnuVenLin: TMenuItem
      Caption = 'Vendas por Linha'
      ShortCut = 32890
      OnClick = mnuVenLinClick
    end
    object mnuVenVen: TMenuItem
      Caption = 'Vendas por Vendedor'
      RadioItem = True
      ShortCut = 32891
      OnClick = mnuVenVenClick
    end
    object mmuPedVen: TMenuItem
      Caption = 'Acompanhamento da Entrega'
      ShortCut = 32886
      OnClick = mmuPedVenClick
    end
    object mnuEntReaRom: TMenuItem
      Caption = 'Entregas Realizadas no Romaneio'
      ShortCut = 16497
      OnClick = mnuEntReaRomClick
    end
    object mnuEntPenRom: TMenuItem
      Caption = 'Entregas Pendentes no Romaneio'
      ShortCut = 16498
      OnClick = mnuEntPenRomClick
    end
    object mnuEntregasRetiraTotal: TMenuItem
      Caption = 'Entregas / Retira Total'
      ShortCut = 16499
      OnClick = mnuEntregasRetiraTotalClick
    end
    object mnuNumCmp: TMenuItem
      Caption = 'Informar Pedido de Compra dos Itens'
      ShortCut = 16500
      OnClick = mnuNumCmpClick
    end
    object mnuObsCli: TMenuItem
      Caption = 'Observa'#231#245'es do Cliente'
      ShortCut = 16501
      OnClick = mnuObsCliClick
    end
    object mnuAltEmpItem: TMenuItem
      Caption = 'Alterar Empresa do Item'
      ShortCut = 16503
      OnClick = mnuAltEmpItemClick
    end
    object mnuAltEmpItens: TMenuItem
      Caption = 'Alterar Empresa dos Itens (Geral)'
      ShortCut = 16506
      OnClick = mnuAltEmpItensClick
    end
    object mnuAltMecanicos: TMenuItem
      Caption = 'Alterar Mec'#226'nicos dos Itens'
      ShortCut = 16507
      OnClick = mnuAltMecanicosClick
    end
    object mnuImportarRequisicao: TMenuItem
      Caption = 'Importar Requisi'#231#227'o'
      ShortCut = 8311
      OnClick = mnuImportarRequisicaoClick
    end
    object mnuHistVeiculo: TMenuItem
      Caption = 'Hist'#243'rico do Ve'#237'culo'
      ShortCut = 8305
      Visible = False
      OnClick = mnuHistVeiculoClick
    end
    object mnuLocFisicaProdutos: TMenuItem
      Caption = 'Localiza'#231#227'o F'#237'sica dos Produtos'
      ShortCut = 24688
      OnClick = mnuLocFisicaProdutosClick
    end
    object mnuMostraTravasMinimas: TMenuItem
      Caption = 'Consulta Travas M'#237'nimas'
      ShortCut = 24689
      OnClick = mnuMostraTravasMinimasClick
    end
    object mnConsultaServico: TMenuItem
      Caption = 'Consulta Servi'#231'os'
      ShortCut = 32851
      OnClick = mnConsultaServicoClick
    end
    object mnuTrocaPDRefOR: TMenuItem
      Caption = 'Trocar Pedido de Refer'#234'ncia do Or'#231'amento'
      ShortCut = 24690
      OnClick = mnuTrocaPDRefORClick
    end
    object mnuConsultaCatalogos: TMenuItem
      Caption = 'Consulta Cat'#225'logos'
      ShortCut = 24691
      OnClick = mnuConsultaCatalogosClick
    end
    object mnuSimularVenda: TMenuItem
      Caption = 'Visualizar Produtos / Impostos'
      ShortCut = 24692
      OnClick = mnuSimularVendaClick
    end
    object mnuIncluirVendasPerdidas: TMenuItem
      Caption = 'Incluir Vendas Perdidas'
      ShortCut = 24693
      OnClick = mnuIncluirVendasPerdidasClick
    end
    object mnuImportarItensDeOutrosDocumentos: TMenuItem
      Caption = 'Importar itens de outros documentos'
      ShortCut = 24695
      OnClick = mnuImportarItensDeOutrosDocumentosClick
    end
    object mnuImportarVendasPerdidas: TMenuItem
      Caption = 'Importar Vendas Perdidas'
      ShortCut = 24696
      OnClick = mnuImportarVendasPerdidasClick
    end
    object mnuCarEquipManOS: TMenuItem
      Caption = 'Carregar Equipamentos da O.S.'
      ShortCut = 24694
      OnClick = mnuCarEquipManOSClick
    end
    object mnuICMSSTParteVenda: TMenuItem
      Caption = 'ICMS ST Parte Venda'
      ShortCut = 32852
      OnClick = mnuICMSSTParteVendaClick
    end
    object mnuMostrarItensAmbiente: TMenuItem
      Caption = 'Mostrar itens por ambiente'
      ShortCut = 32880
      OnClick = mnuMostrarItensAmbienteClick
    end
    object mnuOrcamentos: TMenuItem
      Caption = 'Or'#231'amentos Pendentes'
      ShortCut = 24697
      OnClick = mnuOrcamentosClick
    end
    object mnuAlterarValorCotacaodoDolar: TMenuItem
      Caption = 'Alterar o Valor da Cota'#231#227'o do D'#243'lar'
      ShortCut = 16452
      OnClick = mnuAlterarValorCotacaodoDolarClick
    end
    object mnuQuestFidelidade: TMenuItem
      Caption = 'Quest Fidelidade'
      ShortCut = 32849
      Visible = False
      OnClick = mnuQuestFidelidadeClick
    end
    object mnuVendDep: TMenuItem
      Caption = 'Vendas por departamento'
      ShortCut = 16452
      OnClick = mnuVendDepClick
    end
    object btnLotIte: TMenuItem
      Caption = 'Lotes do Item'
      ShortCut = 16502
      OnClick = btnLotIteClick
    end
    object btnQtdIteCkout: TMenuItem
      Caption = 'Informar quantidade pedido check-out'
      ShortCut = 8314
      OnClick = btnQtdIteCkoutClick
    end
    object mnuTransfEstAnd: TMenuItem
      Caption = 'Transf.Estoq.andamento'
      ShortCut = 24699
      OnClick = mnuTransfEstAndClick
    end
    object mnuExportarTXTPrecosHUBCitel: TMenuItem
      Caption = 'Exportar TXT de pre'#231'os para HUB Citel'
      Enabled = False
      ShortCut = 16453
      Visible = False
      OnClick = mnuExportarTXTPrecosHUBCitelClick
    end
    object mnuVisualizarCubagemPaletizacaoDosProdutos: TMenuItem
      Caption = 'Visualizar a cubagem/paletiza'#231#227'o dos produtos'
      ShortCut = 16454
      OnClick = mnuVisualizarCubagemPaletizacaoDosProdutosClick
    end
    object mnuPesoLiquidoBrutoProduto: TMenuItem
      Caption = 'Peso L'#237'quido/Bruto do Produto'
      ShortCut = 16464
      OnClick = mnuPesoLiquidoBrutoProdutoClick
    end
    object mnuManRequisicaoCompras: TMenuItem
      Caption = 'Manuten'#231#227'o de Requisi'#231#227'o de Compras'
      ShortCut = 16466
      OnClick = mnuManRequisicaoComprasClick
    end
    object mnuImportarRemessa: TMenuItem
      Caption = 'Importar Remessa - Venda Fora do Estabelecimento'
      ShortCut = 16457
      OnClick = mnuImportarRemessaClick
    end
    object mnuDescontoPorMarca: TMenuItem
      Caption = 'Desconto por Marca'
      ShortCut = 16461
      OnClick = mnuDescontoPorMarcaClick
    end
    object mnuNumeroSerieItens: TMenuItem
      Caption = 'Informar N'#250'mero de S'#233'rie dos Itens'
      ShortCut = 32846
      OnClick = mnuNumeroSerieItensClick
    end
  end
  object dtsSubItens: TDataSource
    Left = 798
    Top = 159
  end
  object popFechamento: TPopupMenu
    Left = 265
    Top = 543
    object btnConfirmaPop: TMenuItem
      Caption = '[F10] Fechamento'
      Enabled = False
      OnClick = btnConfirmaClick
    end
    object btnFechaComDesc: TMenuItem
      Tag = 99
      Caption = '[Ctrl + F10] Fechamento com Desconto'
      Enabled = False
      OnClick = btnConfirmaClick
    end
  end
  object OpenFile: TOpenDialog
    DefaultExt = '.xls'
    Filter = 'Excel (*.xls)|*.xls'
    Title = 'Selecione o arquivo'
    Left = 65232
    Top = 598
  end
  object popGridItens: TPopupMenu
    Left = 448
    Top = 496
    object mnuAlterarQuantidade: TMenuItem
      Caption = 'Alterar a quantidade [ TAB ]'
      OnClick = mnuAlterarQuantidadeClick
    end
    object mnuExcluirProduto: TMenuItem
      Caption = 'Excluir o produto [ DEL ]'
      OnClick = mnuExcluirProdutoClick
    end
    object mnuTrocarProduto: TMenuItem
      Caption = 'Trocar o produto [ CTRL + ENTER ] '
      OnClick = mnuTrocarProdutoClick
    end
    object mnuPopGridItensLinha: TMenuItem
      Caption = '-'
    end
    object mnuCompCusto: TMenuItem
      Caption = 'Composi'#231#227'o do Custo'
      OnClick = mnuCompCustoClick
    end
    object mnuItensComp: TMenuItem
      Caption = 'Itens Comprados'
      OnClick = mnuItensCompClick
    end
    object mnuItensVend: TMenuItem
      Caption = 'Itens Vendidos'
      OnClick = mnuItensVendClick
    end
    object mnuFichaKardex: TMenuItem
      Caption = 'Kardex'
      OnClick = mnuFichaKardexClick
    end
    object mnuSaldodeEstoque: TMenuItem
      Caption = 'Saldo de Estoque'
      OnClick = mnuSaldodeEstoqueClick
    end
    object mnuTransfEstoqueAndamento: TMenuItem
      Caption = 'Transf. Estoque em Andamento'
      OnClick = mnuTransfEstoqueAndamentoClick
    end
    object mnuVendasSisAnt: TMenuItem
      Caption = 'Vendas do Sistema Anterior'
      OnClick = mnuVendasSisAntClick
    end
  end
  object ImageSefaz: TcxImageList
    SourceDPI = 96
    Height = 32
    Width = 32
    FormatVersion = 1
    DesignInfo = 26215332
    ImageInfo = <
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300DC7D
          4700D35C1800D55D1800D35C1800D15B1700D35C1800C3551600F1AA8100CA58
          1700D55D1800D35C1800D35C1800D35C1800F0A17300A449A300A449A300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00A449A300DA7B4400DC60
          1900D35C1800E9783700F9DDCD00E9793900C6561600F1AB8300FDF2EC00EF9C
          6C00CF5A1700DC601900DC601900DC601900DC601900F5C2A500C3C3C300C3C3
          C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3C300FFFFFF00C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300E76A2200D15B
          1700EA7E4000DA5F1800E3631900FAE2D400FBE8DD00C1541600FBE5D800FAE2
          D400E8722E00D15B1700DA5F1800DA5F1800DA5F1800F1AB8200C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300FFFFFF00FFFFFF00C3C3C300FFFFFF00FFFF
          FF00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300F1A87E00CE5A
          1700F8D4BF00E76B2400EC8D5600E9773600F9DAC800CA581700FDF1EA00FDF1
          EA00FADFCF00E76C2500D55D1800DC601900DC601900F1AB8300C3C3C300C3C3
          C300FFFFFF00C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300FFFFFF00FFFF
          FF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300F0A17300F7CE
          B700F6C8AD00E76A2200F9DBC900EA7D3F00C1541600FDF3ED00FDF1EA00FDF1
          EA00FCEEE600FDF1EA00F9D9C600E7692000DC601900F1AB8300C3C3C300FFFF
          FF00C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300FFFFFF00EF9F7100F4BB
          9B00F8D6C200E76D2700F5BFA000E9793900C3551600FDF2EC00FBE8DD00FCEB
          E100FDF2EC00FCEDE400FDF2EC00EF9F7100DC601900F1AB8300C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00C3C3C300C3C3C300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C8571600D75E
          1800D35C1800DC601900D15B1700E1621900F7D0B900CE5A1700E9773600E977
          3600C6561600FDF2EC00FDF1EA00FAE0D100D35C1800F1AB8300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300D15B1700CC59
          1700E76D2700CE5A1700F3B79500FDF2EC00F6C8AE00DE611900EC8A5100ED90
          5B00ED935F00FDF1EA00FCEEE600FDF1EA00E1621900F2AD8500C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300FFFFFF00C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300FFFFFF00CE5A1700EC8A
          5200FBE5D800F1A97F00FDF2EC00FDF1EA00F8D3BD00DC601900EE986600E062
          1900C3551600FDF2EC00FCEDE400FCEEE600F5C2A400F1A87E00C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3551600FDF2
          EC00FCEDE400FCEEE600FCEDE400FCEDE400FDF1EA00E9753200E5631900CC59
          1700EE966400FCEFE800FCEDE400FCEDE400FDF2EC00F0A57900C3C3C300FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3
          C300C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300D15B1700CF5A
          1700FCEBE100FCEFE800FCEDE400FCEDE400FCEDE400FDF1EA00FDF2EC00FDF2
          EC00FDF1EA00FDF1EA00FCEFE800FBE8DD00DA5F1800F2AD8500C3C3C300C3C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3C300FFFFFF00D15B1700CE5A
          1700FAE1D200FDF1EA00FCEDE400FCEDE400FCEDE400FCEDE400FBE9DF00F6C6
          AB00FCEDE400F6C5A900EB824600E8702B00D85E1800F2AD8500C3C3C300C3C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3C300D35C1800D55D
          1800F6CAB000F2AE8700F9DCCB00FCEDE400F8D1BB00FCEFE800FDF2EC00E977
          3600CA581700DA5F1800E0621900E0621900E0621900F2AD8500C3C3C300C3C3
          C300FFFFFF00C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300D35C1800E062
          1900DE611900D55D1800F4BB9B00FBE6DA00E8712D00ED905A00F2AE8700E76A
          2200D85E1800E1621900E0621900E0621900E0621900F2AD8500C3C3C300C3C3
          C300C3C3C300C3C3C300FFFFFF00FFFFFF00C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300E0804900E162
          1900E1621900E1621900D75E1800E0621900E1621900E1621900DE611900E162
          1900E0621900E0621900E0621900E0621900E1621900F6C8AD00C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300FFFFFF00A449A300EE95
          6100E5631900E5631900E5631900E5631900E5631900E5631900E5631900E563
          1900E5631900E5631900E5631900E5631900F4B99700A449A300A449A300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3
          C300C3C3C300C3C3C300C3C3C300C3C3C300C3C3C300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300A449A300A449
          A300A449A300A449A300A449A300A449A300A449A300A449A300}
        MaskColor = 10766755
      end
      item
        Image.Data = {
          36100000424D3610000000000000360000002800000020000000200000000100
          2000000000000010000000000000000000000000000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000679C36FFA386
          3BFF4CB122FF65A625FF7EA030FF58AC24FF52AD22FF779F2DFF93AA4BFF7F9E
          2FFF4CB122FF4CB122FF4CB122FF4CB122FF759F31FFA2688EFFAB64A9FFBFB4
          BFFFC3C3C3FFC3C3C3FFC8C8C8FFC4C4C4FFC3C3C3FFC3C3C3FFC8C8C8FFC4C4
          C4FFC3C3C3FFC3C3C3FFC3C3C3FFC8C8C8FFE4DBE4FFB26EB1FFA68638FF5AA9
          25FF4CB122FFBC8936FFEBA77EFFCE9553FFAE893BFFD29C65FFF4D0BCFFE8A1
          75FF92912BFF4CB122FF4CB122FF4CB122FF7D9F2DFFD3A989FFC6B5B9FFC2C1
          C2FFC3C3C3FFC7C7C7FFE2E2E2FFD0D0D0FFCBCBCBFFC9C9C9FFE9E9E9FFD0D0
          D0FFC4C4C4FFC3C3C3FFC3C3C3FFC3C3C3FFC7C6C7FFC0B7C0FF62AA28FF68A3
          24FF88A034FF5DAA25FFB38D34FFDAC194FFEAC5AAFFCE7D4AFFF2CFBBFFF6D1
          BCFFCC9651FF58AC24FF4CB122FF4CB122FF61A926FFA3A954FFC9BFB8FFC3C3
          C3FFC8C8C8FFC4C4C4FFCCCCCCFFEAEAEAFFEFEFEFFFD0D0D0FFF3F3F3FFF3F3
          F3FFD0D0D0FFC4C4C4FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FF94A23FFFD480
          47FF9BA749FFC58A3AFFAD9C43FF6DB036FFDAB386FFC98D54FFF4DACAFFFBEB
          E2FFF3CFB6FFCC9651FFB68735FF63A624FF61A926FF77A733FFCABFB9FFCECE
          CEFFE3E3E3FFC9C9C9FFCACACAFFCECECEFFE8E8E8FFD6D6D6FFF6F6F6FFFEFE
          FEFFF3F3F3FFD2D2D2FFCBCBCBFFC4C4C4FFC3C3C3FFCBCBCBFF7BAB39FF4CB1
          22FF74AC35FFD38C46FFF1B38FFFC39146FFAE8C40FFF0D1BEFFFAEDE3FFFCEE
          E7FFFBEBE1FFF9DFD0FFF3C5AAFF9E9C3BFF61A926FF77A833FFCEC3BDFFE5E5
          E5FFD3D3D3FFCACACAFFE8E8E8FFCACACAFFCDCDCDFFF1F1F1FFFDFDFDFFFFFF
          FFFFFEFEFEFFF8F8F8FFF1F1F1FFCACACAFFC7C7C7FFE9E9E9FFDE965FFFBAA6
          5EFFC2AB6AFFDF8040FFDFA16DFF7CA430FFB48C43FFEFC8B3FFF6D6C3FFF7D7
          C5FFF5D9CAFFFAEAE1FFFAE5D9FFEBA579FFA98A2EFF77A733FFCABFB9FFCCCC
          CCFFE2E2E2FFCDCDCDFFE6E6E6FFCACACAFFCFCFCFFFEFEFEFFFF4F4F4FFF4F4
          F4FFF5F5F5FFFDFDFDFFF9F9F9FFD1D1D1FFC4C4C4FFC8C8C8FF55AC22FF968E
          29FFA2882CFF61A623FFB3802DFFCA8943FFDAAD7DFFA4933CFFBD8C3CFF969C
          37FFCB864CFFF6DFD1FFFBEDE5FFF4CEB8FFCD7D3AFF77A733FFC9BEB8FFC3C3
          C3FFC7C7C7FFC4C4C4FFC8C8C8FFCECECEFFE4E4E4FFCECECEFFC9C9C9FFC9C9
          C9FFCECECEFFF7F7F7FFFEFEFEFFF2F2F2FFCBCBCBFFC9C9C9FF4CB122FF8394
          26FFBE8A39FFB78637FFDDB083FFF4D8C4FFE2C49EFF62AE2EFF66A626FF4CB1
          22FF81AB40FFF8E1D3FFFBEDE5FFF8DFD0FFD68F50FF76AA33FFC9BEB8FFC3C3
          C3FFC9C9C9FFC4C4C4FFCFCFCFFFECECECFFD7D7D7FFC5C5C5FFC3C3C3FFC3C3
          C3FFC9C9C9FFF6F6F6FFFFFFFFFFF8F8F8FFD8D8D8FFE8E8E8FF63A726FFA0A4
          4AFFF4C7ABFFF0B693FFF8DFD1FFFBECE2FFE8CEAEFF6CAC31FF6AA627FF5BAB
          25FF87A23CFFF5DCCFFFFCEDE4FFFAE7DCFFE5C29CFFBCAF6CFFCABEB7FFCECE
          CEFFEAEAEAFFD5D5D5FFF0F0F0FFFCFCFCFFF2F2F2FFCACACAFFC3C3C3FFC3C3
          C3FFC9C9C9FFF6F6F6FFFFFFFFFFFDFDFDFFF3F3F3FFCFCFCFFF6FA731FFEDBF
          A5FFF9E5D9FFFAE6DBFFFBEBE2FFFCECE3FFF7E0D0FFD29D5DFFCB8B41FFB48E
          41FFDDA473FFF9E3D7FFFBECE3FFFAE8DEFFF5D1BDFFC2B072FFCEC2BBFFE9E9
          E9FFFAFAFAFFF9F9F9FFFDFDFDFFFFFFFFFFF9F9F9FFD3D3D3FFCCCCCCFFCCCC
          CCFFD2D2D2FFF7F7F7FFFFFFFFFFFDFDFDFFF1F1F1FFD1D1D1FF60A522FFC582
          40FFF4D5C2FFFBEDE5FFFCEDE4FFFCEDE4FFFBEBE2FFF9E2D5FFF8DED1FFF6DB
          CCFFF9E3D7FFFAE8DDFFF9E0D2FFF4CCB5FFCF8C4BFFA9A957FFCABFB8FFCECE
          CEFFF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF8F8F8FFF7F7F7FFF7F7
          F7FFF8F8F8FFFCFCFCFFF8F8F8FFF0F0F0FFD4D4D4FFEAEAEAFF4CB122FFA08A
          2FFFF1C8B0FFFAE4D7FFFBE9DEFFFBEBE2FFFBE8DEFFFBEBE3FFFAE5DAFFF4C6
          ABFFF3CDB7FFF0B695FFCF9957FF82A637FF799E28FF61A926FFC9BEB8FFC9C9
          C9FFF3F3F3FFF6F6F6FFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFF5F5
          F5FFF4F4F4FFEFEFEFFFD0D0D0FFC9C9C9FFC4C4C4FFC8C8C8FF4CB122FF978E
          2AFFE6AC82FFE8B38BFFF6D3BFFFFAE4D8FFF6CFB9FFF9DECFFFF8D9C8FFD193
          52FFAD8532FFA4892BFF4CB122FF4CB122FF61A926FF61A926FFC9BEB8FFC8C8
          C8FFE8E8E8FFD5D5D5FFF5F5F5FFFDFDFDFFF8F8F8FFF6F6F6FFF1F1F1FFCFCF
          CFFFC9C9C9FFC8C8C8FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FF4CB122FF56AB
          22FF6BA72AFFAD8830FFECA67FFFF3C1A5FFE88A52FF91A843FFDBA16AFF6AA8
          29FF4CB122FF4CB122FF4CB122FF4CB122FF61A926FFA9AB5CFFCABFB9FFC3C3
          C3FFC7C7C7FFC8C8C8FFECECECFFEFEFEFFFD0D0D0FFC9C9C9FFC8C8C8FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFCBCBCBFFA38B39FF6EA3
          27FF4CB122FF4CB122FFA48728FFA78C2EFF4CB122FF4CB122FF909225FF4CB1
          22FF4CB122FF4CB122FF4CB122FF4CB122FF84A135FFE3A898FFC5B4BAFFC2C0
          C2FFC3C3C3FFC3C3C3FFC7C7C7FFC8C8C8FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC7C6C7FFE5DBE5FF66A133FF859C
          34FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB122FF4CB1
          22FF4CB122FF4CB122FF4CB122FF929428FFCE996CFFB563A0FFAB63A9FFBFB4
          BFFFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3
          C3FFC3C3C3FFC3C3C3FFC3C3C3FFC3C3C3FFC0B7C0FFB16BB0FF000000000000
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
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end
