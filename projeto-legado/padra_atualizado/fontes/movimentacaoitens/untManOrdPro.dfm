inherited frmManOrdPro: TfrmManOrdPro
  Left = 354
  Top = 395
  Width = 690
  Height = 299
  Caption = 'Manuten'#231#227'o de Ordem de Produ'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 690
  ExplicitHeight = 299
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 229
    Width = 684
    Height = 25
    ExplicitTop = 229
    ExplicitWidth = 684
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 606
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 606
      ExplicitHeight = 21
      inherited btnGravar: TBitBtnLocked
        Width = 71
        ExplicitWidth = 71
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 143
        ExplicitLeft = 143
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 215
        Width = 70
        ExplicitLeft = 215
        ExplicitWidth = 70
      end
      inherited btnCancela: TBitBtnLocked
        Left = 285
        Width = 70
        ExplicitLeft = 285
        ExplicitWidth = 70
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 355
        Width = 74
        ExplicitLeft = 355
        ExplicitWidth = 74
      end
      object btnExibir: TBitBtnLocked
        Left = 429
        Top = 0
        Width = 99
        Height = 20
        Anchors = [akLeft, akBottom]
        Caption = 'Exibir '#193'rvore'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460FEEBF82E98E3593460FFF00FF00000000000000
          0000000000000000000000000000000000000000000000FF00FF93460F5DD270
          F7DAB793460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 6
        OnClick = btnExibirClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 528
        Top = 0
        Width = 69
        Height = 20
        Anchors = [akRight, akBottom]
        Caption = 'I&mprimir'
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
        TabOrder = 7
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 608
      Width = 74
      Height = 21
      Align = alRight
      ExplicitLeft = 608
      ExplicitWidth = 74
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 254
    Width = 684
    TabOrder = 2
    ExplicitTop = 254
    ExplicitWidth = 684
    inherited pnlNomeForm: TPanel
      Left = 518
      Width = 166
      ExplicitLeft = 518
      ExplicitWidth = 166
    end
    inherited pnlInfo: TPanel
      Width = 518
      ExplicitWidth = 518
    end
  end
  inherited pgcDados: TPageControl
    Width = 684
    Height = 229
    TabOrder = 1
    ExplicitWidth = 684
    ExplicitHeight = 229
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 676
      ExplicitHeight = 197
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 197
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object bvlCodigo: TBevel
          Left = 1
          Top = 1
          Width = 674
          Height = 38
          Align = alTop
          Shape = bsBottomLine
          ExplicitLeft = 2
          ExplicitWidth = 682
        end
        object lblCodigo: TLabel
          Left = 8
          Top = 12
          Width = 36
          Height = 14
          Caption = 'C'#243'digo:'
        end
        object lblCadastro: TLabel
          Left = 357
          Top = 12
          Width = 66
          Height = 14
          Caption = 'Dta Cadastro:'
        end
        object lblBaixa: TLabel
          Left = 518
          Top = 12
          Width = 49
          Height = 14
          Caption = 'Dta Baixa:'
        end
        object lblCodFabrica: TLabel
          Left = 188
          Top = 12
          Width = 64
          Height = 14
          Caption = 'C'#243'd. F'#225'brica:'
        end
        object dbeCodigo: TDBEditFocus
          Left = 48
          Top = 8
          Width = 121
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRO_CODPRO'
          DataSource = dtsOrdPro
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDtaCad: TDBEditFocus
          Left = 427
          Top = 8
          Width = 83
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'PRO_DTACAD'
          DataSource = dtsOrdPro
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaBai: TDBEditFocus
          Left = 572
          Top = 8
          Width = 83
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'PRO_DTABAI'
          DataSource = dtsOrdPro
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object pnlObs: TPanel
          Left = 1
          Top = 138
          Width = 674
          Height = 50
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object lblObserv: TLabel
            Left = 18
            Top = 5
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = 'Observac'#227'o:'
          end
          object dbeObs001: TDBEditFocus
            Left = 94
            Top = 1
            Width = 547
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_OBS001'
            DataSource = dtsOrdPro
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 150
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeObs002: TDBEditFocus
            Left = 94
            Top = 24
            Width = 547
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_OBS002'
            DataSource = dtsOrdPro
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 30
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlDados: TPanel
          Left = 1
          Top = 39
          Width = 674
          Height = 76
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object lblProduto: TLabel
            Left = 41
            Top = 12
            Width = 40
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto:'
          end
          object Label1: TLabel
            Left = 33
            Top = 35
            Width = 58
            Height = 14
            Alignment = taRightJustify
            Caption = 'Quantidade:'
          end
          object Label2: TLabel
            Left = 394
            Top = 35
            Width = 149
            Height = 14
            Caption = 'Data de Previs'#227'o de Produ'#231#227'o:'
          end
          object Label3: TLabel
            Left = 29
            Top = 58
            Width = 62
            Height = 14
            Alignment = taRightJustify
            Caption = 'Num. Pedido:'
          end
          object Label4: TLabel
            Left = 194
            Top = 58
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Esp'#233'cie: '
          end
          object Label5: TLabel
            Left = 272
            Top = 58
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa:'
          end
          object dbeCodPro: TDBEditFocus
            Tag = 99
            Left = 94
            Top = 8
            Width = 57
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_CODITE'
            DataSource = dtsOrdPro
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 0
            OnExit = dbeCodProExit
            OnKeyPress = dbeCodProKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object edtDesProduto: TEditFocus
            Left = 152
            Top = 8
            Width = 489
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeQtdApr: TDBEditFocus
            Tag = 99
            Left = 94
            Top = 31
            Width = 91
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_QTDAPR'
            DataSource = dtsOrdPro
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDtaPro: TDBEditFocus
            Tag = 99
            Left = 544
            Top = 31
            Width = 97
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_DTAPRO'
            DataSource = dtsOrdPro
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            OnEnter = dbeDtaProEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtNumDoc: TEditFocus
            Tag = 99
            Left = 94
            Top = 54
            Width = 91
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 12
            TabOrder = 4
            OnKeyPress = edtNumDocKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 12
            TipoTexto = ttAlfanumerico
          end
          object edtEspDoc: TEditFocus
            Left = 238
            Top = 54
            Width = 25
            Height = 22
            Alignment = taCenter
            Color = 16768952
            Enabled = False
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtEmpDoc: TEditFocus
            Tag = 99
            Left = 320
            Top = 54
            Width = 36
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 3
            TabOrder = 6
            OnKeyPress = edtEmpDocKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 3
            TipoTexto = ttAlfanumerico
          end
          object ChkDataPrev: TCheckBox
            Left = 238
            Top = 34
            Width = 125
            Height = 17
            Caption = 'Manter Data de Prev.'
            TabOrder = 7
          end
        end
        object pnlSequen: TPanel
          Left = 1
          Top = 115
          Width = 674
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Label6: TLabel
            Left = 5
            Top = 5
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'Seq. Execu'#231#227'o:'
          end
          object dbeSequen: TDBEditFocus
            Tag = 99
            Left = 94
            Top = 1
            Width = 91
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRO_SEQUEN'
            DataSource = dtsOrdPro
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object btnConsultaOrdens: TBitBtnLocked
            Left = 189
            Top = 1
            Width = 28
            Height = 22
            Hint = '[F1] - Consultar Ordens em Aberto'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000040000000A000000100000001300000015000000140000
              00110000000C0000000500000001000000000000000000000000000000000000
              00030000000C070404263F271F836E4235CA7A4839DE915644FF774436DE693C
              30CE3A2019870704032B00000010000000040000000000000000000000030000
              0011442C2486976253F5BE998EFFD9C5BEFFE0CFCAFFEFE6E3FFDDCAC4FFD3BC
              B5FFB48B7FFF895140F540231B92000000180000000500000001010204145536
              2D9CC5A398FFF2E9E7FFF5EFEDFFBCAEA8FF71574CFF593A2DFF755B4EFFBEAE
              A7FFEBE2DEFFE5D8D3FFB79085FF4E2A21A90101021A000000032F23246BB58D
              80FFF9F5F4FFF7F3F2FFC1B3ADFF826555FFB19A85FFC2AC97FFB09783FF7F62
              51FFC0B0A9FFECE3DFFFECE2DFFFA37467FF28191A750000000A5E4F60E1BCB1
              ACFFF6F3F3FFF8F4F3FF7A5E50FFBEA995FF857162FF3F2A22FF746053FFB8A3
              8FFF806658FFEEE5E2FFECE2DFFFB1A29CFF503F50E40000000D182C4D885C63
              72FFB2B0B0FFF1EEEDFF725242FFDDD1B9FF806D5EFF493229FF493228FFCFC0
              A9FF745545FFEBE3E1FFABA6A3FF505566FF142A55AA0000000A05080F21395F
              9DFA697F9AFF626160FF55443CFFB2A894FFE4E0C1FF584135FF847466FFA498
              87FF58483FFF5F5C5CFF4E6586FF2F5191FF050B173C00000004000000031221
              3B685A7FB7FFA6C5E3FF7990ABFF444D59FF3E4248FF2B2A25FF3C4148FF3E48
              56FF627D9EFF789DC9FF3C609FFD0B172E630000000600000000000000000000
              00030F1B3159315593ED6F91C1FF9BB9DCFFB0CDE9FFCBE8FCFFA7C7E6FF87AA
              D3FF5A7EB3FF284B8BF10A152958000000060000000100000000000000000000
              0000000000020204071112223E6F1C3765B0213F76D0274C91FC1E3C74D01933
              62B40F1F3D750204081700000003000000000000000000000000000000000000
              0000000000000000000000000002000000030000000400000005000000050000
              0004000000020000000100000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            TabStop = False
            OnClick = btnConsultaOrdensClick
          end
        end
        object edtCodFab: TEditFocus
          Left = 256
          Top = 8
          Width = 93
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
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
    object tbsFases: TTabSheet
      Caption = '&2 - Fases'
      ImageIndex = 1
      object cxgCadFas: TcxGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 670
        Height = 191
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCadFasView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '< Sem fases para ordenar>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgCadFasCODIGO: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'FAS_CODIGO'
            Options.Editing = False
            Width = 65
          end
          object cxgCadFasDESFAS: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da Fase'
            DataBinding.FieldName = 'FAS_DESFAS'
            Options.Editing = False
            Width = 516
          end
          object cxgCadFasSEQUEN: TcxGridDBColumn
            Caption = 'Sequ'#234'ncia'
            DataBinding.FieldName = 'FAS_SEQUEN'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 93
          end
          object cxgCadFasSTATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'FAS_STATUS'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
          end
        end
        object cxgCadFasLevel1: TcxGridLevel
          GridView = cxgCadFasView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 24
  end
  object dtsOrdPro: TDataSource
    Left = 432
    Top = 112
  end
end
