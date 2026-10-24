inherited frmCadPromocaoBrindes: TfrmCadPromocaoBrindes
  Left = 291
  Top = 146
  Width = 1024
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Promo'#231#227'o de Brindes por Produtos Vendidos'
  Position = poDesigned
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 1018
    Color = 16770261
    TabOrder = 3
    ExplicitTop = 527
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 882
      ExplicitLeft = 187
      ExplicitTop = 2
      ExplicitWidth = 702
      inherited btnIncluir: TBitBtnLocked
        Width = 116
        Height = 24
        Align = alLeft
        ParentFont = False
        ExplicitWidth = 116
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Left = 116
        Width = 116
        Height = 24
        Align = alLeft
        ParentFont = False
        ExplicitLeft = 116
        ExplicitWidth = 116
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 232
        Width = 116
        Height = 24
        Align = alLeft
        ParentFont = False
        ExplicitLeft = 232
        ExplicitWidth = 116
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 348
        Width = 116
        Height = 24
        Align = alLeft
        ParentFont = False
        ExplicitLeft = 348
        ExplicitWidth = 116
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Left = 464
        Width = 116
        Height = 24
        Align = alLeft
        ParentFont = False
        ExplicitLeft = 464
        ExplicitWidth = 116
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 580
        Width = 116
        Height = 24
        Align = alLeft
        ParentFont = False
        ExplicitLeft = 580
        ExplicitWidth = 116
        ExplicitHeight = 24
      end
      object btnHeranca: TBitBtnLocked
        Left = 696
        Top = 0
        Width = 185
        Height = 24
        Align = alLeft
        Caption = '&Heran'#231'a de Promo'#231#227'o'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 884
      Width = 132
      Height = 24
      Align = alRight
      ParentFont = False
      ExplicitLeft = 883
      ExplicitWidth = 132
      ExplicitHeight = 24
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 1
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
      object pnlGrid: TPanel
        Left = 0
        Top = 0
        Width = 577
        Height = 226
        Align = alClient
        Alignment = taRightJustify
        ParentColor = True
        TabOrder = 0
      end
    end
  end
  object pnlClient: TPanel [3]
    Left = 0
    Top = 188
    Width = 1018
    Height = 339
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object pnlGridVenda: TPanel
      Left = 10
      Top = 10
      Width = 492
      Height = 319
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      OnEnter = pnlGridVendaEnter
      OnExit = pnlGridVendaExit
      object cxgItensVenda: TcxGrid
        Left = 0
        Top = 28
        Width = 492
        Height = 263
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensVendaView: TcxGridDBBandedTableView
          OnKeyDown = cxgItensVendaViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem registros para exibir'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'PRODUTOS DA VENDA'
            end>
          object cxgItensVendaViewColumn1: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Options.Editing = False
            Width = 55
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensVendaViewColumn2: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 259
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensVendaViewColumn3: TcxGridDBBandedColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            Options.Editing = False
            Width = 85
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensVendaViewColumn4: TcxGridDBBandedColumn
            Caption = 'UN'
            DataBinding.FieldName = 'SIGUNI'
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 27
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensVendaViewColumn5: TcxGridDBBandedColumn
            Caption = 'Qtd. Pontos'
            DataBinding.FieldName = 'QTDPON'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 68
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
        end
        object cxgItensVendaLevel: TcxGridLevel
          GridView = cxgItensVendaView
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 492
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object btnAdicionarProdutos: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 157
          Height = 28
          Align = alLeft
          Caption = '[F3] Adicionar Produto(s)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000C30E0000C30E00000001000000000000006B00000073
            0000007B000000940000009C0000086B0800087B08000884080008A5080008AD
            080008B5080010731000107B10001084100010A5100010AD100010B510001873
            1800187B180018841800188C1800189C180018A5180018AD180018B51800217B
            2100218C210021942100219C210021AD210021B5210029942900299C29003194
            3100319C3100399C390039A5390039AD3900429C420042A5420042AD42004AA5
            4A004AAD4A0052A5520052AD52005AAD5A0063AD630063B563006BB56B0073BD
            73007BB57B007BBD7B0084B5840084C684008CBD8C008CC68C009CCE9C00A5D6
            A500B5DEB500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3C3C3C3C3C
            3C3C3C3C3C3C3C3C3C3B3C340B11111112120C0C06060201323C3C0D1A1F2121
            1F201C16160E0803003C3C141F23232324393C1D17100904023C3C1B23272927
            273C3C3C1E180F08063C3C1F26292B2927283C3C3C180F0E073C3C22292B2B29
            2927253C3C3C17160D3C3C262B3C3C3C3C3C3C3C3C3C3C1C133C3C272D3C3C3C
            3C3C3C3C3C3C3C1C193C3C2B2E2E2D2B2926233C3C3C201F193C3C2B30302D2B
            29263C3C3C1F1F1F193C3C2D33312E2D2B3C3C3C22222121193C3C303733302F
            2E3A3C2929272321193C3C3138373331302F2E2D2C292721113C3C3A312F2D2B
            2B2929272623211A363C3B3C3C3C3C3C3C3C3C3C3C3C3C3C3C3B}
          ParentFont = False
          TabOrder = 0
          TabStop = False
          OnClick = btnAdicionarProdutosClick
        end
        object btnAlterarProduto: TBitBtnLocked
          Left = 157
          Top = 0
          Width = 124
          Height = 28
          Align = alLeft
          Caption = '[F2] Alterar Produto'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333FFF33F333FF3F330E0330FFFCCFCC33777FF7F3377F7730EEE030FFFC
            CFCC377777F7F33773770EEE0000FFFFFCCF777777773F33377FEEE0BFBF0FFF
            FCCF7777333373F337730E0BFBFBF0FFCCFF77733333373F77F330BFBFBFBF0F
            CCFF37F333333F7F773330FBFBFB0B0FFFFF37F3F33F737FFFFF30B0BF0FB000
            000037F73F73F777777730FB0BF0FB0FFFFF373F73F73F7F333F330030BF0F0F
            FF993F77373F737F3377CC33330BF00FFF9977FFF373F77F3F77CC993330009F
            99FF7777F337777F77F333993330F99F99FF3F77FF37F773773F993CC330FFF9
            9F9977F77F37F3377F77993CC330FFF99F997737733733377377}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          TabStop = False
          OnClick = btnAlterarProdutoClick
        end
        object btnExcluirProdutos: TBitBtnLocked
          Left = 281
          Top = 0
          Width = 160
          Height = 28
          Align = alLeft
          Caption = '[Delete] Excluir Produto(s)'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
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
          ParentFont = False
          TabOrder = 2
          TabStop = False
          OnClick = btnExcluirProdutosClick
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 291
        Width = 492
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object btnVisualizarBrindes: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 146
          Height = 28
          Align = alLeft
          Caption = '[ Enter ] Visualizar Brindes'
          Enabled = False
          TabOrder = 0
          OnClick = btnVisualizarBrindesClick
        end
      end
    end
    object pnlGridBrinde: TPanel
      Left = 512
      Top = 10
      Width = 496
      Height = 319
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      OnEnter = pnlGridBrindeEnter
      OnExit = pnlGridBrindeExit
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 496
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object btnAdicionarBrindes: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 154
          Height = 28
          Align = alLeft
          Caption = '[F4] Adicionar Brinde(s)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000C30E0000C30E00000001000000000000006B00000073
            0000007B000000940000009C0000086B0800087B08000884080008A5080008AD
            080008B5080010731000107B10001084100010A5100010AD100010B510001873
            1800187B180018841800188C1800189C180018A5180018AD180018B51800217B
            2100218C210021942100219C210021AD210021B5210029942900299C29003194
            3100319C3100399C390039A5390039AD3900429C420042A5420042AD42004AA5
            4A004AAD4A0052A5520052AD52005AAD5A0063AD630063B563006BB56B0073BD
            73007BB57B007BBD7B0084B5840084C684008CBD8C008CC68C009CCE9C00A5D6
            A500B5DEB500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3C3C3C3C3C
            3C3C3C3C3C3C3C3C3C3B3C340B11111112120C0C06060201323C3C0D1A1F2121
            1F201C16160E0803003C3C141F23232324393C1D17100904023C3C1B23272927
            273C3C3C1E180F08063C3C1F26292B2927283C3C3C180F0E073C3C22292B2B29
            2927253C3C3C17160D3C3C262B3C3C3C3C3C3C3C3C3C3C1C133C3C272D3C3C3C
            3C3C3C3C3C3C3C1C193C3C2B2E2E2D2B2926233C3C3C201F193C3C2B30302D2B
            29263C3C3C1F1F1F193C3C2D33312E2D2B3C3C3C22222121193C3C303733302F
            2E3A3C2929272321193C3C3138373331302F2E2D2C292721113C3C3A312F2D2B
            2B2929272623211A363C3B3C3C3C3C3C3C3C3C3C3C3C3C3C3C3B}
          ParentFont = False
          TabOrder = 0
          TabStop = False
          OnClick = btnAdicionarBrindesClick
        end
        object btnAlterarBrinde: TBitBtnLocked
          Left = 154
          Top = 0
          Width = 119
          Height = 28
          Align = alLeft
          Caption = '[F2] Alterar Brinde'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333FFF33F333FF3F330E0330FFFCCFCC33777FF7F3377F7730EEE030FFFC
            CFCC377777F7F33773770EEE0000FFFFFCCF777777773F33377FEEE0BFBF0FFF
            FCCF7777333373F337730E0BFBFBF0FFCCFF77733333373F77F330BFBFBFBF0F
            CCFF37F333333F7F773330FBFBFB0B0FFFFF37F3F33F737FFFFF30B0BF0FB000
            000037F73F73F777777730FB0BF0FB0FFFFF373F73F73F7F333F330030BF0F0F
            FF993F77373F737F3377CC33330BF00FFF9977FFF373F77F3F77CC993330009F
            99FF7777F337777F77F333993330F99F99FF3F77FF37F773773F993CC330FFF9
            9F9977F77F37F3377F77993CC330FFF99F997737733733377377}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          TabStop = False
          OnClick = btnAlterarBrindeClick
        end
        object btnExcluirBrindes: TBitBtnLocked
          Left = 273
          Top = 0
          Width = 160
          Height = 28
          Align = alLeft
          Caption = '[Delete] Excluir Brinde(s)'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
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
          ParentFont = False
          TabOrder = 2
          TabStop = False
          OnClick = btnExcluirBrindesClick
        end
      end
      object cxgItensBrinde: TcxGrid
        Left = 0
        Top = 28
        Width = 496
        Height = 263
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensBrindeView: TcxGridDBBandedTableView
          OnKeyDown = cxgItensBrindeViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem registros para exibir'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Bands = <
            item
              Caption = 'PRODUTOS PARA BRINDE'
            end>
          object cxGridDBBandedColumn1: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODBRI'
            Options.Editing = False
            Width = 55
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn2: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESBRI'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 259
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn3: TcxGridDBBandedColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            Options.Editing = False
            Width = 85
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn4: TcxGridDBBandedColumn
            Caption = 'UN'
            DataBinding.FieldName = 'SIGUNI'
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 27
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxGridDBBandedColumn5: TcxGridDBBandedColumn
            Caption = 'Qtd. Brindes'
            DataBinding.FieldName = 'QTDBRI'
            FooterAlignmentHorz = taRightJustify
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 68
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
        end
        object cxgItensBrindeLevel: TcxGridLevel
          GridView = cxgItensBrindeView
        end
      end
      object Panel14: TPanel
        Left = 0
        Top = 291
        Width = 496
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object btnVisualizarProdutos: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 152
          Height = 28
          Align = alLeft
          Caption = '[ Enter ] Visualizar Produtos'
          Enabled = False
          TabOrder = 0
          OnClick = btnVisualizarProdutosClick
        end
      end
    end
    object Panel6: TPanel
      Left = 1008
      Top = 10
      Width = 10
      Height = 319
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
    end
    object Panel7: TPanel
      Left = 0
      Top = 10
      Width = 10
      Height = 319
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 3
    end
    object Panel8: TPanel
      Left = 502
      Top = 10
      Width = 10
      Height = 319
      Align = alLeft
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 4
    end
    object Panel5: TPanel
      Left = 0
      Top = 329
      Width = 1018
      Height = 10
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
    end
    object Panel9: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 10
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 6
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 188
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 6
      Width = 33
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 12
      Top = 50
      Width = 70
      Height = 14
      AutoSize = False
      Caption = 'Data Inicial'
    end
    object Label4: TLabel
      Left = 182
      Top = 49
      Width = 161
      Height = 14
      AutoSize = False
      Caption = 'Qtd. Pontos Acumulados'
    end
    object lblInfPonAcu: TLabel
      Left = 308
      Top = 69
      Width = 592
      Height = 15
      Caption = 
        '"Quantidade de pontos acumulados nos produtos vendidos desta pro' +
        'mo'#231#227'o para adquirir direito ao brinde."'
      Color = clInfoBk
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label6: TLabel
      Left = 94
      Top = 50
      Width = 70
      Height = 14
      AutoSize = False
      Caption = 'Data Final'
    end
    object Label3: TLabel
      Left = 94
      Top = 6
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object Bevel2: TBevel
      Left = 0
      Top = 92
      Width = 1018
      Height = 2
      Align = alBottom
      Shape = bsTopLine
      ExplicitTop = 119
      ExplicitWidth = 734
    end
    object dbeCodPro: TDBEditFocus
      Tag = 99
      Left = 10
      Top = 22
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_CODPRO'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesPro: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 22
      Width = 557
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_DESPRO'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaIni: TDBEditFocus
      Tag = 99
      Left = 10
      Top = 64
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_DTAINI'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnEnter = dbeDtaIniEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaFin: TDBEditFocus
      Tag = 99
      Left = 92
      Top = 64
      Width = 80
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRO_DTAFIN'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnEnter = dbeDtaFinEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePonAcu: TDBEditFocus
      Tag = 99
      Left = 180
      Top = 64
      Width = 125
      Height = 22
      Hint = 
        'Quantidade de pontos acumulados nos produtos vendidos desta prom' +
        'o'#231#227'o para adquirir direito ao brinde'
      CharCase = ecUpperCase
      DataField = 'PRO_PONACU'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlTabelasEmpresa: TPanel
      Left = 0
      Top = 94
      Width = 1018
      Height = 94
      Align = alBottom
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object pnlEmpresa: TPanel
        Left = 204
        Top = 0
        Width = 804
        Height = 94
        Align = alClient
        Alignment = taRightJustify
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object clbEmpresa: TCheckListBox
          Left = 0
          Top = 16
          Width = 804
          Height = 78
          Align = alClient
          Columns = 5
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          ParentFont = False
          TabOrder = 0
          OnExit = clbEmpresaExit
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 804
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label16: TLabel
            Left = 0
            Top = 0
            Width = 48
            Height = 14
            Align = alClient
            Caption = 'Empresas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
          end
        end
      end
      object pnlTabelas: TPanel
        Left = 10
        Top = 0
        Width = 184
        Height = 94
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object clbTabPre: TCheckListBox
          Left = 0
          Top = 16
          Width = 184
          Height = 78
          OnClickCheck = clbTabPreClickCheck
          Align = alClient
          Columns = 2
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          Items.Strings = (
            'Tabela 1'
            'Tabela 2'
            'Tabela 3'
            'Tabela 4'
            'Tabela 5'
            'Tabela 6'
            'Tabela 7')
          ParentFont = False
          Style = lbOwnerDrawFixed
          TabOrder = 0
          OnDrawItem = clbTabPreDrawItem
          OnExit = clbTabPreExit
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 184
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object lblTabPreco: TLabel
            Left = 0
            Top = 0
            Width = 83
            Height = 14
            Align = alClient
            Caption = 'Tabelas de Pre'#231'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
          end
        end
      end
      object Panel10: TPanel
        Left = 194
        Top = 0
        Width = 10
        Height = 94
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
      end
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 10
        Height = 94
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
      end
      object Panel12: TPanel
        Left = 1008
        Top = 0
        Width = 10
        Height = 94
        Align = alRight
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1018
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 671
      TabOrder = 1
      ExplicitLeft = 671
    end
    inherited pnlInfo: TPanel
      Width = 671
      TabOrder = 0
      ExplicitWidth = 671
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 864
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 864
    Top = 248
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 144
  end
  object dtsTabela: TDataSource
    Left = 244
    Top = 134
  end
end
