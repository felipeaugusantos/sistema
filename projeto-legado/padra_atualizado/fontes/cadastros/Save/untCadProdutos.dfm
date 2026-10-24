inherited frmCadProdutos: TfrmCadProdutos
  Left = 132
  Top = 140
  Width = 1024
  Height = 797
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Produtos'
  DoubleBuffered = True
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 797
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 728
    Width = 1018
    Height = 26
    TabOrder = 1
    ExplicitTop = 728
    ExplicitWidth = 1018
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 941
      Height = 22
      ExplicitWidth = 941
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Width = 89
        Height = 22
        ExplicitWidth = 89
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 89
        Width = 89
        Height = 22
        ExplicitLeft = 89
        ExplicitWidth = 89
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 178
        Width = 89
        Height = 22
        ExplicitLeft = 178
        ExplicitWidth = 89
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 267
        Width = 89
        Height = 22
        ExplicitLeft = 267
        ExplicitWidth = 89
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 356
        Width = 99
        Height = 22
        ExplicitLeft = 356
        ExplicitWidth = 99
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 455
        Width = 89
        Height = 22
        ExplicitLeft = 455
        ExplicitWidth = 89
        ExplicitHeight = 22
      end
      object btnHeranca: TBitBtnLocked
        Left = 544
        Top = 0
        Width = 99
        Height = 22
        Caption = '&Heran'#231'a de itens'
        Enabled = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
      object btnMaisInfo: TBitBtnLocked
        Left = 643
        Top = 0
        Width = 99
        Height = 22
        Caption = 'Mais I&nforma'#231#245'es'
        TabOrder = 7
        OnClick = btnMaisInfoClick
      end
      object btnEstrutura: TBitBtnLocked
        Left = 742
        Top = 0
        Width = 93
        Height = 22
        Caption = 'Estrutura'
        Enabled = False
        TabOrder = 8
        OnClick = btnEstruturaClick
      end
      object btnTabFor: TBitBtnLocked
        Left = 835
        Top = 0
        Width = 93
        Height = 22
        Hint = 'Acessar o Cadastro de Forma'#231#227'o de Pre'#231'os do Fornecedor'
        Caption = 'Form. Pre'#231'os'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = btnTabForClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 943
      Width = 73
      Align = alRight
      ExplicitLeft = 943
      ExplicitWidth = 73
    end
  end
  inherited pnlStatus: TPanel
    Top = 754
    Width = 1018
    Height = 14
    TabOrder = 2
    ExplicitTop = 754
    ExplicitWidth = 1018
    ExplicitHeight = 14
    inherited pnlNomeForm: TPanel
      Left = 843
      Width = 175
      Height = 14
      TabOrder = 1
      ExplicitLeft = 843
      ExplicitWidth = 175
      ExplicitHeight = 14
    end
    inherited pnlInfo: TPanel
      Width = 843
      Height = 14
      TabOrder = 0
      ExplicitWidth = 843
      ExplicitHeight = 14
      object shpAcessoPrecos: TShape
        Left = 826
        Top = 3
        Width = 14
        Height = 10
        Anchors = [akTop, akRight]
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 602
      end
    end
    inherited pnlBotoesTrace: TPanel
      Height = 14
      ExplicitHeight = 14
      inherited btnIniciarTrace: TSpeedButton
        Height = 14
        ExplicitHeight = 14
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 14
        ExplicitHeight = 14
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 14
        ExplicitHeight = 14
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 14
        ExplicitHeight = 14
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 1018
    Height = 728
    TabOrder = 0
    TabStop = True
    OnChange = pgcDadosChange
    ExplicitWidth = 1018
    ExplicitHeight = 728
    inherited tbsGeral: TTabSheet
      Caption = '1 - Geral'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      OnShow = tbsGeralShow
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 696
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 30
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 80
          Top = 9
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object lbl3: TLabel
          Left = 218
          Top = 9
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Cadastro:'
        end
        object lbl4: TLabel
          Left = 373
          Top = 9
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = #218'lt. Altera.:'
        end
        object lbl5: TLabel
          Left = 507
          Top = 9
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador:'
        end
        object dbeCodIte: TDBEditFocus
          Tag = 99
          Left = 120
          Top = 5
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CODITE'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDtaCad: TDBEditFocus
          Tag = 99
          Left = 294
          Top = 5
          Width = 68
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'ITE_DTACAD'
          DataSource = dtsCadIte
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUltAlt: TDBEditFocus
          Tag = 99
          Left = 429
          Top = 5
          Width = 68
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'ITE_DTAALT'
          DataSource = dtsCadIte
          Enabled = False
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
          TipoTexto = ttAlfanumerico
        end
        object dbeOpeAlt: TDBEditFocus
          Tag = 99
          Left = 560
          Top = 5
          Width = 39
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CODOPE'
          DataSource = dtsCadIte
          Enabled = False
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
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtNomOpe: TEditFocus
          Left = 600
          Top = 5
          Width = 250
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
        object btnGs1Cnp: TBitBtnLocked
          Left = 8
          Top = 3
          Width = 35
          Height = 24
          Hint = 'Consultar Produto GS1/CNP'
          Glyph.Data = {
            BE060000424DBE0600000000000036000000280000001D000000130000000100
            18000000000088060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF9F8FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F7FEFFFFFFFFFFFEFFFFFFF8
            FAFEFFFFFFF9FAFEFFFFFFFFFFFEFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFF0E9E5976A4B642100570E005A13005A13006E2F04A78167FCFBFBFFFFFFFF
            FFFFFFFFFFFFFFFFE6EBFD567DF4537BF46C8EF5D8E2FC4E77F37E9CF6567DF4
            7494F58DA7F796AEF800FFFFFFFFFFFFFFFFFFFFFFFF9C7153500400A2795D96
            6849844F2A6F30056B2A00692800631F00581000B79782FFFFFFFFFFFFFFFFFF
            E9EEFD567DF46186F4809CF699B1F8557CF4A3B8F93B69F2B9C9FA93ACF79DB3
            F800FFFFFFFFFFFFFFFFFF773C13793F18CEB9AA601A009263439263427E451F
            6928006B2B006C2C006B2B005C150096694AFFFFFFFFFFFFF5F7FE7796F69FB5
            F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDF1FDBDCCFAB7C7FA00FFFFFFFFFFFF
            90603F7B421BD0BCAD5A1300CFBAAC6E2F0387532F8B593771340A6A2A006C2C
            006C2C006C2C005C1500B5957FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFE0D3C9500400F0E9E45106
            00E3D8CF550B00C4AB997539107D451E87522E6A2A006B2B006C2C006C2C006B
            2B00581000F9F7F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFF7C431BC1A6937C421CCEBAAB642100D0BCAE5E
            1800B08E767F48225B14005F1A006522006B2B00621E00601A005C1600A27A5E
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFF4D0000EEE6E15B1500D4C2B5834E2A9F7558A57D63773C13682700
            DFD2C9E9DFD8A68065621E00C7AF9FEBE2DDA9846A5F1A00FFFFFF844E2A8956
            328F5E3EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00E2D6CD652100
            D2BEB1966849966849C9B1A15A1200BEA28F530800F9F6F4793F164B0000E5DA
            D2621D00996D50490000E8DFD85B1400FCFCFBFFFFFF71340AFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00D1BEB07D461FB89883B08E767D45
            1DCCB6A6642000AE8C74621E00EDE6E1530800C0A492F7F4F35C15005F1900BD
            A08DEEE7E2520700EAE3DDFFFFFF73350CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00D7C6BA763B12C0A491A78167834E29CDB8A95A1300B7
            98825B1400F8F5F3550B006A2900631F00601B00FCFCFB936444550B005B1400
            F1ECE7FFFFFF73360DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00F2ECE8540900E2D6CD7C441DAF8C74B5957F6E2E02C0A693530900D2BFB2
            B89A8586512DA67F645F1A00F7F4F172340AB69781540A00FFFFFF8F5E3C7033
            08FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF5A1300
            E7DED6540A00E6DCD45B1400CDB8A86E2F04AC876E530800A2795DBFA4917E45
            1F652200824B26CAB4A490603F7A3F18FFFFFFE8DED8B89984FFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFA88369895532B798828E5D
            3BA67F658F5E3DA27A5E73370D9D72557B421A621E006928006C2C0068260063
            1F00591000C8B0A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF510500D8C7BC6D2E02B3927B8D5C3A80
            4923A8836A763B136928006B2B006B2B006C2C006C2C00672600703207FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00FFFFFFFFFFFFE0D2C8490000DBCBC072350B8E5E3CAB866E703106773C13
            74380F6B2A006C2C006C2C00692800591200FCFAFAFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
            FFFFFFD6C4B74B0000AA856CAA866D642100804A24814A246928006B2B006B2B
            006420005F1900F2ECE8C9B1A1C4AB99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFF8F4
            F27F4721540A008B5937804A246A2900632000601C00591100956748FFFFFFFF
            FFFFA57E63AD8970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F4F1C0
            A592A68065A37B60AB886FCAB3A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF00}
          TabOrder = 5
          TabStop = False
          OnClick = btnGs1CnpClick
        end
      end
      object pnlDadosGerais: TPanel
        Left = 0
        Top = 30
        Width = 1010
        Height = 200
        Align = alTop
        Color = 16770261
        DoubleBuffered = True
        ParentBackground = False
        ParentDoubleBuffered = False
        TabOrder = 1
        object Label11: TLabel
          Left = 884
          Top = 149
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Saldo:'
        end
        object Label55: TLabel
          Left = 857
          Top = 127
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Embalagem:'
        end
        object pnlImgPro: TPanel
          Left = 872
          Top = 12
          Width = 131
          Height = 95
          BevelInner = bvLowered
          BorderWidth = 2
          BorderStyle = bsSingle
          Color = clWhite
          DoubleBuffered = True
          ParentBackground = False
          ParentDoubleBuffered = False
          TabOrder = 0
          OnDblClick = imgProDblClick
          object lblErrImg: TLabel
            Left = 4
            Top = 4
            Width = 119
            Height = 83
            Align = alClient
            Alignment = taCenter
            Caption = 
              'N'#227'o foi poss'#237'vel carregar a imagem do produto. Verifique o forma' +
              'to do arquivo!'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -9
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            Visible = False
            WordWrap = True
            OnDblClick = imgProDblClick
            ExplicitWidth = 118
            ExplicitHeight = 48
          end
          object imgPro: TcxImage
            Left = 4
            Top = 4
            Align = alClient
            Properties.FitMode = ifmProportionalStretch
            Properties.PopupMenuLayout.MenuItems = []
            TabOrder = 0
            OnDblClick = imgProDblClick
            Height = 83
            Width = 119
          end
        end
        object dbeSaldos: TEditFocus
          Tag = 99
          Left = 916
          Top = 146
          Width = 84
          Height = 22
          TabStop = False
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
          TabOrder = 2
          OnKeyPress = dbeCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeEmbalagem: TDBEditFocus
          Tag = 99
          Left = 916
          Top = 123
          Width = 84
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'ITE_EMBALA'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          OnChange = dbeEmbalagemChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object pnlGeralEsquerda: TPanel
          Left = 1
          Top = 1
          Width = 856
          Height = 198
          Align = alLeft
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object pnlGeral1: TPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 58
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object Label3: TLabel
              Left = 443
              Top = 17
              Width = 62
              Height = 14
              Alignment = taRightJustify
              Caption = 'Linha/Grupo:'
            end
            object Label4: TLabel
              Left = 67
              Top = 39
              Width = 52
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descri'#231#227'o:'
            end
            object lblSeta: TLabel
              Left = 10
              Top = 21
              Width = 15
              Height = 20
              Hint = 'Ser'#225' impresso na nota fiscal at'#233' este caractere'
              Caption = '6'
              Font.Charset = SYMBOL_CHARSET
              Font.Color = clRed
              Font.Height = -15
              Font.Name = 'Webdings'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              Visible = False
            end
            object lblRefePonteiro: TLabel
              Left = 120
              Top = 0
              Width = 497
              Height = 14
              Caption = 
                'Este label '#233' que controla onde ficar'#225' o ponteiro. Ele ter'#225' o tam' +
                'anho maximo da impress'#227'o na nota fiscal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
            end
            object lblCodDep: TLabel
              Left = 47
              Top = 17
              Width = 70
              Height = 14
              Alignment = taRightJustify
              Caption = 'Departamento:'
            end
            object dbeCodGru: TDBEditFocus
              Tag = 99
              Left = 508
              Top = 13
              Width = 50
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CODGRU'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 1
              OnKeyPress = dbeCodGruKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCodGruChamaCadastro
            end
            object dbeDesIte: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 36
              Width = 729
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESITE'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              OnChange = dbeDesIteChange
              OnKeyPress = dbeDesIteKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtLinGru: TEditFocus
              Left = 559
              Top = 13
              Width = 290
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object dbeCodDep: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 13
              Width = 50
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CODDEP'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              OnExit = dbeCodDepExit
              OnKeyPress = dbeCodDepKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttNumerico
            end
            object edtDesDep: TEditFocus
              Left = 171
              Top = 13
              Width = 260
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
          end
          object pnlGeral2: TPanel
            Left = 0
            Top = 58
            Width = 856
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object lblDesSim: TLabel
              Left = 7
              Top = 5
              Width = 112
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descri'#231#227'o Simplificada:'
            end
            object lblDescOrig: TLabel
              Left = 435
              Top = 5
              Width = 70
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Desc. Original:'
              Visible = False
            end
            object dbeDesSim: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 1
              Width = 311
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESSIM'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              OnChange = dbeDesIteChange
              OnKeyPress = dbeDesIteKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtDescOrig: TEditFocus
              Left = 508
              Top = 1
              Width = 341
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              Visible = False
              NormalColor = 16768952
              FocusColor = 16768952
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlGeral3: TPanel
            Left = 0
            Top = 82
            Width = 856
            Height = 117
            Align = alTop
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            object Label5: TLabel
              Left = 63
              Top = 4
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'Refer'#234'ncia:'
            end
            object Label6: TLabel
              Left = 86
              Top = 27
              Width = 33
              Height = 14
              Alignment = taRightJustify
              Caption = 'Marca:'
            end
            object Label7: TLabel
              Left = 60
              Top = 48
              Width = 59
              Height = 14
              Alignment = taRightJustify
              Caption = 'Fornecedor:'
            end
            object Label8: TLabel
              Left = 55
              Top = 70
              Width = 64
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'd. F'#225'brica:'
            end
            object Label9: TLabel
              Left = 569
              Top = 4
              Width = 55
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'd. Barra:'
            end
            object Label10: TLabel
              Left = 582
              Top = 50
              Width = 42
              Height = 14
              Alignment = taRightJustify
              Caption = 'Unidade:'
            end
            object lblUniCom: TLabel
              Left = 557
              Top = 72
              Width = 67
              Height = 14
              Alignment = taRightJustify
              Caption = 'Unid. Compra:'
            end
            object Label121: TLabel
              Left = 557
              Top = 27
              Width = 67
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'd Bar. Emb:'
            end
            object lblUniTri: TLabel
              Left = 66
              Top = 95
              Width = 51
              Height = 14
              Alignment = taRightJustify
              Caption = 'Unid. Trib.:'
            end
            object lblFatUTr: TLabel
              Left = 488
              Top = 95
              Width = 136
              Height = 14
              Alignment = taRightJustify
              Caption = 'Fator convers'#227'o (Unid.Trib):'
            end
            object dbeRefere: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 0
              Width = 311
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_REFERE'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeCodMar: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 23
              Width = 50
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CODMAR'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              OnKeyPress = dbeCodMarKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCodMarChamaCadastro
            end
            object dbeCodFor: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 46
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CODFOR'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 5
              OnEnter = dbeCodForEnter
              OnExit = dbeCodForExit
              OnKeyPress = dbeCodForKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCodForChamaCadastro
            end
            object dbeCodFab: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 69
              Width = 311
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CODFAB'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeCodBar: TDBEditFocus
              Tag = 99
              Left = 626
              Top = 0
              Width = 223
              Height = 22
              TabStop = False
              CharCase = ecUpperCase
              DataField = 'ITE_CODBAR'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeCodUni: TDBEditFocus
              Tag = 99
              Left = 626
              Top = 46
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CODUNI'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 7
              OnKeyPress = dbeCodUniKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCodUniChamaCadastro
            end
            object edtDesMar: TEditFocus
              Left = 171
              Top = 23
              Width = 260
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtNomFor: TEditFocus
              Left = 213
              Top = 46
              Width = 218
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
            object edtDesUni: TEditFocus
              Left = 666
              Top = 46
              Width = 183
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 8
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object dbeUniCom: TDBEditFocus
              Tag = 99
              Left = 626
              Top = 69
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_UNICOM'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 10
              OnExit = dbeUniComExit
              OnKeyPress = dbeUniComKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCodUniChamaCadastro
            end
            object edtDesUniCom: TEditFocus
              Left = 666
              Top = 69
              Width = 183
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 11
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object dbeBarEmb: TDBEditFocus
              Tag = 99
              Left = 626
              Top = 23
              Width = 223
              Height = 22
              TabStop = False
              CharCase = ecUpperCase
              DataField = 'ITE_BAREMB'
              DataSource = dtsCadIte
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
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeUniTri: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 92
              Width = 39
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_UNITRI'
              DataSource = dtsCadIte
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 2
              ParentFont = False
              TabOrder = 12
              OnKeyPress = dbeUniTriKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              PanelInfo = pnlInfo
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeCodUniChamaCadastro
            end
            object edtDesUniTri: TEditFocus
              Left = 160
              Top = 92
              Width = 271
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 13
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object dbeFatUTr: TDBEditFocus
              Tag = 99
              Left = 626
              Top = 92
              Width = 223
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_FATUTR'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 14
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object pnlPrecos: TPanel
        Left = 0
        Top = 230
        Width = 1010
        Height = 466
        Align = alClient
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object pnlPrecos1: TPanel
          Left = 1
          Top = 1
          Width = 1001
          Height = 464
          Align = alClient
          Anchors = []
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object Label13: TLabel
            Left = 36
            Top = 6
            Width = 82
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Compra:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label14: TLabel
            Left = 39
            Top = 28
            Width = 79
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto 01 (-):'
          end
          object Label33: TLabel
            Left = 213
            Top = 28
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label15: TLabel
            Left = 88
            Top = 50
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = '02 (-):'
          end
          object Label34: TLabel
            Left = 213
            Top = 50
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label16: TLabel
            Left = 88
            Top = 72
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = '03 (-):'
          end
          object Label35: TLabel
            Left = 213
            Top = 72
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label17: TLabel
            Left = 88
            Top = 94
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = '04 (-):'
          end
          object Label36: TLabel
            Left = 213
            Top = 94
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label18: TLabel
            Left = 88
            Top = 116
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = '05 (-):'
          end
          object Label37: TLabel
            Left = 213
            Top = 116
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label19: TLabel
            Left = 88
            Top = 138
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = '06 (-):'
          end
          object Label20: TLabel
            Left = 304
            Top = 6
            Width = 82
            Height = 14
            Alignment = taRightJustify
            Caption = 'ICMS Entrada (-):'
          end
          object Label39: TLabel
            Left = 483
            Top = 6
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label21: TLabel
            Left = 316
            Top = 50
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'IPI Entrada (+):'
          end
          object Label40: TLabel
            Left = 483
            Top = 50
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label22: TLabel
            Left = 341
            Top = 72
            Width = 45
            Height = 14
            Alignment = taRightJustify
            Caption = 'Frete (+):'
          end
          object Label41: TLabel
            Left = 483
            Top = 72
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label23: TLabel
            Left = 282
            Top = 116
            Width = 104
            Height = 14
            Alignment = taRightJustify
            Caption = 'Acr'#233'scimo Finan. (+):'
          end
          object Label42: TLabel
            Left = 483
            Top = 116
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label24: TLabel
            Left = 296
            Top = 138
            Width = 90
            Height = 14
            Alignment = taRightJustify
            Caption = 'Sub. Tribut'#225'ria (+):'
          end
          object Label43: TLabel
            Left = 483
            Top = 138
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblPreCus: TLabel
            Left = 298
            Top = 182
            Width = 88
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o de Custo:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblValFre: TLabel
            Left = 313
            Top = 94
            Width = 73
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Frete (+):'
          end
          object lblDesAdi: TLabel
            Left = 218
            Top = 160
            Width = 168
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Descontos Adicionais (Boleto) (-):'
          end
          object Label133: TLabel
            Left = 483
            Top = 160
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label135: TLabel
            Left = 280
            Top = 28
            Width = 106
            Height = 14
            Alignment = taRightJustify
            Caption = 'Impostos Federais (-):'
          end
          object Label136: TLabel
            Left = 483
            Top = 28
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblTabPre: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 251
            Width = 995
            Height = 14
            Align = alBottom
            AutoSize = False
            Caption = 'TABELAS DE PRE'#199'O'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            ExplicitLeft = 6
            ExplicitTop = 211
            ExplicitWidth = 261
          end
          object Label38: TLabel
            Left = 213
            Top = 138
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label137: TLabel
            Left = 6
            Top = 160
            Width = 112
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Compra L'#237'qu.:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbePreCom: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 2
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PRECOM'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesf01: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 24
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESF01'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesf02: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 46
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESF02'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesf03: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 68
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESF03'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesf04: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 90
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESF04'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 5
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesf05: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 112
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESF05'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 6
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesf06: TDBEditFocus
            Tag = 99
            Left = 120
            Top = 134
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESF06'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 7
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeIcmEnt: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 2
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ICMENT'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 9
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeIpiEnt: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 46
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_IPIENT'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 11
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeFreEnt: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 68
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_FREENT'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 12
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAcrFin: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 112
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ACRFIN'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 14
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeSubsti: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 134
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_SUBSTI'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 15
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePreCus: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 178
            Width = 92
            Height = 22
            TabStop = False
            CharCase = ecUpperCase
            DataField = 'ITE_PRECUS'
            DataSource = dtsIteGer
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 17
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeValFre: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 90
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_VALFRE'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 13
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesAdb: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 156
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESADB'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 16
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeSubFed: TDBEditFocus
            Tag = 99
            Left = 388
            Top = 24
            Width = 92
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_SUBFED'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 10
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtComLiq: TEditFocus
            Left = 120
            Top = 156
            Width = 92
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object chkPreDol: TDBCheckBox
            Left = 215
            Top = 5
            Width = 70
            Height = 17
            TabStop = False
            Caption = 'Em d'#243'lar'
            Ctl3D = True
            DataField = 'ITE_PREDOL'
            DataSource = dtsIteGer
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkPreDolClick
          end
          object FlwPnlTabelas: TFlowPanel
            AlignWithMargins = True
            Left = 3
            Top = 268
            Width = 995
            Height = 193
            Align = alBottom
            BevelOuter = bvNone
            FlowStyle = fsTopBottomLeftRight
            ParentColor = True
            TabOrder = 20
            object gpbTabPre01: TcxGroupBox
              AlignWithMargins = True
              Left = 3
              Top = 3
              Align = alTop
              Caption = 'Tabela 1:'
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.LookAndFeel.Kind = lfUltraFlat
              Style.LookAndFeel.NativeStyle = True
              Style.IsFontAssigned = True
              StyleDisabled.LookAndFeel.Kind = lfUltraFlat
              StyleDisabled.LookAndFeel.NativeStyle = True
              TabOrder = 0
              Visible = False
              Height = 57
              Width = 261
              object lblTitMarBr1: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe1: TLabel
                Left = 6
                Top = 37
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarBr1: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb1: TLabel
                Left = 142
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb1: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar1: TLabel
                Left = 155
                Top = 37
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim1: TLabel
                Left = 123
                Top = 66
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde1: TLabel
                Left = 2
                Top = 66
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb1: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB1'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr1: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR1'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr1Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe1: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE1'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe1MouseEnter
                OnMouseLeave = dbePreVe1MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar1: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde1: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 58
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID1'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbTabPre02: TcxGroupBox
              AlignWithMargins = True
              Left = 3
              Top = 67
              Align = alTop
              Caption = 'Tabela 2:'
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 1
              Visible = False
              Height = 57
              Width = 261
              object lblTitMarBr2: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe2: TLabel
                Left = 6
                Top = 37
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarBr2: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb2: TLabel
                Left = 142
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb2: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar2: TLabel
                Left = 155
                Top = 37
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim2: TLabel
                Left = 123
                Top = 66
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde2: TLabel
                Left = 2
                Top = 66
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb2: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB2'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr2: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR2'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr2Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe2: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE2'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe2MouseEnter
                OnMouseLeave = dbePreVe2MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar2: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde2: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 58
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID2'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbTabPre03: TcxGroupBox
              AlignWithMargins = True
              Left = 3
              Top = 131
              Align = alTop
              BiDiMode = bdLeftToRight
              Caption = 'Tabela 3:'
              ParentBiDiMode = False
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 2
              Visible = False
              Height = 57
              Width = 261
              object lblMarBr3: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitMarBr3: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe3: TLabel
                Left = 6
                Top = 37
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb3: TLabel
                Left = 140
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb3: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar3: TLabel
                Left = 155
                Top = 37
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim3: TLabel
                Left = 123
                Top = 70
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde3: TLabel
                Left = 2
                Top = 70
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb3: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB3'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr3: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR3'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr3Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe3: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE3'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe3MouseEnter
                OnMouseLeave = dbePreVe3MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar3: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde3: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 62
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID3'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbTabPre04: TcxGroupBox
              AlignWithMargins = True
              Left = 270
              Top = 3
              Align = alTop
              Caption = 'Tabela 4:'
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 3
              Visible = False
              Height = 57
              Width = 261
              object lblTitMarBr4: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarBr4: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe4: TLabel
                Left = 6
                Top = 38
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb4: TLabel
                Left = 142
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb4: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar4: TLabel
                Left = 155
                Top = 37
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde4: TLabel
                Left = 1
                Top = 69
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim4: TLabel
                Left = 123
                Top = 71
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb4: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB4'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr4: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR4'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr4Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe4: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE4'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe4MouseEnter
                OnMouseLeave = dbePreVe4MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar4: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde4: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 61
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID4'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbTabPre05: TcxGroupBox
              AlignWithMargins = True
              Left = 270
              Top = 67
              Align = alTop
              Caption = 'Tabela 5:'
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 4
              Visible = False
              Height = 57
              Width = 261
              object lblTitMarBr5: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarBr5: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe5: TLabel
                Left = 6
                Top = 37
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb5: TLabel
                Left = 142
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb5: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar5: TLabel
                Left = 155
                Top = 37
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim5: TLabel
                Left = 123
                Top = 68
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde5: TLabel
                Left = 1
                Top = 68
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb5: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB5'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr5: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR5'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr5Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe5: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE5'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe5MouseEnter
                OnMouseLeave = dbePreVe5MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar5: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde5: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 60
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID5'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbTabPre06: TcxGroupBox
              AlignWithMargins = True
              Left = 270
              Top = 131
              Align = alTop
              Caption = 'Tabela 6:'
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 5
              Visible = False
              Height = 57
              Width = 261
              object lblTitMarBr6: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarBr6: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe6: TLabel
                Left = 6
                Top = 37
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb6: TLabel
                Left = 142
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb6: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar6: TLabel
                Left = 156
                Top = 35
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde6: TLabel
                Left = 1
                Top = 71
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim6: TLabel
                Left = 123
                Top = 71
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb6: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB6'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr6: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR6'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr6Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe6: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE6'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe6MouseEnter
                OnMouseLeave = dbePreVe6MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar6: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde6: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 63
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID6'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object gpbTabPre07: TcxGroupBox
              AlignWithMargins = True
              Left = 537
              Top = 3
              Align = alTop
              Caption = 'Tabela 7:'
              ParentFont = False
              Style.BorderColor = clBlack
              Style.BorderStyle = ebsUltraFlat
              Style.Font.Charset = ANSI_CHARSET
              Style.Font.Color = clBlack
              Style.Font.Height = 14
              Style.Font.Name = 'Arial'
              Style.Font.Pitch = fpVariable
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 6
              Visible = False
              Height = 57
              Width = 261
              object lblTitMarBr7: TLabel
                Left = 29
                Top = 15
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarBr7: TLabel
                Left = 123
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitPreVe7: TLabel
                Left = 6
                Top = 37
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pre'#231'o Venda:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblTitComTb7: TLabel
                Left = 142
                Top = 15
                Width = 59
                Height = 14
                Alignment = taRightJustify
                Caption = 'Comiss'#227'o:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblPerComTb7: TLabel
                Left = 246
                Top = 15
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblDolar7: TLabel
                Left = 155
                Top = 37
                Width = 23
                Height = 14
                Alignment = taRightJustify
                Caption = 'US$:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIde7: TLabel
                Left = 2
                Top = 69
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Ideal:'
                Color = 16770261
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = 14
                Font.Name = 'charter'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object lblMarIdeSim7: TLabel
                Left = 123
                Top = 69
                Width = 10
                Height = 14
                Alignment = taRightJustify
                Caption = '%'
                Transparent = True
                StyleElements = [seClient, seBorder]
              end
              object dbeComTb7: TDBEditFocus
                Tag = 99
                Left = 203
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_COMTB7'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 2
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbeMarBr7: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 11
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARBR7'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 1
                OnEnter = dbeMarBr7Enter
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object dbePreVe7: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 33
                Width = 70
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_PREVE7'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 3
                OnExit = pValidarPrecos
                OnMouseEnter = dbePreVe7MouseEnter
                OnMouseLeave = dbePreVe7MouseLeave
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
              object edtDolar7: TEditFocus
                Tag = 50
                Left = 180
                Top = 33
                Width = 65
                Height = 22
                TabStop = False
                Alignment = taLeftJustify
                CharCase = ecUpperCase
                Ctl3D = True
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                OnExit = pValidarPrecos
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 0
                TipoTexto = ttNumerico
              end
              object dbeMarIde7: TDBEditFocus
                Tag = 99
                Left = 80
                Top = 65
                Width = 42
                Height = 22
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'ITE_MARID7'
                DataSource = dtsIteGer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
          end
          object pnlCamposSuframa: TPanel
            Left = 500
            Top = 2
            Width = 240
            Height = 114
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 18
            Visible = False
            object Label221: TLabel
              Left = 85
              Top = 4
              Width = 41
              Height = 14
              Alignment = taRightJustify
              Caption = 'TCIF (+):'
            end
            object Label222: TLabel
              Left = 93
              Top = 26
              Width = 33
              Height = 14
              Alignment = taRightJustify
              Caption = 'TS (+):'
            end
            object Label223: TLabel
              Left = 4
              Top = 48
              Width = 122
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto PIS/COFINS (-):'
            end
            object Label224: TLabel
              Left = 35
              Top = 70
              Width = 91
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desconto ICMS (-):'
            end
            object Label225: TLabel
              Left = 37
              Top = 92
              Width = 89
              Height = 14
              Alignment = taRightJustify
              Caption = 'Fator Regional (+):'
            end
            object Label227: TLabel
              Left = 228
              Top = 4
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label228: TLabel
              Left = 228
              Top = 26
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label229: TLabel
              Left = 228
              Top = 48
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label230: TLabel
              Left = 228
              Top = 72
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label231: TLabel
              Left = 228
              Top = 94
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object dbeTCIF: TDBEditFocus
              Tag = 99
              Left = 132
              Top = 0
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TCIFCU'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeTS: TDBEditFocus
              Tag = 99
              Left = 132
              Top = 22
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TSCUST'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 1
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeDePiCo: TDBEditFocus
              Tag = 99
              Left = 132
              Top = 44
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DEPICO'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeDeICMS: TDBEditFocus
              Tag = 99
              Left = 132
              Top = 66
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DEICMS'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 3
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeFatReg: TDBEditFocus
              Tag = 99
              Left = 132
              Top = 88
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_FATREG'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 4
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
          end
          object pnlCusReal: TPanel
            Left = 760
            Top = 2
            Width = 227
            Height = 115
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 19
            object lblOutVal: TLabel
              Left = 25
              Top = 3
              Width = 93
              Height = 14
              Alignment = taRightJustify
              Caption = 'Outros Valores (+):'
            end
            object Label25: TLabel
              Left = 44
              Top = 25
              Width = 74
              Height = 14
              Alignment = taRightJustify
              Caption = 'ICMS Sa'#237'da (+):'
            end
            object Label28: TLabel
              Left = 10
              Top = 47
              Width = 108
              Height = 14
              Alignment = taRightJustify
              Caption = 'Impostos Federais (+):'
            end
            object Label66: TLabel
              Left = 3
              Top = 69
              Width = 115
              Height = 14
              Alignment = taRightJustify
              Caption = 'Desp. Operacionais (+):'
            end
            object lblCusReaTit: TLabel
              Left = 4
              Top = 91
              Width = 114
              Height = 14
              Alignment = taRightJustify
              Caption = 'Pre'#231'o de Custo Real:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label44: TLabel
              Left = 214
              Top = 26
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object Label29: TLabel
              Left = 214
              Top = 48
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object lblDesOpePer: TLabel
              Left = 214
              Top = 70
              Width = 10
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
            end
            object dbeOutVal: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 0
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_OUTVAL'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeIcmSai: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 22
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_ICMSAI'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 1
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeImpFed: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 44
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_IMPFED'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDesOpe: TDBEditFocus
              Tag = 99
              Left = 120
              Top = 66
              Width = 92
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DESOPE'
              DataSource = dtsIteGer
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 3
              OnExit = pValidarPrecos
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object edtCusRea: TEditFocus
              Left = 120
              Top = 88
              Width = 92
              Height = 22
              TabStop = False
              Alignment = taRightJustify
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          end
        end
        object Panel6: TPanel
          Left = 1002
          Top = 1
          Width = 7
          Height = 464
          Align = alRight
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
        end
      end
    end
    object tbsMargemIdeal: TTabSheet
      Caption = '2 - Margem Ideal'
      ImageIndex = 15
      object pnlMargemIdeal: TPanel
        Left = 0
        Top = 0
        Width = 309
        Height = 696
        Align = alLeft
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object cxgMarId7: TcxGroupBox
          Left = 0
          Top = 366
          Align = alTop
          Caption = 'Tabela 7:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 6
          Visible = False
          Height = 61
          Width = 309
          object Label179: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Label180: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Label181: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object dbeMarId7: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID7'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId7: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgMarId6: TcxGroupBox
          Left = 0
          Top = 305
          Align = alTop
          Caption = 'Tabela 6:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 5
          Visible = False
          Height = 61
          Width = 309
          object Label174: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label175: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label176: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object dbeMarId6: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID6'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId6: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgMarId5: TcxGroupBox
          Left = 0
          Top = 244
          Align = alTop
          Caption = 'Tabela 5:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 4
          Visible = False
          Height = 61
          Width = 309
          object Label177: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Label178: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Label182: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object dbeMarId5: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID5'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId5: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgMarId4: TcxGroupBox
          Left = 0
          Top = 183
          Align = alTop
          Caption = 'Tabela 4:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 3
          Visible = False
          Height = 61
          Width = 309
          object Label183: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Label184: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label185: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object dbeMarId4: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID4'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId4: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgMarId3: TcxGroupBox
          Left = 0
          Top = 122
          Align = alTop
          Caption = 'Tabela 3:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 2
          Visible = False
          Height = 61
          Width = 309
          object Label186: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label187: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label188: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object dbeMarId3: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID3'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId3: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgMarId2: TcxGroupBox
          Left = 0
          Top = 61
          Align = alTop
          Caption = 'Tabela 2:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 1
          Visible = False
          Height = 61
          Width = 309
          object Label189: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label190: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label191: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object dbeMarId2: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID2'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId2: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgMarId1: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Caption = 'Tabela 1:'
          ParentFont = False
          Style.BorderColor = clBlack
          Style.BorderStyle = ebsUltraFlat
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.IsFontAssigned = True
          TabOrder = 0
          Visible = False
          Height = 61
          Width = 309
          object Label192: TLabel
            Left = 34
            Top = 17
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label193: TLabel
            Left = 11
            Top = 37
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pre'#231'o Venda Ideal:'
            Color = 16770261
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'charter'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label194: TLabel
            Left = 161
            Top = 15
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
            Transparent = True
          end
          object dbeMarId1: TDBEditFocus
            Tag = 99
            Left = 118
            Top = 11
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MARID1'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtPreId1: TEditFocus
            Left = 118
            Top = 34
            Width = 121
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
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
    object tbsComplementos: TTabSheet
      Caption = '2 - Complementos'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object pnlComplementos1: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 92
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label62: TLabel
            Left = 188
            Top = 7
            Width = 65
            Height = 14
            Alignment = taRightJustify
            Caption = 'Imprime Lista:'
          end
          object Label67: TLabel
            Left = 699
            Top = 7
            Width = 28
            Height = 14
            Alignment = taRightJustify
            Caption = 'Ativo:'
          end
          object Label72: TLabel
            Left = 197
            Top = 51
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'Peso Bruto:'
          end
          object ColorLabel3: TColorLabel
            Left = 320
            Top = 7
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object ColorLabel4: TColorLabel
            Left = 794
            Top = 7
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label122: TLabel
            Left = 168
            Top = 74
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Grupo de Pre'#231'os:'
          end
          object Label167: TLabel
            Left = 535
            Top = 73
            Width = 88
            Height = 14
            Alignment = taRightJustify
            Caption = 'Grupo de Produto:'
          end
          object lblPesLiq: TLabel
            Left = 663
            Top = 51
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'Peso L'#237'quido:'
          end
          object lblApeRet: TLabel
            Left = 182
            Top = 29
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Apenas Retira:'
          end
          object lblUsaFle: TLabel
            Left = 609
            Top = 29
            Width = 117
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gerar FLEX do Produto?'
          end
          object lblUsaFle_S_N: TColorLabel
            Left = 794
            Top = 29
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblApeEnt: TLabel
            Left = 321
            Top = 29
            Width = 86
            Height = 14
            Alignment = taRightJustify
            Caption = '/ Apenas Entrega:'
          end
          object lblSimNao: TColorLabel
            Left = 474
            Top = 29
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeImpLis: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 3
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_IMPLIS'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeIteAti: TDBEditFocus
            Tag = 99
            Left = 729
            Top = 3
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ITEATI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbePesoIt: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 47
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PESOIT'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            OnExit = dbePesoItExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCodGpr: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 69
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODGPR'
            DataSource = dtsCadIte
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 7
            OnKeyPress = dbeCodGprKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDesGpr: TEditFocus
            Left = 319
            Top = 69
            Width = 210
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 8
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbePrdGru: TDBEditFocus
            Tag = 99
            Left = 625
            Top = 69
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PRDGRU'
            DataSource = dtsCadIte
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 9
            OnKeyPress = dbePrdGruKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDesPrdPro: TEditFocus
            Left = 691
            Top = 68
            Width = 338
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object dbePesLiq: TDBEditFocus
            Tag = 99
            Left = 729
            Top = 47
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PESLIQ'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeApeRet: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 25
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_APERET'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeUsaFle: TDBEditFocus
            Tag = 99
            Left = 729
            Top = 25
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_USAFLE'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeApeEnt: TDBEditFocus
            Tag = 99
            Left = 409
            Top = 25
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_APEENT'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlPraVal: TPanel
          Left = 1
          Top = 160
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object lblPraVal: TLabel
            Left = 123
            Top = 3
            Width = 130
            Height = 14
            Alignment = taRightJustify
            Caption = 'Prazo de Validade(Meses):'
          end
          object dbePraVal: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PRAVAL'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlComplementos2: TPanel
          Left = 1
          Top = 182
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Label53: TLabel
            Left = 380
            Top = 4
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto Base:'
          end
          object ColorLabel5: TColorLabel
            Left = 488
            Top = 3
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label46: TLabel
            Left = 161
            Top = 4
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto Inflam'#225'vel:'
          end
          object ColorLabel11: TColorLabel
            Left = 292
            Top = 3
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label117: TLabel
            Left = 582
            Top = 4
            Width = 86
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto Pigmento:'
          end
          object ColorLabel7: TColorLabel
            Left = 710
            Top = 3
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label246: TLabel
            Left = 794
            Top = 4
            Width = 97
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto de Balan'#231'a:'
            Visible = False
          end
          object ColorLabel48: TColorLabel
            Left = 929
            Top = 5
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Visible = False
            CorDestaque = clRed
          end
          object dbeIteBas: TDBEditFocus
            Tag = 99
            Left = 451
            Top = 0
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ITEBAS'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeInflam: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_INFLAM'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeProPig: TDBEditFocus
            Tag = 99
            Left = 671
            Top = 0
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ITEPIG'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeIteBal: TDBEditFocus
            Tag = 99
            Left = 893
            Top = 0
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ITEBAL'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            Visible = False
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlMarBas: TPanel
          Left = 1
          Top = 227
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 6
          object lblMarBas: TLabel
            Left = 176
            Top = 3
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'Marca da Base:'
          end
          object cmbMarBas: TComboBoxFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 188
            Height = 22
            Style = csOwnerDrawFixed
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlComplementosPos02: TPanel
          Left = 1
          Top = 93
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object pnlIteCCR: TPanel
            Left = 0
            Top = 0
            Width = 477
            Height = 22
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object lblIteCcr: TLabel
              Left = 165
              Top = 3
              Width = 87
              Height = 14
              Alignment = taRightJustify
              Caption = 'Produto Concreto:'
            end
            object clbIteCcr: TColorLabel
              Left = 292
              Top = 3
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object dbeIteCCR: TDBEditFocus
              Tag = 99
              Left = 255
              Top = 0
              Width = 34
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_ITECCR'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlLocEqui: TPanel
            Left = 477
            Top = 0
            Width = 531
            Height = 22
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object lblPermiteLoc: TLabel
              Left = 27
              Top = 3
              Width = 83
              Height = 14
              Alignment = taRightJustify
              Caption = 'Permite Loca'#231#227'o:'
            end
            object clbReaLoc: TColorLabel
              Left = 159
              Top = 3
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object lblTipLoc: TLabel
              Left = 263
              Top = 3
              Width = 134
              Height = 14
              Alignment = taRightJustify
              Caption = 'Tipo de produto na loca'#231#227'o:'
            end
            object clbTipLoc: TColorLabel
              Left = 442
              Top = 3
              Width = 112
              Height = 14
              Caption = '(A)cess'#243'rio (P)rincipal '
              CorDestaque = clRed
            end
            object dbeReaLoc: TDBEditFocus
              Tag = 99
              Left = 118
              Top = 0
              Width = 34
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_REALOC'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeTipLoc: TDBEditFocus
              Tag = 99
              Left = 401
              Top = 0
              Width = 34
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TIPLOC'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
        end
        object pnlCnv_ML: TPanel
          Left = 1
          Top = 249
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 7
          object lblCnv_ML: TLabel
            Left = 94
            Top = 3
            Width = 159
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fator de convers'#227'o Tintom'#233'trico:'
          end
          object Label82: TLabel
            Left = 370
            Top = -3
            Width = 260
            Height = 28
            Alignment = taCenter
            AutoSize = False
            Caption = 
              'Esse campo representa quantos gramas ou MLs cont'#233'm cada embalage' +
              'm de uma base ou colorante'
            Color = clInfoBk
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object dbeCnv_ML: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 109
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CNV_ML'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlComplementos4: TPanel
          Left = 1
          Top = 293
          Width = 1008
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 9
          object Label68: TLabel
            Left = 95
            Top = 4
            Width = 157
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fator de convers'#227'o Tinta Tipo-2:'
          end
          object lbl12: TLabel
            Left = 389
            Top = 5
            Width = 200
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permitir utilizar este item em bonifica'#231#227'o ?'
          end
          object lbl13: TColorLabel
            Left = 658
            Top = 5
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeFatCnv: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 109
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_FATCNV'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeUsaBon: TDBEditFocus
            Tag = 99
            Left = 592
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_USABON'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlFatCom: TPanel
          Left = 1
          Top = 316
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 10
          object lblFatCom: TLabel
            Left = 99
            Top = 4
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Digitar complemento do produto:'
          end
          object clbFatCom: TColorLabel
            Left = 322
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeFatCom: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_FATCOM'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlSitPro: TPanel
          Left = 1
          Top = 338
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 11
          object lblSitPro: TLabel
            Left = 152
            Top = 3
            Width = 100
            Height = 14
            Alignment = taRightJustify
            Caption = 'Situa'#231#227'o do Produto:'
          end
          object dbeSitPro: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_SITPRO'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeSitProKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttNumerico
          end
          object edtSitPro: TEditFocus
            Left = 320
            Top = 0
            Width = 254
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object pnlDensid: TPanel
          Left = 1
          Top = 382
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 13
          object lblDensid: TLabel
            Left = 198
            Top = 6
            Width = 54
            Height = 14
            Alignment = taRightJustify
            Caption = 'Densidade:'
          end
          object dbeDensid: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 109
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DENSID'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlRapel: TPanel
          Left = 1
          Top = 404
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 14
          object lblRapelDes: TLabel
            Left = 122
            Top = 3
            Width = 130
            Height = 14
            Caption = 'Desconto Referente Rapel:'
          end
          object lblRapelPer: TLabel
            Left = 320
            Top = 2
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object dbePRapel: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PRAPEL'
            DataSource = dtsCadIte
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlProEmb: TPanel
          Left = 1
          Top = 204
          Width = 1008
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object Label2: TLabel
            Left = 155
            Top = 5
            Width = 97
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto Embalagem:'
          end
          object ColorLabel26: TColorLabel
            Left = 292
            Top = 5
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblEmpCar: TLabel
            Left = 380
            Top = 5
            Width = 287
            Height = 14
            Alignment = taRightJustify
            Caption = 'Empresa respons'#225'vel pelo carregamento e entrega do item:'
          end
          object dbeProEmb: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 1
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PROEMB'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeEmpCar: TDBEditFocus
            Tag = 99
            Left = 671
            Top = 1
            Width = 42
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_EMPCAR'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnKeyPress = dbeEmpCarKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttNumerico
          end
          object edtDesEmpCar: TEditFocus
            Left = 715
            Top = 1
            Width = 269
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object pnlDadosConcreto: TPanel
          Left = 1
          Top = 115
          Width = 1008
          Height = 45
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object Label56: TLabel
            Left = 197
            Top = 4
            Width = 57
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abatimento:'
          end
          object Label79: TLabel
            Left = 208
            Top = 27
            Width = 46
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo MPs:'
          end
          object lblBrita: TLabel
            Left = 483
            Top = 4
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Brita:'
          end
          object ColorLabel27: TColorLabel
            Left = 607
            Top = 27
            Width = 156
            Height = 14
            Caption = '(C)onv'#234'ncional ou (B)ombeado?'
            CorDestaque = clRed
          end
          object Label81: TLabel
            Left = 458
            Top = 29
            Width = 47
            Height = 14
            Alignment = taRightJustify
            Caption = 'FCK Dias:'
          end
          object dbeAbatim: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 185
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ABATIM'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeTipMps: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 22
            Width = 185
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_TIPMPS'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeBrita_: TDBEditFocus
            Tag = 99
            Left = 509
            Top = 0
            Width = 162
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_BRITA_'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeConBom: TDBEditFocus
            Tag = 99
            Left = 578
            Top = 22
            Width = 26
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CONBOM'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeFckDia: TDBEditFocus
            Tag = 99
            Left = 509
            Top = 22
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_FCKDIA'
            DataSource = dtsCadIte
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlFatCMP: TPanel
          Left = 1
          Top = 271
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 8
          object lblFatCMP: TLabel
            Left = 26
            Top = 6
            Width = 227
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fator de convers'#227'o madeira de M'#179' para Pe'#231'as:'
          end
          object dbeIteFatCMP: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 109
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_FATCMP'
            DataSource = dtsCadIte
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlLayOrdPro: TPanel
          Left = 1
          Top = 360
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 12
          object lblOrdemProducao: TLabel
            Left = 133
            Top = 4
            Width = 120
            Height = 14
            Alignment = taRightJustify
            Caption = 'Layout Ordem Produ'#231#227'o:'
          end
          object dbeCodLayOrdPro: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_LAYORD'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeCodLayOrdProKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtNomLayOrdPro: TEditFocus
            Left = 320
            Top = 0
            Width = 552
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object Panel8: TPanel
          Left = 1
          Top = 426
          Width = 1008
          Height = 148
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 15
          object Label195: TLabel
            Left = 190
            Top = 85
            Width = 62
            Height = 14
            Alignment = taRightJustify
            Caption = 'Composi'#231#227'o:'
          end
          object Label196: TLabel
            Left = 224
            Top = 108
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'SAC:'
          end
          object Label197: TLabel
            Left = 463
            Top = 106
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pa'#237's de Origem'
          end
          object lblClaCrm: TLabel
            Left = 71
            Top = 129
            Width = 181
            Height = 14
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o Oferta de Consum'#237'veis:'
          end
          object lblClaCrmLeg: TColorLabel
            Left = 285
            Top = 129
            Width = 193
            Height = 14
            Caption = '(C)onsum'#237'vel, (P)rincipal ou (A)cess'#243'rio'
            CorDestaque = clRed
          end
          object lblTemPro: TLabel
            Left = 661
            Top = 61
            Width = 254
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tempo m'#237'nimo de vida '#250'til do produto ap'#243's produ'#231#227'o:'
          end
          object lblDtaLanMer: TLabel
            Left = 738
            Top = 83
            Width = 177
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data de lan'#231'amento para o mercado:'
          end
          object lblCodGpc: TLabel
            Left = 518
            Top = 129
            Width = 187
            Height = 14
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o Global do Produto - GPC:'
          end
          object Label198: TLabel
            Left = 179
            Top = 61
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Exporta Tablet?'
          end
          object ColorLabel35: TColorLabel
            Left = 321
            Top = 61
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeCOMPOS: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 80
            Width = 400
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMPOS'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeITESAC: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 103
            Width = 202
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ITESAC'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePAISOR: TDBEditFocus
            Tag = 99
            Left = 541
            Top = 103
            Width = 400
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PAISOR'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeClaCrm: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 125
            Width = 25
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CLACRM'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeTemPro: TDBEditFocus
            Tag = 99
            Left = 921
            Top = 57
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_TEMPRO'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDtaLan: TDBEditFocus
            Tag = 99
            Left = 921
            Top = 80
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DTALAN'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeCodGpc: TDBEditFocus
            Tag = 99
            Left = 708
            Top = 125
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODGPC'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 8
            OnKeyPress = dbeCodGpcKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
            OnChamaCadastro = dbeCodGpcChamaCadastro
          end
          object edtDesGpc: TEditFocus
            Left = 771
            Top = 125
            Width = 213
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 9
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeExpPok: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 57
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_EXPPOK'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object GroupBox2: TGroupBox
            Left = 76
            Top = -3
            Width = 925
            Height = 59
            Caption = 'Dados para Shelf Life'
            TabOrder = 0
            object lbl15: TLabel
              Left = 10
              Top = 16
              Width = 106
              Height = 14
              Alignment = taRightJustify
              Caption = 'Validade Obrigat'#243'ria ?'
            end
            object lbl17: TColorLabel
              Left = 187
              Top = 15
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object Label171: TLabel
              Left = 252
              Top = 15
              Width = 44
              Height = 14
              Alignment = taRightJustify
              Caption = 'Validade:'
            end
            object lblDiaCri: TLabel
              Left = 51
              Top = 38
              Width = 247
              Height = 14
              Alignment = taRightJustify
              Caption = 'Dias antes do vencimento para transferir ao cr'#237'tico:'
            end
            object lblVALDIA: TLabel
              Left = 651
              Top = 16
              Width = 191
              Height = 14
              Alignment = taRightJustify
              Caption = 'Tempo de Validade do Produto(Em Dias)'
            end
            object lblTOLREC: TLabel
              Left = 531
              Top = 38
              Width = 311
              Height = 14
              Alignment = taRightJustify
              Caption = 'Toler'#226'ncia sobre Vencimento para Recebimento de Produtos (%)'
            end
            object dbeValObr: TDBEditFocus
              Tag = 99
              Left = 119
              Top = 13
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_VALOBR'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeVALIDA: TDBEditFocus
              Tag = 99
              Left = 299
              Top = 12
              Width = 238
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_VALIDA'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDiaCri: TDBEditFocus
              Tag = 99
              Left = 299
              Top = 35
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DIACRI'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeTOLREC: TDBEditFocus
              Tag = 99
              Left = 845
              Top = 35
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TOLREC'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 9
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeVALDIA: TDBEditFocus
              Tag = 99
              Left = 845
              Top = 12
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_VALDIA'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
          end
        end
        object pnlUsarSeries: TPanel
          Left = 1
          Top = 574
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Ctl3D = True
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 16
          object ColorLabel9: TColorLabel
            Left = 323
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label203: TLabel
            Left = 36
            Top = 4
            Width = 213
            Height = 14
            Caption = 'Produto com controle de n'#250'meros de s'#233'rie ?'
          end
          object spbVerSeries: TSpeedButton
            Left = 385
            Top = 1
            Width = 177
            Height = 20
            Caption = 'Ver Numeros de S'#233'rie'
            OnClick = spbVerSeriesClick
          end
          object dbeUSASER: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_USASER'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnChange = dbeUSASERChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlQuestDemanda: TPanel
          Left = 1
          Top = 671
          Width = 1008
          Height = 24
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 17
          object pnlUsaQuest: TPanel
            Left = 0
            Top = 0
            Width = 502
            Height = 24
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 0
            object lblColorUsaQuest: TColorLabel
              Left = 322
              Top = 5
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object lblUsaQuest: TLabel
              Left = 87
              Top = 4
              Width = 162
              Height = 14
              Alignment = taRightJustify
              Caption = 'Usa pontua'#231#227'o Quest Fidelidade?'
            end
            object dbeUsaQuest: TDBEditFocus
              Tag = 99
              Left = 255
              Top = 1
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_USAQUE'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object pnlConferenciaDemanda: TPanel
            Left = 502
            Top = 0
            Width = 506
            Height = 24
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Label232: TLabel
              Left = 4
              Top = 4
              Width = 366
              Height = 14
              Alignment = taRightJustify
              Caption = 
                'Gerar confer'#234'ncia da localiza'#231#227'o f'#237'sica ap'#243's quantas retiradas d' +
                'a mesma ?'
            end
            object dbeCNFDEM: TDBEditFocus
              Tag = 99
              Left = 376
              Top = 1
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CNFDEM'
              DataSource = dtsIteGer
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
          end
        end
        object pnlCertEPI_BNDES: TPanel
          Left = 1
          Top = 640
          Width = 713
          Height = 31
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 20
          object ColorLabel12: TColorLabel
            Left = 322
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label47: TLabel
            Left = 158
            Top = 5
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Conv'#234'nio BNDES ?'
          end
          object Label61: TLabel
            Left = 383
            Top = 5
            Width = 169
            Height = 14
            Alignment = taRightJustify
            Caption = 'Certificado de Aprova'#231#227'o EPI (CA):'
          end
          object dbeBNDES: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CBNDES'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object DBEditFocus4: TDBEditFocus
            Tag = 99
            Left = 558
            Top = 1
            Width = 130
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CEREPI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlControladoPolicia: TPanel
          Left = 1
          Top = 596
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Ctl3D = True
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 18
          object ColorLabel46: TColorLabel
            Left = 323
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label80: TLabel
            Left = 59
            Top = 4
            Width = 190
            Height = 14
            Caption = 'Produto controlado pela pol'#237'cia federal?'
          end
          object ColorLabel47: TColorLabel
            Left = 650
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label237: TLabel
            Left = 402
            Top = 4
            Width = 174
            Height = 14
            Caption = 'Produto controlado pela pol'#237'cia civil?'
          end
          object DBEUSAPFD: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_USAPFD'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnChange = dbeUSASERChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object DBEUSAPCV: TDBEditFocus
            Tag = 99
            Left = 582
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_USAPCV'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnChange = dbeUSASERChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlQRCode: TPanel
          Left = 1
          Top = 618
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Ctl3D = True
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 19
          object Label238: TLabel
            Left = 53
            Top = 4
            Width = 196
            Height = 14
            Alignment = taRightJustify
            Caption = 'URL para Qrcode - Etiqueta de Produtos:'
          end
          object dbeQRCode: TDBEditFocus
            Tag = 99
            Left = 255
            Top = 0
            Width = 729
            Height = 22
            DataField = 'ITE_QRCODE'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnChange = dbeUSASERChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
      end
    end
    object tbsDadosSaida: TTabSheet
      Caption = '3 - Dados de Sa'#237'da'
      ImageIndex = 9
      object pnlIndRev: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblIndRev: TLabel
          Left = 61
          Top = 3
          Width = 136
          Height = 14
          Alignment = taRightJustify
          Caption = 'Industrializa'#231#227'o ou revenda:'
        end
        object lbcIndRev: TColorLabel
          Left = 270
          Top = 3
          Width = 43
          Height = 14
          Caption = '(I) ou (R)'
          CorDestaque = clRed
        end
        object dbeIndRev: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_INDREV'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlImpDir: TPanel
        Left = 0
        Top = 22
        Width = 1010
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object lblImpDir: TLabel
          Left = 110
          Top = 4
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Importa'#231#227'o Direta:'
        end
        object lblcImpDir: TColorLabel
          Left = 262
          Top = 4
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeImpDir: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_IMPDIR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlDadosSaida2: TPanel
        Left = 0
        Top = 43
        Width = 1010
        Height = 150
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object Label119: TLabel
          Left = 100
          Top = 4
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'M'#250'ltiplo para Venda:'
        end
        object Label57: TLabel
          Left = 106
          Top = 25
          Width = 91
          Height = 14
          Alignment = taRightJustify
          Caption = 'Mensagem Livre 1:'
        end
        object Label58: TLabel
          Left = 188
          Top = 44
          Width = 9
          Height = 14
          Alignment = taRightJustify
          Caption = '2:'
        end
        object Label59: TLabel
          Left = 90
          Top = 66
          Width = 107
          Height = 42
          Alignment = taRightJustify
          Caption = 'Aplica'#231#227'o'#13#10'Pressione TAB'#13#10'para o proximo campo'
        end
        object Label142: TLabel
          Left = 51
          Top = 111
          Width = 146
          Height = 14
          Alignment = taRightJustify
          Caption = 'Obrig. C'#243'd. Barras Expedi'#231#227'o:'
        end
        object ColorLabel18: TColorLabel
          Left = 264
          Top = 111
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblDesChk: TLabel
          Left = 14
          Top = 132
          Width = 183
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desobrigar confer'#234'ncia no check-out:'
        end
        object lblDesChkSN: TColorLabel
          Left = 264
          Top = 132
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeMultVenda: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MLTVEN'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeMsgLv1: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 22
          Width = 483
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MSGLV1'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMsgLv2: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 44
          Width = 483
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MSGLV2'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAplica: TDBMemoFocus
          Left = 199
          Top = 66
          Width = 484
          Height = 41
          DataField = 'ITE_APLICA'
          DataSource = dtsCadIte
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 4
          OnClick = dbeAplicaClick
          OnEnter = dbeAplicaEnter
          OnExit = dbeAplicaExit
          OnKeyPress = dbeAplicaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object dbeBarExp: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 107
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_BAREXP'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object pnlPraMin: TPanel
          Left = 266
          Top = 0
          Width = 415
          Height = 22
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label172: TLabel
            Left = 155
            Top = 4
            Width = 201
            Height = 14
            Alignment = taRightJustify
            Caption = 'Prazo m'#233'dio m'#237'nimo para c'#225'lculo de juros:'
          end
          object dbePraMin: TDBEditFocus
            Tag = 99
            Left = 358
            Top = 0
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PRAMIN'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object btnPraMinHelp: TBitBtnLocked
            Left = 394
            Top = 0
            Width = 22
            Height = 21
            Hint = 'Clique aqui para mais informa'#231#245'es sobre a promo'#231#227'o selecionada!'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000800000010000000100000
              0008000000010000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
              0B60000000070000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
              27EA0000000E0000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
              30EC0000000D0000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
              1A51000000050000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000010000000600000011000000140000
              000A000000020000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000670503AA999532EFF4528
              187A000000070000000100000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
              4AF724150D490000000800000002000000000000000000000000000000000000
              0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
              9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
              000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
              AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
              00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
              76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
              000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
              70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
              000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
              C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
              0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
              77E570533B9A17100A2500000002000000000000000000000000000000000000
              0000000000000000000000000000000000010000000100000002000000030000
              0002000000020000000100000000000000000000000000000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            TabStop = False
            OnClick = btnPraMinHelpClick
          end
        end
        object bdeDesChk: TDBEditFocus
          Tag = 99
          Left = 199
          Top = 129
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DESCHK'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlDadosSaidaEsquerda: TPanel
        Left = 0
        Top = 193
        Width = 579
        Height = 503
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object lblPesagemObr: TLabel
          Left = 274
          Top = 394
          Width = 192
          Height = 14
          Alignment = taRightJustify
          Caption = 'Controlar pesagem obrigat'#243'ria (Sa'#237'da) ?'
          WordWrap = True
        end
        object lblPesagemObrSN: TColorLabel
          Left = 491
          Top = 394
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblDesCnd: TLabel
          Left = 271
          Top = 412
          Width = 195
          Height = 14
          Alignment = taRightJustify
          Caption = 'Aplicar desconto da condi'#231#227'o de pagto?'
        end
        object lblDesCndSN: TColorLabel
          Left = 491
          Top = 412
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object pnlDadosSaida3: TPanel
          Left = 0
          Top = 0
          Width = 579
          Height = 45
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label75: TLabel
            Left = 61
            Top = 3
            Width = 136
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o Vendedor Interno:'
          end
          object Label77: TLabel
            Left = 272
            Top = 3
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label78: TLabel
            Left = 551
            Top = 6
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lbl26: TLabel
            Left = 326
            Top = 3
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o Repres. Externo Loja:'
          end
          object lbl27: TLabel
            Left = 9
            Top = 25
            Width = 188
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o Repres. Externo Distribuidor:'
          end
          object lbl28: TLabel
            Left = 272
            Top = 25
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblComDig: TLabel
            Left = 384
            Top = 25
            Width = 95
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o Digitador:'
          end
          object lblComDigPer: TLabel
            Left = 546
            Top = 27
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object shpPEACVI: TShape
            Left = 261
            Top = 0
            Width = 7
            Height = 22
            Hint = 'Usu'#225'rio sem acesso para alterar esse valor'
            Brush.Color = clGreen
            Pen.Color = clGreen
            Pen.Style = psInsideFrame
            Pen.Width = 0
          end
          object shpPEACVE: TShape
            Left = 544
            Top = 1
            Width = 7
            Height = 22
            Hint = 'Usu'#225'rio sem acesso para alterar esse valor'
            Brush.Color = clGreen
            Pen.Color = clGreen
            Pen.Style = psInsideFrame
            Pen.Width = 0
          end
          object shpPEACVD: TShape
            Left = 261
            Top = 22
            Width = 7
            Height = 22
            Hint = 'Usu'#225'rio sem acesso para alterar esse valor'
            Brush.Color = clGreen
            Pen.Color = clGreen
            Pen.Style = psInsideFrame
            Pen.Width = 0
          end
          object dbeComVar: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMVAR'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeComAta: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMATA'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeComDis: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 22
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMDIS'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeComDig: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 21
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMDIG'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlComPro: TPanel
          Left = 0
          Top = 67
          Width = 579
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          object lblComProPer: TLabel
            Left = 264
            Top = 4
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblComPro: TLabel
            Left = 73
            Top = 4
            Width = 124
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o do Profissional:'
          end
          object dbeComPro: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMPRO'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlQtPPro: TPanel
          Left = 0
          Top = 89
          Width = 579
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 3
          object lblQtPPro: TLabel
            Left = 4
            Top = 4
            Width = 193
            Height = 14
            Alignment = taRightJustify
            Caption = 'Quantidade de Pontos para Profissional:'
          end
          object dbeQtPPro: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_QTPPRO'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlDadosSaida4: TPanel
          Left = 0
          Top = 111
          Width = 579
          Height = 266
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 4
          object lblDesMaxPor: TLabel
            Left = 264
            Top = 5
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDesMvmPor: TLabel
            Left = 545
            Top = 4
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDesMSuPor: TLabel
            Left = 264
            Top = 29
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDesMsmPor: TLabel
            Left = 546
            Top = 29
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDesMGePor: TLabel
            Left = 264
            Top = 53
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDesMgmPor: TLabel
            Left = 546
            Top = 53
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblMarMinPor: TLabel
            Left = 264
            Top = 74
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label239: TLabel
            Left = 546
            Top = 74
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lbl37: TLabel
            Left = 264
            Top = 97
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label240: TLabel
            Left = 546
            Top = 97
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lbl39: TLabel
            Left = 264
            Top = 120
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label241: TLabel
            Left = 546
            Top = 120
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label242: TLabel
            Left = 319
            Top = 120
            Width = 161
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem M'#237'nima Gerente - Master:'
          end
          object lbl38: TLabel
            Left = 40
            Top = 120
            Width = 157
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem M'#237'nima Gerente - J'#250'nior:'
          end
          object Label243: TLabel
            Left = 297
            Top = 97
            Width = 183
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem M'#237'nima Sub Gerente - Master:'
          end
          object lbl36: TLabel
            Left = 18
            Top = 97
            Width = 179
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem M'#237'nima Sub Gerente - J'#250'nior:'
          end
          object Label244: TLabel
            Left = 311
            Top = 74
            Width = 169
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem M'#237'nima Vendedor - Master:'
          end
          object lblMarMin: TLabel
            Left = 32
            Top = 74
            Width = 165
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem M'#237'nima Vendedor - J'#250'nior:'
          end
          object lblDesMgm: TLabel
            Left = 307
            Top = 52
            Width = 173
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto M'#225'ximo Gerente - Master:'
          end
          object lblDesMGe: TLabel
            Left = 28
            Top = 52
            Width = 169
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto M'#225'ximo Gerente - J'#250'nior:'
          end
          object lblDesMsm: TLabel
            Left = 284
            Top = 29
            Width = 196
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto M'#225'ximo Sub-Gerente - Master:'
          end
          object lblDesMSu: TLabel
            Left = 8
            Top = 29
            Width = 189
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto M'#225'ximo Sub-Gerente - J'#250'nior'
          end
          object lblDesMvm: TLabel
            Left = 298
            Top = 5
            Width = 181
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto M'#225'ximo Vendedor - Master:'
          end
          object lblDesMax: TLabel
            Left = 20
            Top = 5
            Width = 177
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto M'#225'ximo Vendedor - J'#250'nior:'
          end
          object dbeDesMax: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 1
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESMAX'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus8: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 116
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MARMMG'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 11
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus2: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 116
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MARMGE'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 10
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus7: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 93
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MARMMS'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 9
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus1: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 93
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MARMSG'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 8
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus6: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 70
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MARMMV'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 7
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeMarMin: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 70
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MARMIN'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 6
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesMgm: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 47
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESMGM'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 5
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesMGe: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 47
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESMGE'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesMsm: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 24
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESMSM'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesMSu: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 24
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESMSU'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesMvm: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESMVM'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object pnlOrdServico: TPanel
            Left = 2
            Top = 139
            Width = 397
            Height = 22
            BevelOuter = bvNone
            TabOrder = 12
            object lblOrdServ: TLabel
              Left = 105
              Top = 3
              Width = 90
              Height = 14
              Hint = 'TOP_UP'
              Alignment = taRightJustify
              Caption = 'Ordem de Servi'#231'o:'
            end
            object clbOrdServ: TColorLabel
              Left = 262
              Top = 3
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object edtOrdServ: TDBEditFocus
              Tag = 99
              Left = 197
              Top = 0
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_ORDSER'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object pnlGarant: TPanel
            Left = 4
            Top = 162
            Width = 569
            Height = 84
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 13
            Visible = False
            object lblGarant: TLabel
              Left = 57
              Top = 3
              Width = 136
              Height = 14
              Hint = 'TOP_UP'
              Alignment = taRightJustify
              Caption = 'Tempo de Garantia (Meses):'
            end
            object Label12: TLabel
              Left = 16
              Top = 26
              Width = 177
              Height = 14
              Hint = 'TOP_UP'
              Alignment = taRightJustify
              Caption = 'Informa'#231#245'es da Garantia do Produto:'
            end
            object lblGarFil: TLabel
              Left = 16
              Top = 47
              Width = 177
              Height = 14
              Hint = 'TOP_UP'
              Alignment = taRightJustify
              Caption = 'Garantia Realizada Pela Pr'#243'pria Filial:'
            end
            object lblGarFilColor: TColorLabel
              Left = 260
              Top = 47
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object lblGarFilAviso: TLabel
              Left = 197
              Top = 67
              Width = 402
              Height = 14
              AutoSize = False
              Caption = 
                '* Toda filial deve configurar esse campo de acordo com sua neces' +
                'sidade.'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object lblRspGar: TLabel
              Left = 308
              Top = 1
              Width = 131
              Height = 14
              Hint = 'TOP_UP'
              Alignment = taRightJustify
              Caption = 'Respons'#225'vel pela garantia:'
            end
            object lblLoja_fornec: TColorLabel
              Left = 466
              Top = 1
              Width = 95
              Height = 14
              Caption = '(L)oja (F)ornededor'
              CorDestaque = clRed
            end
            object dbeGarant: TDBEditFocus
              Tag = 99
              Left = 195
              Top = 0
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_TMPGAR'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeInfGar: TDBEditFocus
              Tag = 99
              Left = 195
              Top = 22
              Width = 368
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_INFGAR'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 50
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeGarFil: TDBEditFocus
              Tag = 99
              Left = 195
              Top = 44
              Width = 63
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_GARFIL'
              DataSource = dtsIteGer
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeRspGar: TDBEditFocus
              Tag = 99
              Left = 441
              Top = 0
              Width = 23
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_RSPGAR'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object pnlImpEtiqRes: TPanel
            Left = 38
            Top = 243
            Width = 305
            Height = 24
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 14
            object lblImpEtiqRes: TLabel
              Left = 1
              Top = 5
              Width = 200
              Height = 14
              Alignment = taRightJustify
              Caption = 'Imprimir etiqueta de quantidade restante ?'
              WordWrap = True
            end
            object ColorLabelImpEtiqRes: TColorLabel
              Left = 225
              Top = 5
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object dbeImpEtiqRes: TDBEditFocus
              Tag = 99
              Left = 201
              Top = 0
              Width = 22
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_ETIQRE'
              DataSource = dtsCadIte
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
        end
        object pnlComMec: TPanel
          Left = 0
          Top = 45
          Width = 579
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object lblPerValMc: TLabel
            Left = 548
            Top = 3
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lbl8: TLabel
            Left = 368
            Top = 3
            Width = 114
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o do Mec'#226'nico:'
          end
          object Label162: TLabel
            Left = 60
            Top = 3
            Width = 137
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Comiss'#227'o Mec'#226'nico:'
          end
          object ColorLabel31: TColorLabel
            Left = 223
            Top = -2
            Width = 59
            Height = 14
            Caption = '(P)ercentual'
            CorDestaque = clRed
          end
          object ColorLabel32: TColorLabel
            Left = 223
            Top = 9
            Width = 34
            Height = 14
            Caption = '(V)alor'
            CorDestaque = clRed
          end
          object dbeComMec: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMMEC'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeTpCoMc: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 0
            Width = 22
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_TPCOMC'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeTpCoMcExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object dbePesagemObr: TDBEditFocus
          Tag = 99
          Left = 468
          Top = 390
          Width = 22
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_PESOBR'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object edtDesCnd: TDBEditFocus
          Tag = 99
          Left = 468
          Top = 409
          Width = 22
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DESCND'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object Panel17: TPanel
          Left = 2
          Top = 383
          Width = 266
          Height = 37
          BevelOuter = bvNone
          TabOrder = 5
          object Label245: TLabel
            Left = 3
            Top = -3
            Width = 236
            Height = 14
            Caption = 'Sugest'#227'o para empresa multi-loja no faturamento'
          end
          object DBEditFocus3: TDBEditFocus
            Tag = 99
            Left = 2
            Top = 10
            Width = 33
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_EMPSUG'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeCodEmpSugExit
            OnKeyPress = dbeCodEmpSugKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object EditFocus1: TEditFocus
            Left = 39
            Top = 11
            Width = 200
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object pnlSubProdPermiteVendaSeparado: TPanel
          Left = 5
          Top = 433
          Width = 335
          Height = 42
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 8
          object lblSubProdPermiteVendaSeparado: TLabel
            Left = -3
            Top = -1
            Width = 254
            Height = 42
            Alignment = taRightJustify
            Caption = 
              'Quando o produto for componente de uma estrutura (sub-produto), ' +
              'permitir inform'#225'-lo separadamente na tela da venda?'
            WordWrap = True
          end
          object clbSubProdPermiteVendaSeparado: TColorLabel
            Left = 280
            Top = 16
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeSubProdPermiteVendaSeparado: TDBEditFocus
            Tag = 99
            Left = 254
            Top = 11
            Width = 22
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_VENSUB'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
      end
      object gpbMinTab: TGroupBox
        Left = 823
        Top = -2
        Width = 184
        Height = 180
        Caption = 'Quant. M'#237'nima por Tabela de Pre'#231'o'
        TabOrder = 4
        object pnlMinTb1: TPanel
          Left = 18
          Top = 13
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          Visible = False
          object Label60: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 1:'
          end
          object dbeMinTb1: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB1'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlMinTb2: TPanel
          Left = 18
          Top = 37
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          Visible = False
          object Label134: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 2:'
          end
          object dbeMinTb2: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB2'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlMinTb3: TPanel
          Left = 18
          Top = 61
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 2
          Visible = False
          object Label148: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 3:'
          end
          object dbeMinTb3: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB3'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlMinTb4: TPanel
          Left = 18
          Top = 85
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 3
          Visible = False
          object Label149: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 4:'
          end
          object dbeMinTb4: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB4'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlMinTb5: TPanel
          Left = 18
          Top = 107
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 4
          Visible = False
          object Label150: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 5:'
          end
          object dbeMinTb5: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB5'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlMinTb6: TPanel
          Left = 18
          Top = 129
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 5
          Visible = False
          object Label151: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 6:'
          end
          object dbeMinTb6: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB6'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object pnlMinTb7: TPanel
          Left = 18
          Top = 153
          Width = 157
          Height = 26
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 6
          Visible = False
          object Label156: TLabel
            Left = 3
            Top = 6
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela Pre'#231'o 7:'
          end
          object dbeMinTb7: TDBEditFocus
            Tag = 99
            Left = 81
            Top = 2
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            Ctl3D = True
            DataField = 'ITE_MINTB7'
            DataSource = dtsIteGer
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
      end
      object pnl2: TPanel
        Left = 577
        Top = 205
        Width = 433
        Height = 259
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 5
        object lblMaxBri: TLabel
          Left = 159
          Top = 99
          Width = 169
          Height = 14
          Alignment = taRightJustify
          Caption = 'Qtde. M'#225'xima Permitida de Brindes:'
        end
        object ColorLabel22: TColorLabel
          Left = 356
          Top = 4
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object ColorLabel23: TColorLabel
          Left = 42
          Top = 4
          Width = 287
          Height = 14
          Alignment = taRightJustify
          Caption = 'Permitir Entrega Futura com Status "Aguardando o Cliente"?'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          WordWrap = True
          CorDestaque = clRed
        end
        object ColorLabel24: TColorLabel
          Left = 49
          Top = 27
          Width = 280
          Height = 14
          Alignment = taRightJustify
          Caption = 'Permitir Entrega Futura com Status "Previs'#227'o de Entrega"?'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          WordWrap = True
          CorDestaque = clRed
        end
        object ColorLabel25: TColorLabel
          Left = 356
          Top = 27
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblMesGir: TColorLabel
          Left = 42
          Top = 74
          Width = 286
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade meses sem venda para inativa'#231#227'o de compras:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Visible = False
          WordWrap = True
          CorDestaque = clRed
        end
        object lblNotEsp: TLabel
          Left = 25
          Top = 99
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Divis'#237'vel:'
        end
        object clbNotEsp: TColorLabel
          Left = 94
          Top = 99
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblFaltaProduto: TColorLabel
          Left = 68
          Top = 50
          Width = 261
          Height = 14
          Alignment = taRightJustify
          Caption = 'Permitir Entrega Futura com Status "Falta de Produto"?'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          WordWrap = True
          CorDestaque = clRed
        end
        object ColorLabel34: TColorLabel
          Left = 356
          Top = 50
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblObrDefLoteWMS: TLabel
          Left = 1
          Top = 192
          Width = 178
          Height = 28
          Alignment = taRightJustify
          Caption = 
            'Obrigar a defini'#231#227'o do lote(WMS) do produto na tela de pedido de' +
            ' venda?'
          Visible = False
          WordWrap = True
        end
        object clbObrDefLoteWMS: TColorLabel
          Left = 229
          Top = 202
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Visible = False
          CorDestaque = clRed
        end
        object lblCarEst: TLabel
          Left = -9
          Top = 222
          Width = 210
          Height = 31
          Alignment = taRightJustify
          AutoSize = False
          Caption = 
            'Item estrutura em OR/PD/VN, carregar os itens da estrutura da se' +
            'guinte forma:'
          WordWrap = True
        end
        object dbeMaxBri: TDBEditFocus
          Tag = 99
          Left = 331
          Top = 95
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MAXBRI'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePeeFut: TDBEditFocus
          Tag = 99
          Left = 332
          Top = 0
          Width = 23
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_PEEFUT'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbePeFutP: TDBEditFocus
          Tag = 99
          Left = 332
          Top = 24
          Width = 23
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_PEFUTP'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeMesGir: TDBEditFocus
          Tag = 99
          Left = 332
          Top = 71
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MESGIR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 3
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeNotEsp: TDBEditFocus
          Tag = 99
          Left = 70
          Top = 95
          Width = 23
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_NOTESP'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object pnlDtaVal: TPanel
          Left = 8
          Top = 115
          Width = 283
          Height = 22
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 6
          object Label173: TLabel
            Left = 0
            Top = 4
            Width = 198
            Height = 14
            Alignment = taRightJustify
            Caption = 'Validade de pre'#231'o da tab. do fornecedor:'
          end
          object dbeDtaVal: TDBEditFocus
            Tag = 99
            Left = 199
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DTAVAL'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object dbeFaltaProduto: TDBEditFocus
          Tag = 99
          Left = 332
          Top = 48
          Width = 23
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_PEFFPR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object gpbFreTra: TGroupBox
          Left = 1
          Top = 135
          Width = 380
          Height = 53
          Caption = 'C'#225'lculo do Frete:'
          TabOrder = 7
          object lbl16: TLabel
            Left = 12
            Top = 24
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Frete:'
          end
          object clb1: TColorLabel
            Left = 109
            Top = 18
            Width = 93
            Height = 14
            Caption = '(P)ercentual  (F)ixo'
            CorDestaque = clRed
          end
          object lbl18: TLabel
            Left = 225
            Top = 24
            Width = 71
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor do Frete:'
          end
          object lblVlcFre: TLabel
            Left = 368
            Top = 20
            Width = 12
            Height = 22
            Alignment = taRightJustify
            AutoSize = False
            Caption = '%'
            Layout = tlCenter
          end
          object ColorLabel21: TColorLabel
            Left = 132
            Top = 29
            Width = 44
            Height = 14
            Caption = '(U)nit'#225'rio'
            CorDestaque = clRed
          end
          object dbeTipFre: TDBEditFocus
            Tag = 99
            Left = 82
            Top = 20
            Width = 22
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_TIPFRE'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnChange = dbeTipFreChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeVlCFre: TDBEditFocus
            Tag = 99
            Left = 300
            Top = 20
            Width = 65
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_VLCFRE'
            DataSource = dtsCadIte
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object dbeObrDefLoteWMS: TDBEditFocus
          Tag = 99
          Left = 205
          Top = 198
          Width = 23
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_LOTEPD'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object cmbCarEst: TComboBoxFocus
          Tag = 99
          Left = 205
          Top = 225
          Width = 130
          Height = 22
          Style = csOwnerDrawFixed
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemIndex = 0
          TabOrder = 9
          Text = 'ITEM ESTRUTURA'
          Items.Strings = (
            'ITEM ESTRUTURA'
            'SUB-PRODUTOS')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object gpbMetVid: TGroupBox
        Left = 578
        Top = 463
        Width = 429
        Height = 132
        Caption = 'Metragem'
        TabOrder = 6
        object lblLargura: TLabel
          Left = 8
          Top = 17
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = 'Largura Sugest'#227'o:'
        end
        object lblAltura: TLabel
          Left = 66
          Top = 40
          Width = 32
          Height = 14
          Alignment = taRightJustify
          Caption = 'Altura:'
        end
        object lblLarguraMax: TLabel
          Left = 18
          Top = 87
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Largura M'#225'xima:'
        end
        object lblAlturaMax: TLabel
          Left = 27
          Top = 109
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Caption = 'Altura M'#225'xima:'
        end
        object lblMed4: TLabel
          Tag = 99
          Left = 193
          Top = 109
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
        end
        object lblMed3: TLabel
          Tag = 99
          Left = 193
          Top = 87
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
        end
        object lblMed2: TLabel
          Tag = 99
          Left = 193
          Top = 40
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
        end
        object lblMed1: TLabel
          Tag = 99
          Left = 193
          Top = 17
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
        end
        object lblAreaSug: TLabel
          Left = 22
          Top = 64
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = #193'rea Sugest'#227'o:'
        end
        object lblMed5: TLabel
          Tag = 99
          Left = 193
          Top = 64
          Width = 12
          Height = 14
          Caption = 'M'#178
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblAreaMax: TLabel
          Left = 236
          Top = 17
          Width = 66
          Height = 14
          Alignment = taRightJustify
          Caption = #193'rea M'#225'xima:'
        end
        object lblMed6: TLabel
          Tag = 99
          Left = 397
          Top = 17
          Width = 12
          Height = 14
          Caption = 'M'#178
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblLarMin: TLabel
          Left = 226
          Top = 40
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Largura M'#237'nima:'
        end
        object lblMed7: TLabel
          Tag = 99
          Left = 397
          Top = 40
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
        end
        object lblMed8: TLabel
          Tag = 99
          Left = 397
          Top = 62
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
        end
        object lblAltMin: TLabel
          Left = 235
          Top = 62
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Altura M'#237'nima:'
        end
        object lblAreMin: TLabel
          Left = 240
          Top = 86
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = #193'rea M'#237'nima:'
        end
        object lblMed9: TLabel
          Tag = 99
          Left = 397
          Top = 86
          Width = 12
          Height = 14
          Caption = 'M'#178
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbeLarVid: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 13
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_LARVID'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAltVid: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 36
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_ALTVID'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeLaMaVi: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 83
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_LAMAVI'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAlMaVi: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 106
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_ALMAVI'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAreSug: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 60
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_ARESUG'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAreMax: TDBEditFocus
          Tag = 99
          Left = 305
          Top = 13
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_AREMAX'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeLarMin: TDBEditFocus
          Tag = 99
          Left = 305
          Top = 36
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_LARMIN'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAltMin: TDBEditFocus
          Tag = 99
          Left = 305
          Top = 59
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_ALTMIN'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAreMin: TDBEditFocus
          Tag = 99
          Left = 305
          Top = 82
          Width = 89
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_AREMIN'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnFatAcre: TBitBtnLocked
          Left = 257
          Top = 107
          Width = 138
          Height = 22
          Caption = 'Fator de Acr'#233'scimo'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000051543
            30BC1D5D42FF1D5D42FF15422FBD000000050000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000061E65
            48FF63DBB3FF2FCB95FF1B5F43FF0000000700000000000000000000000A0000
            000F0000001100000011000000110000001200000016000000180000001C216E
            4FFF6EDEBAFF36D09CFF1E6649FF0000001000000007000000057F5648C1B076
            63FFAF7562FFAF7562FFAF7561FFD0B0A5FF54886EFF237556FF237152FF2475
            56FF41D5A4FF40D2A4FF216E50FF1F6448FF1E6246FF154531BCB27B68FFF8F2
            EDFFF8F2EDFFF8F1EEFFF9F2EDFFF8F4F2FF298663FF88E8CBFF4EDAADFF4CDA
            ACFF4BD9ACFF48D9AAFF47D7ABFF46D6AAFF45D6A6FF216F50FFB57E6BFFF9F3
            EFFFF7EFEAFF8C6F63FFF7EFE9FFF7F3F0FF2C8E6BFF90EBD0FF8EEACFFF8DEA
            CFFF8BE9CDFF52DEB3FF51DCB2FF86E7C9FF83E7C9FF247757FFB7826FFFF9F4
            F1FF8F7266FF8E7164FF8D7064FFBEB0A9FF549C7FFF2E926EFF2E906DFF2D8E
            6BFF92EBD3FF59E0B8FF2A8764FF298362FF288260FF1D5E46C0BA8573FFFAF5
            F3FFF8F1EBFF907367FFF7F0EBFFF9F3EEFFE8DCD8FFF9F5F2FFF5F2EFFF2F95
            71FF9BEED7FF5FE4BEFF2D8F6CFF000000170000000400000003BD8977FFFAF6
            F4FF93766BFF92756AFFDFCDC6FFDECCC5FFDECAC4FFDDCAC3FFEBE1DEFF329B
            77FF9EF0DAFF9DEFDAFF2F9572FF000000120000000000000000C08C7BFFFAF8
            F5FFF8F3EFFF94796DFFF8F2EEFFF8F3EFFFDFCDC7FFF8F2EEFFFAF7F5FF60AB
            8DFF34A07BFF339E78FF5DA486FF0000000F0000000000000000C3917FFFFBF9
            F6FF977B70FF967B6FFFE2D2CCFFE2D1CBFFE1CFC9FFE0CFC8FFE4D4CFFFDDC0
            B4FFFAF7F6FFFBF9F8FFD3B4A9FF0000000C0000000000000000C59483FFFCF9
            F7FFFAF5F2FF997E71FFFAF5F1FFFAF5F1FFE4D2CCFFFAF5F1FFF9F4F1FFCA9B
            87FFFAF5F0FFFBF8F6FFBD8977FF0000000C0000000000000000C79787FFFDFA
            F8FF9B8175FF9B7F73FFCFA692FFCFA490FFCEA38FFFCDA08CFFCC9F8AFFCC9D
            89FFFAF6F1FFFCF9F7FFBF8D7CFF0000000B0000000000000000C99A8AFFFCFB
            F9FFFDFBF9FFFDFBF9FFFDFBF9FFFDFBF9FFFCFBF9FFFCFBF8FFFCFBF8FFFDFA
            F8FFFDFBF8FFFCFAF8FFC2917FFF0000000A0000000000000000CC9E8EFFFDFB
            F9FFFDFBFAFFFCFBF9FFFDFBFAFFFDFBF9FFFDFBF9FFFDFBF9FFFDFBFAFFFDFB
            F9FFFCFBF9FFFCFBF9FFC59583FF00000008000000000000000098776AC1CDA0
            8FFFCC9F8EFFCC9E8EFFCB9E8DFFCA9D8CFFCA9D8CFFCA9B8BFFC99A8AFFC99A
            89FFC89989FFC79988FF947164C2000000050000000000000000}
          TabOrder = 9
          OnClick = btnFatAcreClick
        end
      end
      object pnlEmpSug: TPanel
        Left = 577
        Top = 599
        Width = 266
        Height = 37
        BevelOuter = bvNone
        TabOrder = 7
        object Label124: TLabel
          Left = 2
          Top = 0
          Width = 236
          Height = 14
          Caption = 'Sugest'#227'o para empresa multi-loja no faturamento'
        end
        object dbeCodEmpSug: TDBEditFocus
          Tag = 99
          Left = 2
          Top = 13
          Width = 33
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_EMPSUG'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = dbeCodEmpSugExit
          OnKeyPress = dbeCodEmpSugKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object edtDesEmpSug: TEditFocus
          Left = 37
          Top = 13
          Width = 227
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
    end
    object tbsDadosEntrada: TTabSheet
      Caption = '&4 - Dados de Entrada'
      object pnlDadosEntrada1: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label141: TLabel
          Left = 233
          Top = 4
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ativo para Compras:'
        end
        object ColorLabel17: TColorLabel
          Left = 399
          Top = 4
          Width = 58
          Height = 14
          Caption = '(S)im (N)'#227'o '
          CorDestaque = clRed
        end
        object dbeAtiCom: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ATICOM'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlDesFab: TPanel
        Left = 0
        Top = 46
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        object lblDesFab: TLabel
          Left = 232
          Top = 4
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desc. de Fabricante:'
        end
        object dbeDesFab: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 362
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DESFAB'
          DataSource = dtsCadIte
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeDesFabKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlDadosEntrada2: TPanel
        Left = 0
        Top = 68
        Width = 1010
        Height = 275
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        object clrReaEnd: TColorLabel
          Left = 399
          Top = 234
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblReaEnd: TLabel
          Left = 154
          Top = 234
          Width = 178
          Height = 14
          Alignment = taRightJustify
          Caption = 'Realizar endere'#231'amento do produto?'
        end
        object Label118: TLabel
          Left = 229
          Top = 28
          Width = 103
          Height = 14
          Alignment = taRightJustify
          Caption = 'M'#250'ltiplo para Compra:'
        end
        object Label147: TLabel
          Left = 169
          Top = 74
          Width = 163
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dias para entrega do Fornecedor:'
        end
        object Label139: TLabel
          Left = 144
          Top = 97
          Width = 188
          Height = 14
          Alignment = taRightJustify
          Caption = 'Permitir redu'#231#227'o de pre'#231'os na entrada:'
        end
        object ColorLabel16: TColorLabel
          Left = 399
          Top = 97
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label168: TLabel
          Left = 14
          Top = 119
          Width = 318
          Height = 14
          Alignment = taRightJustify
          Caption = 'No Abastecimento das Filiais, Abastecer com M'#250'ltiplo de Compras:'
        end
        object ColorLabel19: TColorLabel
          Left = 399
          Top = 119
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label31: TLabel
          Left = 182
          Top = 143
          Width = 150
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#237'vel de Giro de Estoque Geral:'
        end
        object ColorLabel10: TColorLabel
          Left = 399
          Top = 143
          Width = 70
          Height = 14
          Caption = '(A), (B) ou (C)'
          CorDestaque = clRed
        end
        object lblEsMiDg: TLabel
          Left = 195
          Top = 188
          Width = 137
          Height = 14
          Alignment = taRightJustify
          Caption = 'Op'#231#227'o para estoque m'#237'nimo:'
        end
        object clEsMiDg: TColorLabel
          Left = 399
          Top = 188
          Width = 93
          Height = 14
          Caption = '(G)erado (D)igitado'
          CorDestaque = clRed
        end
        object lbl6: TLabel
          Left = 230
          Top = 212
          Width = 102
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acordo de Objetivos:'
        end
        object Label166: TLabel
          Left = 244
          Top = 5
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = 'Grupo de Compra:'
        end
        object lblRastre: TLabel
          Left = 104
          Top = 256
          Width = 228
          Height = 14
          Alignment = taRightJustify
          Caption = 'Utilizar Controle de Rastreabilidade do produto?'
        end
        object lblRastreSN: TColorLabel
          Left = 399
          Top = 256
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object Label159: TLabel
          Left = 152
          Top = 165
          Width = 180
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#237'vel de Criticidade de Estoque Geral:'
        end
        object ColorLabel36: TColorLabel
          Left = 399
          Top = 164
          Width = 70
          Height = 14
          Caption = '(X), (Y) ou (Z)'
          CorDestaque = clRed
        end
        object ColorLabel40: TColorLabel
          Left = 399
          Top = 50
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblTransSpoolMlt: TLabel
          Left = 55
          Top = 50
          Width = 277
          Height = 14
          Alignment = taRightJustify
          Caption = 'Permitir spool de tranfer'#234'ncia fora do multiplo de compra?'
        end
        object dbeReaEnd: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 231
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_REAEND'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMultCompra: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 24
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MLTCOM'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeDiaFor: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 70
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DIAFOR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeRprEnt: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 93
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_RPRENT'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAbaMlt: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 116
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ABAMLT'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeNvlGir: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 139
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_NVLGIR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeEsMiDg: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 185
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ESMIDG'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeAcoObj: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 208
          Width = 200
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ACOOBJ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeGruCmp: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 1
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'ITE_GRUCMP'
          DataSource = dtsCadIte
          MaxLength = 3
          ParentCtl3D = False
          TabOrder = 0
          OnKeyPress = dbeGruCmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtDesCmp: TEditFocus
          Left = 399
          Top = 1
          Width = 297
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Ctl3D = True
          Enabled = False
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbeRastre: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 253
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_RASTRE'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNvlCri: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 162
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_NVLCRI'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeMltSpo: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 47
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_MLTSPO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlImpEti: TPanel
        Left = 0
        Top = 24
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label83: TLabel
          Left = 119
          Top = 4
          Width = 213
          Height = 14
          Alignment = taRightJustify
          Caption = 'Imprimir Etiqueta na Entrada de Mercadorias:'
        end
        object ColorLabel28: TColorLabel
          Left = 399
          Top = 4
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeImpEti: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_IMPETI'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlConLot: TPanel
        Left = 0
        Top = 343
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 4
        object Label163: TLabel
          Left = 158
          Top = 2
          Width = 174
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto com lote controlado na O.P.:'
        end
        object ColorLabel33: TColorLabel
          Left = 399
          Top = 2
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeConLot: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CONLOT'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlOBRBAR: TPanel
        Left = 0
        Top = 387
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 6
        object Label132: TLabel
          Left = 65
          Top = 2
          Width = 267
          Height = 14
          Alignment = taRightJustify
          Caption = 'Obrigat'#243'rio o C'#243'digo de Barras na Entrada Simplificada:'
        end
        object ColorLabel15: TColorLabel
          Left = 399
          Top = 2
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeOBRBAR: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_OBRBAR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlFicIns: TPanel
        Left = 0
        Top = 431
        Width = 1010
        Height = 183
        Align = alTop
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 8
        object Panel9: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Ficha de Instru'#231#227'o para Confer'#234'ncia do Produto:'
          ParentColor = True
          TabOrder = 0
        end
        object dbeFicIns: TDBMemoFocus
          Left = 1
          Top = 25
          Width = 1008
          Height = 124
          Align = alClient
          BorderStyle = bsNone
          DataField = 'ITE_FICINS'
          DataSource = dtsCadIte
          ScrollBars = ssBoth
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object Panel10: TPanel
          Left = 1
          Top = 149
          Width = 1008
          Height = 33
          Align = alBottom
          Caption = 'Panel10'
          Padding.Left = 300
          Padding.Right = 300
          TabOrder = 2
          object btnAbrirPasta: TBitBtnLocked
            Left = 301
            Top = 1
            Width = 406
            Height = 31
            Align = alClient
            Caption = 'Arquivos de Instru'#231#245'es'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            Glyph.Data = {
              F6060000424DF606000000000000360000002800000018000000180000000100
              180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FF92635DA46769A46769A46769A46769A46769A46769A46769A46769A467
              69A46769A46769A46769A46769A46769A46769A46769A46769A46769FF00FFFF
              00FFFF00FFFF00FFFF00FF93655EF2D9B0F2D7ABF0D4A9F0D1A5EFD1A1F0CF9E
              EFCE9CEFCB98EECA95EDC992EDC78FEDC68EEDC58BEBC488EBC286EBC184EBC0
              829F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF3DAB5F2D8B0F2D7ADF2
              D5AAF0D3A5EFD1A3EFD09FEFCE9DEFCC99EFCB97EDCA93EEC991EDC68EEBC58B
              EBC489EBC287EBC2869F6F60FF00FFFF00FFFF00FFFF00FFFF00FF93655FF4DD
              BAF3DAB6008100008100F2D5AAF0D4A7811E00811E00811E00811E00811E0081
              1E00811E00811E00811E00EDC58AEDC4889F6F60FF00FFFF00FFFF00FFFF00FF
              FF00FF93655FF4E0BDF3DEBB008100008100F3D8B0F2D5ACF0D4A9F2D3A4F0D1
              A1EFCF9FEFCE9CEECC98EECA96EEC992EDC990EDC68CEDC58B9F6F60FF00FFFF
              00FFFF00FFFF00FFFF00FF654441A79A86A69882A6977FA5967EA5957BA59378
              A59276A59173A59072A48F6EA48E6CA38C6AA38B68A18A66A18965A18862A188
              606C4C41FF00FFFF00FFFF00FF004B00004B00004B00004B00004B00004B0000
              4B00004B00004B00004B00004B00004B00004B00004B00004B00004B00004B00
              004B00004B00004B00004B00004B00004B00FF00FF004B00FF00FF986963F7E6
              CCF7E5C9F6E2C5F6E1C1F4DEBFF4DDBAF3DCB6F3D9B2F2D7AFF2D5ABF0D4A9F0
              D3A4F0D0A1EFCF9EEFCE9AEFCB98EECB969F6F60FF00FF004B00FF00FF004B00
              FF00FF9E6E64F8E9D0F7E6CE004B00004B00F6E2C2F4E0BF004B00004B00004B
              00004B00004B00004B00004B00004B00004B00EFCE9CEECC999F6F60FF00FF00
              4B00FF00FF004B00FF00FFA37266FAEBD7F8EAD3004B00004B00F6E3C7F6E2C4
              F4E0C0F4DEBCF3DCB8F3DCB5F2D8B1F2D7ADF2D4AAF0D3A6F0D1A4F0D0A0EFCE
              9D9F6F60FF00FF004B00FF00FF004B00FF00FF724F46AAA195A99F91A79E8FA9
              9E8EA99D8BA79A89A79A86A79983A79881A6977FA6967BA59379A59377A59175
              A59072A48F70A48F6D6C4C42FF00FF004B00FF00FF004B00004B00004A000049
              00004800004800004900004A00004B00004B00004B00004B00004B00004B0000
              4B00004B00004B00004B00004B00004B00004B00004B00004B00FF00FFFF00FF
              FF00FFA77766DED7CAD4CCBFD4CABBDCD1C1EBE0CAF4E6CFF7E9CFF7E6CAF6E3
              C7F4E2C4F4E0C0F4DEBCF4DCB8F3DCB5F3D9B1F2D7ADF0D5AAA07264FF00FFFF
              00FFFF00FFFF00FFFF00FFA1735FBFBAB0ABA59C005800006200DDD1C1F0E3D0
              801E00811E00811E00811E00811E00811E00811E00811E00811E00F3D9B2F3D8
              AFA07264FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B00004B00004B0000
              5600CEC5B6E7DCCBF0E5D1F6E7D1F6E7D0F7E6CEF7E5CAF6E3C6F6E1C2F4E0BF
              F3DEBBF4DCB6F3D9B4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B000895
              1106900E004B0098938BB8B0A6CEC5B8DDD4C2EBE1CEF6E9D3F8EAD3F7E7CEF7
              E6CBF6E3C6F6E1C4F6E0C0F4DEBCF3DDB8A07264FF00FFFF00FFFF00FFFF00FF
              FF00FF004B000C9D190A9814004B008A888198938CA7A198BFB6AADDD4C4F2E6
              D4F8EBD7F8EAD3F8E9D0F7E6CCF6E5C9F6E2C5F4E1C1F4E0BDA07264FF00FFFF
              00FF004B00004B00004B00004B0011A6240EA11D004B00004B00004B00004B00
              ABA59CD5CCC1F0E6D7F8EDD9FAEDD8F8EAD5F8E9D1F7E6CCF6E5CAF6E3C6F6E1
              C1A07264FF00FFFF00FF004B0025C74720C1401CBA3818B23014AC2911A5220D
              A01C0A9A17004B005814006E19007D1D00801E00811E00811E00811E00811E00
              811E00F7E6CAF6E3C6A07264FF00FFFF00FF004B002CD35528CC4D23C5451FBF
              3E1BB73517B02E13AB2710A520004B00BFBBB4DEDAD0F3EDE0FBF2E3FBF0E1FA
              EFDDF8EDDAF8EBD7F8EAD3F7E9CFF7E6CBA07264FF00FFFF00FF004B00004B00
              004B00004B0027CB4B22C443004B00004B00004B00004B00E0DCD7EFEAE2FAF3
              E9FBF4E9FBF2E5FAF2E2FBEFE0FAEEDAF8EBD8F8EAD4F7E7D0A07264FF00FFFF
              00FFFF00FFFF00FFFF00FF004B002DD45829CF52004B00AAA9A7D0CFCCEBE9E5
              F6F2EDFAF6EFFBF6EEFCF6EDFCF4E9FBF2E6FAF0E2FAEFE0FAEEDDFAEDD8F8EA
              D4A07264FF00FFFF00FFFF00FFFF00FFFF00FF004B0034DE6530D95E004B009D
              6B4FB77E5CC98965CE8C67CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68
              CF8E68CF8E68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FF004B00004B
              00004B00004B00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            ParentFont = False
            TabOrder = 0
            WordWrap = True
            OnClick = btnAbrirPastaClick
          end
        end
      end
      object pnlCPESOB: TPanel
        Left = 0
        Top = 365
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 5
        object lblPesagemObrEnt: TLabel
          Left = 124
          Top = 2
          Width = 208
          Height = 14
          Alignment = taRightJustify
          Caption = 'Controlar pesagem obrigat'#243'ria ( Entrada ) ?'
          Visible = False
        end
        object lblPesagemObrEntSN: TColorLabel
          Left = 399
          Top = 2
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Visible = False
          CorDestaque = clRed
        end
        object dbePesagemObrEnt: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CPESOB'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
      object pnlRecDev: TPanel
        Left = 0
        Top = 409
        Width = 1010
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 7
        object Label202: TLabel
          Left = 127
          Top = 2
          Width = 205
          Height = 14
          Alignment = taRightJustify
          Caption = 'Permitir receber devolu'#231#227'o deste produto?'
        end
        object ColorLabel39: TColorLabel
          Left = 399
          Top = 2
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object dbeRecDev: TDBEditFocus
          Tag = 99
          Left = 334
          Top = 0
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_RECDEV'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
    end
    object tbsFiscais: TTabSheet
      Caption = '5 - Dados Fiscais'
      ImageIndex = 2
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label146: TLabel
          Left = 23
          Top = 355
          Width = 115
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de produto (SPED):'
        end
        object lblProPCD: TLabel
          Left = 19
          Top = 455
          Width = 234
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto destinado a portadores de defici'#234'ncia ?:'
        end
        object clbProPCD: TColorLabel
          Left = 324
          Top = 455
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblUtiAmp: TLabel
          Left = 15
          Top = 481
          Width = 342
          Height = 14
          Alignment = taRightJustify
          Caption = 
            'Aplica Legisla'#231#227'o AMPARA para venda para os estados de MG e RS ?' +
            ':'
        end
        object lblUtiAmp_S_N: TColorLabel
          Left = 391
          Top = 481
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object clbAtoDDF: TColorLabel
          Left = 467
          Top = 634
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblAtoDDF: TLabel
          Left = 10
          Top = 634
          Width = 417
          Height = 14
          Caption = 
            'Produto pertence '#224' lista do Ato Declarat'#243'rio do Decreto 34063/12' +
            ' para o estado de DF:'
        end
        object pnlAgroto: TPanel
          Left = 1
          Top = 284
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object lbl1: TColorLabel
            Left = 210
            Top = 4
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lbl2: TLabel
            Left = 83
            Top = 5
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'Agrot'#243'xico:'
          end
          object dbeAgroto: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 0
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_AGROTO'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlDadosFiscais: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 283
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label32: TLabel
            Left = 46
            Top = 64
            Width = 90
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o Fiscal:'
          end
          object Label48: TLabel
            Left = 78
            Top = 41
            Width = 58
            Height = 14
            Alignment = taRightJustify
            Caption = 'IPI de Sa'#237'da:'
          end
          object Label49: TLabel
            Left = 9
            Top = 18
            Width = 127
            Height = 14
            Alignment = taRightJustify
            Caption = 'NCM / Classifica'#231#227'o de IPI:'
          end
          object Label50: TLabel
            Left = 509
            Top = 41
            Width = 89
            Height = 14
            Alignment = taRightJustify
            Caption = 'Incide PIS/COFINS:'
          end
          object Label51: TLabel
            Left = 247
            Top = 41
            Width = 127
            Height = 14
            Alignment = taRightJustify
            Caption = 'Combust'#237'vel / Lubrificante:'
          end
          object Label52: TLabel
            Left = 205
            Top = 39
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object ColorLabel1: TColorLabel
            Left = 669
            Top = 39
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object ColorLabel2: TColorLabel
            Left = 412
            Top = 39
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label69: TLabel
            Left = 60
            Top = 87
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo FINAME:'
          end
          object Label30: TLabel
            Left = 399
            Top = 110
            Width = 200
            Height = 14
            Alignment = taRightJustify
            Caption = 'Venda com obrigatoriedade de CPF/CNPJ:'
          end
          object ColorLabel8: TColorLabel
            Left = 669
            Top = 107
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label140: TLabel
            Left = 51
            Top = 200
            Width = 86
            Height = 14
            Alignment = taRightJustify
            Caption = 'Mensagem Fiscal:'
          end
          object Label45: TLabel
            Left = 49
            Top = 178
            Width = 87
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o de IPI:'
          end
          object Label64: TLabel
            Left = 483
            Top = 156
            Width = 114
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o de COFINS:'
          end
          object Label74: TLabel
            Left = 44
            Top = 156
            Width = 92
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o de PIS:'
          end
          object Label161: TLabel
            Left = 325
            Top = 223
            Width = 365
            Height = 14
            Alignment = taRightJustify
            Caption = 
              'Venda com obrigatoriedade de NFe (N'#227'o permite emiss'#227'o de Cupom F' +
              'iscal):'
          end
          object ColorLabel20: TColorLabel
            Left = 726
            Top = 223
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label76: TLabel
            Left = 234
            Top = 87
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo ANP:'
          end
          object lblObrIba: TLabel
            Left = 330
            Top = 133
            Width = 269
            Height = 14
            Alignment = taRightJustify
            Caption = 'Venda com obrigatoriedade de c'#243'digo IBAMA no cliente:'
          end
          object clbObrIba: TColorLabel
            Left = 669
            Top = 130
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lbl50: TLabel
            Left = 455
            Top = 18
            Width = 143
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo EX IPI (Exce'#231#227'o NCM):'
          end
          object lblCest: TLabel
            Left = 502
            Top = 178
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o CEST:'
          end
          object Label27: TLabel
            Left = 382
            Top = 87
            Width = 75
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o ANP:'
          end
          object Label26: TLabel
            Left = 40
            Top = 110
            Width = 96
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permitir venda para:'
          end
          object dbeCodAbr: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 57
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODABF'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            OnKeyPress = dbeCodAbrKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
            OnChamaCadastro = dbeCodAbrChamaCadastro
          end
          object dbeIpiSai: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 34
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_IPISAI'
            DataSource = dtsIteGer
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeClaIpi: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 11
            Width = 132
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CLAIPI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnKeyPress = dbeClaIpiKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object dbeIncPis: TDBEditFocus
            Tag = 99
            Left = 602
            Top = 34
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_INCPIS'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeComLub: TDBEditFocus
            Tag = 99
            Left = 377
            Top = 34
            Width = 32
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMLUB'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtDesAbf: TEditFocus
            Left = 205
            Top = 57
            Width = 460
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 22
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeCodFin: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 80
            Width = 82
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODFIN'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeObrCpf: TDBEditFocus
            Tag = 99
            Left = 602
            Top = 103
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_OBRCPF'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 10
            OnExit = dbeObrCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeMenFis: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 194
            Width = 859
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_MENFIS'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 18
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAbfPis: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 149
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ABFPIS'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 12
            OnKeyPress = dbeAbfPisKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object dbeAbfCof: TDBEditFocus
            Tag = 99
            Left = 602
            Top = 149
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ABFCOF'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 14
            OnKeyPress = dbeAbfCofKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object dbeAbfIpi: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 172
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ABFIPI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 16
            OnKeyPress = dbeAbfIpiKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDesAbfIpi: TEditFocus
            Left = 205
            Top = 172
            Width = 240
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 21
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesAbfCof: TEditFocus
            Left = 666
            Top = 149
            Width = 334
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 15
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesAbfPis: TEditFocus
            Left = 205
            Top = 149
            Width = 240
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 13
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeObrNfe: TDBEditFocus
            Tag = 99
            Left = 693
            Top = 216
            Width = 28
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_OBRNFE'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 19
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCodLub: TDBEditFocus
            Tag = 99
            Left = 297
            Top = 80
            Width = 82
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODLUB'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeObrIba: TDBEditFocus
            Tag = 99
            Left = 602
            Top = 126
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_OBRIBA'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 11
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeExcIpi: TDBEditFocus
            Tag = 99
            Left = 602
            Top = 11
            Width = 82
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_EXCIPI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnExit = dbeExcIpiExit
            OnKeyPress = dbeExcIpiKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCdCest: TDBEditFocus
            Tag = 99
            Left = 602
            Top = 172
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CDCEST'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 17
            OnKeyPress = dbeCdCestKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
            OnChamaCadastro = dbeCdCestChamaCadastro
          end
          object edtCestDesc: TEditFocus
            Left = 666
            Top = 171
            Width = 334
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 23
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object dbeDesANP: TDBEditFocus
            Tag = 99
            Left = 461
            Top = 80
            Width = 204
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_DESANP'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object pnlSuframa: TPanel
            Left = 0
            Top = 238
            Width = 1008
            Height = 45
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 20
            Visible = False
            object Label217: TLabel
              Left = 3
              Top = 8
              Width = 137
              Height = 14
              Caption = 'Calcular ICMS Desonerado ?'
            end
            object ColorLabel41: TColorLabel
              Left = 173
              Top = 8
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object Label218: TLabel
              Left = 268
              Top = 8
              Width = 419
              Height = 14
              Caption = 
                'Considerar desconto de PIS/COFINS na base de c'#225'lculo do ICMS Ope' +
                'ra'#231#245'es Pr'#243'prias ?'
            end
            object Label219: TLabel
              Left = 237
              Top = 30
              Width = 450
              Height = 14
              Caption = 
                'Considerar desconto de ICMS Desonerado na base de c'#225'lculo do ICM' +
                'S Opera'#231#245'es Pr'#243'prias ?'
              Visible = False
            end
            object ColorLabel42: TColorLabel
              Left = 726
              Top = 8
              Width = 128
              Height = 14
              Caption = '(S)im (N)'#227'o (F)Fornecedor'
              CorDestaque = clRed
            end
            object ColorLabel43: TColorLabel
              Left = 726
              Top = 30
              Width = 128
              Height = 14
              Caption = '(S)im (N)'#227'o (F)Fornecedor'
              Visible = False
              CorDestaque = clRed
            end
            object dbeCICMDE: TDBEditFocus
              Tag = 99
              Left = 141
              Top = 5
              Width = 28
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CICMDE'
              DataSource = dtsIteGer
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeCDPIOP: TDBEditFocus
              Tag = 99
              Left = 693
              Top = 0
              Width = 28
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_CDPIOP'
              DataSource = dtsIteGer
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
            object dbeDIDIOP: TDBEditFocus
              Tag = 99
              Left = 693
              Top = 22
              Width = 28
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_DIDIOP'
              DataSource = dtsIteGer
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 2
              Visible = False
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object lkpPermissaoVenda: TDBLookupComboBoxFocus
            Left = 141
            Top = 103
            Width = 238
            Height = 22
            DataField = 'ITE_PERVDA'
            DataSource = dtsCadIte
            KeyField = 'VALUE'
            ListField = 'DESCRICAO'
            ListSource = dtsPermissaoVenda
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlClaOnu: TPanel
          Left = 1
          Top = 306
          Width = 1008
          Height = 22
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object Label143: TLabel
            Left = 44
            Top = 4
            Width = 93
            Height = 14
            Alignment = taRightJustify
            Caption = 'Classifica'#231#227'o ONU:'
          end
          object dbeCodOnu: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 1
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODONU'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            TabOrder = 0
            OnKeyPress = dbeCodOnuKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDesOnu: TEditFocus
            Left = 205
            Top = 1
            Width = 460
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object pnlCodDic: TPanel
          Left = 1
          Top = 328
          Width = 1008
          Height = 28
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object Label145: TLabel
            Left = 82
            Top = 4
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo DIC:'
          end
          object dbeCodDic: TDBEditFocus
            Tag = 99
            Left = 141
            Top = 1
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODDIC'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 7
            TabOrder = 0
            OnKeyPress = dbeCodDicKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtDesDic: TEditFocus
            Left = 205
            Top = 1
            Width = 460
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object cmbItePro: TComboBoxFocus
          Tag = 99
          Left = 142
          Top = 352
          Width = 320
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object grp1: TGroupBox
          Left = 10
          Top = 376
          Width = 704
          Height = 73
          Caption = 'Conte'#250'do de Importa'#231#227'o:'
          TabOrder = 5
          object lbl40: TLabel
            Left = 54
            Top = 23
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Percentual (CI):'
          end
          object lbl41: TLabel
            Left = 197
            Top = 22
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lbl42: TLabel
            Left = 58
            Top = 45
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'N'#186' Ficha (FCI):'
          end
          object lbl43: TLabel
            Left = 443
            Top = 16
            Width = 216
            Height = 14
            Caption = '"Resolu'#231#227'o do Senado Federal n'#186' 13/12"'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object dbePer_CI: TDBEditFocus
            Tag = 99
            Left = 132
            Top = 17
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PER_CI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeNumFCI: TDBEditFocus
            Tag = 99
            Left = 132
            Top = 39
            Width = 524
            Height = 22
            DataField = 'ITE_NUMFCI'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object edtProPCD: TDBEditFocus
          Tag = 99
          Left = 257
          Top = 452
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_PROPCD'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeUtiAmp: TDBEditFocus
          Tag = 99
          Left = 358
          Top = 478
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_UTIAMP'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object GroupBox1: TGroupBox
          Left = 10
          Top = 500
          Width = 704
          Height = 89
          Caption = 'Indicador de Escala e Benef'#237'cio Fiscal'
          TabOrder = 8
          object ColorLabel37: TColorLabel
            Left = 531
            Top = 19
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label120: TLabel
            Left = 337
            Top = 19
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Indicador de Escala Relevante?:'
          end
          object Label199: TLabel
            Left = 316
            Top = 42
            Width = 175
            Height = 14
            Alignment = taRightJustify
            Caption = 'CNPJ do Fabricante da Mercadoria?:'
          end
          object Label200: TLabel
            Left = 250
            Top = 68
            Width = 241
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo de Benef'#237'cio Fiscal na UF aplicado ao item:'
          end
          object Label201: TLabel
            Left = 6
            Top = 19
            Width = 139
            Height = 42
            Alignment = taRightJustify
            Caption = 
              'Enviar Indicador de Escala e C'#243'digo do Benef'#237'cio Fiscal? (NF-e 4' +
              '.00)'
            WordWrap = True
          end
          object ColorLabel38: TColorLabel
            Left = 186
            Top = 35
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblUSABEF: TLabel
            Left = 31
            Top = 67
            Width = 114
            Height = 14
            Alignment = taRightJustify
            Caption = 'Possui benef'#237'cio f'#237'scal?'
          end
          object clbUSABEF: TColorLabel
            Left = 186
            Top = 65
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object dbeCdbFis: TDBEditFocus
            Tag = 99
            Left = 497
            Top = 65
            Width = 181
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CDBFIS'
            DataSource = dtsCadIte
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
            TipoTexto = ttAlfanumerico
          end
          object dbeCnpFme: TDBEditFocus
            Tag = 99
            Left = 497
            Top = 39
            Width = 181
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CNPFME'
            DataSource = dtsCadIte
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
            TipoTexto = ttAlfanumerico
          end
          object dbeIndEsc: TDBEditFocus
            Tag = 99
            Left = 497
            Top = 13
            Width = 28
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_INDESC'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeENIECB: TDBEditFocus
            Tag = 99
            Left = 152
            Top = 29
            Width = 28
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ENIECB'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeUSABEF: TDBEditFocus
            Tag = 99
            Left = 152
            Top = 59
            Width = 28
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_USABEF'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlAbrevContabil: TPanel
          Left = 10
          Top = 591
          Width = 783
          Height = 22
          BevelOuter = bvNone
          TabOrder = 9
          object Label216: TLabel
            Left = 0
            Top = 5
            Width = 100
            Height = 14
            Alignment = taRightJustify
            Caption = 'Abrevia'#231#227'o Cont'#225'bil:'
          end
          object dbeAbfCon: TDBEditFocus
            Tag = 99
            Left = 104
            Top = 0
            Width = 93
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ABFCON'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeAbfConKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDesAbfCon: TEditFocus
            Left = 199
            Top = 0
            Width = 447
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object dbeAtoDDF: TDBEditFocus
          Tag = 99
          Left = 434
          Top = 631
          Width = 28
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_ATODDF'
          DataSource = dtsIteGer
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
    end
    object tbsAbreviacaoes: TTabSheet
      Caption = '&6 - Abrevia'#231#245'es Fiscais'
      ImageIndex = 17
      object pnlAbrev: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        Caption = 'pnlAbrev'
        TabOrder = 0
      end
    end
    object tbsEstoque: TTabSheet
      Caption = '&7 - Estoque'
      ImageIndex = 3
      OnEnter = tbsEstoqueEnter
      object ScrollBox1: TPanel
        Left = 0
        Top = 65
        Width = 1010
        Height = 23
        Align = alTop
        Caption = 'SALDO DE ESTOQUE DAS LOJAS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
      end
      object pnlAmz: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        BorderStyle = bsSingle
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object dbgLotAmz: TDBGridCitel
          Left = 0
          Top = 0
          Width = 1006
          Height = 61
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnKeyDown = dbgVendasKeyDown
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'AMZ_CODAMZ'
              Title.Caption = 'C'#243'd. Armaz'#233'm'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AMZ_DESCRI'
              Title.Caption = 'Descri'#231#227'o do Armaz'#233'm'
              Width = 220
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOT_LOCFIS'
              Title.Caption = 'Localiza'#231#227'o F'#237'sica'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOT_SALDOS'
              Title.Alignment = taRightJustify
              Title.Caption = 'Saldo'
              Width = 80
              Visible = True
            end>
        end
      end
      object cxgLojas: TcxGridCitel
        Left = 0
        Top = 88
        Width = 1010
        Height = 608
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvLojas: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyleZebra
          Bands = <
            item
              Caption = 'Loja'
              FixedKind = fkLeft
              Width = 130
            end
            item
              Caption = 'Dados Gerais'
              Width = 1600
            end>
          object cxvLojasCODEMP: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODEMP'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taCenter
            MinWidth = 57
            Options.Editing = False
            Width = 57
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvLojasNOMEMP: TcxGridDBBandedColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'NOMEMP'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            MinWidth = 0
            Options.Editing = False
            Width = 100
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvLojasDTABAL: TcxGridDBBandedColumn
            Caption = 'Data Balan'#231'o'
            DataBinding.FieldName = 'DTABAL'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxvLojasSALBAL: TcxGridDBBandedColumn
            Caption = 'Saldo Balan'#231'o'
            DataBinding.FieldName = 'SALBAL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 69
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxvLojasML_BAL: TcxGridDBBandedColumn
            Caption = 'Sld.Bal. ML/GR'
            DataBinding.FieldName = 'ML_BAL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxvLojasDTAAJU: TcxGridDBBandedColumn
            Caption = 'Dta Ult. Balan'#231'o'
            DataBinding.FieldName = 'DTAAJU'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxvLojasQTDAJU: TcxGridDBBandedColumn
            Caption = 'Dif. Ult. Balan'#231'o'
            DataBinding.FieldName = 'QTDAJU'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 69
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxvLojasSALDOS: TcxGridDBBandedColumn
            Caption = 'Saldos'
            DataBinding.FieldName = 'SALDOS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxvLojasSAL_ML: TcxGridDBBandedColumn
            Caption = 'Saldo ML/GR'
            DataBinding.FieldName = 'SAL_ML'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxvLojasSALRES: TcxGridDBBandedColumn
            Caption = 'Saldo Reserv.'
            DataBinding.FieldName = 'SALRES'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            OnCustomDrawCell = cxvLojasCODEMPCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 69
            Position.BandIndex = 1
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxvLojasESTMIN: TcxGridDBBandedColumn
            Caption = 'Estoq. M'#237'nimo'
            DataBinding.FieldName = 'ESTMIN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            Properties.OnValidate = cxvLojasESTMINPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object cxvLojasESTMAX: TcxGridDBBandedColumn
            Caption = 'Estoq. M'#225'ximo'
            DataBinding.FieldName = 'ESTMAX'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.EditFormat = True
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            Properties.OnValidate = cxvLojasESTMAXPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 12
            Position.RowIndex = 0
          end
          object cxvLojasNIVGIR: TcxGridDBBandedColumn
            Caption = 'N'#237'vel de Giro'
            DataBinding.FieldName = 'NIVGIR'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'A'
              'B'
              'C')
            HeaderAlignmentHorz = taCenter
            Width = 66
            Position.BandIndex = 1
            Position.ColIndex = 13
            Position.RowIndex = 0
          end
          object cxvLojasIMPLIS: TcxGridDBBandedColumn
            Caption = 'Imp. Lista'
            DataBinding.FieldName = 'IMPLIS'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 68
            Position.BandIndex = 1
            Position.ColIndex = 14
            Position.RowIndex = 0
          end
          object cxvLojasAPERET: TcxGridDBBandedColumn
            Caption = 'Apenas Retira'
            DataBinding.FieldName = 'APERET'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 15
            Position.RowIndex = 0
          end
          object cxvLojasAPEENT: TcxGridDBBandedColumn
            Caption = 'Apenas Entrega'
            DataBinding.FieldName = 'APEENT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 1
            Position.ColIndex = 16
            Position.RowIndex = 0
          end
          object cxvLojasCPRCEN: TcxGridDBBandedColumn
            Caption = 'Compra Centralizada'
            DataBinding.FieldName = 'CPRCEN'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 113
            Position.BandIndex = 1
            Position.ColIndex = 17
            Position.RowIndex = 0
          end
          object cxvLojasEMPCEN: TcxGridDBBandedColumn
            Caption = 'Empresa Centralizadora'
            DataBinding.FieldName = 'EMPCEN'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'CODEMP'
            Properties.ListColumns = <
              item
                FieldName = 'NOMEMP'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.OnCloseUp = cxvLojasEMPCENPropertiesCloseUp
            HeaderAlignmentHorz = taCenter
            MinWidth = 140
            Width = 140
            Position.BandIndex = 1
            Position.ColIndex = 18
            Position.RowIndex = 0
          end
          object cxvLojasNIVCRI: TcxGridDBBandedColumn
            Caption = 'N'#237'vel Criticidade'
            DataBinding.FieldName = 'NIVCRI'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'X'
              'Y'
              'Z')
            HeaderAlignmentHorz = taCenter
            Width = 69
            Position.BandIndex = 1
            Position.ColIndex = 19
            Position.RowIndex = 0
          end
          object cxvLojasMINDIG: TcxGridDBBandedColumn
            Caption = 'Estoq. M'#237'n. Digitado'
            DataBinding.FieldName = 'MINDIG'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            Properties.OnValidate = cxvLojasMINDIGPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 92
            Position.BandIndex = 1
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object cxvLojasPONPED: TcxGridDBBandedColumn
            Caption = 'Ponto de Pedido'
            DataBinding.FieldName = 'PONPED'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            Properties.OnValidate = cxvLojasPONPEDPropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 70
            Position.BandIndex = 1
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object cxvLojasMAXDIG: TcxGridDBBandedColumn
            Caption = 'Estoq. M'#225'x. Digitado'
            DataBinding.FieldName = 'MAXDIG'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '#,##0.000;-#,##0.000'
            Properties.OnValidate = cxvLojasColumn1PropertiesValidate
            HeaderAlignmentHorz = taRightJustify
            Width = 92
            Position.BandIndex = 1
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object cxvLojasSITPRO: TcxGridDBBandedColumn
            Caption = 'Situa'#231#227'o do Produto'
            DataBinding.FieldName = 'SITPRO'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'SITCOD'
            Properties.ListColumns = <
              item
                FieldName = 'SITDES'
              end>
            Properties.ListOptions.ShowHeader = False
            Properties.OnCloseUp = cxvLojasSITPROPropertiesCloseUp
            HeaderAlignmentHorz = taCenter
            Width = 105
            Position.BandIndex = 1
            Position.ColIndex = 20
            Position.RowIndex = 0
          end
          object cxvLojasESMIDG: TcxGridDBBandedColumn
            Caption = 'Op'#231#227'o Est. M'#237'nimo'
            DataBinding.FieldName = 'ESMIDG'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.Items.Strings = (
              'D'
              'G')
            HeaderAlignmentHorz = taCenter
            Position.BandIndex = 1
            Position.ColIndex = 21
            Position.RowIndex = 0
          end
          object cxvLojasPONEXP: TcxGridDBBandedColumn
            Caption = 'Ponto de Exposi'#231#227'o'
            DataBinding.FieldName = 'PONEXP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            Position.BandIndex = 1
            Position.ColIndex = 22
            Position.RowIndex = 0
          end
        end
        object cxgLojasLevel1: TcxGridLevel
          GridView = cxvLojas
        end
      end
    end
    object tabLocalizacao: TTabSheet
      Caption = '&8- Localiza'#231#227'o F'#237'sica'
      ImageIndex = 13
      object pnlLoc: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 114
        Align = alTop
        BevelOuter = bvNone
        BorderStyle = bsSingle
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Label152: TLabel
          Left = 50
          Top = 43
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'Localiza'#231#227'o F'#237'sica:'
        end
        object Label153: TLabel
          Left = 7
          Top = 65
          Width = 135
          Height = 14
          Alignment = taRightJustify
          Caption = 'Localiza'#231#227'o Super Estoque:'
        end
        object Label154: TLabel
          Left = 298
          Top = 43
          Width = 115
          Height = 14
          Alignment = taRightJustify
          Caption = 'Capacidade Loc. F'#237'sica:'
        end
        object Label155: TLabel
          Left = 255
          Top = 65
          Width = 158
          Height = 14
          Alignment = taRightJustify
          Caption = 'Capacidade Loc. Super Estoque:'
        end
        object lblLocSep: TLabel
          Left = 44
          Top = 88
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Local da Separa'#231#227'o:'
        end
        object dbeLocFis: TDBEditFocus
          Tag = 99
          Left = 148
          Top = 35
          Width = 95
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_LOCFIS'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 0
          OnKeyPress = dbeLocFisKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSupEst: TDBEditFocus
          Tag = 99
          Left = 148
          Top = 58
          Width = 95
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_LOCSUP'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnKeyPress = dbeSupEstKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTamLocS: TDBEditFocus
          Tag = 99
          Left = 417
          Top = 58
          Width = 488
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_TAMLCS'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTamLocF: TDBEditFocus
          Tag = 99
          Left = 417
          Top = 35
          Width = 488
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_TAMLCF'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 1006
          Height = 23
          Align = alTop
          Caption = 'LOCALIZA'#199#195'O PRINCIPAL DO PRODUTO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentBackground = False
          ParentColor = True
          ParentFont = False
          TabOrder = 6
        end
        object dbeCodLse: TDBEditFocus
          Tag = 99
          Left = 148
          Top = 81
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_CODLSE'
          DataSource = dtsIteGer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          OnKeyPress = dbeCodLseKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesLse: TEditFocus
          Left = 212
          Top = 81
          Width = 693
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
        object cbxAplicarTodas: TCheckBox
          Left = 909
          Top = 58
          Width = 164
          Height = 22
          Caption = 'Aplicar em todas as empresas'
          TabOrder = 7
          OnClick = cbxAplicarTodasClick
        end
      end
      object pnlLocFis: TPanel
        Left = 0
        Top = 114
        Width = 1010
        Height = 582
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Caption = 'pnlLocFis'
        TabOrder = 1
      end
    end
    object tbsDadosBalanca: TTabSheet
      Caption = '&9 - Dados da Balan'#231'a'
      ImageIndex = 4
      object pnlCabBalanca: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 180
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label70: TLabel
          Left = 16
          Top = 24
          Width = 64
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Descri'#231#227'o:'
        end
        object Label71: TLabel
          Left = 480
          Top = 24
          Width = 31
          Height = 14
          Caption = 'Pre'#231'o:'
        end
        object Label73: TLabel
          Left = 16
          Top = 46
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Receita:'
        end
        object Label95: TLabel
          Left = 51
          Top = 68
          Width = 29
          Height = 14
          Alignment = taRightJustify
          Caption = 'Setor:'
        end
        object Label96: TLabel
          Left = 400
          Top = 68
          Width = 64
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'd. Barras:'
        end
        object Label97: TLabel
          Left = 16
          Top = 90
          Width = 64
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'digo:'
        end
        object Label98: TLabel
          Left = 168
          Top = 90
          Width = 45
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Tecla.:'
        end
        object Label99: TLabel
          Left = 290
          Top = 90
          Width = 45
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Validade:'
        end
        object Label100: TLabel
          Left = 8
          Top = 112
          Width = 73
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Tipo de Venda:'
        end
        object ColorLabel6: TColorLabel
          Left = 144
          Top = 108
          Width = 82
          Height = 14
          Caption = '(U)nidade (P)eso'
          CorDestaque = clRed
        end
        object Label116: TLabel
          Left = 16
          Top = 134
          Width = 64
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Por'#231#227'o de:'
        end
        object Label131: TLabel
          Left = 16
          Top = 157
          Width = 64
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Por'#231#227'o de:'
        end
        object ColorLabel14: TColorLabel
          Left = 140
          Top = 156
          Width = 82
          Height = 14
          Caption = 'Balan'#231'a (T)oledo'
          CorDestaque = clRed
        end
        object ColorLabel13: TColorLabel
          Left = 397
          Top = 132
          Width = 82
          Height = 14
          Caption = 'Balan'#231'a (F)ilizola'
          CorDestaque = clRed
        end
        object dbeDesFlz: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 16
          Width = 193
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_DESFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePreBal: TDBEditFocus
          Tag = 99
          Left = 516
          Top = 16
          Width = 61
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'ITE_PREVE1'
          DataSource = dtsIteGer
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
        object dbeRecFlz: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 38
          Width = 53
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_RECFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 4
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSetFlz: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 60
          Width = 53
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_SETFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          OnKeyPress = dbeSetFlzKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtDesSet: TEditFocus
          Left = 138
          Top = 60
          Width = 255
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
        object dbeBarFlz: TDBEditFocus
          Tag = 99
          Left = 468
          Top = 60
          Width = 109
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'ITE_CODBAR'
          DataSource = dtsCadIte
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodFlz: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 82
          Width = 55
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'ITE_CODFLZ'
          DataSource = dtsCadIte
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTecFlz: TDBEditFocus
          Tag = 99
          Left = 216
          Top = 82
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_TECFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValFlz: TDBEditFocus
          Tag = 99
          Left = 338
          Top = 82
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_VALFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTipFlz: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 104
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_TIPFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePorFlz: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 126
          Width = 309
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_PORFLZ'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeQtdNtr: TDBEditFocus
          Tag = 99
          Left = 84
          Top = 149
          Width = 53
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_QTDNTR'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
      end
      object pnlGeralBalanca: TPanel
        Left = 0
        Top = 180
        Width = 1010
        Height = 416
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label101: TLabel
          Left = 282
          Top = 57
          Width = 89
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtd / Por'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label102: TLabel
          Left = 390
          Top = 57
          Width = 65
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = '% VD(*)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label103: TLabel
          Left = 191
          Top = 81
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Cal'#243'rico:'
        end
        object Label106: TLabel
          Left = 191
          Top = 129
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Carboidratos:'
        end
        object Label104: TLabel
          Left = 191
          Top = 153
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Prote'#237'nas:'
        end
        object Label105: TLabel
          Left = 191
          Top = 177
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Gorduras Totais:'
        end
        object Label107: TLabel
          Left = 175
          Top = 201
          Width = 113
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Gorduras Saturadas:'
        end
        object Label108: TLabel
          Left = 503
          Top = 105
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Colesterol:'
        end
        object Label109: TLabel
          Left = 503
          Top = 129
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fibra Alimentar:'
        end
        object Label110: TLabel
          Left = 503
          Top = 153
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#225'lcio:'
        end
        object Label111: TLabel
          Left = 503
          Top = 177
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Ferro:'
        end
        object Label112: TLabel
          Left = 503
          Top = 201
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'S'#243'dio:'
        end
        object Label113: TLabel
          Left = 594
          Top = 57
          Width = 89
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qtd / Por'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label114: TLabel
          Left = 702
          Top = 57
          Width = 65
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = '% VD(*)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label115: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 11
          Width = 1002
          Height = 16
          Margins.Top = 10
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'INFORMA'#199#213'ES NUTRICIONAIS'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 1
          ExplicitTop = 1
          ExplicitWidth = 782
        end
        object Label127: TLabel
          Left = 191
          Top = 105
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Energ'#233'tico:'
        end
        object Label128: TLabel
          Left = 503
          Top = 81
          Width = 97
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Gorduras Trans:'
        end
        object dbeValCal: TDBEditFocus
          Tag = 99
          Left = 291
          Top = 75
          Width = 81
          Height = 22
          DataField = 'ITE_VALCAL'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnEnter = dbeValCalEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePerCal: TDBEditFocus
          Tag = 99
          Left = 374
          Top = 75
          Width = 81
          Height = 22
          DataField = 'ITE_PERCAL'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVCarbo: TDBEditFocus
          Tag = 99
          Left = 291
          Top = 123
          Width = 81
          Height = 22
          DataField = 'ITE_VCARBO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePCarbo: TDBEditFocus
          Tag = 99
          Left = 374
          Top = 123
          Width = 81
          Height = 22
          DataField = 'ITE_PCARBO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVProte: TDBEditFocus
          Tag = 99
          Left = 291
          Top = 147
          Width = 81
          Height = 22
          DataField = 'ITE_VPROTE'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePProte: TDBEditFocus
          Tag = 99
          Left = 374
          Top = 147
          Width = 81
          Height = 22
          DataField = 'ITE_PPROTE'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVGorTo: TDBEditFocus
          Tag = 99
          Left = 291
          Top = 171
          Width = 81
          Height = 22
          DataField = 'ITE_VGORTO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePGorTo: TDBEditFocus
          Tag = 99
          Left = 374
          Top = 171
          Width = 81
          Height = 22
          DataField = 'ITE_PGORTO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVGorSa: TDBEditFocus
          Tag = 99
          Left = 291
          Top = 195
          Width = 81
          Height = 22
          DataField = 'ITE_VGORSA'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 20
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePGorSa: TDBEditFocus
          Tag = 99
          Left = 374
          Top = 195
          Width = 81
          Height = 22
          DataField = 'ITE_PGORSA'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 21
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVColes: TDBEditFocus
          Tag = 99
          Left = 603
          Top = 99
          Width = 81
          Height = 22
          DataField = 'ITE_VCOLES'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePColes: TDBEditFocus
          Tag = 99
          Left = 686
          Top = 99
          Width = 81
          Height = 22
          DataField = 'ITE_PCOLES'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVFibAl: TDBEditFocus
          Tag = 99
          Left = 603
          Top = 123
          Width = 81
          Height = 22
          DataField = 'ITE_VFIBAL'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePFibAl: TDBEditFocus
          Tag = 99
          Left = 686
          Top = 123
          Width = 81
          Height = 22
          DataField = 'ITE_PFIBAL'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVCalci: TDBEditFocus
          Tag = 99
          Left = 603
          Top = 147
          Width = 81
          Height = 22
          DataField = 'ITE_VCALCI'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 14
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePCalci: TDBEditFocus
          Tag = 99
          Left = 686
          Top = 147
          Width = 81
          Height = 22
          DataField = 'ITE_PCALCI'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVFerro: TDBEditFocus
          Tag = 99
          Left = 603
          Top = 171
          Width = 81
          Height = 22
          DataField = 'ITE_VFERRO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 18
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePFerro: TDBEditFocus
          Tag = 99
          Left = 686
          Top = 171
          Width = 81
          Height = 22
          DataField = 'ITE_PFERRO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          TabOrder = 19
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVSodio: TDBEditFocus
          Tag = 99
          Left = 603
          Top = 195
          Width = 81
          Height = 22
          DataField = 'ITE_VSODIO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 22
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePSodio: TDBEditFocus
          Tag = 99
          Left = 686
          Top = 195
          Width = 81
          Height = 22
          DataField = 'ITE_PSODIO'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 23
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValEne: TDBEditFocus
          Tag = 99
          Left = 291
          Top = 99
          Width = 81
          Height = 22
          DataField = 'ITE_VALENE'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 4
          OnEnter = dbeValCalEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePerEne: TDBEditFocus
          Tag = 99
          Left = 374
          Top = 99
          Width = 81
          Height = 22
          DataField = 'ITE_PERENE'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeVGorTa: TDBEditFocus
          Tag = 99
          Left = 603
          Top = 75
          Width = 81
          Height = 22
          DataField = 'ITE_VGORTA'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePGorTa: TDBEditFocus
          Tag = 99
          Left = 686
          Top = 75
          Width = 81
          Height = 22
          DataField = 'ITE_PGORTA'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 596
        Width = 1010
        Height = 100
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Label129: TLabel
          Left = 139
          Top = 37
          Width = 54
          Height = 28
          Alignment = taRightJustify
          Caption = 'Informa'#231#227'o'#13#10'Extra'
        end
        object Label130: TLabel
          Left = 81
          Top = 14
          Width = 113
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Observa'#231#227'o:'
        end
        object dbeObsBal: TDBEditFocus
          Tag = 99
          Left = 196
          Top = 6
          Width = 414
          Height = 22
          CharCase = ecUpperCase
          DataField = 'ITE_OBSBAL'
          DataSource = dtsCadIte
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeInfExt: TDBMemoFocus
          Left = 196
          Top = 29
          Width = 414
          Height = 65
          DataField = 'ITE_INFEXT'
          DataSource = dtsCadIte
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 840
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 1
          OnExit = dbeInfExtExit
          OnKeyPress = dbeInfExtKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
    object tbsPrecos: TTabSheet
      Caption = '&10 - Pre'#231'os ('#218'ltima compra / Venda / M'#233'dio)'
      ImageIndex = 5
      OnShow = tbsPrecosShow
      object Panel3: TPanel
        Left = 0
        Top = 189
        Width = 1010
        Height = 507
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object pgcUltVendaCompra: TPageControl
          Left = 1
          Top = 1
          Width = 1008
          Height = 474
          ActivePage = tbsUltVenda
          Align = alClient
          TabOrder = 0
          OnChange = pgcUltVendaCompraChange
          OnEnter = pgcUltVendaCompraEnter
          object tbsUltCompra: TTabSheet
            Caption = '1 - &Ultimas Compras'
            ImageIndex = 1
            object dbgCompras: TDBGridCitel
              Left = 0
              Top = 0
              Width = 1000
              Height = 445
              Align = alClient
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = 14
              TitleFont.Name = 'Arial'
              TitleFont.Pitch = fpVariable
              TitleFont.Style = []
              OnKeyDown = dbgComprasKeyDown
              OnTitleClick = dbgComprasTitleClick
              CorZebra = clMoneyGreen
              Zebra = True
              DestacarMouse = False
              Columns = <
                item
                  Expanded = False
                  FieldName = 'DTA_MOV'
                  Title.Caption = 'Data Mov'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NUMDOC'
                  Title.Caption = 'Documento'
                  Width = 85
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ESPDOC'
                  Title.Caption = 'Esp.'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CODEMP'
                  Title.Caption = 'Emp.'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DTADOC'
                  Title.Caption = 'Data Doc'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PEDCOM'
                  Title.Caption = 'Ped. Compra'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CODFOR'
                  Title.Caption = 'Cod. Fornec.'
                  Width = 70
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FORNECEDOR'
                  Title.Caption = 'Fornecedor'
                  Width = 150
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UNICOM'
                  Title.Caption = 'Un. Compra'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UNIVEN'
                  Title.Caption = 'Un. Venda'
                  Width = 60
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'QTDITE'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Q.T.D.E.'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'UNITARIO'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Unit'#225'rio'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'PR_TOTAL'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Vlr. Total'
                  Width = 78
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CLAFIS'
                  Title.Caption = 'CFOP'
                  Width = 60
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'BASICM'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Base ICMS'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'ALQICM'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Aliq. ICMS'
                  Width = 56
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALICM'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor ICMS'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'BASIPI'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Base IPI'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'ALQIPI'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Aliq. IPI'
                  Width = 44
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALIPI'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor IPI'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'BASRET'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Base ST'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'VALRET'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Valor ST'
                  Width = 78
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VAEIPI'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Vr. IPI n'#227'o Cred.'
                  Width = 85
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VALFRE'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Vr. Frete'
                  Width = 65
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_OUTDES'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Outras Desp.'
                  Width = 70
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VENDOR'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Vendor'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_CONFRE'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Conhec. Frete'
                  Width = 75
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_DESACE'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Desp. Acess.'
                  Width = 70
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_ICMANT'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'ICMS Antecip.'
                  Width = 75
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VLGNRE'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'GNRE'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VALTCI'
                  Title.Caption = 'TCIF'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VAL_TS'
                  Title.Caption = 'TS'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_VAERET'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Vr. ST N'#227'o Cred.'
                  Width = 85
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_ALQPIS'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Al'#237'q. PIS'
                  Width = 50
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_ALQCOF'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Al'#237'q. COFINS'
                  Width = 70
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_TOTULT'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Pre'#231'o '#218'lt. Compra'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DET_IMPULT'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Pre'#231'o '#218'lt. Compra + Imp.'
                  Width = 120
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'OPERAD'
                  Title.Caption = 'Operador'
                  Width = 150
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRECOM'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Pre'#231'o Compra'
                  Width = 75
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESF01'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Desc. Forn. 1'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESF02'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Desc. Forn. 2'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESF03'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Desc. Forn. 3'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESF04'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Desc. Forn. 4'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESF05'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Desc. Forn. 5'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESF06'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Desc. Forn. 6'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'COMLIQ'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Pr. Compra L'#237'q.'
                  Width = 80
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ICMENT'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Icms Entr.'
                  Width = 90
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SUBFED'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(-) % Imp. Federais'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'IPIENT'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(+) % IPI Entr.'
                  Width = 80
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'FREENT'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(+) % Frete'
                  Width = 60
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'VALFRE'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(+) Vr Frete'
                  Width = 80
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ACRFIN'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(+) % Acr. Financ.'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'SUBSTI'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(+) % Sub. Tribut.'
                  Width = 90
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'DESADB'
                  Title.Alignment = taRightJustify
                  Title.Caption = '(+) % Desc. Adic'
                  Width = 100
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'PRECUS'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Pre'#231'o de Custo'
                  Width = 80
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CONPAG'
                  Title.Caption = 'Cond. Pag'
                  Width = 150
                  Visible = True
                end>
            end
          end
          object tbsGirEnt: TTabSheet
            Caption = '2 - &Giro de Estoque - Compras'
            ImageIndex = 2
            object cxgGiroCompras: TcxGridCitel
              Left = 0
              Top = 0
              Width = 1000
              Height = 445
              Align = alClient
              TabOrder = 0
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxbGiroCompras: TcxGridDBBandedTableViewCitel
                Navigator.Buttons.CustomButtons = <>
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES01
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES02
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES03
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES04
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES05
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES06
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES07
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES08
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES09
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES10
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES11
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasMES12
                  end
                  item
                    Kind = skSum
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasGIR_MEDI03_COM
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasGIR_MEDI06_COM
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroComprasGIR_MEDI12_COM
                  end>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.ApplyChanges = fracDelayed
                OptionsBehavior.ColumnHeaderHints = False
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                OptionsView.ExpandButtonsForEmptyDetails = False
                OptionsView.Footer = True
                OptionsView.GroupByBox = False
                Bands = <
                  item
                    FixedKind = fkLeft
                    Width = 250
                  end
                  item
                    Caption = 'Informa'#231#245'es'
                    Width = 1100
                  end>
                Zebra = True
                Destaque = False
                DestacarRegistro = False
                CorZebra = clMoneyGreen
                object cxbGiroComprasGIR_CODEMP: TcxGridDBBandedColumn
                  Caption = 'Empresa'
                  DataBinding.FieldName = 'GIR_CODEMP'
                  HeaderAlignmentHorz = taCenter
                  Width = 250
                  Position.BandIndex = 0
                  Position.ColIndex = 0
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES01: TcxGridDBBandedColumn
                  Caption = '01/2014'
                  DataBinding.FieldName = 'MES01'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 0
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES02: TcxGridDBBandedColumn
                  Caption = '02/2014'
                  DataBinding.FieldName = 'MES02'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 1
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES03: TcxGridDBBandedColumn
                  Caption = '03/2014'
                  DataBinding.FieldName = 'MES03'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 2
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES04: TcxGridDBBandedColumn
                  Caption = '04/2014'
                  DataBinding.FieldName = 'MES04'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 3
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES05: TcxGridDBBandedColumn
                  Caption = '05/2014'
                  DataBinding.FieldName = 'MES05'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 4
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES06: TcxGridDBBandedColumn
                  Caption = '06/2014'
                  DataBinding.FieldName = 'MES06'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 5
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES07: TcxGridDBBandedColumn
                  Caption = '07/2014'
                  DataBinding.FieldName = 'MES07'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 6
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES08: TcxGridDBBandedColumn
                  Caption = '08/2014'
                  DataBinding.FieldName = 'MES08'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 7
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES09: TcxGridDBBandedColumn
                  Caption = '09/2014'
                  DataBinding.FieldName = 'MES09'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 8
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES10: TcxGridDBBandedColumn
                  Caption = '10/2014'
                  DataBinding.FieldName = 'MES10'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 9
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES11: TcxGridDBBandedColumn
                  Caption = '11/2014'
                  DataBinding.FieldName = 'MES11'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 10
                  Position.RowIndex = 0
                end
                object cxbGiroComprasMES12: TcxGridDBBandedColumn
                  Caption = '12/2014'
                  DataBinding.FieldName = 'MES12'
                  HeaderAlignmentHorz = taRightJustify
                  Position.BandIndex = 1
                  Position.ColIndex = 11
                  Position.RowIndex = 0
                end
                object cxbGiroComprasGIR_MEDI03_COM: TcxGridDBBandedColumn
                  Caption = 'M'#233'dia 3 Meses'
                  DataBinding.FieldName = 'GIR_MEDI03_COM'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 90
                  Position.BandIndex = 1
                  Position.ColIndex = 12
                  Position.RowIndex = 0
                end
                object cxbGiroComprasGIR_MEDI06_COM: TcxGridDBBandedColumn
                  Caption = 'M'#233'dia 6 Meses'
                  DataBinding.FieldName = 'GIR_MEDI06_COM'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 90
                  Position.BandIndex = 1
                  Position.ColIndex = 13
                  Position.RowIndex = 0
                end
                object cxbGiroComprasGIR_MEDI12_COM: TcxGridDBBandedColumn
                  Caption = 'M'#233'dia 12 Meses'
                  DataBinding.FieldName = 'GIR_MEDI12_COM'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 90
                  Position.BandIndex = 1
                  Position.ColIndex = 14
                  Position.RowIndex = 0
                end
              end
              object cxgGiroComprasLevel: TcxGridLevel
                GridView = cxbGiroCompras
              end
            end
          end
          object tbsUltVenda: TTabSheet
            Caption = '3 - Ultimas &Vendas'
            ImageIndex = 1
            OnShow = tbsUltVendaShow
            object dbgVendas: TDBGridCitel
              Left = 0
              Top = 0
              Width = 1000
              Height = 445
              Align = alClient
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
              ReadOnly = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clBlack
              TitleFont.Height = 14
              TitleFont.Name = 'Arial'
              TitleFont.Pitch = fpVariable
              TitleFont.Style = []
              OnKeyDown = dbgVendasKeyDown
              CorZebra = clMoneyGreen
              Zebra = True
              DestacarMouse = False
              Columns = <
                item
                  Expanded = False
                  FieldName = 'DTA_MOV'
                  Title.Caption = 'Data Mov'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'NUMDOC'
                  Title.Caption = 'Documento'
                  Width = 85
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'ESPDOC'
                  Title.Caption = 'Esp.'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CODEMP'
                  Title.Caption = 'Emp.'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'VENDEDOR'
                  Title.Caption = 'Vendedor'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CONPAG'
                  Title.Caption = 'Condi'#231#227'o de pagamento'
                  Width = 200
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CLIENTE'
                  Title.Caption = 'Cliente'
                  Width = 280
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'QTDITE'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Q.T.D.E.'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'PR_UNITARIO'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Unit'#225'rio'
                  Width = 78
                  Visible = True
                end
                item
                  Alignment = taRightJustify
                  Expanded = False
                  FieldName = 'PR_TOTAL'
                  Title.Alignment = taRightJustify
                  Title.Caption = 'Vlr. Total'
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'CLAFIS'
                  Title.Caption = 'CFOP'
                  Visible = True
                end>
            end
          end
          object tbsGirSai: TTabSheet
            Caption = '4 - Giro de &Estoque - Vendas'
            ImageIndex = 3
            object cxgGiroVendas: TcxGridCitel
              Left = 0
              Top = 0
              Width = 1000
              Height = 445
              Align = alClient
              TabOrder = 0
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxbGiroVendas: TcxGridDBBandedTableViewCitel
                Navigator.Buttons.CustomButtons = <>
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES01
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES02
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES03
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES04
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES05
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES06
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES07
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES08
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES09
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES10
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES11
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES12
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasMES13
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasGIR_MEDI03_VEN
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasGIR_MEDI06_VEN
                  end
                  item
                    Kind = skSum
                    Column = cxbGiroVendasGIR_MEDI12_VEN
                  end>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.ApplyChanges = fracDelayed
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                OptionsView.Footer = True
                OptionsView.GroupByBox = False
                Bands = <
                  item
                    FixedKind = fkLeft
                    Width = 250
                  end
                  item
                    Caption = 'Informa'#231#245'es'
                    Width = 1100
                  end>
                Zebra = True
                Destaque = False
                DestacarRegistro = False
                CorZebra = clMoneyGreen
                object cxbGiroVendasGIR_CODEMP: TcxGridDBBandedColumn
                  Caption = 'Empresa'
                  DataBinding.FieldName = 'GIR_CODEMP'
                  HeaderAlignmentHorz = taCenter
                  Width = 250
                  Position.BandIndex = 0
                  Position.ColIndex = 0
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES01: TcxGridDBBandedColumn
                  Caption = '01/2014'
                  DataBinding.FieldName = 'MES01'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 0
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES02: TcxGridDBBandedColumn
                  Caption = '02/2014'
                  DataBinding.FieldName = 'MES02'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 1
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES03: TcxGridDBBandedColumn
                  Caption = '03/2014'
                  DataBinding.FieldName = 'MES03'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 2
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES04: TcxGridDBBandedColumn
                  Caption = '04/2014'
                  DataBinding.FieldName = 'MES04'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 3
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES05: TcxGridDBBandedColumn
                  Caption = '05/2014'
                  DataBinding.FieldName = 'MES05'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 4
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES06: TcxGridDBBandedColumn
                  Caption = '06/2014'
                  DataBinding.FieldName = 'MES06'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 5
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES07: TcxGridDBBandedColumn
                  Caption = '07/2014'
                  DataBinding.FieldName = 'MES07'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 6
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES08: TcxGridDBBandedColumn
                  Caption = '08/2014'
                  DataBinding.FieldName = 'MES08'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 7
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES09: TcxGridDBBandedColumn
                  Caption = '09/2014'
                  DataBinding.FieldName = 'MES09'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 8
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES10: TcxGridDBBandedColumn
                  Caption = '10/2014'
                  DataBinding.FieldName = 'MES10'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 9
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES11: TcxGridDBBandedColumn
                  Caption = '11/2014'
                  DataBinding.FieldName = 'MES11'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 10
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES12: TcxGridDBBandedColumn
                  Caption = '12/2014'
                  DataBinding.FieldName = 'MES12'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 11
                  Position.RowIndex = 0
                end
                object cxbGiroVendasMES13: TcxGridDBBandedColumn
                  Caption = '01/2015'
                  DataBinding.FieldName = 'MES13'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 64
                  Position.BandIndex = 1
                  Position.ColIndex = 12
                  Position.RowIndex = 0
                end
                object cxbGiroVendasGIR_MEDI03_VEN: TcxGridDBBandedColumn
                  Caption = 'M'#233'dia 3 Meses'
                  DataBinding.FieldName = 'GIR_MEDI03_VEN'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 90
                  Position.BandIndex = 1
                  Position.ColIndex = 13
                  Position.RowIndex = 0
                end
                object cxbGiroVendasGIR_MEDI06_VEN: TcxGridDBBandedColumn
                  Caption = 'M'#233'dia 6 Meses'
                  DataBinding.FieldName = 'GIR_MEDI06_VEN'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 90
                  Position.BandIndex = 1
                  Position.ColIndex = 14
                  Position.RowIndex = 0
                end
                object cxbGiroVendasGIR_MEDI12_VEN: TcxGridDBBandedColumn
                  Caption = 'M'#233'dia 12 Meses'
                  DataBinding.FieldName = 'GIR_MEDI12_VEN'
                  HeaderAlignmentHorz = taRightJustify
                  Width = 90
                  Position.BandIndex = 1
                  Position.ColIndex = 15
                  Position.RowIndex = 0
                end
              end
              object cxgGiroVendasLevel: TcxGridLevel
                GridView = cxbGiroVendas
              end
            end
          end
          object tbsLoteRastreamento: TTabSheet
            Caption = '5 - Rastreamento do Lote'
            ImageIndex = 4
            object cxgLoteRastreamento: TcxGridCitel
              Left = 0
              Top = 24
              Width = 1000
              Height = 421
              Align = alClient
              TabOrder = 0
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxgLoteRastreamentoTBV: TcxGridDBTableViewCitel
                Navigator.Buttons.CustomButtons = <>
                DataController.DataSource = dtsLoteRastreamento
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.ApplyChanges = fracDelayed
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                OptionsView.GroupByBox = False
                Zebra = True
                Destaque = False
                CorZebra = clMoneyGreen
                object cxgLoteRastreamentoTBVColumn1: TcxGridDBColumn
                  Caption = 'DT. Movimento'
                  DataBinding.FieldName = 'DATA'
                  Width = 90
                end
                object cxgLoteRastreamentoTBVColumn2: TcxGridDBColumn
                  Caption = 'Lote'
                  DataBinding.FieldName = 'NUMERO_LOTE'
                  Width = 175
                end
                object cxgLoteRastreamentoTBVColumn3: TcxGridDBColumn
                  Caption = 'Documento'
                  DataBinding.FieldName = 'DOCUMENTO'
                  Width = 144
                end
                object cxgLoteRastreamentoTBVColumn4: TcxGridDBColumn
                  Caption = 'Fornecedor'
                  DataBinding.FieldName = 'FORNECEDOR'
                  Width = 410
                end
                object cxgLoteRastreamentoTBVColumn5: TcxGridDBColumn
                  Caption = 'Ped. Venda da OP'
                  DataBinding.FieldName = 'PEDIDO_VENDA'
                  Width = 144
                end
              end
              object cxgLoteRastreamentoLVL: TcxGridLevel
                GridView = cxgLoteRastreamentoTBV
              end
            end
            object Panel11: TPanel
              Left = 0
              Top = 0
              Width = 1000
              Height = 24
              Align = alTop
              TabOrder = 1
              object lblDepartamentoLoteRastreamento: TLabel
                Left = 5
                Top = 2
                Width = 81
                Height = 14
                Caption = 'Departamento:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
            end
          end
        end
        object pnlRodapePrecosUltCompraVendaMedio: TPanel
          Left = 1
          Top = 475
          Width = 1008
          Height = 31
          Align = alBottom
          ParentColor = True
          TabOrder = 1
          object lblInfoCnvMl: TLabel
            Left = 306
            Top = 9
            Width = 161
            Height = 18
            Alignment = taCenter
            Caption = 'QUANTIDADES EM ML'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object btnCfgGri: TBitBtnLocked
            Left = 139
            Top = 5
            Width = 148
            Height = 22
            Caption = 'Confi&gura colunas '
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
              00090000000E0000000F00000010000000100000001100000011000000110000
              00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
              4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
              ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
              6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
              9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
              71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
              64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
              75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
              B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
              78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
              BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
              7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
              BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
              7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
              C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
              84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
              C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
              87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
              D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
              8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
              97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
              8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
              AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
              91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
              F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
              95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
              FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
              6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
              93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
            TabOrder = 0
            OnClick = btnCfgGriClick
          end
          object BitBtnLocked1: TBitBtnLocked
            Left = 4
            Top = 5
            Width = 134
            Height = 22
            Caption = 'Salvar para Excel'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000020000
              00090000000E0000000F00000010000000100000001100000011000000110000
              001200000012000000110000000C000000030000000000000000000000087B50
              43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
              59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
              5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
              ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
              62FFFDFBFAFFF7EDE6FF53A46CFF058131FF048030FF047F30FF037E2FFF037D
              2EFF027C2EFF027B2DFF02792CFF01792CFF00782BFF00511DAD0000000BB079
              66FFFDFBFBFFF8EEE8FF068332FFFAF6F6FF058131FFF9F5F3FF047F2FFFF8F2
              F1FFF7F2EFFF7DB68EFFF7EFEDFFF6EEEBFF7BB48BFF01782BFF0000000AB37C
              69FFFEFCFBFFF8F0EAFF068433FFFBF7F6FF058231FFF9F5F4FF048030FFF8F4
              F2FF037E2FFF037D2FFF027C2EFF7DB68DFFF6EEEBFF01792CFF00000009B67F
              6CFFFEFDFCFFF9F0EBFF078533FF81BE95FFFBF7F6FF80BD94FF048131FFF9F5
              F2FF047F30FF037E2FFF7EB88FFFF6F1EEFF037B2DFF017A2DFF00000009B983
              71FFFEFDFCFFFAF3EEFF068634FFFCF8F8FF068433FFFBF7F6FF068231FFFAF5
              F3FF048030FF047F30FFF8F3F0FF037D2EFF027C2EFF027A2DFF00000008BC88
              77FFFEFEFDFFFBF4EFFF078634FFFBFAF9FF078533FFFAF8F7FF068333FFFAF7
              F5FF058131FF058030FF7EB991FFF8F2F0FFF7F2EFFF027C2DFF00000007BF8C
              7AFFFEFEFDFFFBF6F1FF55AA71FF078634FF078534FF068534FF068433FF0683
              32FF058332FF058131FF058030FF047F30FF037E2FFF025420AD00000006C18F
              7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
              EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
              82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
              F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
              85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
              F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
              89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
              FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
              67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
              87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
              0002000000030000000400000004000000050000000500000005000000060000
              0006000000060000000600000005000000010000000000000000}
            TabOrder = 1
            OnClick = BitBtnLocked1Click
          end
        end
      end
      object pnlUltimosMov: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 189
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label85: TLabel
          Left = 104
          Top = 9
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltima Compra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label86: TLabel
          Left = 75
          Top = 30
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data:'
        end
        object Label87: TLabel
          Left = 42
          Top = 52
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object Label88: TLabel
          Left = 69
          Top = 74
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o:'
        end
        object Label94: TLabel
          Left = 38
          Top = 120
          Width = 62
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o M'#233'dio:'
        end
        object Label93: TLabel
          Left = 10
          Top = 164
          Width = 90
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltimo Fornecedor:'
        end
        object Label92: TLabel
          Left = 529
          Top = 75
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o:'
        end
        object Label91: TLabel
          Left = 502
          Top = 53
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object Label90: TLabel
          Left = 535
          Top = 31
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data:'
        end
        object Label89: TLabel
          Left = 565
          Top = 10
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltima Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label169: TLabel
          Left = 14
          Top = 96
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o + Impostos:'
        end
        object Label144: TLabel
          Left = 12
          Top = 142
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltimo Documento:'
        end
        object Label138: TLabel
          Left = 222
          Top = 9
          Width = 151
          Height = 14
          Alignment = taRightJustify
          Caption = #218'ltima Compra Embalagem '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'charter'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label164: TLabel
          Left = 245
          Top = 96
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o + Impostos:'
        end
        object Label165: TLabel
          Left = 300
          Top = 74
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o:'
        end
        object Label170: TLabel
          Left = 273
          Top = 52
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object lblPMED_V: TLabel
          Left = 464
          Top = 97
          Width = 96
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pre'#231'o M'#233'dio Venda:'
        end
        object lblCotMoe: TLabel
          Left = 412
          Top = 140
          Width = 127
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cota'#231#227'o da '#250'ltima compra:'
        end
        object btnMemCalcPrecoImpEmb: TSpeedButton
          Left = 427
          Top = 91
          Width = 23
          Height = 21
          Hint = 'Memoria de C'#225'lculo'
          Flat = True
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
          OnClick = btnMemCalcPrecoImpEmbClick
        end
        object btnMemCalcPrecoImpostos: TSpeedButton
          Left = 196
          Top = 90
          Width = 23
          Height = 21
          Hint = 'Memoria de C'#225'lculo'
          Flat = True
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
          OnClick = btnMemCalcPrecoImpostosClick
        end
        object btnMemCalcPrecoMedio: TSpeedButton
          Left = 196
          Top = 113
          Width = 23
          Height = 21
          Hint = 'Memoria de C'#225'lculo'
          Flat = True
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
          OnClick = btnMemCalcPrecoMedioClick
        end
        object edtUltCom: TEditFocus
          Left = 102
          Top = 25
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtQtdUco: TEditFocus
          Left = 102
          Top = 47
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,###0.000'
        end
        object edtPreUlt: TEditFocus
          Left = 102
          Top = 69
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtPreMed: TEditFocus
          Left = 102
          Top = 113
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtUltFor: TEditFocus
          Left = 102
          Top = 157
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomUltFor: TEditFocus
          Left = 192
          Top = 157
          Width = 408
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 14
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtPreuve: TEditFocus
          Left = 563
          Top = 69
          Width = 87
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtQtdUve: TEditFocus
          Left = 563
          Top = 47
          Width = 87
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,###0.000'
        end
        object edtDtaUve: TEditFocus
          Left = 563
          Top = 25
          Width = 87
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object rgpDadosUvc: TRadioGroup
          Left = 661
          Top = 37
          Width = 332
          Height = 49
          Caption = 'Dados das Compras / Vendas'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Empresa Atual'
            'Todas as Empresas')
          TabOrder = 13
        end
        object btnVenCom: TBitBtnLocked
          Left = 661
          Top = 7
          Width = 150
          Height = 21
          Caption = 'Calcular Compras/Vendas'
          TabOrder = 0
          OnClick = btnVenComClick
        end
        object edtImpUlt: TEditFocus
          Left = 102
          Top = 91
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtUltNot: TEditFocus
          Left = 102
          Top = 135
          Width = 307
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtPreUltEmb: TEditFocus
          Left = 333
          Top = 69
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtPreImpUltEmb: TEditFocus
          Left = 333
          Top = 91
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtEmbQtd: TEditFocus
          Left = 333
          Top = 47
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,###0.000'
        end
        object edtPMED_V: TEditFocus
          Left = 563
          Top = 91
          Width = 87
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 16
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtCotMoe: TEditFocus
          Left = 541
          Top = 135
          Width = 59
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 17
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
      end
    end
    object tbsFornecedores: TTabSheet
      Caption = '&11 - Fornecedores'
      ImageIndex = 11
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object lbl19: TLabel
          Left = 1
          Top = 675
          Width = 1008
          Height = 20
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'Pressione [ DELETE ] para excluir este fornecedor'
          Color = clGray
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 487
          ExplicitWidth = 784
        end
        object dbgFornecedor: TDBGridCitel
          Left = 1
          Top = 92
          Width = 1008
          Height = 583
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          OnDrawColumnCell = dbgFornecedorDrawColumnCell
          OnKeyDown = dbgFornecedorKeyDown
          OnTitleClick = dbgFornecedorTitleClick
          CorZebra = clMoneyGreen
          Zebra = False
          DestacarMouse = False
          Columns = <
            item
              Expanded = False
              FieldName = 'ITE_CODFOR'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FOR_NOMFOR'
              Title.Caption = 'Nome do Fornecedor'
              Width = 258
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CID_NOMCID'
              Title.Caption = 'Cidade'
              Width = 149
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CID_ESTADO'
              Title.Caption = 'UF'
              Width = 25
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FOR_FONE01'
              Title.Caption = 'Telefone'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITE_CODITF'
              Title.Caption = 'C'#243'd. Item Fornec.'
              Width = 161
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ITE_CODCNA'
              Title.Caption = 'C'#243'digo CNA'
              Width = 120
              Visible = True
            end>
        end
        object pnlTopo: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 91
          Align = alTop
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object lbl20: TLabel
            Left = 14
            Top = 5
            Width = 56
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fornecedor'
          end
          object lbl21: TLabel
            Left = 14
            Top = 44
            Width = 144
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo do Item no Fornecedor'
          end
          object Label54: TLabel
            Left = 206
            Top = 44
            Width = 58
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo CNA'
          end
          object edtNomForn: TEditFocus
            Left = 109
            Top = 20
            Width = 434
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Enabled = False
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
          object edtCodForn: TEditFocus
            Tag = 99
            Left = 14
            Top = 20
            Width = 93
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            TabOrder = 0
            OnEnter = edtCodFornEnter
            OnExit = edtCodFornExit
            OnKeyPress = edtCodFornKeyPress
            OnKeyUp = edtCodFornKeyUp
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttInteiro
          end
          object edtCodItF: TEditFocus
            Tag = 99
            Left = 14
            Top = 59
            Width = 186
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 35
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 35
            TipoTexto = ttAlfanumerico
          end
          object btnAdicionarForn: TBitBtnLocked
            Left = 551
            Top = 59
            Width = 74
            Height = 22
            Caption = '&Adicionar'
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
            TabOrder = 4
            OnClick = btnAdicionarFornClick
          end
          object btnCancelarForn: TBitBtnLocked
            Left = 625
            Top = 59
            Width = 74
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
            TabOrder = 5
            OnClick = btnCancelarFornClick
          end
          object edtCodCna: TEditFocus
            Tag = 99
            Left = 206
            Top = 59
            Width = 186
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 20
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 20
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
    object tbsEmbalagens: TTabSheet
      Caption = '12 - Embalagens'
      ImageIndex = 7
    end
    object tbsExportaSite: TTabSheet
      Caption = '13 - E-CO&MMERCE'
      ImageIndex = 8
      object pnlDadosECommerce: TPanel
        Tag = 99
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        Caption = 'RESERVADO PARA TfrmPanelDadosECommerce'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 40
        Font.Name = 'Arial Black'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
      end
    end
    object tbsMontadoras: TTabSheet
      Caption = '14 - Montadoras'
      ImageIndex = 11
    end
    object tbsDesMaxTBP: TTabSheet
      Caption = '15 - Desconto m'#225'ximo por tabela de pre'#231'o'
      ImageIndex = 12
      OnShow = tbsDesMaxTBPShow
      object cxgDesMaxTabPre: TcxGrid
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDesMaxTabPreeView: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'Desconto m'#225'ximo por tabela de pre'#231'o'
              Width = 1065
            end>
          object cxgDesMaxTabPreeViewColumn2: TcxGridDBBandedColumn
            Caption = 'Tabela de Pre'#231'o'
            DataBinding.FieldName = 'ITE_TABPRE'
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Options.Sorting = False
            Width = 93
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgDesMaxTabPreeViewColumn3: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Vendedor - J'#250'nior'
            DataBinding.FieldName = 'ITE_DESMAX'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '% ,0.00;-% ,0.00'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Options.Sorting = False
            Width = 157
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgDesMaxTabPreeViewColumn4: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Vendedor - Master'
            DataBinding.FieldName = 'ITE_DESVMM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Options.Sorting = False
            Width = 157
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgDesMaxTabPreeViewColumn1: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Sub-Gerente - J'#250'nior'
            DataBinding.FieldName = 'ITE_DESMSU'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '% ,0.00;-% ,0.00'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Width = 164
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgDesMaxTabPreeViewColumn6: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Sub-Gerente - Master'
            DataBinding.FieldName = 'ITE_DESSMM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Options.Sorting = False
            Width = 178
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgDesMaxTabPreeViewColumn5: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Gerente - J'#250'nior'
            DataBinding.FieldName = 'ITE_DESMGE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '% ,0.00;-% ,0.00'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Options.Sorting = False
            Width = 158
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxgDesMaxTabPreeViewColumn7: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Gerente - Master'
            DataBinding.FieldName = 'ITE_DESGMM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Filtering = False
            Options.FilteringPopup = False
            Options.Moving = False
            Options.Sorting = False
            Width = 158
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
        end
        object cxgDesMaxTabPreLevel1: TcxGridLevel
          GridView = cxgDesMaxTabPreeView
        end
      end
    end
    object tbsIteEmb: TTabSheet
      Caption = '16 - Desconto Embalagem Fechada'
      ImageIndex = 17
      object pnlIteEmb: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object pnlIteEmbTopo: TPanel
          Left = 0
          Top = 0
          Width = 1010
          Height = 42
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lbl22: TLabel
            Left = 2
            Top = 1
            Width = 55
            Height = 14
            Caption = 'Quantidade'
          end
          object lbl23: TLabel
            Left = 78
            Top = 1
            Width = 59
            Height = 14
            Caption = '% Desconto'
          end
          object lbl25: TLabel
            Left = 153
            Top = 1
            Width = 77
            Height = 14
            Caption = 'Tabela de Pre'#231'o'
          end
          object lblPrinCalcRom: TLabel
            Left = 239
            Top = 1
            Width = 213
            Height = 14
            Caption = 'Principal para C'#225'lculo de Volume - Romaneio'
          end
          object edtEmbFec: TEditFocus
            Tag = 99
            Left = 2
            Top = 16
            Width = 70
            Height = 22
            Alignment = taLeftJustify
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
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtDesFec: TEditFocus
            Tag = 99
            Left = 78
            Top = 16
            Width = 69
            Height = 22
            Alignment = taLeftJustify
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
            OnExit = pValidarPrecos
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object cbxTabEmf: TComboBoxFocus
            Tag = 99
            Left = 153
            Top = 16
            Width = 80
            Height = 22
            Style = csOwnerDrawFixed
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object btnAdicionaIteEmb: TBitBtnLocked
            Left = 458
            Top = 16
            Width = 74
            Height = 22
            Caption = '&Adicionar'
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
            TabOrder = 4
            OnClick = btnAdicionaIteEmbClick
          end
          object btnCancelaIteEmb: TBitBtnLocked
            Left = 532
            Top = 16
            Width = 74
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
            TabOrder = 5
            OnClick = btnCancelaIteEmbClick
          end
          object cmbPriRom: TComboBoxFocus
            Tag = 99
            Left = 239
            Top = 16
            Width = 80
            Height = 22
            Style = csDropDownList
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemIndex = 1
            TabOrder = 3
            Text = 'N'#227'o'
            Items.Strings = (
              'Sim'
              'N'#227'o')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlIteEmbBottom: TPanel
          Left = 0
          Top = 663
          Width = 1010
          Height = 33
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object Label63: TLabel
            Left = 5
            Top = 18
            Width = 193
            Height = 14
            Caption = '[DELETE] - Para apagar um registro.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label125: TLabel
            Left = 5
            Top = 1
            Width = 279
            Height = 14
            Caption = '[ENTER] ou [Clique Duplo] - Para editar um registro.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object cxgIteEmb: TcxGridCitel
          Left = 0
          Top = 42
          Width = 1010
          Height = 621
          Align = alClient
          TabOrder = 2
          TabStop = False
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgIteEmbTableView: TcxGridDBTableViewCitel
            OnDblClick = cxgIteEmbTableViewDblClick
            OnKeyDown = cxgIteEmbTableViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = True
            Destaque = True
            CorZebra = clMoneyGreen
            object cxgIteEmbTableViewQTDEMB: TcxGridDBColumn
              Caption = 'Qtde. Embalagem'
              DataBinding.FieldName = 'ITB_QTDEMB'
              Options.Sorting = False
              Width = 104
            end
            object cxgIteEmbTableViewDESCON: TcxGridDBColumn
              Caption = '% Desconto'
              DataBinding.FieldName = 'ITB_DESCON'
              Options.Sorting = False
              Width = 87
            end
            object cxgIteEmbTableViewTABPRE: TcxGridDBColumn
              Caption = 'Tabela de Pre'#231'o'
              DataBinding.FieldName = 'ITB_TABPRE'
              Options.Sorting = False
              Width = 105
            end
            object cxgIteEmbTableViewPRIROM: TcxGridDBColumn
              Caption = 'Principal para Calculo de Volume - Romaneio'
              DataBinding.FieldName = 'ITB_PRIROM'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 'S'
              Properties.ValueUnchecked = 'N'
              Options.Sorting = False
              Width = 234
            end
          end
          object cxgIteEmbLevel: TcxGridLevel
            GridView = cxgIteEmbTableView
          end
        end
      end
    end
    object tbsProdAcab: TTabSheet
      Caption = '17 - Produto Acabado'
      ImageIndex = 16
      OnShow = tbsProdAcabShow
      object pnlProdAcab: TPanel
        Left = -4
        Top = 2
        Width = 786
        Height = 665
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlComEti8: TPanel
          Left = 0
          Top = 577
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 11
          object lblComEti8: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 08:'
          end
          object edtComEti8: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti7: TPanel
          Left = 0
          Top = 554
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 10
          object lblComEti7: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 07:'
          end
          object edtComEti7: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti6: TPanel
          Left = 0
          Top = 531
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 9
          object lblComEti6: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 06:'
          end
          object edtComEti6: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti5: TPanel
          Left = 0
          Top = 508
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 8
          object lblComEti5: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 05:'
          end
          object edtComEti5: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti4: TPanel
          Left = 0
          Top = 485
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 7
          object lblComEti4: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 04:'
          end
          object edtComEti4: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti3: TPanel
          Left = 0
          Top = 462
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 6
          object lblComEti3: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 03:'
          end
          object edtComEti3: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti2: TPanel
          Left = 0
          Top = 439
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 5
          object lblComEti2: TLabel
            Left = 16
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 02:'
          end
          object edtComEti2: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti1: TPanel
          Left = 0
          Top = 416
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object lblComEti1: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 01:'
          end
          object edtComEti1: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti9: TPanel
          Left = 0
          Top = 600
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 12
          object lblComEti9: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 09:'
          end
          object edtComEti9: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlComEti10: TPanel
          Left = 0
          Top = 623
          Width = 786
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 13
          object lblComEti10: TLabel
            Left = 17
            Top = 3
            Width = 126
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'LINHA 10:'
          end
          object edtComEti10: TEditFocus
            Tag = 99
            Left = 144
            Top = 0
            Width = 617
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object pnlSitPrd: TPanel
          Left = 0
          Top = 125
          Width = 786
          Height = 58
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object lbl35: TLabel
            Left = 82
            Top = 14
            Width = 172
            Height = 14
            Alignment = taRightJustify
            Caption = 'Situa'#231#227'o para An'#225'lise de Produ'#231#227'o:'
          end
          object lbl44: TColorLabel
            Left = 300
            Top = 3
            Width = 257
            Height = 14
            Caption = '(1) Entrar sempre no calculo da An'#225'lise de Produ'#231#227'o.'
            CorDestaque = clRed
          end
          object lbl45: TColorLabel
            Left = 300
            Top = 16
            Width = 436
            Height = 28
            Caption = 
              '(2) Entrar no calculo da An'#225'lise de Produ'#231#227'o, somente se tiver P' +
              'edido de Venda pendente,'#13#10'independente do Giro de Estoque no per' +
              #237'odo [ Produtos de Venda Casada ]'
            CorDestaque = clRed
          end
          object dbeSitPrd: TDBEditFocus
            Tag = 99
            Left = 257
            Top = 10
            Width = 34
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_SITPRD'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlMateriaPrima: TPanel
          Left = 0
          Top = 48
          Width = 786
          Height = 77
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Label84: TLabel
            Left = 104
            Top = 9
            Width = 38
            Height = 14
            Alignment = taRightJustify
            Caption = 'S'#243'lidos:'
          end
          object Label157: TLabel
            Left = 93
            Top = 35
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Categoria:'
          end
          object ColorLabel29: TColorLabel
            Left = 231
            Top = 32
            Width = 176
            Height = 14
            Caption = '(1) Carga,  (2) Resina ou  (0) Outros'
            CorDestaque = clRed
          end
          object Label158: TLabel
            Left = 51
            Top = 55
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Absor'#231#227'o de '#211'leo:'
          end
          object ColorLabel30: TColorLabel
            Left = 231
            Top = 9
            Width = 10
            Height = 14
            Caption = '%'
            CorDestaque = clRed
          end
          object dbePerSol: TDBEditFocus
            Tag = 99
            Left = 144
            Top = 6
            Width = 80
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_PERSOL'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeECarga: TDBEditFocus
            Tag = 99
            Left = 144
            Top = 29
            Width = 80
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ECARGA'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAbsOle: TDBEditFocus
            Tag = 99
            Left = 144
            Top = 52
            Width = 80
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_ABSOLE'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlCodCom: TPanel
          Left = 0
          Top = 24
          Width = 786
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object lblCompos: TLabel
            Left = 79
            Top = 6
            Width = 62
            Height = 14
            Alignment = taRightJustify
            Caption = 'Composi'#231#227'o:'
          end
          object dbeCodCom: TDBEditFocus
            Tag = 99
            Left = 144
            Top = 2
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_CODCOM'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeCodComKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtDesCom: TEditFocus
            Left = 209
            Top = 2
            Width = 552
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object pnlLayOrdInd: TPanel
          Left = 0
          Top = 285
          Width = 786
          Height = 131
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object Label126: TLabel
            Left = 4
            Top = 16
            Width = 140
            Height = 14
            Alignment = taRightJustify
            Caption = 'Layout Ordem Produ'#231#227'o Ind.:'
          end
          object edtNomLayOrdInd: TEditFocus
            Left = 210
            Top = 12
            Width = 394
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object btnCancelLayOrdInd: TBitBtnLocked
            Left = 684
            Top = 12
            Width = 74
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
            TabOrder = 3
            OnClick = btnCancelLayOrdIndClick
          end
          object btnAddLayOrdInd: TBitBtnLocked
            Left = 610
            Top = 12
            Width = 74
            Height = 22
            Caption = '&Adicionar'
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
            TabOrder = 2
            OnClick = btnAddLayOrdIndClick
          end
          object cxgLayOrdInd: TcxGridCitel
            Left = 144
            Top = 38
            Width = 617
            Height = 91
            TabOrder = 4
            TabStop = False
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgLayOrdIndTV: TcxGridDBTableViewCitel
              OnDblClick = cxgLayOrdIndTVDblClick
              OnKeyDown = cxgLayOrdIndTVKeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = True
              Destaque = True
              CorZebra = clMoneyGreen
              object cxgLayOrDIndLAYOUT: TcxGridDBColumn
                Caption = 'Layout'
                DataBinding.FieldName = 'LAY_DESCRI'
                Options.Sorting = False
                Width = 604
              end
            end
            object cxgLayOrdIndLvl1: TcxGridLevel
              GridView = cxgLayOrdIndTV
            end
          end
          object edtCodLayOrdInd: TEditFocus
            Tag = 99
            Left = 144
            Top = 12
            Width = 63
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 6
            TabOrder = 0
            OnKeyPress = edtCodLayOrdIndKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlGranel: TPanel
          Left = 0
          Top = 0
          Width = 786
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 14
          object Label160: TLabel
            Left = 66
            Top = 6
            Width = 75
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto Granel:'
          end
          object edtDesPag: TEditFocus
            Left = 144
            Top = 2
            Width = 617
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        object pnlComponente: TPanel
          Left = 0
          Top = 183
          Width = 786
          Height = 102
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 15
          object Label220: TLabel
            Left = 8
            Top = 17
            Width = 163
            Height = 14
            Alignment = taRightJustify
            Caption = 'Componente "A" na formula'#231#227'o ?:'
          end
          object ColorLabel44: TColorLabel
            Left = 230
            Top = 19
            Width = 31
            Height = 14
            Caption = '(S / N)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object Label226: TLabel
            Left = 297
            Top = 19
            Width = 162
            Height = 14
            Alignment = taRightJustify
            Caption = 'Componente "B" na formula'#231#227'o ?:'
          end
          object ColorLabel45: TColorLabel
            Left = 531
            Top = 18
            Width = 31
            Height = 14
            Caption = '(S / N)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object dbeComponenteA: TDBEditFocus
            Tag = 99
            Left = 176
            Top = 14
            Width = 43
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMPNA'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnExit = dbeComponenteAExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeComponenteB: TDBEditFocus
            Tag = 99
            Left = 482
            Top = 12
            Width = 43
            Height = 22
            CharCase = ecUpperCase
            DataField = 'ITE_COMPNB'
            DataSource = dtsCadIte
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            OnExit = dbeComponenteAExit
            OnKeyPress = dbeComponenteBKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object pnlDesclComponeteAB: TPanel
            Left = 8
            Top = 39
            Width = 753
            Height = 59
            BevelOuter = bvNone
            Color = 16770261
            Enabled = False
            ParentBackground = False
            TabOrder = 3
            object Label234: TLabel
              Left = 13
              Top = 14
              Width = 73
              Height = 14
              Alignment = taRightJustify
              Caption = 'Componente B:'
            end
            object Label235: TLabel
              Left = 45
              Top = 42
              Width = 41
              Height = 14
              Alignment = taRightJustify
              Caption = 'Diluente:'
            end
            object dbeProdutoDiluente: TDBEditFocus
              Tag = 99
              Left = 97
              Top = 35
              Width = 45
              Height = 22
              DataField = 'ITE_CODITD'
              DataSource = dtsCadIte
              Enabled = False
              MaxLength = 5
              TabOrder = 2
              OnKeyPress = dbeProdutoDiluenteKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttNumerico
            end
            object dbeProduto: TDBEditFocus
              Tag = 99
              Left = 97
              Top = 11
              Width = 45
              Height = 22
              DataField = 'ITE_CODITB'
              DataSource = dtsCadIte
              Enabled = False
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = dbeProdutoKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TipoTexto = ttNumerico
            end
            object edtDesProduto: TEditFocus
              Left = 146
              Top = 11
              Width = 569
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
            object edtDescProdutoDiluente: TEditFocus
              Left = 146
              Top = 36
              Width = 569
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlCatalise: TPanel
            Left = 568
            Top = 5
            Width = 193
            Height = 37
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            object Label233: TLabel
              Left = 9
              Top = 13
              Width = 98
              Height = 14
              Alignment = taRightJustify
              Caption = 'Rela'#231#227'o de Cat'#225'lise:'
            end
            object dbeValorCatalise: TDBEditFocus
              Tag = 99
              Left = 113
              Top = 7
              Width = 68
              Height = 22
              CharCase = ecUpperCase
              DataField = 'ITE_VALCAT'
              DataSource = dtsCadIte
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              OnExit = pValidarPrecos
              OnKeyPress = dbeValorCataliseKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
    end
    object tbsDesMaxFaixaQtde: TTabSheet
      Caption = '18 - Desconto m'#225'ximo por faixa de quantidade'
      ImageIndex = 18
      object cxgDesMaxFaixaQtde: TcxGrid
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDesMaxFaixaQtdeTreeView: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          NewItemRow.InfoText = 'Clique aqui para cadastrar um novo registro'
          NewItemRow.Visible = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Bands = <
            item
              Caption = 'Desconto m'#225'ximo por faixa de quantidade'
              Width = 724
            end>
          object cxgDesMaxFaixaQtdeTreeViewInicial: TcxGridDBBandedColumn
            Caption = 'Qtde Inicial'
            DataBinding.FieldName = 'DFQ_QTDINI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.OnValidate = cxgDesMaxFaixaQtdeTreeViewInicialPropertiesValidate
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 65
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewFinal: TcxGridDBBandedColumn
            Caption = 'Qtde Final'
            DataBinding.FieldName = 'DFQ_QTDFIN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = ',0.00;-,0.00'
            Properties.OnValidate = cxgDesMaxFaixaQtdeTreeViewFinalPropertiesValidate
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Moving = False
            Width = 65
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewDesVen: TcxGridDBBandedColumn
            Caption = 'Des. M'#225'x. Vendedor - J'#250'nior'
            DataBinding.FieldName = 'DFQ_DESVEN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = '% ,0.00;-% ,0.00'
            Properties.OnValidate = cxgDesMaxFaixaQtdeTreeViewDesVenPropertiesValidate
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 149
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewDesSub: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Sub-Gerente - J'#250'nior'
            DataBinding.FieldName = 'DFQ_DESSUB'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = '% ,0.00;-% ,0.00'
            Properties.OnValidate = cxgDesMaxFaixaQtdeTreeViewDesSubPropertiesValidate
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 169
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewDesGer: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Gerente - J'#250'nior'
            DataBinding.FieldName = 'DFQ_DESGER'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DisplayFormat = '% ,0.00;-% ,0.00'
            Properties.OnValidate = cxgDesMaxFaixaQtdeTreeViewDesGerPropertiesValidate
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 145
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewColumn1: TcxGridDBBandedColumn
            Caption = 'Des. M'#225'x. Vendedor - Master'
            DataBinding.FieldName = 'DFQ_DESVEM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 149
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewColumn2: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Sub-Gerente - Master'
            DataBinding.FieldName = 'DFQ_DESSUM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 172
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxgDesMaxFaixaQtdeTreeViewColumn3: TcxGridDBBandedColumn
            Caption = 'Desc. M'#225'x. Gerente - Master'
            DataBinding.FieldName = 'DFQ_DESGEM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            RepositoryItem = cxredtDesMax
            HeaderAlignmentHorz = taCenter
            Options.Moving = False
            Width = 150
            Position.BandIndex = 0
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxgDesMaxFaixaQtdeTreeView
        end
      end
    end
    object tbsproduto_veiculo: TTabSheet
      Caption = '19 - Relacionamento Produto x Ve'#237'culo'
      ImageIndex = 18
      OnShow = tbsproduto_veiculoShow
      object pnlProdutoVeiculo: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        Caption = 'pnlProdutoVeiculo'
        ParentColor = True
        TabOrder = 0
        object Panel13: TPanel
          Left = 1
          Top = 151
          Width = 1008
          Height = 544
          Align = alClient
          TabOrder = 0
          object cxVeiculoProduto: TcxGridCitel
            Left = 1
            Top = 1
            Width = 1006
            Height = 509
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxVeiculoProdutoView: TcxGridDBTableViewCitel
              OnKeyDown = cxVeiculoProdutoViewKeyDown
              Navigator.Buttons.CustomButtons = <>
              OnCellDblClick = cxVeiculoProdutoViewCellDblClick
              DataController.Filter.Options = [fcoCaseInsensitive, fcoSoftNull]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.Visible = True
              FilterRow.ApplyChanges = fracImmediately
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = '< Sem dados para exibir >'
              OptionsView.GroupByBox = False
              Zebra = True
              Destaque = False
              CorZebra = clMoneyGreen
              object cxVeiculosProdutoCODMAR: TcxGridDBColumn
                Caption = 'Marca'
                DataBinding.FieldName = 'MOD_CODMAR'
                Width = 42
              end
              object cxVeiculosProdutoDESMAR: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'MAR_DESMAR'
                Width = 145
              end
              object cxVeiculosProdutoCODMOD: TcxGridDBColumn
                Caption = 'Modelo'
                DataBinding.FieldName = 'MOD_CODMOD'
                Width = 44
              end
              object cxVeiculosProdutoDESMOD: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'MOD_DESMOD'
                Width = 154
              end
              object cxVeiculosProdutoANOINI: TcxGridDBColumn
                Caption = 'Ano Inicial'
                DataBinding.FieldName = 'MOD_ANOINI'
                HeaderAlignmentHorz = taRightJustify
              end
              object cxVeiculosProdutoANOFIN: TcxGridDBColumn
                Caption = 'Ano Final'
                DataBinding.FieldName = 'MOD_ANOFIN'
                HeaderAlignmentHorz = taRightJustify
              end
              object cxVeiculosProdutoCOMBUS: TcxGridDBColumn
                Caption = 'Combust'#237'vel'
                DataBinding.FieldName = 'MOD_COMBUS'
                Width = 85
              end
              object cxVeiculosProdutoVALVUL: TcxGridDBColumn
                Caption = 'V'#225'lvula'
                DataBinding.FieldName = 'MOD_VALVUL'
                HeaderAlignmentHorz = taRightJustify
              end
              object cxVeiculosProdutoCILIND: TcxGridDBColumn
                Caption = 'Cilindrada'
                DataBinding.FieldName = 'MOD_CILIND'
                HeaderAlignmentHorz = taRightJustify
                MinWidth = 77
                Width = 77
              end
              object cxVeiculosProdutoPOTENC: TcxGridDBColumn
                Caption = 'Pot'#234'ncia'
                DataBinding.FieldName = 'MOD_POTENC'
                HeaderAlignmentHorz = taRightJustify
              end
              object cxVeiculoProdutoOBSERV: TcxGridDBColumn
                Caption = 'Observa'#231#245'es'
                DataBinding.FieldName = 'MOD_OBSERV'
                Width = 165
              end
            end
            object cxVeiculoProdutoLevel1: TcxGridLevel
              GridView = cxVeiculoProdutoView
            end
          end
          object Panel14: TPanel
            Left = 1
            Top = 510
            Width = 1006
            Height = 33
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label213: TLabel
              Left = 1
              Top = 1
              Width = 1004
              Height = 14
              Align = alTop
              Caption = '[Delete] -  Para deletar o registro'
              ExplicitWidth = 180
            end
            object Label214: TLabel
              Left = 1
              Top = 15
              Width = 1004
              Height = 14
              Align = alTop
              Caption = '[Duplo Clique] -  Para Alterar o Registro'
              ExplicitWidth = 215
            end
          end
        end
        object Panel12: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 150
          Align = alTop
          ParentColor = True
          TabOrder = 1
          object Label204: TLabel
            Left = 135
            Top = 83
            Width = 48
            Height = 14
            Caption = 'Ano Final:'
          end
          object Label205: TLabel
            Left = 36
            Top = 35
            Width = 33
            Height = 14
            Caption = 'Marca:'
          end
          object Label206: TLabel
            Left = 31
            Top = 59
            Width = 37
            Height = 14
            Alignment = taRightJustify
            Caption = 'Modelo:'
          end
          object Label207: TLabel
            Left = 16
            Top = 83
            Width = 52
            Height = 14
            Alignment = taRightJustify
            Caption = 'Ano Inicial:'
          end
          object Label208: TLabel
            Left = 249
            Top = 83
            Width = 61
            Height = 14
            Caption = 'Combust'#237'vel:'
          end
          object Label209: TLabel
            Left = 30
            Top = 107
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'V'#225'lvula:'
          end
          object Label210: TLabel
            Left = 133
            Top = 107
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cilindrada:'
          end
          object Label211: TLabel
            Left = 264
            Top = 107
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Pot'#234'ncia:'
          end
          object Label212: TLabel
            Left = 61
            Top = 6
            Width = 383
            Height = 14
            Caption = 
              'Para carregar dados do veiculo j'#225' definido em outro produto, cli' +
              'que no bot'#227'o >>'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object btnCarregaModeloVeiculoExistente: TSpeedButton
            Left = 450
            Top = 2
            Width = 153
            Height = 24
            Caption = 'Carregar pr'#233'-e&xistente'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000005139
              2270A27244E06B4B2D9400000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000A272
              44E0B8824DFFB8824DFF5D422781000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000006B4B
              2D94B8824DFFB8824DFFB8824DFF5D4227810000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00005B40267EB8824DFFB8824DFFB8824DFF5D42278100000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000005B40267EB8824DFFB8824DFFB8824DFF7E5935AE7B5734ABA675
              45E6A67545E67B5734AB422F1C5C010100010000000000000000000000000000
              000000000000000000005B40267EB8824DFFB8824DFFB8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFF5C4127800101000100000000000000000000
              00000000000000000000000000007D5834ADB8824DFFB8824DFF5C41267F1E15
              0D2A1E150D2A5C41267FA57545E5B8824DFF422F1C5C00000000000000000000
              00000000000000000000000000007B5734ABB8824DFF5C41267F000000000000
              000000000000000000005C41267FB8824DFF7B5734AB00000000000000000000
              0000000000000000000000000000A67545E6B8824DFF1E150D2A000000000000
              000000000000000000001E150D2AB8824DFFA67545E600000000000000000000
              0000000000000000000000000000A67545E6B8824DFF1E150D2A000000000000
              000000000000000000001E150D2AB8824DFFA67545E600000000000000000000
              00000000000000000000000000007B5734ABB8824DFF5C41267F000000000000
              000000000000000000005C41267FB8824DFF7B5734AB00000000000000000000
              0000000000000000000000000000422F1C5CB8824DFFA57545E55C41267F1E15
              0D2A1E150D2A5C41267FA57545E5B8824DFF422F1C5C00000000000000000000
              0000000000000000000000000000010100015C412780B8824DFFB8824DFFB882
              4DFFB8824DFFB8824DFFB8824DFF5C4127800101000100000000000000000000
              00000000000000000000000000000000000001010001422F1C5C7B5734ABA675
              45E6A67545E67B5734AB422F1C5C010100010000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            OnClick = btnCarregaModeloVeiculoExistenteClick
          end
          object Label215: TLabel
            Left = 27
            Top = 131
            Width = 41
            Height = 14
            Alignment = taRightJustify
            Caption = 'Observ.:'
          end
          object mskAnoInicial: TMaskEditFocus
            Tag = 99
            Left = 72
            Top = 75
            Width = 56
            Height = 22
            EditMask = '9999;1;_'
            MaxLength = 4
            TabOrder = 2
            Text = '    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtValvula: TEditFocus
            Tag = 99
            Left = 72
            Top = 99
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 3
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object edtCilindrada: TEditFocus
            Tag = 99
            Left = 186
            Top = 99
            Width = 57
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object edtPotencia: TEditFocus
            Tag = 99
            Left = 314
            Top = 99
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            MaxLength = 5
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttInteiro
          end
          object mskAnoFin: TMaskEditFocus
            Tag = 99
            Left = 186
            Top = 75
            Width = 57
            Height = 22
            EditMask = '9999;1;_'
            MaxLength = 4
            TabOrder = 3
            Text = '    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object btnAddRelacionamentoProdutoVeiculo: TBitBtnLocked
            Left = 450
            Top = 122
            Width = 78
            Height = 24
            Caption = 'Adiciona&r'
            TabOrder = 9
            OnClick = btnAddRelacionamentoProdutoVeiculoClick
          end
          object cmbCombustivel: TComboBoxFocus
            Left = 314
            Top = 75
            Width = 134
            Height = 22
            Style = csOwnerDrawFixed
            TabOrder = 4
            Items.Strings = (
              ''
              'Etanol'
              'Gasolina'
              'GNV'
              'Diesel'
              'Flex'
              'Eletrico')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object btnCancelar: TBitBtnLocked
            Left = 529
            Top = 122
            Width = 78
            Height = 24
            Caption = 'Cance&lar'
            TabOrder = 10
            OnClick = btnCancelarClick
          end
          object edtDescModVei: TEditFocus
            Tag = 99
            Left = 72
            Top = 51
            Width = 376
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 1
            OnKeyPress = edtModeloVeiculoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 40
            TipoTexto = ttAlfanumerico
          end
          object edtDescMarVei: TEditFocus
            Tag = 99
            Left = 72
            Top = 27
            Width = 376
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 0
            OnKeyPress = edtMarcaVeiculoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 40
            TipoTexto = ttAlfanumerico
          end
          object chkLimpaCamposVeiculo: TCheckBox
            Left = 454
            Top = 32
            Width = 193
            Height = 17
            Caption = 'Limpar campos ap'#243's adicionar?'
            Checked = True
            State = cbChecked
            TabOrder = 11
          end
          object edtObservacoes: TEditFocus
            Tag = 99
            Left = 72
            Top = 123
            Width = 376
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 100
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 40
            TipoTexto = ttAlfanumerico
          end
        end
      end
    end
    object tbsAtributos: TTabSheet
      Caption = '20 - Dados T'#233'cnicos - Atributos do Produto'
      ImageIndex = 20
      object lblDetUti: TLabel
        Left = 15
        Top = 376
        Width = 108
        Height = 42
        Alignment = taRightJustify
        Caption = 'Detalhes da utiliza'#231#227'o:'#13#10'Pressione TAB'#13#10'para o proximo campo'
      end
      object lblPatVid: TLabel
        Left = 15
        Top = 494
        Width = 227
        Height = 14
        Alignment = taRightJustify
        Caption = 'Arquivo de V'#237'deo de apresenta'#231#227'o do produto:'
      end
      object gpbAtributos: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 764
        Height = 358
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Atributos:'
        TabOrder = 0
        object pnlBotoesAtributos: TPanel
          Left = 2
          Top = 309
          Width = 760
          Height = 47
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object Label1770: TLabel
            Left = 11
            Top = 17
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Novo atributo:'
          end
          object edtCodAtri: TEditFocus
            Tag = 99
            Left = 79
            Top = 10
            Width = 52
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 0
            OnEnter = edtCodAtriEnter
            OnExit = edtCodAtriExit
            OnKeyPress = edtCodAtriKeyPress
            OnKeyUp = edtCodAtriKeyUp
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttInteiro
          end
          object edtDesAtri: TEditFocus
            Left = 132
            Top = 10
            Width = 225
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Color = 16768952
            Enabled = False
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
          object btnIncluiAtrib: TBitBtnLocked
            Left = 359
            Top = 9
            Width = 98
            Height = 24
            Caption = 'Incluir Atributo'
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
            TabOrder = 2
            TabStop = False
            OnClick = btnIncluiAtribClick
          end
          object btnExcluiAtrib: TBitBtnLocked
            Left = 560
            Top = 9
            Width = 105
            Height = 24
            Caption = 'Excluir Atributo'
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
            TabOrder = 3
            TabStop = False
            OnClick = btnExcluiAtribClick
          end
        end
        object cxdAtributos: TcxDBVerticalGrid
          AlignWithMargins = True
          Left = 5
          Top = 19
          Width = 754
          Height = 287
          BorderStyle = cxcbsNone
          Align = alClient
          LayoutStyle = lsMultiRecordView
          LookAndFeel.ScrollbarMode = sbmClassic
          OptionsView.BandsInterval = 0
          OptionsView.RowHeaderWidth = 355
          OptionsView.ValueWidth = 300
          OptionsView.RecordsInterval = 10
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.GoToNextCellOnTab = True
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsData.CancelOnExit = False
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          Styles.Background = cxsColunaFixa
          TabOrder = 0
          DataController.GridMode = True
          Version = 1
        end
      end
      object dbeDetUti: TDBMemoFocus
        Left = 129
        Top = 376
        Width = 640
        Height = 106
        DataField = 'ITE_DETUTI'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
        OnEnter = dbeDetUtiEnter
        OnKeyPress = dbeDetUtiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object dbePatVid: TDBEditFocus
        Tag = 99
        Left = 246
        Top = 489
        Width = 498
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_PATVID'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object btnPatVid: TcxButton
        Left = 745
        Top = 488
        Width = 24
        Height = 24
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
          526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000022249444154
          785EA593BD6B545110C57F6FF3242AA9B412144B3FB1500CA20663FC032C6C44
          B0B010041194147616366295805A88A058898D8D106C444D6C44123426120959
          36B8316FD9F8F2B15F6FDFBD7746B9EFAD82019B1CB81C6698397366E006AACA
          461000859CC959F327FC079DC1E1C4C381D785807EB21815A827E642DF8DB1E7
          E30F4E8BA2A0CA1F12A5F7FA281D8488F61FBAFC940C8A6DD5987A76F3DE9D4B
          FB468F5C7D53653D0470B94B426704DC2AA4DF517184380E9EBBB6DD99E1F2A9
          03DB4072BB0AA2608C1B1BB8F5E10C6032012BA00E5C422016D4D2250D0E5F1C
          24E8DE0104A00208AA8ED1BB57FA80AEBF02A9CB046C82DA26625BE00CD4CBA8
          CF1B54F21A1556AB75809E20080A800BDEDD3EA67D8343C8CA272AD3E3C40B15
          54404510C92EA7A28888E7A5F92AEAD38A38AD862675B4E28864A1C872D460FF
          F961BC786E1B71A85A108B3A8B8A0149894BDF78FB6868DEAFB05A2E11CFCCD2
          B3AB174D221AB32F51DF90DD47457C8C737E1D114769B2CCCA9A19094DDBB154
          9A632D5A66E7F1BDB42BD3D85ADC29CC9A54C04F17C40B0951B1C29772FD4598
          B62D4B73737477F7B0796B487D6602DB58F6D63B2E347391E71CB59536F1CFC6
          D7FBEFA362D86AA4B018B1E7C44992C529926AD14F50BF7BA749BD082A5EA8BA
          9010D7CD0860C24633FD88AB1D9D1C79C5647E5D72560001505401554421B55A
          FEFCA3F9184803600BB00928B01EC13FB10206489E9CDDED0036FC9D7F01FAB6
          A14B22EE620A0000000049454E44AE426082}
        TabOrder = 3
        TabStop = False
        OnClick = btnPatVidClick
      end
    end
    object tbsIteCom: TTabSheet
      Caption = '21 - Comiss'#227'o'
      ImageIndex = 21
      object dbgIteCom: TcxGrid
        Left = 0
        Top = 0
        Width = 1010
        Height = 696
        Align = alClient
        TabOrder = 0
        object dbgIteComDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object dbgIteComDBTableViewColumn1: TcxGridDBColumn
            Caption = 'Tabela'
            DataBinding.FieldName = 'COM_TABPRE'
            Options.Editing = False
            Width = 63
          end
          object dbgIteComDBTableViewColumn2: TcxGridDBColumn
            Caption = '% Vendedor Interno'
            DataBinding.FieldName = 'COM_VENINT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '0.00 %;0.00 %'
            Properties.MaxValue = 100.000000000000000000
            Properties.Nullable = False
            Properties.Nullstring = '0.00'
            Properties.UseNullString = True
            Properties.ValidationOptions = []
            Properties.OnValidate = dbgIteComDBTableViewColumn2PropertiesValidate
            Width = 117
          end
          object dbgIteComDBTableViewColumn3: TcxGridDBColumn
            Caption = '% Vendedor Externo'
            DataBinding.FieldName = 'COM_VENEXT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.AssignedValues.MinValue = True
            Properties.DisplayFormat = '0.00 %;0.00 %'
            Properties.MaxValue = 100.000000000000000000
            Properties.Nullable = False
            Properties.Nullstring = '0.00'
            Properties.UseNullString = True
            Properties.ValidationOptions = []
            Properties.OnValidate = dbgIteComDBTableViewColumn3PropertiesValidate
            Width = 179
          end
        end
        object dbgIteComLevel1: TcxGridLevel
          GridView = dbgIteComDBTableView
        end
      end
    end
    object tbsControlePallet: TTabSheet
      Caption = '22 - Controle de Pallet do produto por Fornecedor'
      ImageIndex = 21
      object cxgPalett: TcxGrid
        Left = 0
        Top = 80
        Width = 1010
        Height = 597
        Align = alClient
        TabOrder = 0
        object cxvPalett: TcxGridDBTableView
          OnDblClick = cxvPalettDblClick
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsControlePallet
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxvPaleteCodFor: TcxGridDBColumn
            Caption = 'C'#243'd. Fornec.'
            DataBinding.FieldName = 'PAL_CODFOR'
            Options.Editing = False
            Width = 89
          end
          object cxvPalettColumn2: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'FOR_NOMFOR'
            Options.Editing = False
            Width = 221
          end
          object cxvPaleteQtdIIte: TcxGridDBColumn
            Caption = 'Qtd. de Itens por Pallet'
            DataBinding.FieldName = 'PAL_QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 124
          end
          object cxvPaleteValIte: TcxGridDBColumn
            Caption = 'Valor Por Palett'
            DataBinding.FieldName = 'PAL_VALPAL'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 109
          end
        end
        object cxlPalett: TcxGridLevel
          GridView = cxvPalett
        end
      end
      object Panel15: TPanel
        Left = 0
        Top = 677
        Width = 1010
        Height = 19
        Align = alBottom
        ParentColor = True
        TabOrder = 1
        object Label65: TLabel
          Left = 1
          Top = 1
          Width = 1008
          Height = 17
          Align = alClient
          Caption = '  [Duplo Clique] Para Editar     [Delete] Para Excluir'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 268
          ExplicitHeight = 14
        end
      end
      object Panel16: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 80
        Align = alTop
        TabOrder = 2
        object lblCodFornecedor: TLabel
          Left = 4
          Top = 4
          Width = 81
          Height = 14
          Caption = 'C'#243'd. Fornecedor'
        end
        object Label123: TLabel
          Left = 4
          Top = 41
          Width = 86
          Height = 14
          Caption = 'Qtd. Itens p/ Pallet'
        end
        object Label236: TLabel
          Left = 115
          Top = 41
          Width = 72
          Height = 14
          Caption = 'Valor por Pallet'
        end
        object edtDesForPal: TEditFocus
          Left = 95
          Top = 17
          Width = 434
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnGravaPalete: TBitBtnLocked
          Left = 186
          Top = 55
          Width = 89
          Height = 22
          Caption = 'Gravar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
            7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF313131726E726A66697D797A2929293838384242422828286868683131
            31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
            6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
            CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
            203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
            A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
            E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
            D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
            ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
            FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
            2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
            5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
            DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
            D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
            C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnGravaPaleteClick
        end
        object btnCancelPalete: TBitBtnLocked
          Left = 277
          Top = 55
          Width = 99
          Height = 22
          Caption = 'Cancelar'
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
          TabOrder = 5
          OnClick = btnCancelPaleteClick
        end
        object edtQtdItePal: TEditFocus
          Tag = 99
          Left = 4
          Top = 55
          Width = 86
          Height = 22
          Alignment = taRightJustify
          TabOrder = 1
          OnExit = edtQtdItePalExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtValPalet: TEditFocus
          Tag = 99
          Left = 96
          Top = 55
          Width = 86
          Height = 22
          Alignment = taRightJustify
          TabOrder = 2
          OnExit = edtValPaletExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtCodForPal: TEditFocus
          Tag = 99
          Left = 4
          Top = 17
          Width = 86
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          OnKeyPress = edtCodForPalKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttInteiro
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 961
    Top = 588
  end
  inherited ApplicationEvents: TApplicationEvents
    OnDeactivate = ApplicationEventsDeactivate
    Left = 658
    Top = 476
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 624
  end
  object dtsCadIte: TDataSource
    OnStateChange = dtsCadIteStateChange
    OnDataChange = dtsCadIteDataChange
    Left = 826
    Top = 456
  end
  object dtsIteGer: TDataSource
    Left = 402
    Top = 360
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpAuto
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
    Left = 608
    Top = 360
  end
  object cxedtRepository: TcxEditRepository
    Left = 448
    Top = 360
    PixelsPerInch = 96
    object cxredtDesMax: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '% ,0.00;-% ,0.00'
      Properties.MaxValue = 100.000000000000000000
      Properties.OnValidate = cxredtDesMaxPropertiesValidate
    end
  end
  object popMaisInfo: TPopupMenu
    Left = 545
    Top = 456
    object mnuEmprestimos: TMenuItem
      Caption = 'Empr'#233'stimos'
      OnClick = mnuEmprestimosClick
    end
    object mnuPreparaGerTE: TMenuItem
      Caption = 'Prepara Gera'#231#227'o TE'
      OnClick = mnuPreparaGerTEClick
    end
    object mnuProdutosAcabados: TMenuItem
      Caption = 'Produtos Acabados'
      OnClick = mnuProdutosAcabadosClick
    end
    object mnuPromocoes: TMenuItem
      Caption = 'Promo'#231#245'es'
      OnClick = mnuPromocoesClick
    end
    object FichaKardex1: TMenuItem
      Caption = 'Ficha Kardex'
      OnClick = FichaKardex1Click
    end
    object mnuConstrucaodoPreodeCusto: TMenuItem
      Caption = 'Constru'#231#227'o do Pre'#231'o do Produto'
      OnClick = mnuConstrucaodoPreodeCustoClick
    end
    object mnuSemelhantes: TMenuItem
      Caption = 'Semelhantes'
      OnClick = mnuSemelhantesClick
    end
  end
  object cxStyleRepositoryAtr: TcxStyleRepository
    Left = 736
    Top = 272
    PixelsPerInch = 96
    object cxsColunaFixa: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsColunaFixaDestaque: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxsTitulo: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 14347226
      TextColor = clBlue
    end
    object cxsNegrito: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsControlePallet: TDataSource
    Left = 500
    Top = 392
  end
  object cxedtRepositoryAtr: TcxEditRepository
    Left = 760
    Top = 368
    PixelsPerInch = 96
    object cxEditRepositoryCurrencyItem1: TcxEditRepositoryCurrencyItem
      Properties.AssignedValues.MinValue = True
      Properties.DisplayFormat = '% ,0.00;-% ,0.00'
      Properties.MaxValue = 100.000000000000000000
      Properties.OnValidate = cxredtDesMaxPropertiesValidate
    end
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 528
    Top = 360
    PixelsPerInch = 96
    object cxStyleZebra: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object dtsLoteRastreamento: TDataSource
    Left = 873
    Top = 583
  end
  object dtsPermissaoVenda: TDataSource
    Left = 725
    Top = 385
  end
  object openPatVid: TOpenDialog
    DefaultExt = '*.mp4'
    FileName = 'C:\Users\joao.catarino.CITEL\Videos\teste.avi'
    Filter = 
      'Arquivo AVI|*.avi|Arquivo MP4|*.mp4|Arquivo MOV|*.mov|Arquivo WM' +
      'V|*.wmv'
    Left = 748
    Top = 540
  end
end
