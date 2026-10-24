inherited frmCadLocFisica: TfrmCadLocFisica
  Width = 670
  Height = 560
  Caption = 'Cadastro de Localiza'#231#227'o F'#237'sica'
  OnDestroy = FormDestroy
  ExplicitWidth = 670
  ExplicitHeight = 560
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 488
    Width = 664
    Height = 27
    TabOrder = 3
    ExplicitTop = 488
    ExplicitWidth = 664
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 588
      Height = 23
      ExplicitTop = 2
      ExplicitWidth = 588
      ExplicitHeight = 23
      inherited btnIncluir: TBitBtnLocked
        Width = 75
        Height = 23
        Align = alLeft
        ExplicitWidth = 75
        ExplicitHeight = 23
      end
      inherited btnGravar: TBitBtnLocked
        Left = 75
        Width = 75
        Height = 23
        Align = alLeft
        ExplicitLeft = 75
        ExplicitWidth = 75
        ExplicitHeight = 23
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 75
        Height = 23
        Align = alLeft
        ExplicitLeft = 150
        ExplicitWidth = 75
        ExplicitHeight = 23
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 225
        Width = 75
        Height = 23
        Align = alLeft
        ExplicitLeft = 225
        ExplicitWidth = 75
        ExplicitHeight = 23
      end
      inherited btnCancela: TBitBtnLocked
        Left = 300
        Width = 75
        Height = 23
        Align = alLeft
        ExplicitLeft = 300
        ExplicitWidth = 75
        ExplicitHeight = 23
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 375
        Width = 75
        Height = 23
        Align = alLeft
        ExplicitLeft = 375
        ExplicitWidth = 75
        ExplicitHeight = 23
      end
      object btnImportarPlanilha: TBitBtnLocked
        Left = 450
        Top = 0
        Width = 112
        Height = 23
        Align = alLeft
        Caption = 'Importar Planilha'
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
        TabOrder = 6
        OnClick = btnImportarPlanilhaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 590
      Width = 72
      Height = 23
      Align = alRight
      ExplicitLeft = 590
      ExplicitWidth = 72
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 515
    Width = 664
    TabOrder = 4
    ExplicitTop = 515
    ExplicitWidth = 664
    inherited pnlNomeForm: TPanel
      Left = 317
      ExplicitLeft = 317
    end
    inherited pnlInfo: TPanel
      Width = 317
      ExplicitWidth = 317
    end
  end
  inherited pgcDados: TPageControl
    Top = 488
    Width = 664
    Height = 0
    Align = alBottom
    ExplicitTop = 488
    ExplicitWidth = 664
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 656
      ExplicitHeight = 226
    end
  end
  object pnlCabecalho: TPanel [3]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 658
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 28
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 38
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object pnlOpcoes: TPanel
      Left = 202
      Top = 10
      Width = 372
      Height = 17
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object dbckbAtivo: TDBCheckBox
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 52
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Ativo'
        DataField = 'LOC_ATIVO_'
        DataSource = dtsCadLoc
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbckbCritico: TDBCheckBox
        AlignWithMargins = True
        Left = 52
        Top = 0
        Width = 118
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Localiza'#231#227'o Cr'#237'tica'
        DataField = 'LOC_CRITIC'
        DataSource = dtsCadLoc
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbCkbTransitoria: TDBCheckBox
        AlignWithMargins = True
        Left = 170
        Top = 0
        Width = 78
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Transit'#243'ria'
        DataField = 'LOC_TRANSI'
        DataSource = dtsCadLoc
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dbCkbBalcao: TDBCheckBox
        AlignWithMargins = True
        Left = 248
        Top = 0
        Width = 59
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Balc'#227'o'
        DataField = 'LOC_BALCAO'
        DataSource = dtsCadLoc
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object dbeCodLoc: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 8
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LOC_CODLOC'
      DataSource = dtsCadLoc
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 32
      Width = 498
      Height = 22
      CharCase = ecUpperCase
      DataField = 'LOC_DESCRI'
      DataSource = dtsCadLoc
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object grpInformacoes: TcxGroupBox [4]
    AlignWithMargins = True
    Left = 3
    Top = 63
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Informa'#231#245'es'
    TabOrder = 1
    Height = 312
    Width = 658
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = -26
      Top = 79
      Width = 46
      Height = 22
      DataField = 'LOC_CODEMP'
      DataSource = dtsCadLoc
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      Visible = False
      OnKeyPress = dbeCodAmzKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object grpCaracteristicas: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 74
      Align = alTop
      Caption = 'Caracter'#237'sticas'
      TabOrder = 1
      Height = 185
      Width = 648
      object pnlArmazem: TPanel
        Left = 2
        Top = 19
        Width = 644
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlArmazem'
        TabOrder = 0
        object lblArmazem: TLabel
          Left = 53
          Top = 6
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Armaz'#233'm:'
        end
        object dbeCodAmz: TDBEditFocus
          Tag = 99
          Left = 104
          Top = 1
          Width = 46
          Height = 22
          DataField = 'LOC_CODAMZ'
          DataSource = dtsCadLoc
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = dbeCodAmzKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesAmz: TEditFocus
          Left = 150
          Top = 1
          Width = 407
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
      object pnlLocSep: TPanel
        Left = 2
        Top = 42
        Width = 644
        Height = 24
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label13: TLabel
          Left = 7
          Top = 6
          Width = 95
          Height = 14
          Alignment = taRightJustify
          Caption = 'Loc. de Separa'#231#227'o:'
        end
        object dbeCodLse: TDBEditFocus
          Tag = 99
          Left = 104
          Top = 1
          Width = 46
          Height = 22
          DataField = 'LOC_CODLSE'
          DataSource = dtsCadLoc
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = dbeCodLseKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesLse: TEditFocus
          Left = 150
          Top = 1
          Width = 407
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
      object pnlCapMaxRepo: TPanel
        Left = 2
        Top = 66
        Width = 644
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label8: TLabel
          Left = 3
          Top = 3
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Capacidade M'#225'xima:'
        end
        object Label7: TLabel
          Left = 239
          Top = 3
          Width = 99
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ponto de Reposi'#231#227'o:'
        end
        object dbeCapaci: TDBEditFocus
          Tag = 99
          Left = 104
          Top = 0
          Width = 130
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LOC_CAPACI'
          DataSource = dtsCadLoc
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbePonRep: TDBEditFocus
          Tag = 99
          Left = 340
          Top = 0
          Width = 217
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LOC_PONREP'
          DataSource = dtsCadLoc
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
      object pnlPesoLocDim: TPanel
        Left = 2
        Top = 88
        Width = 644
        Height = 94
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object Label16: TLabel
          Left = 153
          Top = 5
          Width = 11
          Height = 14
          Alignment = taRightJustify
          Caption = 'kg'
        end
        object Label14: TLabel
          Left = 49
          Top = 5
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Peso M'#225'x.:'
        end
        object grpDimensoes: TGroupBox
          Left = 408
          Top = 3
          Width = 149
          Height = 91
          Caption = 'Dimens'#245'es ( cm )'
          TabOrder = 2
          object Label72: TLabel
            Left = 34
            Top = 18
            Width = 41
            Height = 14
            Alignment = taRightJustify
            Caption = 'Largura:'
          end
          object lblPesLiq: TLabel
            Left = 43
            Top = 42
            Width = 32
            Height = 14
            Alignment = taRightJustify
            Caption = 'Altura:'
          end
          object Label3: TLabel
            Left = 8
            Top = 66
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Profundidade:'
            ParentShowHint = False
            ShowHint = False
          end
          object dbeLargur: TDBEditFocus
            Tag = 99
            Left = 79
            Top = 15
            Width = 62
            Height = 22
            CharCase = ecUpperCase
            DataField = 'LOC_LARGUR'
            DataSource = dtsCadLoc
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeAltura: TDBEditFocus
            Tag = 99
            Left = 79
            Top = 39
            Width = 62
            Height = 22
            CharCase = ecUpperCase
            DataField = 'LOC_ALTURA'
            DataSource = dtsCadLoc
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeProfun: TDBEditFocus
            Tag = 99
            Left = 79
            Top = 63
            Width = 62
            Height = 22
            CharCase = ecUpperCase
            DataField = 'LOC_PROFUN'
            DataSource = dtsCadLoc
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object dbePesMax: TDBEditFocus
          Tag = 99
          Left = 104
          Top = 1
          Width = 46
          Height = 22
          CharCase = ecUpperCase
          DataField = 'LOC_PESMAX'
          DataSource = dtsCadLoc
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object pnlPrdDif: TPanel
          Left = 21
          Top = 49
          Width = 365
          Height = 45
          BevelOuter = bvNone
          TabOrder = 3
          object Label4: TLabel
            Left = 3
            Top = 23
            Width = 177
            Height = 14
            Alignment = taRightJustify
            Caption = 'Taxa de ocupa'#231#227'o m'#225'xima permitida:'
            ParentShowHint = False
            ShowHint = True
          end
          object dbckbPdeRpd: TDBCheckBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 359
            Height = 19
            Align = alTop
            Caption = 'Permite receber produtos diferentes?'
            DataField = 'LOC_PDERPD'
            DataSource = dtsCadLoc
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dbeTaxaOcpMax: TDBEditFocus
            Tag = 99
            Left = 186
            Top = 20
            Width = 62
            Height = 22
            CharCase = ecUpperCase
            DataField = 'LOC_TXOMAX'
            DataSource = dtsCadLoc
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 3
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object grpPicking: TGroupBox
          Left = 170
          Top = 3
          Width = 235
          Height = 49
          Caption = 'Tipo de Localiza'#231#227'o'
          TabOrder = 1
          OnExit = grpPickingExit
          object rbPicking: TRadioButton
            Left = 8
            Top = 13
            Width = 54
            Height = 17
            Caption = 'Picking'
            TabOrder = 0
          end
          object rbBuffer: TRadioButton
            Left = 87
            Top = 13
            Width = 52
            Height = 17
            Caption = 'Buffer'
            TabOrder = 1
          end
          object rbExcesso: TRadioButton
            Left = 163
            Top = 13
            Width = 63
            Height = 17
            Caption = 'Excesso'
            TabOrder = 2
          end
          object rbPickingCheckOut: TRadioButton
            Left = 8
            Top = 30
            Width = 106
            Height = 17
            Caption = 'Picking Check-out'
            TabOrder = 3
          end
          object rbPickingLabor: TRadioButton
            Left = 114
            Top = 30
            Width = 112
            Height = 17
            Caption = 'Picking Laborat'#243'rio'
            TabOrder = 4
          end
        end
      end
    end
    object grpEndereco: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 19
      Margins.Top = 0
      Align = alTop
      Caption = 'Endere'#231'o'
      TabOrder = 0
      Height = 49
      Width = 648
      object Label9: TLabel
        Left = 96
        Top = 19
        Width = 22
        Height = 14
        Alignment = taRightJustify
        Caption = 'Rua:'
      end
      object Label10: TLabel
        Left = 175
        Top = 19
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pr'#233'dio:'
      end
      object Label11: TLabel
        Left = 267
        Top = 19
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Andar:'
      end
      object Label12: TLabel
        Left = 355
        Top = 19
        Width = 65
        Height = 14
        Alignment = taRightJustify
        Caption = 'Apartamento:'
      end
      object dbeRua: TDBEditFocus
        Tag = 99
        Left = 120
        Top = 16
        Width = 47
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LOC_R_U_A_'
        DataSource = dtsCadLoc
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePredio: TDBEditFocus
        Tag = 99
        Left = 210
        Top = 16
        Width = 47
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LOC_PREDIO'
        DataSource = dtsCadLoc
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeAndar: TDBEditFocus
        Tag = 99
        Left = 302
        Top = 16
        Width = 47
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LOC_ANDAR_'
        DataSource = dtsCadLoc
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeApartamento: TDBEditFocus
        Tag = 99
        Left = 422
        Top = 16
        Width = 47
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LOC_APARTA'
        DataSource = dtsCadLoc
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object grpProduto: TcxGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 262
      Margins.Top = 0
      Align = alTop
      Caption = 'Produto'
      TabOrder = 2
      Height = 45
      Width = 648
      object Label15: TLabel
        Left = 60
        Top = 19
        Width = 40
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto:'
      end
      object dbeItePic: TDBEditFocus
        Tag = 99
        Left = 106
        Top = 16
        Width = 46
        Height = 22
        CharCase = ecUpperCase
        DataField = 'LOC_ITEPIC'
        DataSource = dtsCadLoc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeItePicKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtDesIte: TEditFocus
        Left = 152
        Top = 16
        Width = 393
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
  end
  object pnlObservacao: TPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 380
    Width = 658
    Height = 82
    Margins.Top = 0
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object Label59: TLabel
      Left = 47
      Top = 3
      Width = 63
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#227'o:'
    end
    object dbeObserv: TDBMemoFocus
      Left = 116
      Top = 0
      Width = 439
      Height = 67
      DataField = 'LOC_OBSERV'
      DataSource = dtsCadLoc
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      OnKeyPress = dbeObservKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 176
  end
  object dtsCadLoc: TDataSource
    Left = 504
    Top = 136
  end
end
