inherited frmManOrdProIndustrial: TfrmManOrdProIndustrial
  Width = 1168
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Manuten'#231#227'o da Ordem de Produ'#231#227'o'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1168
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 1152
    ExplicitTop = 517
    ExplicitWidth = 1152
    inherited FlwBotoes: TFlowPanel
      Width = 1071
      ExplicitTop = 2
      ExplicitWidth = 1071
      inherited btnIncluir: TBitBtnLocked
        Tag = 88
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Tag = 88
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Tag = 88
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Tag = 88
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Tag = 88
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Tag = 88
        Width = 78
        Height = 24
        ExplicitWidth = 78
        ExplicitHeight = 24
      end
      object btnImprimir: TBitBtnLocked
        Left = 438
        Top = 0
        Width = 77
        Height = 24
        Caption = 'Im&primir'
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
        TabOrder = 6
        OnClick = btnImprimirClick
      end
      object btnLoteMP: TBitBtnLocked
        Left = 515
        Top = 0
        Width = 77
        Height = 24
        Caption = '&Lotes M.P.'
        TabOrder = 7
        OnClick = btnLoteMPClick
      end
      object btnGirEstoque: TBitBtnLocked
        Left = 592
        Top = 0
        Width = 151
        Height = 24
        Caption = 'Gir. Estoq &Venda 12 Meses'
        TabOrder = 8
        OnClick = btnGirEstoqueClick
      end
      object btnAtualProdAcabado: TBitBtnLocked
        Left = 743
        Top = 0
        Width = 151
        Height = 24
        Caption = 'Atualiza Produtos Acabados'
        TabOrder = 9
        Visible = False
        OnClick = btnAtualProdAcabadoClick
      end
      object btnEtiquetas: TBitBtnLocked
        Left = 894
        Top = 0
        Width = 77
        Height = 24
        Align = alLeft
        Caption = '[F3] Etiqueta'
        TabOrder = 10
        OnClick = btnEtiquetasClick
      end
      object btnFormulas: TBitBtnLocked
        Left = 971
        Top = 0
        Width = 89
        Height = 24
        Align = alLeft
        Caption = '[F4] F'#243'rmulas'
        TabOrder = 11
        OnClick = btnFormulasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1073
      Height = 24
      Align = alRight
      ExplicitLeft = 1073
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1152
    ExplicitTop = 545
    ExplicitWidth = 1152
    inherited pnlNomeForm: TPanel
      Left = 805
      ExplicitLeft = 805
    end
    inherited pnlInfo: TPanel
      Width = 805
      ExplicitWidth = 805
    end
  end
  inherited pgcDados: TPageControl
    Width = 1152
    Height = 517
    OnChange = pgcDadosChange
    ExplicitWidth = 1152
    ExplicitHeight = 517
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1144
      ExplicitHeight = 485
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 1144
        Height = 485
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlCabec: TPanel
          Left = 0
          Top = 0
          Width = 1144
          Height = 65
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label2: TLabel
            Left = 17
            Top = 16
            Width = 40
            Height = 14
            Alignment = taRightJustify
            Caption = 'Produto:'
          end
          object Label3: TLabel
            Left = 37
            Top = 41
            Width = 20
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cor:'
          end
          object Label1: TLabel
            Left = 653
            Top = 16
            Width = 68
            Height = 14
            Caption = 'C'#243'digo da OP:'
          end
          object Label6: TLabel
            Left = 513
            Top = 41
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data de Previs'#227'o:'
          end
          object lblDtaVal: TLabel
            Left = 679
            Top = 41
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data de Validade:'
          end
          object dbeCodIte: TDBEditFocus
            Tag = 99
            Left = 60
            Top = 13
            Width = 50
            Height = 22
            DataField = 'ORD_CODITE'
            DataSource = dtsTabela
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = dbeCodIteKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtDesIte: TEditFocus
            Left = 111
            Top = 13
            Width = 537
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
          object dbeCodCor: TDBEditFocus
            Tag = 99
            Left = 60
            Top = 37
            Width = 50
            Height = 22
            DataField = 'ORD_CODCOR'
            DataSource = dtsTabela
            MaxLength = 4
            TabOrder = 2
            OnKeyPress = dbeCodCorKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtDesCor: TEditFocus
            Left = 111
            Top = 37
            Width = 396
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
          object dbeCodOrd: TDBEditFocus
            Left = 725
            Top = 13
            Width = 39
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'ORD_CODORD'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 4
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaCad: TDBEditFocus
            Left = 765
            Top = 13
            Width = 64
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'ORD_DTACAD'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaPre: TDBEditFocus
            Tag = 99
            Left = 604
            Top = 37
            Width = 64
            Height = 22
            DataField = 'ORD_DTAPRE'
            DataSource = dtsTabela
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaVal: TDBEditFocus
            Tag = 99
            Left = 766
            Top = 37
            Width = 64
            Height = 22
            DataField = 'ORD_DTAVAL'
            DataSource = dtsTabela
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object cxgItens: TcxGrid
          Left = 0
          Top = 184
          Width = 1144
          Height = 272
          Align = alClient
          TabOrder = 1
          OnEnter = cxgItensEnter
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgItensView: TcxGridDBTableView
            OnKeyDown = cxgItensViewKeyDown
            Navigator.Buttons.CustomButtons = <>
            FilterBox.Visible = fvNever
            OnCustomDrawCell = cxgItensViewCustomDrawCell
            OnEditKeyDown = cxgItensViewEditKeyDown
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = ' '
            OptionsView.ShowEditButtons = gsebAlways
            OptionsView.GroupByBox = False
            object cxgItensViewColumn1: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'ORD_CODITE'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Focusing = False
              Width = 50
            end
            object cxgItensViewColumn2: TcxGridDBColumn
              Caption = 'Descri'#231#227'o do Produto'
              DataBinding.FieldName = 'DESITE'
              Options.Editing = False
              Options.Focusing = False
              SortIndex = 0
              SortOrder = soAscending
              Width = 370
            end
            object cxgItensViewColumn4: TcxGridDBColumn
              Caption = 'Marca'
              DataBinding.FieldName = 'DESMAR'
              Options.Editing = False
              Options.Focusing = False
              Width = 125
            end
            object cxgItensViewColumn3: TcxGridDBColumn
              Caption = 'Unid.'
              DataBinding.FieldName = 'SIGUNI'
              GroupSummaryAlignment = taCenter
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Options.Focusing = False
              Width = 39
            end
            object cxgItensESTOQUE_MAXIMO: TcxGridDBColumn
              Caption = 'Est.M'#225'x'
              DataBinding.FieldName = 'ESTOQUE_MAXIMO'
              Options.Editing = False
              Options.Focusing = False
            end
            object cxgItensESTOQUE_MINIMO: TcxGridDBColumn
              Caption = 'Est.M'#237'n'
              DataBinding.FieldName = 'ESTOQUE_MINIMO'
              Options.Editing = False
              Options.Focusing = False
            end
            object cxgItensESTOQUE_FISICO: TcxGridDBColumn
              Caption = 'Est.F'#237'sico'
              DataBinding.FieldName = 'ESTOQUE_FISICO'
              Options.Editing = False
              Options.Focusing = False
            end
            object cxgItensESTOQUE_DISPONIVEL: TcxGridDBColumn
              Caption = 'Est.Disp'
              DataBinding.FieldName = 'ESTOQUE_DISPONIVEL'
              Options.Editing = False
              Options.Focusing = False
            end
            object cxgItensCAPMAX: TcxGridDBColumn
              Caption = 'Sug. Capacidade M'#225'x.'
              DataBinding.FieldName = 'SUGMAX'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Options.Editing = False
              Options.Focusing = False
              Width = 118
            end
            object cxgItensQTDPRO: TcxGridDBColumn
              Caption = 'Qtd. Produzir'
              DataBinding.FieldName = 'ORD_QTDPRO'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DecimalPlaces = 4
              Properties.DisplayFormat = '0.0000'
              FooterAlignmentHorz = taRightJustify
              HeaderAlignmentHorz = taRightJustify
              Width = 72
            end
            object cxgItensCOMPOSICAO: TcxGridDBColumn
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Caption = 'Composi'#231#227'o'
                  Default = True
                  Kind = bkText
                  Width = 75
                end>
              Properties.ViewStyle = vsButtonsOnly
              Properties.OnButtonClick = cxgItensCOMPOSICAOPropertiesButtonClick
              Width = 80
            end
            object cxgItensITE_CODPAG: TcxGridDBColumn
              DataBinding.FieldName = 'ITE_CODPAG'
              Visible = False
            end
          end
          object cxgItensLevel1: TcxGridLevel
            GridView = cxgItensView
          end
        end
        object pnlTotais: TPanel
          Left = 0
          Top = 140
          Width = 1144
          Height = 44
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object Label4: TLabel
            Left = 368
            Top = 6
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Volume Total (LT):'
          end
          object Label5: TLabel
            Left = 591
            Top = 6
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Peso Total (KG):'
          end
          object dbeVolume: TDBEditFocus
            Left = 454
            Top = 2
            Width = 100
            Height = 22
            Color = 16768952
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePeso: TDBEditFocus
            Left = 670
            Top = 2
            Width = 100
            Height = 22
            Color = 16768952
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object pnlCapacidadeMaxima: TPanel
            Left = 13
            Top = 1
            Width = 311
            Height = 40
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            object lblCapacidadeMaxima: TLabel
              Left = 4
              Top = 5
              Width = 189
              Height = 14
              Alignment = taRightJustify
              Caption = 'Capacidade M'#225'xima de Produ'#231#227'o (KG):'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeCapacidadeMaxima: TDBEditFocus
              Tag = 99
              Left = 195
              Top = 1
              Width = 113
              Height = 22
              Color = clWhite
              DataField = 'ORD_CAPMAX'
              DataSource = dtsTabela
              MaxLength = 10
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object chbUsaCapacidadeMaxima: TDBCheckBox
              Tag = 99
              Left = 4
              Top = 23
              Width = 229
              Height = 17
              Caption = 'Produzir com base na quantidade m'#225'xima'
              DataField = 'ORD_UQDMAX'
              DataSource = dtsTabela
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              OnClick = chbUsaCapacidadeMaximaClick
            end
          end
        end
        object pnlBaixa: TPanel
          Left = 0
          Top = 65
          Width = 1144
          Height = 75
          Align = alTop
          BevelInner = bvLowered
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          Visible = False
          object Label7: TLabel
            Left = 93
            Top = 13
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'In'#237'cio da Produ'#231#227'o:'
          end
          object Label8: TLabel
            Left = 328
            Top = 13
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'T'#233'mino da Produ'#231#227'o:'
          end
          object Label9: TLabel
            Left = 591
            Top = 13
            Width = 70
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data da Baixa:'
          end
          object imgLocFis: TImage
            Left = 8
            Top = 43
            Width = 16
            Height = 16
            Picture.Data = {
              0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
              0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
              4D410000B18F0BFC610500000012744558745469746C65005374617475733B46
              6C61673B83001E630000023849444154384F63F8FFFF3F4518CE58B9FD2C0310
              300231131A66AC5D60C95003C4D5F32D801848CFB360A802E2CAB9160803408A
              976C3AF17FF1C613FF671EB27B34EBB0DDB9D269E62BB3BA0C9D81722C6533CD
              194A679A3194CE30632801E1E9A60CC5D3CD500C609EB7EAD0FFD8FC49FF1FBE
              5BFFFFD6CB65FF8FDD9CF8BF7F6DD8FFC47ADD70A03C1B10337EF97798018473
              27188331B2012C3396EEF91F95DDF37FCDB9C8FF8F7EF6FF3FFC3CE5FFDA8BD1
              FF6BE7BAFC8CABD1693775939403AAE386624E20664636806DC2DCADFFC3D25B
              FFAF3E0B3160EF93F0FFF34E39FFAF5D66F9BF789AF9FFCC4E93FFD5F34D9E54
              CC36BE56BBC8F413D8202403D8BBA6ADFD1F9458FF7FD5E90814032A179BFE6F
              586EFB7FC601D7FF7BAE55FE3F7071E27F235FE193403D3CC8067034F52FFDEF
              1F5BF57F259A01C5F30CC1064CDDE7F07FD94597FFC1856A7F952DF8FC817AD8
              900DE0AC6A9FF3DF2BB2E47FDB52E7FF592DD6FF6D2225FE475468FE4FEAD0FA
              5FB3C8FA7FE53C93FF81858AFFB51D05BB81EA79819811D900EEA2DA49FFDD83
              73FE6B390B1CD0B0174892D6E45653D413D072895358E19DA9F24ED74DF8A4B2
              197F02502D3F1033990588A3C4026F5649E77F57FF341047188859408AA0340F
              108B00B12010730031A359A004837990248A017C4939F5FF1DBC12401C7E9838
              218C6030300844A594FEB7758B0271049015E1C30806D079419139FFAD9D4240
              1C216445F830820174B6B99DFF7F1006B19115E1C3080624B004A0981559116E
              FC9F01004C3407DB45CA6A650000000049454E44AE426082}
            Visible = False
          end
          object lblTitLocFis: TLabel
            Left = 28
            Top = 38
            Width = 160
            Height = 14
            Caption = 'Localiza'#231#227'o f'#237'sica da amostra'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            Visible = False
          end
          object lblLocFis: TLabel
            Left = 28
            Top = 54
            Width = 49
            Height = 14
            Caption = 'lblLocFis'
            Font.Charset = ANSI_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object DBEditFocus1: TDBEditFocus
            Left = 187
            Top = 10
            Width = 64
            Height = 22
            Color = 16768952
            DataField = 'ORD_DTAINI'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus2: TDBEditFocus
            Left = 251
            Top = 10
            Width = 46
            Height = 22
            Color = 16768952
            DataField = 'ORD_HORINI'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus3: TDBEditFocus
            Left = 432
            Top = 10
            Width = 64
            Height = 22
            Color = 16768952
            DataField = 'ORD_DTAFIN'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus4: TDBEditFocus
            Left = 496
            Top = 10
            Width = 46
            Height = 22
            Color = 16768952
            DataField = 'ORD_HORFIN'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object DBEditFocus5: TDBEditFocus
            Left = 664
            Top = 10
            Width = 64
            Height = 22
            Color = 16768952
            DataField = 'ORD_DTABAI'
            DataSource = dtsTabela
            ReadOnly = True
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object prgProgresso: TProgressBar
          Left = 0
          Top = 474
          Width = 1144
          Height = 11
          Align = alBottom
          Smooth = True
          TabOrder = 4
          Visible = False
        end
        object pnlLegenda: TPanel
          Left = 0
          Top = 456
          Width = 1144
          Height = 18
          Align = alBottom
          TabOrder = 5
          object Label19: TLabel
            Left = 1034
            Top = 1
            Width = 109
            Height = 16
            Align = alRight
            AutoSize = False
            Caption = '[F1] - Composi'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 737
          end
        end
      end
    end
    object tbsFases: TTabSheet
      Caption = '&2 - Fases'
      ImageIndex = 1
      object cxgCadFas: TcxGrid
        Left = 0
        Top = 61
        Width = 1144
        Height = 381
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
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle1
          object cxgCadFasCODFAS: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'FAS_CODFAS'
            Options.Editing = False
            Width = 73
          end
          object cxgCadFasDESFAS: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da Fase'
            DataBinding.FieldName = 'FAS_DESFAS'
            Options.Editing = False
            Width = 565
          end
          object cxgCadFasUTILIS: TcxGridDBColumn
            Caption = 'Utiliza'
            DataBinding.FieldName = 'FAS_UTILIZ'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 84
          end
        end
        object cxgCadFasLevel1: TcxGridLevel
          GridView = cxgCadFasView
        end
      end
      object pnlBotoesFases: TPanel
        Left = 0
        Top = 442
        Width = 1144
        Height = 43
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btnMarcaTodos: TBitBtnLocked
          Left = 8
          Top = 11
          Width = 177
          Height = 22
          Caption = '&Marca Todos as Fases'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnMarcaTodosClick
        end
        object btnDesmarcaTodos: TBitBtnLocked
          Left = 189
          Top = 11
          Width = 192
          Height = 22
          Caption = '&Desmarca Todas as Fases'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF3333993333339993333377FF3333377FF3399993333339
            993337777FF3333377F3393999333333993337F777FF333337FF993399933333
            399377F3777FF333377F993339993333399377F33777FF33377F993333999333
            399377F333777FF3377F993333399933399377F3333777FF377F993333339993
            399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
            99333773FF3333777733339993333339933333773FFFFFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnDesmarcaTodosClick
        end
      end
      object mmoTravaFases: TMemo
        Left = 0
        Top = 0
        Width = 1144
        Height = 61
        Align = alTop
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Lines.Strings = (
          '                 '
          
            '                                           H'#225' Fases j'#225' iniciadas' +
            ' para essa Ordem de Produ'#231#227'o.'
          
            '                                    Para alterar as fases fa'#231'a o' +
            ' cancelamento do monitoramento.')
        ParentFont = False
        TabOrder = 2
        Visible = False
      end
    end
    object tbsFormula: TTabSheet
      Caption = '3 - F'#243'rmula'
      ImageIndex = 2
      object Splitter1: TSplitter
        Left = 0
        Top = 241
        Width = 1144
        Height = 4
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 747
      end
      object dbgOrdMat: TDBGridCitel
        Left = 0
        Top = 0
        Width = 1144
        Height = 241
        Align = alTop
        ImeName = ' '
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDrawColumnCell = dbgOrdMatDrawColumnCell
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = True
        Columns = <
          item
            Expanded = False
            FieldName = 'ITESUB'
            Title.Caption = 'Codigo'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Width = 366
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'QTDFOR'
            Title.Alignment = taCenter
            Title.Caption = '% Formula'
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QTDITE'
            Title.Caption = 'Quantidade'
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNITAR'
            Title.Caption = 'Custo'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTCUS'
            Title.Caption = 'Total'
            Width = 71
            Visible = True
          end>
      end
      object pnlBottom: TPanel
        Left = 0
        Top = 411
        Width = 1144
        Height = 74
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Label10: TLabel
          Left = 412
          Top = 7
          Width = 92
          Height = 14
          Alignment = taRightJustify
          Caption = 'Peso Real Formula:'
        end
        object shpCorrecao: TShape
          Left = 7
          Top = 5
          Width = 16
          Height = 16
          Brush.Color = 11777023
        end
        object Label11: TLabel
          Left = 28
          Top = 7
          Width = 51
          Height = 14
          Caption = 'Corre'#231#245'es'
        end
        object Label12: TLabel
          Left = 429
          Top = 54
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Peso Envasado:'
        end
        object Label13: TLabel
          Left = 417
          Top = 30
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Litros Envasados:'
        end
        object Label14: TLabel
          Left = 611
          Top = 7
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Custo:'
        end
        object Label15: TLabel
          Left = 600
          Top = 30
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Custo p/ Litro:'
        end
        object Label16: TLabel
          Left = 604
          Top = 54
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Custo p/ Kilo:'
        end
        object DBEditFocus6: TDBEditFocus
          Left = 510
          Top = 3
          Width = 67
          Height = 22
          Color = 16768952
          DataField = 'ORD_PESREA'
          DataSource = dtsTabela
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTotKil: TDBEditFocus
          Left = 510
          Top = 50
          Width = 67
          Height = 22
          Color = 16768952
          DataField = 'ORD_TOTKIL'
          DataSource = dtsTabela
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTotLil: TDBEditFocus
          Left = 510
          Top = 26
          Width = 67
          Height = 22
          Color = 16768952
          DataField = 'ORD_TOTLIT'
          DataSource = dtsTabela
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCusFor: TDBEditFocus
          Left = 670
          Top = 3
          Width = 67
          Height = 22
          Color = 16768952
          DataField = 'SUM_TOTCUS'
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCusLit: TEditFocus
          Left = 670
          Top = 26
          Width = 67
          Height = 22
          Alignment = taRightJustify
          Color = 16768952
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
        object edtCusKil: TEditFocus
          Left = 670
          Top = 50
          Width = 67
          Height = 22
          Alignment = taRightJustify
          Color = 16768952
          ReadOnly = True
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 245
        Width = 1144
        Height = 166
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object Label17: TLabel
          Left = 0
          Top = 0
          Width = 1144
          Height = 20
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'ENVASE'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 2
          ExplicitTop = 5
          ExplicitWidth = 745
        end
        object dbgEnvasados: TDBGridCitel
          Left = 0
          Top = 20
          Width = 1144
          Height = 146
          Align = alClient
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = 14
          TitleFont.Name = 'Arial'
          TitleFont.Pitch = fpVariable
          TitleFont.Style = []
          CorZebra = clMoneyGreen
          Zebra = True
          DestacarMouse = True
          Columns = <
            item
              Expanded = False
              FieldName = 'ORD_CODITE'
              Title.Caption = 'C'#243'digo'
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESITE'
              Title.Caption = 'Descri'#231#227'o'
              Width = 363
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SIGUNI'
              Title.Caption = 'UN'
              Width = 26
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORD_QTDENV'
              Title.Caption = 'Quantidade'
              Width = 72
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORD_VOLACA'
              Title.Caption = 'Volume'
              Width = 75
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ORD_PESACA'
              Title.Caption = 'Peso'
              Width = 70
              Visible = True
            end>
        end
      end
    end
    object tbsDescProdProducao: TTabSheet
      Caption = '4 - Descri'#231#227'o Procedimento Produ'#231#227'o'
      ImageIndex = 3
      object RichDescProcProducao: TRichEdit
        Left = 0
        Top = 0
        Width = 1144
        Height = 485
        Align = alClient
        ReadOnly = True
        TabOrder = 0
        Zoom = 100
      end
    end
    object tbsHistoricoBaixa: TTabSheet
      Caption = '5 - Hist'#243'rico da baixa'
      ImageIndex = 4
      object memHisBai: TMemoFocus
        Left = 0
        Top = 0
        Width = 1144
        Height = 485
        Align = alClient
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 488
    Top = 328
  end
  object dtsTabela: TDataSource
    Left = 592
    Top = 280
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 72
    Top = 336
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
