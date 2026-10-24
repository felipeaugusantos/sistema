inherited frmCadComboProdVenda: TfrmCadComboProdVenda
  Width = 1024
  Height = 796
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Combo de Produtos para Venda'
  WindowState = wsMaximized
  ExplicitTop = -80
  ExplicitWidth = 1024
  ExplicitHeight = 796
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 726
    Width = 1018
    Height = 25
    ExplicitTop = 726
    ExplicitWidth = 1018
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 1014
      inherited btnIncluir: TBitBtnLocked
        Width = 90
        Height = 21
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 90
        Width = 90
        Height = 21
        ExplicitLeft = 90
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 180
        Height = 21
        ExplicitLeft = 180
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 252
        Width = 90
        Height = 21
        ExplicitLeft = 252
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 342
        Width = 90
        Height = 21
        ExplicitLeft = 342
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 432
        Width = 90
        Height = 21
        ExplicitLeft = 432
        ExplicitWidth = 90
        ExplicitHeight = 21
      end
      object btnHeranca: TBitBtnLocked
        Left = 522
        Top = 0
        Width = 121
        Height = 21
        Caption = '&Heran'#231'a de Combo'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000B00000011000000120000
          0013000000130000001300000013000000120000000C00000003000000000000
          00000000000000000000000000000000000A184D38C2226B4DFF226A4CFF226A
          4BFF22694BFF22684BFF22684BFF21684AFF184A34C30000000B000000000000
          00000000000000000000000000000000000E267856FF49C59DFF3EBF94FF3CBE
          92FF3BBE91FF3ABD90FF38BC8FFF37BA8DFF22694BFF00000010000000000000
          00000000000000000000000000000000000E287C5AFF53CBA4FF37BE90FF36BE
          90FF37BD90FF36BD8FFF35BC8FFF3CBE93FF236C4EFF00000010000000000000
          00000000000000000000000000000000000D2A815FFF5DD1AEFF39C295FF39C1
          95FF39C094FF38BF93FF38BF93FF41C599FF246F50FF0000000F000000020000
          00070000000B0000000C0000000C000000152C8663FF66D6B6FF3CC59AFF3BC4
          98FF3BC498FF3BC397FF3AC396FF47C8A0FF267254FF0000000E000000061E59
          41BE287959FF277858FF287757FF277757FF2E8766FF4BB694FF45B490FF50BE
          9CFF5ED4B0FF55D0AAFF49CBA2FF4ECDA6FF277657FF0000000D000000083395
          71FF88E5CDFF65D9B9FF62D9B8FF62D8B6FF52BC9BFF81E1C6FF6EDCBCFF58BC
          9EFF68DAB8FF65D8B6FF62D7B4FF6CDABAFF297B5BFF0000000C00000008349A
          75FF90E8D2FF42CEA5FF42CEA4FF42CEA4FF51BC9BFF8BE6CDFFA2EDD8FF7BC8
          B2FFAFEEDEFFACEDDCFFA7EDDAFFA4EBD8FF2B805FFF0000000A00000007369E
          7AFF98EBD6FF43D0A6FF43D0A6FF43D0A6FF3FBD96FF3EB791FF56BFA0FF3392
          70FF339672FF339671FF339471FF329370FF226349C3000000060000000638A2
          7EFFA0EDDAFF44D1A7FF44D1A7FF44D1A7FF44D0A7FF44D0A6FF6DDEBFFF2D86
          64FF0000000D0000000800000008000000080000000500000002000000053AA6
          81FFA6EEDDFF65DDBBFF7AE4C7FF81E6CBFF71E1C2FF5BD9B5FF72E0C2FF2F8C
          6AFF000000070000000000000000000000000000000000000000000000043BAA
          84FFD5F8EFFF9DF0DBFF98EED8FF92ECD5FF8DEAD2FF87E8CEFF9EEDD9FF3293
          70FF000000060000000000000000000000000000000000000000000000033CAD
          87FFE9FDF9FFE8FCF7FFE5FCF7FFE3FBF6FFE0FAF4FFDDFAF3FFDAF9F2FF3599
          76FF000000040000000000000000000000000000000000000000000000022D81
          64BF3DAE88FF3CAE87FF3DAD87FF3DAD87FF3DAC87FF3CAC87FF3CAC85FF2876
          5BBF000000020000000000000000000000000000000000000000000000000000
          0001000000020000000200000002000000020000000200000003000000030000
          0002000000010000000000000000000000000000000000000000}
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Height = 21
      Align = alRight
      ExplicitLeft = 938
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 1018
    Height = 0
    ActivePage = nil
    Align = alNone
    ExplicitWidth = 1018
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 1010
      ExplicitHeight = 226
    end
  end
  inherited pnlStatus: TPanel
    Top = 751
    Width = 1018
    ExplicitTop = 751
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 671
      ExplicitLeft = 671
    end
    inherited pnlInfo: TPanel
      Width = 671
      ExplicitWidth = 671
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 726
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitHeight = 723
    object pnlProdut: TPanel
      Left = 0
      Top = 129
      Width = 1018
      Height = 560
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitHeight = 557
      object pnlProGer: TPanel
        Left = 14
        Top = 0
        Width = 978
        Height = 560
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitHeight = 557
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 978
          Height = 180
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Panel7'
          TabOrder = 0
          object cxgProAti: TcxGridCitel
            Left = 0
            Top = 23
            Width = 978
            Height = 157
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGridDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
              OnDblClick = cxGridDBBandedTableViewCitel1DblClick
              OnKeyDown = cxGridDBBandedTableViewCitel1KeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsProAti
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Produtos de Ativa'#231#227'o'
                  Styles.Header = cxStyle1
                  Width = 656
                end>
              Zebra = True
              Destaque = True
              DestacarRegistro = True
              CorZebra = clMoneyGreen
              object CODITEA: TcxGridDBBandedColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'CODITEA'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 78
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object DESITEA: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESITEA'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 329
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object REFEREA: TcxGridDBBandedColumn
                Caption = 'Refer'#234'ncia'
                DataBinding.FieldName = 'REFEREA'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 100
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object SIGUNIA: TcxGridDBBandedColumn
                Caption = 'Un.'
                DataBinding.FieldName = 'SIGUNIA'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 34
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object QTDITEA: TcxGridDBBandedColumn
                Caption = 'Quantidade'
                DataBinding.FieldName = 'QTDITEA'
                HeaderAlignmentHorz = taRightJustify
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 115
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBBandedTableViewCitel1
            end
          end
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 978
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object btnProAti: TBitBtnLocked
              Left = 0
              Top = 0
              Width = 360
              Height = 23
              Caption = '[ F5 ] - Abrir Filtro para Inserir Produtos de Ativa'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000020000000900000011000000110000
                0009000000020000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000093D332F8268524CF467514BF42E24
                21820000000A0000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000108B756CFFEBE8E7FFBAAFA9FF6F58
                50FF000000110000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000011877169FFE5E0DDFFBEB0A7FF715A
                53FF000000120000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000010846E67FFE4DDDAFFC2B4ABFF735C
                56FF000000110000000000000000000000000000000000000000000000000000
                000000000000000000000000000200000012836C64FFDDD5D0FFC2B4ACFF775F
                59FF000000140000000200000000000000000000000000000000000000000000
                000000000000000000030101010F34292681826B64FFD3CFCBFFBDB3AEFF7962
                5CFF2F2523830101011100000004000000010000000000000000000000000000
                0000000000040C0A092662524ACC8F786EFFA18D81FFAE9B8FFFAF9A8EFF9D87
                7AFF826A61FF554440CD0A080829000000050000000100000000000000000000
                0003120F0E2D7F6B63ECA69186FFBEB0A5FFCCC1B8FFBDACA1FFBEABA0FFB29E
                92FFA69082FF937B70FF6B5650ED0F0C0B310000000300000000000000010000
                00076E5E58C6AD9B90FFC4B7ADFFE5DFDAFFDBD5CDFFC9BBB1FFC3B1A6FFBCAB
                9FFFAF9B8EFFA69285FF937B6FFF574642C80000000A00000001000000022B25
                234EA49087FFC5B8ADFFE1DBD5FFF4F3F0FFE5E1DAFFCFC3B9FFC3B1A6FFC3B3
                A8FFB4A296FFAD998CFFA28C7FFF826A61FF211A19530000000300000004685C
                55A6B6A59AFFCEC4BBFFF2F0EDFFFCFCFBFFECEBE4FFD4C9C0FFC3B1A6FFC7B8
                AEFFB6A598FFAF9C8FFFA79284FF927A6DFF4E403CA900000006000000059E8C
                83ECC5B8AEFFE3DED8FFFCFAFAFFFDFCFBFFFCFBFAFFF8F8F5FFF6F3F0FFF2EE
                EBFFEAE4DFFFD8CEC6FFC5B6ACFFA18A7EFF77645DEB0000000800000004B19D
                94FFF0ECE9FFDCD5D2FFB6A8A4FF988681FF77615AFF7E6862FF89746CFF9580
                79FFB1A099FFC4B6B0FFD7CCC5FFDDD4CBFF87736BFE00000007000000023D35
                335CA8968DF0CCC0B9FFE3DBD6FFEFEBE7FFF1EEEAFFF4F0EEFFF1EDEAFFE8E1
                DCFFE0D7D1FFCEC2BAFFB3A39AFF8C7971F12F29266000000003000000000000
                00010807070F3E36335E695E579F897870CE8F7F77DDA49088FFA18D84FF8877
                70DD7D6C65CF5D514CA1352E2B60070606120000000300000000}
              ParentFont = False
              TabOrder = 0
              TabStop = False
              OnClick = btnProAtiClick
            end
            object btnMarTod: TBitBtnLocked
              Left = 742
              Top = 0
              Width = 109
              Height = 23
              Align = alRight
              Caption = '[F11] Marcar Todas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              TabStop = False
              OnClick = btnMarTodClick
            end
            object btnDesTod: TBitBtnLocked
              Left = 851
              Top = 0
              Width = 127
              Height = 23
              Align = alRight
              Caption = '[F12]Desmarcar Todas'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              TabStop = False
              OnClick = btnDesTodClick
            end
          end
        end
        object Panel8: TPanel
          Left = 0
          Top = 180
          Width = 978
          Height = 184
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel8'
          TabOrder = 1
          ExplicitHeight = 181
          object cxgProCom: TcxGridCitel
            Left = 0
            Top = 24
            Width = 978
            Height = 160
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            ExplicitHeight = 157
            object cxgProComDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
              OnDblClick = cxgProComDBBandedTableViewCitel1DblClick
              OnKeyDown = cxgProComDBBandedTableViewCitel1KeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsProCom
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Produtos do Combo'
                  Styles.Header = cxStyle1
                end
                item
                  Caption = 'Financeiro'
                  Styles.Header = cxStyle1
                  Width = 207
                end>
              Zebra = True
              Destaque = True
              DestacarRegistro = True
              CorZebra = clMoneyGreen
              object CODITEC: TcxGridDBBandedColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'CODITEC'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 78
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object DESITEC: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESITEC'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 331
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object REFEREC: TcxGridDBBandedColumn
                Caption = 'Refer'#234'ncia'
                DataBinding.FieldName = 'REFEREC'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 92
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object SIGUNIC: TcxGridDBBandedColumn
                Caption = 'Un.'
                DataBinding.FieldName = 'SIGUNIC'
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 32
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object QTDITEC: TcxGridDBBandedColumn
                Caption = 'Quantidade'
                DataBinding.FieldName = 'QTDITEC'
                HeaderAlignmentHorz = taRightJustify
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 106
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object BRINDEC: TcxGridDBBandedColumn
                Caption = 'Bri'
                DataBinding.FieldName = 'BRINDEC'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 27
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object TABPREC: TcxGridDBBandedColumn
                Caption = 'Tab'
                DataBinding.FieldName = 'TABPREC'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 29
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object OPERADC: TcxGridDBBandedColumn
                Caption = '+ / -'
                DataBinding.FieldName = 'OPERADC'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 28
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object TIPDESC: TcxGridDBBandedColumn
                Caption = '% / $'
                DataBinding.FieldName = 'TIPDESC'
                PropertiesClassName = 'TcxLabelProperties'
                Properties.Alignment.Horz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Focusing = False
                Styles.Header = cxStyle2
                Width = 35
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object VALDESC: TcxGridDBBandedColumn
                Caption = 'Valor / Perc'
                DataBinding.FieldName = 'VALDESC'
                HeaderAlignmentHorz = taRightJustify
                Options.Focusing = False
                Styles.Header = cxStyle2
                Position.BandIndex = 1
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
            end
            object cxgProComLevel1: TcxGridLevel
              GridView = cxgProComDBBandedTableViewCitel1
            end
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 978
            Height = 24
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object btnProCom: TBitBtnLocked
              Left = 0
              Top = 1
              Width = 360
              Height = 23
              Caption = '[ F6 ] - Abrir Filtro para Inserir Produtos do Combo'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000020000000900000011000000110000
                0009000000020000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000093D332F8268524CF467514BF42E24
                21820000000A0000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000108B756CFFEBE8E7FFBAAFA9FF6F58
                50FF000000110000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000011877169FFE5E0DDFFBEB0A7FF715A
                53FF000000120000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000010846E67FFE4DDDAFFC2B4ABFF735C
                56FF000000110000000000000000000000000000000000000000000000000000
                000000000000000000000000000200000012836C64FFDDD5D0FFC2B4ACFF775F
                59FF000000140000000200000000000000000000000000000000000000000000
                000000000000000000030101010F34292681826B64FFD3CFCBFFBDB3AEFF7962
                5CFF2F2523830101011100000004000000010000000000000000000000000000
                0000000000040C0A092662524ACC8F786EFFA18D81FFAE9B8FFFAF9A8EFF9D87
                7AFF826A61FF554440CD0A080829000000050000000100000000000000000000
                0003120F0E2D7F6B63ECA69186FFBEB0A5FFCCC1B8FFBDACA1FFBEABA0FFB29E
                92FFA69082FF937B70FF6B5650ED0F0C0B310000000300000000000000010000
                00076E5E58C6AD9B90FFC4B7ADFFE5DFDAFFDBD5CDFFC9BBB1FFC3B1A6FFBCAB
                9FFFAF9B8EFFA69285FF937B6FFF574642C80000000A00000001000000022B25
                234EA49087FFC5B8ADFFE1DBD5FFF4F3F0FFE5E1DAFFCFC3B9FFC3B1A6FFC3B3
                A8FFB4A296FFAD998CFFA28C7FFF826A61FF211A19530000000300000004685C
                55A6B6A59AFFCEC4BBFFF2F0EDFFFCFCFBFFECEBE4FFD4C9C0FFC3B1A6FFC7B8
                AEFFB6A598FFAF9C8FFFA79284FF927A6DFF4E403CA900000006000000059E8C
                83ECC5B8AEFFE3DED8FFFCFAFAFFFDFCFBFFFCFBFAFFF8F8F5FFF6F3F0FFF2EE
                EBFFEAE4DFFFD8CEC6FFC5B6ACFFA18A7EFF77645DEB0000000800000004B19D
                94FFF0ECE9FFDCD5D2FFB6A8A4FF988681FF77615AFF7E6862FF89746CFF9580
                79FFB1A099FFC4B6B0FFD7CCC5FFDDD4CBFF87736BFE00000007000000023D35
                335CA8968DF0CCC0B9FFE3DBD6FFEFEBE7FFF1EEEAFFF4F0EEFFF1EDEAFFE8E1
                DCFFE0D7D1FFCEC2BAFFB3A39AFF8C7971F12F29266000000003000000000000
                00010807070F3E36335E695E579F897870CE8F7F77DDA49088FFA18D84FF8877
                70DD7D6C65CF5D514CA1352E2B60070606120000000300000000}
              ParentFont = False
              TabOrder = 0
              TabStop = False
              OnClick = btnProComClick
            end
          end
        end
        object Panel9: TPanel
          Left = 0
          Top = 364
          Width = 978
          Height = 196
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel9'
          TabOrder = 2
          ExplicitTop = 361
          object Panel10: TPanel
            Left = 0
            Top = 0
            Width = 682
            Height = 196
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel10'
            TabOrder = 0
            object Panel3: TPanel
              Left = 0
              Top = 0
              Width = 682
              Height = 22
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object btnProSim: TBitBtnLocked
                Left = 0
                Top = 1
                Width = 360
                Height = 21
                Caption = '[ F7 ] - Abrir Filtro para Inserir Produtos Similares'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000020000000900000011000000110000
                  0009000000020000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000093D332F8268524CF467514BF42E24
                  21820000000A0000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000108B756CFFEBE8E7FFBAAFA9FF6F58
                  50FF000000110000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000011877169FFE5E0DDFFBEB0A7FF715A
                  53FF000000120000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000010846E67FFE4DDDAFFC2B4ABFF735C
                  56FF000000110000000000000000000000000000000000000000000000000000
                  000000000000000000000000000200000012836C64FFDDD5D0FFC2B4ACFF775F
                  59FF000000140000000200000000000000000000000000000000000000000000
                  000000000000000000030101010F34292681826B64FFD3CFCBFFBDB3AEFF7962
                  5CFF2F2523830101011100000004000000010000000000000000000000000000
                  0000000000040C0A092662524ACC8F786EFFA18D81FFAE9B8FFFAF9A8EFF9D87
                  7AFF826A61FF554440CD0A080829000000050000000100000000000000000000
                  0003120F0E2D7F6B63ECA69186FFBEB0A5FFCCC1B8FFBDACA1FFBEABA0FFB29E
                  92FFA69082FF937B70FF6B5650ED0F0C0B310000000300000000000000010000
                  00076E5E58C6AD9B90FFC4B7ADFFE5DFDAFFDBD5CDFFC9BBB1FFC3B1A6FFBCAB
                  9FFFAF9B8EFFA69285FF937B6FFF574642C80000000A00000001000000022B25
                  234EA49087FFC5B8ADFFE1DBD5FFF4F3F0FFE5E1DAFFCFC3B9FFC3B1A6FFC3B3
                  A8FFB4A296FFAD998CFFA28C7FFF826A61FF211A19530000000300000004685C
                  55A6B6A59AFFCEC4BBFFF2F0EDFFFCFCFBFFECEBE4FFD4C9C0FFC3B1A6FFC7B8
                  AEFFB6A598FFAF9C8FFFA79284FF927A6DFF4E403CA900000006000000059E8C
                  83ECC5B8AEFFE3DED8FFFCFAFAFFFDFCFBFFFCFBFAFFF8F8F5FFF6F3F0FFF2EE
                  EBFFEAE4DFFFD8CEC6FFC5B6ACFFA18A7EFF77645DEB0000000800000004B19D
                  94FFF0ECE9FFDCD5D2FFB6A8A4FF988681FF77615AFF7E6862FF89746CFF9580
                  79FFB1A099FFC4B6B0FFD7CCC5FFDDD4CBFF87736BFE00000007000000023D35
                  335CA8968DF0CCC0B9FFE3DBD6FFEFEBE7FFF1EEEAFFF4F0EEFFF1EDEAFFE8E1
                  DCFFE0D7D1FFCEC2BAFFB3A39AFF8C7971F12F29266000000003000000000000
                  00010807070F3E36335E695E579F897870CE8F7F77DDA49088FFA18D84FF8877
                  70DD7D6C65CF5D514CA1352E2B60070606120000000300000000}
                ParentFont = False
                TabOrder = 0
                TabStop = False
                OnClick = btnProSimClick
              end
            end
            object cxgProSim: TcxGridCitel
              Left = 0
              Top = 22
              Width = 682
              Height = 174
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxgProSimTableView1: TcxGridDBTableViewCitel
                Navigator.Buttons.CustomButtons = <>
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.ApplyChanges = fracDelayed
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                Zebra = False
                Destaque = False
                CorZebra = clMoneyGreen
              end
              object cxGridDBBandedTableViewCitel2: TcxGridDBBandedTableViewCitel
                OnKeyDown = cxGridDBBandedTableViewCitel2KeyDown
                Navigator.Buttons.CustomButtons = <>
                DataController.DataSource = dtsProSim
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.ApplyChanges = fracDelayed
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                Bands = <
                  item
                    Caption = 'Produtos Similares aos Produtos do Combo'
                    Styles.Header = cxStyle1
                    Width = 656
                  end>
                Zebra = True
                Destaque = True
                DestacarRegistro = True
                CorZebra = clMoneyGreen
                object cxGridDBBandedColumn1: TcxGridDBBandedColumn
                  Caption = 'C'#243'digo'
                  DataBinding.FieldName = 'CODITES'
                  Options.Focusing = False
                  Styles.Header = cxStyle2
                  Width = 78
                  Position.BandIndex = 0
                  Position.ColIndex = 0
                  Position.RowIndex = 0
                end
                object cxGridDBBandedColumn2: TcxGridDBBandedColumn
                  Caption = 'Descri'#231#227'o'
                  DataBinding.FieldName = 'DESITES'
                  Options.Focusing = False
                  Styles.Header = cxStyle2
                  Width = 329
                  Position.BandIndex = 0
                  Position.ColIndex = 1
                  Position.RowIndex = 0
                end
                object cxGridDBBandedColumn3: TcxGridDBBandedColumn
                  Caption = 'Refer'#234'ncia'
                  DataBinding.FieldName = 'REFERES'
                  Options.Focusing = False
                  Styles.Header = cxStyle2
                  Width = 100
                  Position.BandIndex = 0
                  Position.ColIndex = 2
                  Position.RowIndex = 0
                end
                object cxGridDBBandedColumn4: TcxGridDBBandedColumn
                  Caption = 'Un.'
                  DataBinding.FieldName = 'SIGUNIS'
                  Options.Focusing = False
                  Styles.Header = cxStyle2
                  Width = 34
                  Position.BandIndex = 0
                  Position.ColIndex = 3
                  Position.RowIndex = 0
                end
              end
              object cxGridLevel2: TcxGridLevel
                GridView = cxGridDBBandedTableViewCitel2
              end
            end
          end
          object Panel11: TPanel
            Left = 682
            Top = 0
            Width = 296
            Height = 196
            Align = alRight
            BevelOuter = bvNone
            Caption = 'Panel11'
            TabOrder = 1
            object Panel12: TPanel
              Left = 0
              Top = 0
              Width = 296
              Height = 22
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object btnInsEle: TBitBtnLocked
                Left = 0
                Top = 1
                Width = 294
                Height = 21
                Caption = '[ F8 ] - Inserir / Remover Elementos'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000020000000900000011000000110000
                  0009000000020000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000093D332F8268524CF467514BF42E24
                  21820000000A0000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000108B756CFFEBE8E7FFBAAFA9FF6F58
                  50FF000000110000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000011877169FFE5E0DDFFBEB0A7FF715A
                  53FF000000120000000000000000000000000000000000000000000000000000
                  000000000000000000000000000000000010846E67FFE4DDDAFFC2B4ABFF735C
                  56FF000000110000000000000000000000000000000000000000000000000000
                  000000000000000000000000000200000012836C64FFDDD5D0FFC2B4ACFF775F
                  59FF000000140000000200000000000000000000000000000000000000000000
                  000000000000000000030101010F34292681826B64FFD3CFCBFFBDB3AEFF7962
                  5CFF2F2523830101011100000004000000010000000000000000000000000000
                  0000000000040C0A092662524ACC8F786EFFA18D81FFAE9B8FFFAF9A8EFF9D87
                  7AFF826A61FF554440CD0A080829000000050000000100000000000000000000
                  0003120F0E2D7F6B63ECA69186FFBEB0A5FFCCC1B8FFBDACA1FFBEABA0FFB29E
                  92FFA69082FF937B70FF6B5650ED0F0C0B310000000300000000000000010000
                  00076E5E58C6AD9B90FFC4B7ADFFE5DFDAFFDBD5CDFFC9BBB1FFC3B1A6FFBCAB
                  9FFFAF9B8EFFA69285FF937B6FFF574642C80000000A00000001000000022B25
                  234EA49087FFC5B8ADFFE1DBD5FFF4F3F0FFE5E1DAFFCFC3B9FFC3B1A6FFC3B3
                  A8FFB4A296FFAD998CFFA28C7FFF826A61FF211A19530000000300000004685C
                  55A6B6A59AFFCEC4BBFFF2F0EDFFFCFCFBFFECEBE4FFD4C9C0FFC3B1A6FFC7B8
                  AEFFB6A598FFAF9C8FFFA79284FF927A6DFF4E403CA900000006000000059E8C
                  83ECC5B8AEFFE3DED8FFFCFAFAFFFDFCFBFFFCFBFAFFF8F8F5FFF6F3F0FFF2EE
                  EBFFEAE4DFFFD8CEC6FFC5B6ACFFA18A7EFF77645DEB0000000800000004B19D
                  94FFF0ECE9FFDCD5D2FFB6A8A4FF988681FF77615AFF7E6862FF89746CFF9580
                  79FFB1A099FFC4B6B0FFD7CCC5FFDDD4CBFF87736BFE00000007000000023D35
                  335CA8968DF0CCC0B9FFE3DBD6FFEFEBE7FFF1EEEAFFF4F0EEFFF1EDEAFFE8E1
                  DCFFE0D7D1FFCEC2BAFFB3A39AFF8C7971F12F29266000000003000000000000
                  00010807070F3E36335E695E579F897870CE8F7F77DDA49088FFA18D84FF8877
                  70DD7D6C65CF5D514CA1352E2B60070606120000000300000000}
                ParentFont = False
                TabOrder = 0
                TabStop = False
                OnClick = btnInsEleClick
              end
            end
            object cxgElemen: TcxGridCitel
              Left = 0
              Top = 22
              Width = 296
              Height = 153
              Align = alClient
              TabOrder = 1
              LookAndFeel.ScrollbarMode = sbmClassic
              object cxgElemenDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
                OnKeyDown = cxgElemenDBBandedTableViewCitel1KeyDown
                Navigator.Buttons.CustomButtons = <>
                DataController.DataSource = dtsElemen
                DataController.Filter.Options = [fcoCaseInsensitive]
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                FilterRow.InfoText = 'Clique aqui para definir um filtro'
                FilterRow.ApplyChanges = fracDelayed
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
                OptionsView.GroupByBox = False
                Bands = <
                  item
                    Caption = 'Elementos de Indica'#231#227'o'
                    Styles.Header = cxStyle1
                    Width = 263
                  end>
                Zebra = True
                Destaque = True
                DestacarRegistro = True
                CorZebra = clMoneyGreen
                object DESELE: TcxGridDBBandedColumn
                  Caption = 'Elementos'
                  DataBinding.FieldName = 'DESELE'
                  Styles.Header = cxStyle2
                  Width = 200
                  Position.BandIndex = 0
                  Position.ColIndex = 0
                  Position.RowIndex = 0
                end
                object TEMREG: TcxGridDBBandedColumn
                  DataBinding.FieldName = 'TEMREG'
                  PropertiesClassName = 'TcxImageComboBoxProperties'
                  Properties.Images = cxImageList1
                  Properties.Items = <
                    item
                      ImageIndex = 0
                      Value = 'S'
                    end
                    item
                      ImageIndex = 1
                      Value = 'N'
                    end>
                  Width = 20
                  Position.BandIndex = 0
                  Position.ColIndex = 1
                  Position.RowIndex = 0
                  IsCaptionAssigned = True
                end
              end
              object cxgElemenLevel1: TcxGridLevel
                GridView = cxgElemenDBBandedTableViewCitel1
              end
            end
            object pnlLegEle: TPanel
              Left = 0
              Top = 175
              Width = 296
              Height = 21
              Align = alBottom
              TabOrder = 2
              object Image1: TImage
                Left = 8
                Top = 1
                Width = 17
                Height = 17
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                  4D410000B18F0BFC610500000023744558745469746C650043616E63656C3B53
                  746F703B457869743B426172733B526962626F6E3B4C9696B20000039A494441
                  54384F25937F5093751CC7BF08A6D8A4BAD24E625D601B220E866C6DA01E63C6
                  84C12CF8232C4FBD32135046C7717990245E144EEE34032EEE883A301164FCB0
                  84399D79594917C3C680720B04F921C2F66CC006DB91DEBBEFF3F0BD7B3DF7BE
                  CFE7F37E3FDFEF73CF97784CADC473BB8378EF5C257405FE967B44642B2AA87A
                  70A2D0325E5CF48485D57F176A6B0C1F1C14D399204A80C7A4270BC6164203F4
                  AC3180B2DAAACD2B1EFDF413FFECB75FC3DDDE00CFED4E7829EEF646CCD45761
                  ECE409BFF9D8D1523ABB96B28A0BA02B402B97F1868EE799C62BCAE0B9D58EF9
                  EE8B98EBA887ABA506AEE61AB8DBEA30F75323E8CB3071F6730C1CCFFD451329
                  7C810D610382CC1F1EFE66B4BC941A2FC152948FBA70118C999970369E83B3E1
                  1C6E666571354BE1312E68ECCB32FC71F8FDCBD4BB967466654AADB9394F18FD
                  77B857908306D53B30759BD19C53826E75060CE91A4E9BBA7AB99E39FF23B8AE
                  D4C19A9FF7B43E353589983234B5235F9CC4E3DA0AD4F1A3F0C03E05876B09F6
                  51062DDAD31CF7A99E767A316C9BE266A6ABCB3172BA0486B4743DB9B9473D6C
                  3FFA2E46B4FB7143F316FED49D8777E93F38E77DB03D64601B63303BE7C3C2E2
                  32D7336AF662382F1BB623D9B8A14A7B48AE2B54CBFF64A760E8ED1DB01FA25B
                  DEBD1B3DBA0B9871FB304377F2D84D617CF8BDE22B18944ADC3F9086C18C040C
                  6625C1A048592657E549CB96D43730A09661686F22AE49B6C378EA2CDDF2121E
                  391731E5F0529670BD54876BF1DB31902E87758F14FD2A09582F6912CBC77A95
                  2B85AED86D68FBB80C03FF3A3039EB05B3E00333EFC7F88C17FDF659E80B4EA1
                  2B261A9637E3D0AB10A3295636456A85E2EF4D3B64B028C5B8142E8473DA8949
                  C7225C0B7EF45FA8E65809F1C0F1C8C9CDFC9514839F1325A816C47692A2D088
                  5D17A3E29E9A776EC35DA51CB70E1C829F61704F5709A32C9E22E1345B637B77
                  9365E84B8CC60F5BC4C87FF93535FB230557BE22BC7C25722B2CC9B1E84996A2
                  551809932C8E7E1739776656B3B51E851416450CF4915138B349C05E9EF56CC0
                  AAAD6BD66DA8DCB8B9AF294200F32E113525A03F4582BE8428CA167AE6780CAA
                  13D0B75384E6CD029CD9186115AD79964FBD8164A2E03D362430FE19DEA6B2E7
                  F82D551BC2D12E88C01DF1EBE895D240CAAF5477D05A35ED7DF63CFFC7E8D5C1
                  AF524FD0B8761F21EC83132B17837770DD4BAA125E686B7948D8842E840F5D48
                  18CAD7874D16F342DBF607BFA8A1332194C015DF3EF23F759146D7DCAFD62A00
                  00000049454E44AE426082}
              end
              object Label7: TLabel
                Left = 28
                Top = 3
                Width = 75
                Height = 14
                Caption = 'Sem Registro'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Image2: TImage
                Left = 194
                Top = 1
                Width = 17
                Height = 17
                Picture.Data = {
                  0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
                  0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
                  4D410000B18F0BFC610500000021744558745469746C65004170706C793B4F4B
                  3B436865636B3B426172733B526962626F6E3B6463C868000003A64944415438
                  4F4D937D50D3751CC77FA2AB0CCE844EAD331B0339C6C38603EDCE23E80865E4
                  248ABA150B27D1648E8D1288A734E681131FB8AC29036CCB8C553320F0085C20
                  C822260F4D6C83C538509EDA788807818CFE7AF7FDCDBAEB77F7BAFBDD7D3FEF
                  D7E7F3B9FB7EA9C995066AEEA18922DF3AC2FA8C0BEC985C6DA8EE7835A75F69
                  085B507ECBED3FA1E7346495070BC9F963048FF9BFCC94EBCF1BD4D44A3D45B9
                  568DEE7052166B5BA63AC8585AB30FAD5615EC4E03E656BB30345303D3D059A8
                  9B0528F832B44F54E81748379A7D78EB91800E0BD299CF647C1A3C6C301DC3E4
                  721386972A3130AFC29DB95CD817CF6074590BD76A0B1A2D05C8D7716793F3FD
                  B824E731B15CE7166C78EF34BBA9CE5C00C7C26574FC7E049D2E09CC2E19BAA7
                  E5E89951A067568E66BB18BFCD57A0D5761A8ACF42ACDB777A7AD1CDA9A46C3F
                  FE716D2CEC7F94A3E5BE086D1362DC9A7A1726A7045D4E296E4F4B5174752F0E
                  64322139CF8663B11265B509385414904937A7DEFE28A0A6A13B1F37C7D27063
                  544824C9681B4F413B1199A60E435AC646DE27328C8C3BC1976FC30F4387D136
                  58823455A099083652C242FF91764701AE0F2741DD128518D946E469C360BCF7
                  1672AA3828D2E4C035BB04C599445C6E15E1C77BEFE0F6841269A5EC3522F0A2
                  DECCF35F363AD261B0C52146EA893EAB15F91732102BF7768727A71FE0FC57D9
                  507D1347A613A3DE71103F4DC8917A2A102191DECF52AF65FBDED7F70A60B0EE
                  83BA311119C5AFC239B384A6CE0E8C4E2E6260F40E1273B7C338928ADAA1787C
                  67E7A376E075883E0EA027D844252858CD658D51B862D98B6B83021457C7A2B8
                  428685076B5858F91B87947B70F567210C83B1D0DBA2A1FFF54594DF8CC11B39
                  2C0B1178522F8B7788D3CF71F185251215BDBB70CD264056F96EE8EA4B61EABF
                  8ED473FE64BDFDB8D2FF023EB744A0FA6E348E5DE2812F795E49048F13A82705
                  72DFBB27BEE6A2AA37029A6E2E59E720524A7C1129A5A069DF8FAA3E1E2A09DA
                  5F76A3A48E87C40F58362F1FC6D324EB410BD647C46FE52564FACD7FA80B2282
                  30687AB8644F219A868F424726D3F4EC22F27014EA439094E3BF161EB7258AE4
                  189D13EF5394695C464B18E1F15BF71C90F98EA49CDC89A2DA20A8BB4271A99B
                  838B660E4E7E1F8C5455005E39CA1CE03D0AD3A3AF73673BC624B4807E891BC8
                  583ED1C9CF15C6499866819C05370A16F84798D697443B4E793EC5D842EA1874
                  3D9D7367FFFBF95744EF44DBE97BBE99E043F0266C223C41F0F87F7DC79884FA
                  070244118F93E074F30000000049454E44AE426082}
              end
              object Label8: TLabel
                Left = 214
                Top = 3
                Width = 76
                Height = 14
                Caption = 'Com Registro'
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
      end
      object pnlProCom: TPanel
        Left = 992
        Top = 0
        Width = 26
        Height = 560
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitHeight = 557
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 14
        Height = 560
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitHeight = 557
      end
    end
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 129
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel2: TPanel
        Left = 757
        Top = 0
        Width = 261
        Height = 129
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object Panel13: TPanel
          Left = 235
          Top = 0
          Width = 26
          Height = 129
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object Panel14: TPanel
          Left = 0
          Top = 0
          Width = 235
          Height = 129
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object clbEmpresa: TCheckListBox
            Tag = 99
            Left = 0
            Top = 17
            Width = 235
            Height = 112
            Align = alClient
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            TabOrder = 0
            OnKeyDown = clbEmpresaKeyDown
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 235
            Height = 17
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Empresas que se aplicam o Combo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object pnlCabRig: TPanel
        Left = 0
        Top = 0
        Width = 757
        Height = 129
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object pnlCabeça: TPanel
          Left = 0
          Top = 0
          Width = 757
          Height = 129
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 17
            Top = 11
            Width = 39
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo:'
          end
          object Label2: TLabel
            Left = 546
            Top = 14
            Width = 46
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Validade:'
          end
          object Label3: TLabel
            Left = 668
            Top = 14
            Width = 6
            Height = 14
            Alignment = taRightJustify
            Caption = 'a'
          end
          object lblTabPreco: TLabel
            Left = 58
            Top = 32
            Width = 280
            Height = 14
            Caption = 'Este Combo se aplica para as seguintes tabelas de pre'#231'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbeCodCom: TDBEditFocus
            Tag = 99
            Left = 58
            Top = 7
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'COM_CODCOM'
            DataSource = dtsComVen
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesCom: TDBEditFocus
            Tag = 99
            Left = 129
            Top = 7
            Width = 411
            Height = 22
            CharCase = ecUpperCase
            DataField = 'COM_DESCOM'
            DataSource = dtsComVen
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
            Left = 594
            Top = 10
            Width = 68
            Height = 22
            CharCase = ecUpperCase
            DataField = 'COM_DTAINI'
            DataSource = dtsComVen
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaFin: TDBEditFocus
            Tag = 99
            Left = 679
            Top = 10
            Width = 68
            Height = 22
            CharCase = ecUpperCase
            DataField = 'COM_DTAFIN'
            DataSource = dtsComVen
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object clbTabPre: TCheckListBox
            Left = 58
            Top = 48
            Width = 482
            Height = 64
            OnClickCheck = clbTabPreClickCheck
            Columns = 3
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            Items.Strings = (
              'Tabela de Pre'#231'o 1'
              'Tabela de Pre'#231'o 2'
              'Tabela de Pre'#231'o 3'
              'Tabela de Pre'#231'o 4'
              'Tabela de Pre'#231'o 5'
              'Tabela de Pre'#231'o 6'
              'Tabela de Pre'#231'o 7')
            Style = lbOwnerDrawFixed
            TabOrder = 4
            OnDrawItem = clbTabPreDrawItem
            OnKeyDown = clbTabPreKeyDown
          end
        end
      end
    end
    object pnlRodape: TPanel
      Left = 0
      Top = 689
      Width = 1018
      Height = 37
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 686
      object Label4: TLabel
        Left = 16
        Top = 3
        Width = 387
        Height = 14
        AutoSize = False
        Caption = '[ F3 ] Alternar entre Grids(Ativa'#231#227'o/Combo/Similares/Elementos) '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 9
        Top = 18
        Width = 153
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '[ DELETE ] Excluir Produtos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 401
        Top = 3
        Width = 125
        Height = 14
        AutoSize = False
        Caption = '[ ENTER ] Editar dados'
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
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 352
    Top = 0
  end
  object dtsProAti: TDataSource
    Left = 170
    Top = 371
  end
  object dtsComVen: TDataSource
    Left = 410
    Top = 65531
  end
  object dtsProCom: TDataSource
    Left = 378
    Top = 219
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 624
    Top = 72
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 568
    Top = 72
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object cxStyleRepository3: TcxStyleRepository
    Left = 592
    Top = 120
    PixelsPerInch = 96
    object cxStyle3: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clYellow
    end
  end
  object dtsProSim: TDataSource
    Left = 242
    Top = 571
  end
  object dtsElemen: TDataSource
    Left = 754
    Top = 547
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 8389072
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
      end>
  end
end
