inherited frmCadNegociacaoClientes: TfrmCadNegociacaoClientes
  Width = 820
  Height = 698
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Negocia'#231#227'o de Clientes'
  WindowState = wsMaximized
  ExplicitWidth = 820
  ExplicitHeight = 698
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 628
    Width = 814
    Height = 25
    ExplicitTop = 628
    ExplicitWidth = 814
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 738
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 738
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 76
        ExplicitLeft = 74
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 150
        Width = 76
        ExplicitLeft = 150
        ExplicitWidth = 76
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 226
        Width = 76
        ExplicitLeft = 226
        ExplicitWidth = 76
      end
      inherited btnCancela: TBitBtnLocked
        Left = 302
        Width = 76
        ExplicitLeft = 302
        ExplicitWidth = 76
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 378
        Width = 76
        ExplicitLeft = 378
        ExplicitWidth = 76
      end
      object btnHeranca: TBitBtnLocked
        Left = 454
        Top = 0
        Width = 113
        Height = 20
        Caption = '&Heran'#231'a Negocia'#231#227'o'
        Enabled = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
      object btnRepassaTab: TBitBtnLocked
        Left = 567
        Top = 0
        Width = 160
        Height = 20
        Caption = '&Repassar Para Demais Tabelas'
        Enabled = False
        TabOrder = 7
        OnClick = btnRepassaTabClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 740
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 740
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 814
    Height = 628
    ExplicitWidth = 814
    ExplicitHeight = 628
    inherited tbsGeral: TTabSheet
      OnShow = tbsGeralShow
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 806
      ExplicitHeight = 596
      object pnlTabPrecos: TPanel
        Left = 0
        Top = 92
        Width = 806
        Height = 324
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object pgcTabelas: TPageControl
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 798
          Height = 316
          ActivePage = tbsTab7
          Align = alClient
          Style = tsFlatButtons
          TabOrder = 0
          TabStop = False
          object tbsTab1: TTabSheet
            Caption = 'Tabela &1'
            object pnlPoliticaTab1: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
          object tbsTab2: TTabSheet
            Caption = 'Tabela &2'
            ImageIndex = 1
            object pnlPoliticaTab2: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
          object tbsTab3: TTabSheet
            Caption = 'Tabela &3'
            ImageIndex = 2
            object pnlPoliticaTab3: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
          object tbsTab4: TTabSheet
            Caption = 'Tabela &4'
            ImageIndex = 3
            object pnlPoliticaTab4: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
          object tbsTab5: TTabSheet
            Caption = 'Tabela &5'
            ImageIndex = 4
            object pnlPoliticaTab5: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
          object tbsTab6: TTabSheet
            Caption = 'Tabela &6'
            ImageIndex = 5
            object pnlPoliticaTab6: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
          object tbsTab7: TTabSheet
            Caption = 'Tabela &7'
            ImageIndex = 6
            object pnlPoliticaTab7: TPanel
              Left = 0
              Top = 0
              Width = 790
              Height = 284
              Align = alClient
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
            end
          end
        end
      end
      object pnlTabelas: TPanel
        Left = 0
        Top = 37
        Width = 806
        Height = 55
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          806
          55)
        object lblTabPreco: TLabel
          Left = 45
          Top = 2
          Width = 303
          Height = 14
          Caption = 'Esta negocia'#231#227'o se aplica para as seguintes tabelas de pre'#231'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object clbTabPre: TCheckListBox
          Tag = 99
          Left = 45
          Top = 16
          Width = 750
          Height = 36
          OnClickCheck = clbTabPreClickCheck
          Anchors = [akLeft, akTop, akRight]
          Columns = 4
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          Items.Strings = (
            'Tabela de Pre'#231'o 1'
            'Tabela de Pre'#231'o 2'
            'Tabela de Pre'#231'o 3'
            'Tabela de Pre'#231'o 4'
            'Tabela de Pre'#231'o 5'
            'Tabela de Pre'#231'o 6'
            'Tabela de Pre'#231'o 7')
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnDrawItem = clbTabPreDrawItem
          OnEnter = clbTabPreEnter
          OnExit = clbTabPreExit
          OnKeyDown = clbTabPreKeyDown
        end
      end
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 37
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          806
          37)
        object Label1: TLabel
          Left = 10
          Top = 12
          Width = 66
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'C'#243'digo:'
        end
        object dbeCodNeg: TDBEditFocus
          Tag = 99
          Left = 82
          Top = 9
          Width = 70
          Height = 22
          DataField = 'NEG_CODNEG'
          DataSource = dtsCadNeg
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = 8421631
          Requerido = True
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDesNeg: TDBEditFocus
          Tag = 99
          Left = 153
          Top = 9
          Width = 513
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          DataField = 'NEG_DESCRI'
          DataSource = dtsCadNeg
          MaxLength = 100
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = 8421631
          Requerido = True
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object rdgStatus: TDBRadioGroup
          Tag = 99
          Left = 671
          Top = 0
          Width = 124
          Height = 33
          Anchors = [akTop, akRight]
          Caption = 'Stauts'
          Columns = 2
          DataField = 'NEG_STATUS'
          DataSource = dtsCadNeg
          Items.Strings = (
            'Ativo'
            'Inativo')
          TabOrder = 2
          Values.Strings = (
            'A'
            'I')
        end
      end
      object pnlTitulo2: TPanel
        Left = 0
        Top = 416
        Width = 806
        Height = 20
        Align = alTop
        TabOrder = 3
        object lblTitulo2: TLabel
          Left = 1
          Top = 1
          Width = 804
          Height = 18
          Align = alClient
          Alignment = taCenter
          Caption = 'Pol'#237'tica de Descontos por Data de Compra'
          Color = 16770261
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 239
          ExplicitHeight = 15
        end
      end
      object pnlDataCompra: TPanel
        Left = 0
        Top = 436
        Width = 806
        Height = 160
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object pnlDescontoCompras: TPanel
          Left = 1
          Top = 1
          Width = 804
          Height = 158
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object cxGridDataCompra: TcxGridCitel
            Left = 1
            Top = 39
            Width = 802
            Height = 91
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGridDBTableCompra: TcxGridDBTableViewCitel
              OnDblClick = cxGridDBTableCompraDblClick
              OnKeyDown = cxGridDBTableCompraKeyDown
              OnKeyPress = cxGridDBTableCompraKeyPress
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsCmpNeg
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsCustomize.ColumnSorting = False
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
              object cxGridDBTableCompraDIAINI: TcxGridDBColumn
                Caption = 'Dia Inicial'
                DataBinding.FieldName = 'CMP_DIAINI'
                Width = 91
              end
              object cxGridDBTableCompraDIAFIM: TcxGridDBColumn
                Caption = 'Dia Final'
                DataBinding.FieldName = 'CMP_DIAFIM'
                Width = 87
              end
              object cxGridDBTableCompraPERCON: TcxGridDBColumn
                Caption = '% Desconto'
                DataBinding.FieldName = 'CMP_PERDES'
                Width = 127
              end
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridDBTableCompra
            end
          end
          object Panel3: TPanel
            Left = 1
            Top = 130
            Width = 802
            Height = 27
            Align = alBottom
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            DesignSize = (
              802
              27)
            object Label15: TLabel
              Left = 14
              Top = 5
              Width = 135
              Height = 14
              Caption = 'DEL - Deleta Item no Grid'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label16: TLabel
              Left = 611
              Top = 5
              Width = 119
              Height = 14
              Anchors = [akTop, akRight]
              Caption = 'Ordena os Descontos'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblTotalCmp: TLabel
              Left = 482
              Top = 5
              Width = 21
              Height = 14
              Anchors = [akLeft, akTop, akRight, akBottom]
              Caption = '0,00'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblRodape2: TLabel
              Left = 263
              Top = 5
              Width = 212
              Height = 14
              Caption = '(%) Total da Pol'#237'tica por Data de Compra'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object btnCima: TBitBtnLocked
              Left = 736
              Top = 1
              Width = 28
              Height = 24
              Anchors = [akTop, akRight]
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000B8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF0000000000000000000000000000000000000000000000003827
                174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D000000000000
                00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFF3827174D0000000000000000000000000000
                000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000000000
                00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                0000000000000000000000000000000000003827174DB8824DFFB8824DFFB882
                4DFF3827174D0000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000003827174DB8824DFF3827
                174D000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000000000000000000003827174D0000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 0
              OnClick = btnCimaClick
            end
            object btnBaixo: TBitBtnLocked
              Left = 764
              Top = 1
              Width = 28
              Height = 24
              Anchors = [akTop, akRight]
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000003827174D000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000003827174DB8824DFF3827174D0000
                0000000000000000000000000000000000000000000000000000000000000000
                00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
                174D000000000000000000000000000000000000000000000000000000000000
                000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF3827174D0000000000000000000000000000000000000000000000000000
                0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
                00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFF3827174D000000000000000000000000000000003827
                174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000003827174DB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFFB8824DFFB8824DFFB8824DFFB8824DFF3827174D00000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000B8824DFFB8824DFFB8824DFFB8824DFFB882
                4DFF000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              TabOrder = 1
              OnClick = btnBaixoClick
            end
          end
          object pnlDadosDtaCmp: TPanel
            Left = 1
            Top = 1
            Width = 802
            Height = 38
            Align = alTop
            TabOrder = 0
            DesignSize = (
              802
              38)
            object Label13: TLabel
              Left = 14
              Top = 12
              Width = 75
              Height = 14
              Caption = 'Compras do dia'
            end
            object Label14: TLabel
              Left = 371
              Top = 12
              Width = 59
              Height = 14
              Caption = '% Desconto'
            end
            object Label2: TLabel
              Left = 160
              Top = 12
              Width = 41
              Height = 14
              Caption = 'at'#233' o dia'
            end
            object Label3: TLabel
              Left = 270
              Top = 12
              Width = 3
              Height = 14
              Caption = ':'
            end
            object edtDiaIni: TEditFocus
              Left = 97
              Top = 8
              Width = 54
              Height = 22
              Alignment = taRightJustify
              TabOrder = 0
              OnKeyPress = edtDiaIniKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = 8421631
              Requerido = True
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object btnAddDescCompra: TBitBtnLocked
              Left = 645
              Top = 9
              Width = 74
              Height = 22
              Anchors = [akTop, akRight]
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
              TabOrder = 3
              OnClick = btnAddDescCompraClick
            end
            object btnCancDescCompra: TBitBtnLocked
              Left = 720
              Top = 9
              Width = 74
              Height = 22
              Anchors = [akTop, akRight]
              Caption = 'Ca&ncelar'
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
              OnClick = btnCancDescCompraClick
            end
            object edtPerDesCmp: TCurrencyEditFocus
              Left = 291
              Top = 8
              EditValue = 0.000000000000000000
              Properties.Alignment.Horz = taRightJustify
              Properties.DisplayFormat = ',0.00;-,0.00'
              StyleFocused.Color = 8421631
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = 8421631
              Requerido = True
              Width = 75
            end
            object edtDiaFim: TEditFocus
              Left = 210
              Top = 8
              Width = 54
              Height = 22
              Alignment = taRightJustify
              TabOrder = 1
              OnKeyPress = edtDiaFimKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = 8421631
              Requerido = True
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
        end
      end
    end
    object tabProdutos: TTabSheet
      Caption = '&2 - Produtos da Negocia'#231#227'o'
      ImageIndex = 2
      object pnlFiltros: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 80
        Align = alTop
        Color = 16770261
        Enabled = False
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          806
          80)
        object Label4: TLabel
          Left = 388
          Top = 9
          Width = 42
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object Label9: TLabel
          Left = 12
          Top = 9
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 371
          Top = 32
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 47
          Top = 33
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblUnidade: TLabel
          Left = 38
          Top = 56
          Width = 42
          Height = 14
          Caption = 'Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 368
          Top = 56
          Width = 62
          Height = 14
          Caption = '% Desconto:'
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 432
          Top = 5
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesIte: TEditFocus
          Left = 503
          Top = 5
          Width = 213
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
        object mskLinhaGrupo: TMaskEditFocus
          Tag = 99
          Left = 82
          Top = 5
          Width = 70
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnExit = mskLinhaGrupoExit
          OnKeyPress = mskLinhaGrupoKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupo: TEditFocus
          Left = 153
          Top = 5
          Width = 213
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
        object edtFornecedor: TEditFocus
          Tag = 99
          Left = 432
          Top = 29
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          OnExit = edtFornecedorExit
          OnKeyPress = edtFornecedorKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesFornecedor: TEditFocus
          Left = 503
          Top = 29
          Width = 213
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtMarca: TEditFocus
          Tag = 99
          Left = 82
          Top = 29
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          TabOrder = 4
          OnExit = edtMarcaExit
          OnKeyPress = edtMarcaKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMarca: TEditFocus
          Left = 153
          Top = 29
          Width = 213
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAddIte: TBitBtnLocked
          Left = 725
          Top = 5
          Width = 74
          Height = 22
          Anchors = [akTop, akRight]
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
          TabOrder = 11
          OnClick = btnAddIteClick
        end
        object btnCancIte: TBitBtnLocked
          Left = 725
          Top = 29
          Width = 74
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Ca&ncelar'
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
          TabOrder = 12
          OnClick = btnCancIteClick
        end
        object edtCodUni: TEditFocus
          Tag = 99
          Left = 82
          Top = 53
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
          MaxLength = 2
          ParentFont = False
          TabOrder = 8
          OnExit = edtCodUniExit
          OnKeyPress = edtCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttNumerico
        end
        object edtDesUni: TEditFocus
          Left = 153
          Top = 53
          Width = 213
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescIte: TCurrencyEditFocus
          Left = 432
          Top = 53
          EditValue = 0.000000000000000000
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          StyleFocused.Color = 8421631
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = 8421631
          Requerido = True
          Width = 70
        end
      end
      object cxGridProdutos: TcxGridCitel
        Left = 0
        Top = 80
        Width = 806
        Height = 516
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableProdutos: TcxGridDBTableViewCitel
          OnKeyDown = cxGridDBTableProdutosKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnEditValueChanged = cxGridDBTableProdutosEditValueChanged
          DataController.DataSource = dtsIteNeg
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridProdutosCODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            Options.Editing = False
            Width = 50
          end
          object cxGridProdutosDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            MinWidth = 100
            Options.Editing = False
            Width = 599
          end
          object cxGridProdutosSIGUNI: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNI_SIGUNI'
            Options.Editing = False
            Width = 53
          end
          object cxGridProdutosPERITE: TcxGridDBColumn
            Caption = '% Desconto'
            DataBinding.FieldName = 'PERITE'
            HeaderAlignmentHorz = taRightJustify
            Width = 81
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableProdutos
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = '&3 - Clientes da Negocia'#231#227'o'
      ImageIndex = 1
      object pnlPesqCli: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 151
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl3: TLabel
          Left = 65
          Top = 14
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl4: TLabel
          Left = 52
          Top = 60
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 64
          Top = 83
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 551
          Top = 83
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl7: TLabel
          Left = 12
          Top = 129
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
        end
        object Label5: TLabel
          Left = 28
          Top = 36
          Width = 72
          Height = 14
          Caption = 'Rede de Lojas:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblRegiao: TLabel
          Left = 64
          Top = 105
          Width = 36
          Height = 14
          Caption = 'Regi'#227'o:'
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 103
          Top = 10
          Width = 65
          Height = 22
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
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 169
          Top = 10
          Width = 485
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
        object edtCodAti: TEditFocus
          Tag = 99
          Left = 103
          Top = 56
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnExit = edtCodAtiExit
          OnKeyPress = edtCodAtiKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesAti: TEditFocus
          Left = 169
          Top = 56
          Width = 485
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
        object edtCodCid: TEditFocus
          Tag = 99
          Left = 103
          Top = 79
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnExit = edtCodCidExit
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCid: TEditFocus
          Left = 169
          Top = 79
          Width = 367
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
        object edtEstado: TEditFocus
          Tag = 99
          Left = 589
          Top = 79
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtCgcCpf: TEditFocus
          Tag = 99
          Left = 103
          Top = 125
          Width = 35
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          Text = '1'
          OnChange = edtCgcCpfChange
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 1
          TipoTexto = ttNumerico
        end
        object edtNuCnPj: TMaskEditFocus
          Left = 139
          Top = 125
          Width = 208
          Height = 22
          ReadOnly = True
          TabOrder = 12
          Text = ''
          OnEnter = edtNuCnPjEnter
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnIncCli: TBitBtnLocked
          Left = 502
          Top = 126
          Width = 74
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
          TabOrder = 13
          OnClick = btnIncCliClick
        end
        object btnCancelCli: TBitBtnLocked
          Left = 580
          Top = 126
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
          TabOrder = 14
          OnClick = btnCancelCliClick
        end
        object edtCodRede: TEditFocus
          Tag = 99
          Left = 103
          Top = 33
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          OnExit = edtCodRedeExit
          OnKeyPress = edtCodRedeKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesRede: TEditFocus
          Left = 169
          Top = 33
          Width = 485
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
        object edtDesRegiao: TEditFocus
          Left = 169
          Top = 102
          Width = 485
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object edtCodRegiao: TEditFocus
          Tag = 99
          Left = 103
          Top = 102
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnExit = edtCodRegiaoExit
          OnKeyPress = edtCodRegiaoKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
      end
      object cxGridClientes: TcxGridCitel
        Left = 0
        Top = 151
        Width = 806
        Height = 445
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridClientesTableClientes: TcxGridDBTableViewCitel
          OnKeyDown = cxGridClientesTableClientesKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCliNeg
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridClientesTableCODCLI: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CLI_CODCLI'
            Options.Editing = False
          end
          object cxGridClientesTableNOMCLI: TcxGridDBColumn
            Caption = 'Nome Cliente'
            DataBinding.FieldName = 'NOMCLI'
            MinWidth = 100
            Options.Editing = False
            Width = 286
          end
          object cxGridClientesTableCPFCGC: TcxGridDBColumn
            Caption = 'CNPJ / CPF'
            DataBinding.FieldName = 'CGCCPF'
            Options.Editing = False
            Width = 127
          end
          object cxGridClientesTableNOMCID: TcxGridDBColumn
            Caption = 'Cidade / Estado'
            DataBinding.FieldName = 'NOMCID'
            MinWidth = 60
            Options.Editing = False
            Width = 155
          end
          object cxGridClientesTableNOMATI: TcxGridDBColumn
            Caption = 'Atividade'
            DataBinding.FieldName = 'NOMATI'
            MinWidth = 60
            Options.Editing = False
            Width = 137
          end
          object cxGridClientesTableNUMDOC: TcxGridDBColumn
            Caption = 'Doc. '#218'ltima Compra'
            DataBinding.FieldName = 'NUMDOC'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 102
          end
          object cxGridClientesTableESPDOC: TcxGridDBColumn
            Caption = 'Esp'#233'cie'
            DataBinding.FieldName = 'ESPDOC'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object cxGridClientesTableDTAUCP: TcxGridDBColumn
            Caption = 'Data '#218'ltima Compra'
            DataBinding.FieldName = 'DTAUCP'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 102
          end
        end
        object cxGridClientesLevel1: TcxGridLevel
          GridView = cxGridClientesTableClientes
        end
      end
    end
    object tabCompraMinima: TTabSheet
      Caption = '&4 - Desconto por Quantidade M'#237'nima'
      ImageIndex = 3
      object pnlFiltrosQtd: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 80
        Align = alTop
        Color = 16770261
        Enabled = False
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          806
          80)
        object Label7: TLabel
          Left = 388
          Top = 9
          Width = 42
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object Label8: TLabel
          Left = 12
          Top = 9
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 371
          Top = 32
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 47
          Top = 33
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 38
          Top = 56
          Width = 42
          Height = 14
          Caption = 'Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 368
          Top = 56
          Width = 62
          Height = 14
          Caption = '% Desconto:'
        end
        object Label20: TLabel
          Left = 551
          Top = 56
          Width = 93
          Height = 14
          Caption = 'Quantidade M'#237'nima:'
        end
        object edtCodIteQtd: TEditFocus
          Tag = 99
          Left = 432
          Top = 5
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          OnExit = edtCodIteQtdExit
          OnKeyPress = edtCodIteQtdKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesIteQtd: TEditFocus
          Left = 503
          Top = 5
          Width = 213
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
        object mskLinhaGrupoQtd: TMaskEditFocus
          Tag = 99
          Left = 82
          Top = 5
          Width = 70
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnExit = mskLinhaGrupoQtdExit
          OnKeyPress = mskLinhaGrupoQtdKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupoQtd: TEditFocus
          Left = 153
          Top = 5
          Width = 213
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
        object edtFornecedorQtd: TEditFocus
          Tag = 99
          Left = 432
          Top = 29
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          OnExit = edtFornecedorQtdExit
          OnKeyPress = edtFornecedorQtdKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesFornecedorQtd: TEditFocus
          Left = 503
          Top = 29
          Width = 213
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtMarcaQtd: TEditFocus
          Tag = 99
          Left = 82
          Top = 29
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          TabOrder = 4
          OnExit = edtMarcaQtdExit
          OnKeyPress = edtMarcaQtdKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMarcaQtd: TEditFocus
          Left = 153
          Top = 29
          Width = 213
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnAddQtdIte: TBitBtnLocked
          Left = 725
          Top = 5
          Width = 74
          Height = 22
          Anchors = [akTop, akRight]
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
          TabOrder = 12
          OnClick = btnAddQtdIteClick
        end
        object btnCancQtdIte: TBitBtnLocked
          Left = 725
          Top = 29
          Width = 74
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Ca&ncelar'
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
          TabOrder = 13
          OnClick = btnCancQtdIteClick
        end
        object edtCodUniQtd: TEditFocus
          Tag = 99
          Left = 82
          Top = 53
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
          MaxLength = 2
          ParentFont = False
          TabOrder = 8
          OnExit = edtCodUniQtdExit
          OnKeyPress = edtCodUniQtdKeyPress
          NormalColor = clWindow
          FocusColor = clMoneyGreen
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttNumerico
        end
        object edtDesUniQtd: TEditFocus
          Left = 153
          Top = 53
          Width = 213
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescIteQtd: TCurrencyEditFocus
          Left = 432
          Top = 53
          EditValue = 0.000000000000000000
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          StyleFocused.Color = 8421631
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = 8421631
          Requerido = True
          Width = 70
        end
        object edtQtdIte: TCurrencyEditFocus
          Left = 646
          Top = 53
          EditValue = 0.000000000000000000
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = ',0.00;-,0.00'
          StyleFocused.Color = 8421631
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = 8421631
          Requerido = True
          Width = 70
        end
      end
      object cxGridProdutosQtd: TcxGridCitel
        Left = 0
        Top = 80
        Width = 806
        Height = 516
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableQtdProdutos: TcxGridDBTableViewCitel
          OnKeyDown = cxGridDBTableQtdProdutosKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnEditValueChanged = cxGridDBTableQtdProdutosEditValueChanged
          DataController.DataSource = dtsQtdNeg
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            Options.Editing = False
            Width = 50
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            MinWidth = 100
            Options.Editing = False
            Width = 496
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNI_SIGUNI'
            Options.Editing = False
            Width = 53
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Quantidade M'#237'nima'
            DataBinding.FieldName = 'QTDITE'
            HeaderAlignmentHorz = taRightJustify
            Width = 101
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = '% Desconto'
            DataBinding.FieldName = 'PERITE'
            HeaderAlignmentHorz = taRightJustify
            Width = 81
          end
        end
        object cxGridLevel3: TcxGridLevel
          GridView = cxGridDBTableQtdProdutos
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 653
    Width = 814
    ExplicitTop = 653
    ExplicitWidth = 814
    inherited pnlNomeForm: TPanel
      Left = 467
      ExplicitLeft = 467
    end
    inherited pnlInfo: TPanel
      Width = 467
      ExplicitWidth = 467
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 8
  end
  object dtsCliNeg: TDataSource
    Left = 684
    Top = 187
  end
  object dtsCadNeg: TDataSource
    OnStateChange = dtsCadNegStateChange
    Left = 460
    Top = 11
  end
  object dtsIteNeg: TDataSource
    Left = 684
    Top = 235
  end
  object dtsCmpNeg: TDataSource
    OnStateChange = dtsCmpNegStateChange
    Left = 488
    Top = 515
  end
  object dtsQtdNeg: TDataSource
    Left = 684
    Top = 291
  end
end
