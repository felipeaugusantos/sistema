inherited frmEntImportacaoNotaEletronica: TfrmEntImportacaoNotaEletronica
  Left = 195
  Top = 179
  Width = 1024
  Height = 678
  Caption = 'Importa'#231#227'o de Nota Eletr'#244'nica'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 678
  PixelsPerInch = 96
  TextHeight = 14
  object splSepador: TSplitter [0]
    Left = 0
    Top = 40
    Height = 278
    ExplicitLeft = 264
    ExplicitTop = 224
    ExplicitHeight = 100
  end
  object Splitter1: TSplitter [1]
    Left = 0
    Top = 578
    Width = 1008
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    MinSize = 20
    ResizeStyle = rsNone
    ExplicitLeft = 2
    ExplicitTop = 239
  end
  inherited pnlBotoes: TPanel
    Top = 594
    Width = 1008
    Height = 29
    TabOrder = 7
    ExplicitTop = 594
    ExplicitWidth = 1008
    ExplicitHeight = 29
    DesignSize = (
      1008
      29)
    object lblInformacao: TLabel [0]
      Left = 904
      Top = 2
      Width = 3
      Height = 25
      Align = alLeft
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 14
    end
    inherited FlwBotoes: TFlowPanel
      Left = 127
      Width = 263
      Height = 25
      Align = alLeft
      TabOrder = 1
      ExplicitLeft = 127
      ExplicitWidth = 263
      ExplicitHeight = 25
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 140
        Height = 25
        Caption = '[ F3 ] Mudar Ordena'#231#227'o'
        Spacing = 2
        ExplicitWidth = 140
        ExplicitHeight = 25
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 140
        Width = 122
        Height = 25
        Caption = '[ F5 ] &Abrir Pesquisa'
        Spacing = 2
        ExplicitLeft = 140
        ExplicitWidth = 122
        ExplicitHeight = 25
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1080
      Top = 4
      Width = 156
      Caption = '[ ESC ] &Cancelar'
      TabOrder = 5
      ExplicitLeft = 1080
      ExplicitTop = 4
      ExplicitWidth = 156
    end
    object btnImporta: TBitBtnLocked
      Left = 741
      Top = 2
      Width = 163
      Height = 25
      Align = alLeft
      Caption = '[ F10 ] &Importar Documentos'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
        FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
        00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
        F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
        00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
        F033777777777337F73309999990FFF0033377777777FFF77333099999000000
        3333777777777777333333399033333333333337773333333333333903333333
        3333333773333333333333303333333333333337333333333333}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnImportaClick
    end
    object btnRelErr: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 125
      Height = 25
      Align = alLeft
      Caption = '[ F2 ] &Relat'#243'rio Erros'
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
      TabOrder = 0
      OnClick = btnRelErrClick
    end
    object btnCadFornecedor: TBitBtnLocked
      Left = 390
      Top = 2
      Width = 184
      Height = 25
      Align = alLeft
      Caption = '[ F7 ] Cadastro de &Fornecedores'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000070000
        000B0000000C0000000C0000000C0000000C0000000D0000000D0000000D0000
        000D0000000D0000000E0000000E0000000E0000000D000000097B502ABEAC70
        3BFFAB6F3CFFAB703BFFAC703BFFAC6F3CFFAC703BFFAC703BFFAC703BFFAC70
        3BFFAC703BFFAB703CFFAC6F3CFFAC703BFFAC703CFF7B512BC0B17743FFDDB6
        86FFD6AA74FFD7AA72FFD6A872FFD6A872FFD6A771FFD5A770FFD5A66FFFD5A5
        6FFFD5A56EFFD4A56DFFD4A46DFFD4A46CFFD9AE7BFFB17743FFB67E4BFFDBB2
        82FFD2A069FFD19F68FFD19E68FFD09E66FFD09E65FFD09D65FFCE9C64FFCE9C
        63FFCE9B63FFCE9A62FFCE9A61FFCD9A62FFD5A975FFB77F4BFFB27C69FFF7F1
        ECFFF5EDE6FFF5ECE6FFF5ECE6FFF5EDE6FFF5ECE6FFF4ECE5FFF5ECE6FFF5EC
        E5FFF4EBE5FFF4ECE5FFF5ECE4FFF5EBE5FFF6F0EAFFA66D59FFB68370FFF8F3
        EFFF9B7E72FF8D6D60FF8C6C60FF8C6C5FFF8B6B5FFF8B6A5EFF907365FFF4EC
        E5FFF6EDE7FFF5EDE7FFF5EDE6FFF5ECE6FFF7F1ECFFAA725EFFBB8977FFFAF4
        F2FFE8DED7FFB6A096FF8F7165FF8E6E62FF8E6E62FFAE968CFFE3D8D1FFF6EF
        E9FFB88D7CFFB88C7BFFB78B79FFB68A78FFF8F3EEFFAE7864FFC08F7DFFFAF6
        F4FFF7F2EDFFF7F1EDFFA2877CFF917266FF9D8276FFF7F1ECFFF7F0EBFFF7F0
        EBFFF7F0EBFFF7F0EBFFF7F0EBFFF7F0EAFFF9F4F2FFB37D6AFFC39584FFFBF8
        F6FFF9F4EFFFF2ECE7FF94766BFF937569FF93756AFFF2EBE6FFF8F2EEFFF8F2
        EEFFC09786FFC09584FFBD9382FFBD9282FFFAF6F3FFB88471FFC89B89FFFCF9
        F7FFFAF5F2FFB8A199FF96796DFF95786CFF95776BFFB5A097FFF9F4F1FFF9F3
        F0FFF9F4F0FFF8F3F0FFF8F3F0FFF8F4F0FFFBF8F5FFBC8A77FFCCA18FFFFCFB
        F9FFFAF7F4FFA58C82FF987B70FF987B6FFF977A6FFFA48A7FFFFAF6F3FFFAF6
        F3FFC7A091FFC6A08EFFC49D8DFFC49C8CFFFCF9F7FFC0907EFFD0A694FFFDFB
        FBFFFCF8F6FFD6C9C3FFA88E85FFA0847AFFA78E84FFD5C7C2FFFBF7F5FFFBF7
        F5FFFBF7F5FFFAF7F5FFFBF7F4FFFBF6F4FFFDFBF9FFC49784FFD3AA99FFFEFE
        FDFFFEFEFDFFFEFEFDFFFEFEFDFFFEFEFDFFFEFEFDFFFEFEFDFFFEFEFDFFFEFE
        FDFFFEFEFDFFFEFDFDFFFEFDFDFFFEFDFDFFFEFDFDFFC99C8AFF9E8174BFD5AE
        9CFFD5AD9BFFD5AC9AFFD4AB9AFFD3AA99FFD2AA98FFD2A997FFD1A897FFD1A7
        95FFD1A695FFD0A594FFCFA593FFCEA392FFCDA291FF98786BC1000000020000
        0003000000040000000400000004000000040000000400000005000000050000
        0005000000050000000500000005000000050000000500000004}
      TabOrder = 2
      OnClick = btnCadFornecedorClick
    end
    object btnMarcaDesmarcaTodos: TBitBtnLocked
      Left = 574
      Top = 2
      Width = 167
      Height = 25
      Align = alLeft
      Caption = '[ F8 ] Marca/Desmarca Todos'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnMarcaDesmarcaTodosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 623
    Width = 1008
    TabOrder = 3
    ExplicitTop = 623
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
  inherited pnlHeader: TPanel
    Left = 3
    Top = 40
    Width = 361
    Height = 278
    Align = alLeft
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 40
    ExplicitWidth = 361
    ExplicitHeight = 278
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 361
      Height = 87
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 4
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      object lblPastaArq: TLabel
        Left = 4
        Top = 4
        Width = 353
        Height = 79
        Align = alClient
        Caption = 'Pasta dos arquivos XML'
        ExplicitWidth = 117
        ExplicitHeight = 14
      end
      object Label2: TLabel
        Left = 4
        Top = 47
        Width = 275
        Height = 14
        Caption = 'Chave de Acesso da Danfe para Importar do Servi'#231'o  FIT'
      end
      object edtChaveAcesso: TMaskEditFocus
        Left = 4
        Top = 61
        Width = 351
        Height = 20
        Ctl3D = False
        Enabled = False
        EditMask = 
          '9999\-9999\-9999\-9999\-9999\-9999\-9999\-9999\-9999\-9999\-9999' +
          ';1;_'
        MaxLength = 54
        ParentCtl3D = False
        TabOrder = 1
        Text = '    -    -    -    -    -    -    -    -    -    -    '
        OnKeyPress = edtChaveAcessoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      inline fraPathXml: TfraDirectoryEditFocus
        Left = 4
        Top = 19
        Width = 352
        Height = 22
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 19
        inherited edtDirectory: TEditFocus
          OnChange = fraPathXmledtDirectoryChange
          OnExit = fraPathXmledtDirectoryExit
          ExplicitHeight = 22
        end
      end
    end
    object cklArqXML: TCheckListBox
      Tag = 99
      Left = 0
      Top = 109
      Width = 361
      Height = 169
      Align = alClient
      Enabled = False
      ItemHeight = 14
      TabOrder = 1
    end
    object btnDownloadFiles: TBitBtnLocked
      Left = 0
      Top = 87
      Width = 361
      Height = 22
      Align = alTop
      Caption = '[Alt + F3] &Baixar Arquivos Pendentes'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
        84FF848484FF848484FF848484FF000000000000000000000000000000000000
        0000848484FF0000000000000000000000000000000000000000000000000000
        00000000000000000000848484FF000000000000000000000000000000000000
        0000000000000000000000000000000000003827174DB8824DFF3827174D0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000003827174DB8824DFFB8824DFFB8824DFF3827
        174D000000000000000000000000000000000000000000000000000000000000
        000000000000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB882
        4DFF3827174D0000000000000000000000000000000000000000000000000000
        0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
        4DFFB8824DFF3827174D00000000000000000000000000000000000000000000
        00003827174DB8824DFFB8824DFF3827174DB8824DFFB8824DFFB8824DFF3827
        174DB8824DFFB8824DFF3827174D000000000000000000000000000000000000
        000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000B8824DFFB8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 2
      OnClick = btnDownloadFilesClick
    end
  end
  inherited pnlTail: TPanel
    Top = 318
    Width = 1008
    Height = 0
    Enabled = False
    TabOrder = 4
    Visible = True
    ExplicitTop = 318
    ExplicitWidth = 1008
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Left = 364
    Top = 40
    Width = 644
    Height = 278
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    OnEnter = dbgConsultaEnter
    OnExit = dbgConsultaExit
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'B08_NNF'
        Title.Alignment = taCenter
        Title.Caption = 'Nota Fiscal'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'B07_SERIE'
        Title.Alignment = taCenter
        Title.Caption = 'S'#233'rie'
        Width = 30
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'B09_DEMI'
        Title.Alignment = taCenter
        Title.Caption = 'Emiss'#227'o'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C03_XNOME'
        Title.Caption = 'Fornecedor'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMARQ'
        Title.Caption = 'Nome do Arquivo'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOFOR'
        Title.Caption = 'Tipo Fornecedor'
        Width = 215
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C12_UF'
        Title.Caption = 'UF'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPAJUSTE'
        Title.Alignment = taCenter
        Title.Caption = 'Nf Ajuste?'
        Width = 60
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 0
    Width = 1008
    TabOrder = 0
    ExplicitTop = 0
    ExplicitWidth = 1008
  end
  object pgcInformacoes: TPageControl [8]
    Left = 0
    Top = 318
    Width = 1008
    Height = 260
    HelpType = htKeyword
    HelpKeyword = 'na'
    ActivePage = tbsErrItens
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnChange = pgcInformacoesChange
    object tbsLogErr: TTabSheet
      Caption = '&Log de Erros Importa'#231#227'o'
      object memLogErr: TMemo
        Left = 0
        Top = 0
        Width = 1000
        Height = 231
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        Lines.Strings = (
          '')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WordWrap = False
      end
    end
    object tbsErrItens: TTabSheet
      Caption = '&Produtos n'#227'o encontrados no sistema'
      ImageIndex = 1
      object dbgIteFor: TDBGridCitel
        Left = 0
        Top = 0
        Width = 1000
        Height = 144
        Align = alClient
        DataSource = dtsIteFor
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = [fsBold]
        OnEnter = dbgIteForEnter
        OnKeyPress = dbgIteForKeyPress
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'ITE_NUMDOC'
            ReadOnly = True
            Title.Caption = 'Nota Fiscal'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CODFOR'
            ReadOnly = True
            Title.Caption = 'C'#243'd.Forn.'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 58
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_NOMFOR'
            ReadOnly = True
            Title.Caption = 'Nome do Fornecedor'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 230
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_DESITF'
            ReadOnly = True
            Title.Caption = 'Descri'#231#227'o Item Fornec.'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 232
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CODITF'
            ReadOnly = True
            Title.Caption = 'C'#243'd. Item Fornec.'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 132
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CLAIPI'
            Title.Caption = 'NCM'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CODSIT'
            Title.Caption = 'CST'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 28
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CLAFIS'
            Title.Caption = 'CFOP'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CODITE'
            Title.Caption = 'C'#243'digo Item'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_DESITE'
            ReadOnly = True
            Title.Caption = 'Descri'#231#227'o do Item'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 232
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'C12_UF'
            ReadOnly = True
            Title.Caption = 'UF'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 28
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_CODFAB'
            ReadOnly = True
            Title.Caption = 'C'#243'digo de F'#225'brica'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = 14
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_UNIDAD'
            Title.Caption = 'Unidade'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ITE_UNITAR'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Unit'#225'rio'
            Title.Font.Charset = ANSI_CHARSET
            Title.Font.Color = clBlack
            Title.Font.Height = -11
            Title.Font.Name = 'Arial'
            Title.Font.Pitch = fpVariable
            Title.Font.Style = []
            Width = 73
            Visible = True
          end>
      end
      object Panel2: TPanel
        Left = 0
        Top = 198
        Width = 1000
        Height = 33
        Align = alBottom
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        object Label1: TLabel
          Left = 493
          Top = 1
          Width = 506
          Height = 31
          Align = alRight
          Alignment = taCenter
          Caption = 
            '** S'#227'o exibidos os produtos de Notas Fiscais que n'#227'o foram impor' +
            'tadas por motivo de inconsist'#234'ncias ** '
          Layout = tlCenter
          ExplicitHeight = 14
        end
        object btnConfCodigos: TBitBtnLocked
          Left = 5
          Top = 6
          Width = 268
          Height = 22
          Caption = '[ F9 ] &Confirmar relacionamentos entre c'#243'digos'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
            83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
            DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
            AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
            00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
            E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
            3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
            ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
            CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
            00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
            F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
            0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
            D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
            2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
            43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
            DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
            FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
            0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
            82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          OnClick = btnConfCodigosClick
        end
        object btnCadastroDeProduto: TBitBtnLocked
          Left = 274
          Top = 6
          Width = 159
          Height = 22
          Hint = 'Aperte a tecla F6 para entrar na tela "Cadastro de Produtos"'
          Caption = '[ F6 ] Cadastro de &Produto'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
            83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
            DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
            AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
            00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
            E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
            3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
            ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
            CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
            00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
            F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
            0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
            D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
            2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
            43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
            DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
            FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
            0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
            82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnCadastroDeProdutoClick
        end
      end
      object pnlAplicacao: TPanel
        Left = 0
        Top = 144
        Width = 1000
        Height = 54
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        object pnlAplica: TPanel
          Left = 0
          Top = 0
          Width = 1000
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Aplica'#231#227'o'
          Color = 16770261
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object mmoAplica: TDBMemoFocus
          Left = 0
          Top = 20
          Width = 1000
          Height = 34
          Align = alClient
          BorderStyle = bsNone
          DataField = 'ITE_APLICA'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
  end
  object pgbProgresso: TProgressBar [9]
    Left = 0
    Top = 584
    Width = 1008
    Height = 10
    Align = alBottom
    Smooth = True
    TabOrder = 6
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
    Top = 65528
  end
  inherited qryConsulta: TUniQuery
    Left = 152
    Top = 336
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 184
    Top = 336
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    ProviderName = ''
    Left = 216
    Top = 336
    object cdsConsultaB08_NNF: TStringField
      FieldName = 'B08_NNF'
      Size = 12
    end
    object cdsConsultaB07_SERIE: TStringField
      FieldName = 'B07_SERIE'
      Size = 3
    end
    object cdsConsultaB09_DEMI: TDateField
      FieldName = 'B09_DEMI'
    end
    object cdsConsultaC03_XNOME: TStringField
      FieldName = 'C03_XNOME'
      Size = 60
    end
    object cdsConsultaNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 255
    end
    object cdsConsultaGER_CODFOR: TStringField
      FieldName = 'GER_CODFOR'
    end
    object cdsConsultaDIV_CST: TBooleanField
      FieldName = 'DIV_CST'
    end
    object cdsConsultaVRDUPDIVCON: TBooleanField
      FieldName = 'VRDUPDIVCON'
    end
    object cdsConsultaTIPOFOR: TStringField
      FieldName = 'TIPOFOR'
      Size = 25
    end
    object cdsConsultaC12_UF: TStringField
      FieldName = 'C12_UF'
      Size = 2
    end
    object cdsConsultaTIPAJUSTE: TStringField
      FieldName = 'TIPAJUSTE'
      Size = 10
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 248
    Top = 336
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40141.361759432870000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 248
    Top = 368
    Datasets = <
      item
        DataSet = frxDBErros
        DataSetName = 'frxDBErros'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 253.228510000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBErros
        DataSetName = 'frxDBErros'
        RowCount = 0
        Stretched = True
        object mmoDetalhe: TfrxMemoView
          Width = 1044.283676930000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ERROS:')
          ParentFont = False
        end
        object frxDBErrosMOTIVO: TfrxMemoView
          Left = 79.370130000000000000
          Width = 953.574956930000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataField = 'MOTIVO'
          DataSet = frxDBErros
          DataSetName = 'frxDBErros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBErros."MOTIVO"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 374.173470000000000000
        Width = 1046.929810000000000000
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 111.440940000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
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
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 316.460205000000000000
          Top = 34.000000000000000000
          Width = 414.009400000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE CRITICAS DE IMPORTACAO DE NOTA ELETRONICA')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPagina: TfrxMemoView
          Left = 921.635190000000000000
          Top = 34.015770000000010000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 969.414720000000000000
          Top = 58.574829999999990000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 837.055660000000000000
          Top = 58.574829999999990000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795300000000000000
        ParentFont = False
        Top = 192.756030000000000000
        Width = 1046.929810000000000000
        Condition = 'frxDBErros."NOMARQ"'
        object Memo3: TfrxMemoView
          Left = 79.370130000000000000
          Top = 18.897650000000000000
          Width = 960.000620000000000000
          Height = 15.118120000000000000
          DataSet = frxDBErros
          DataSetName = 'frxDBErros'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBErros."NOMARQ"]')
        end
        object Memo1: TfrxMemoView
          Left = 4.559059999999999000
          Top = 1.779529999999994000
          Width = 71.811023622047240000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NUM. NOTA:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 19.677179999999990000
          Width = 71.811023622047240000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ARQUIVO:')
          ParentFont = False
        end
        object frxDBErrosNUMDOC: TfrxMemoView
          Left = 79.370130000000000000
          Top = 1.779529999999994000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          DataSet = frxDBErros
          DataSetName = 'frxDBErros'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBErros."NUMDOC"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 294.803340000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 7.559059999999988000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40141.361124849540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 216
    Top = 368
    Datasets = <
      item
        DataSet = frxDBErros
        DataSetName = 'frxDBErros'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1305.600000000000000000
        DataSet = frxDBErros
        DataSetName = 'frxDBErros'
        RowCount = 0
        Stretched = True
        object frxDBErrosMOTIVO: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'MOTIVO'
          DataSet = frxDBErros
          DataSetName = 'frxDBErros'
          Memo.UTF8W = (
            '[frxDBErros."MOTIVO"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ERRO    :')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 323.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE CRITICAS DE IMPORTACAO DE NOTA ELETRONICA')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 170.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxDBErros."NOMARQ"'
        object frxDBErrosNOMARQ: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 34.000000000000000000
          Width = 1209.600000000000000000
          Height = 17.000000000000000000
          DataField = 'NOMARQ'
          DataSet = frxDBErros
          DataSetName = 'frxDBErros'
          Memo.UTF8W = (
            '[frxDBErros."NOMARQ"]')
          TruncOutboundText = False
        end
        object frxDBErrosNUMDOC: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSet = frxDBErros
          DataSetName = 'frxDBErros'
          Memo.UTF8W = (
            '[frxDBErros."NUMDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.NOTA:')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ARQUIVO :')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxDBErros: TfrxDBDataset
    UserName = 'frxDBErros'
    CloseDataSource = False
    DataSet = cdsErros
    BCDToCurrency = False
    Left = 184
    Top = 368
  end
  object cdsErros: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'NUMDOC'
    Params = <>
    Left = 152
    Top = 368
    object cdsErrosNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 200
    end
    object cdsErrosNUMDOC: TStringField
      FieldName = 'NUMDOC'
    end
    object cdsErrosNSERIE: TStringField
      FieldName = 'NSERIE'
    end
    object cdsErrosMOTIV: TStringField
      FieldName = 'MOTIVO'
      Size = 300
    end
    object cdsErrosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 11
    end
    object cdsErrosCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 13
    end
    object cdsErrosDESITE: TStringField
      DisplayWidth = 70
      FieldName = 'DESITE'
      Size = 70
    end
  end
  object cdsIteFor: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ITE_NUMDOC;ITE_NOMFOR'
    Params = <>
    AfterInsert = cdsIteForAfterInsert
    BeforePost = cdsIteForBeforePost
    Left = 384
    Top = 368
    object cdsIteForITE_CODITE: TStringField
      FieldName = 'ITE_CODITE'
      Size = 5
    end
    object cdsIteForITE_DESITE: TStringField
      FieldName = 'ITE_DESITE'
      Size = 70
    end
    object cdsIteForITE_CODFOR: TStringField
      FieldName = 'ITE_CODFOR'
      Size = 8
    end
    object cdsIteForFOR_NOMFOR: TStringField
      FieldName = 'ITE_NOMFOR'
      Size = 60
    end
    object cdsIteForITE_CODITF: TStringField
      FieldName = 'ITE_CODITF'
      Size = 50
    end
    object cdsIteForITE_DESITF: TStringField
      FieldName = 'ITE_DESITF'
      Size = 250
    end
    object cdsIteForITE_NUMDOC: TStringField
      FieldName = 'ITE_NUMDOC'
      Size = 12
    end
    object cdsIteForITE_CODFAB: TStringField
      FieldName = 'ITE_CODFAB'
      Size = 50
    end
    object cdsIteForITE_CODBAR: TStringField
      FieldName = 'ITE_CODBAR'
      Size = 30
    end
    object cdsIteForITE_UNIDAD: TStringField
      FieldName = 'ITE_UNIDAD'
      Size = 30
    end
    object cdsIteForITE_UNITAR: TFloatField
      FieldName = 'ITE_UNITAR'
    end
    object cdsIteForITE_CLAIPI: TStringField
      FieldName = 'ITE_CLAIPI'
      Size = 10
    end
    object cdsIteForITE_NUMFCI: TStringField
      FieldName = 'ITE_NUMFCI'
      Size = 50
    end
    object cdsIteForITE_FATUTR: TFloatField
      FieldName = 'ITE_FATUTR'
    end
    object cdsIteForITE_FREENT: TFloatField
      FieldName = 'ITE_FREENT'
    end
    object cdsIteForITE_PER_CI: TFloatField
      FieldName = 'ITE_PER_CI'
    end
    object cdsIteForITE_IPIENT: TFloatField
      FieldName = 'ITE_IPIENT'
    end
    object cdsIteForITE_ICMENT: TFloatField
      FieldName = 'ITE_ICMENT'
    end
    object cdsIteForITE_SUBSTI: TFloatField
      FieldName = 'ITE_SUBSTI'
    end
    object cdsIteForITE_CLAFIS: TStringField
      FieldName = 'ITE_CLAFIS'
      Size = 5
    end
    object cdsIteForITE_CODSIT: TStringField
      FieldName = 'ITE_CODSIT'
      Size = 3
    end
    object cdsIteForITE_APLICA: TMemoField
      FieldName = 'ITE_APLICA'
      BlobType = ftMemo
    end
    object cdsIteForITE_CDCEST: TStringField
      FieldName = 'ITE_CDCEST'
      Size = 7
    end
    object cdsIteForITE_EAN: TStringField
      FieldName = 'ITE_CDCEAN'
      Size = 14
    end
    object cdsIteForITE_EANTRIB: TStringField
      FieldName = 'ITE_CDCEAT'
      Size = 14
    end
    object cdsIteForITE_CODITEANT: TStringField
      FieldName = 'ITE_CODITEANT'
      Size = 5
    end
    object cdsIteForITE_ATUALIZATABELAITEFOR: TIntegerField
      FieldName = 'ITE_ATUALIZATABELAITEFOR'
    end
    object cdsIteForAutIncITEFOR: TStringField
      FieldName = 'AutIncITEFOR'
    end
    object cdsIteForC12_UF: TStringField
      FieldName = 'C12_UF'
      Size = 2
    end
  end
  object dtsIteFor: TDataSource
    DataSet = cdsIteFor
    Left = 416
    Top = 368
  end
  object frxDBClaIpi: TfrxDBDataset
    UserName = 'frxDBClaIpi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 552
    Top = 256
  end
  object frxReportM_ClaIPI: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41719.311022500000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure mmoCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<frxDBClaIpi."ITE_CLAIPI"> = '#39#39') Then'
      '  Begin              '
      '    mmoCodigo.Text := <frxDBClaIpi."ITE_CODITE"> + '#39'*'#39';'
      
        '    rllRodape.Visible := True;                                  ' +
        '            '
      '  End;              '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 552
    Top = 304
    Datasets = <
      item
        DataSet = frxDBClaIpi
        DataSetName = 'frxDBClaIpi'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
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
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 1305.600000000000000000
        DataSet = frxDBClaIpi
        DataSetName = 'frxDBClaIpi'
        RowCount = 0
        Stretched = True
        object mmoCodigo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CODBAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CLAIPI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NEWIPI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NUMFCI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_PER_CI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NEWFCI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NEWPER"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object rllRodape: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              '* OS ITENS QUE N'#195'O POSSUEM O NCM OU FCI CADASTRADOS RECEBERAM O ' +
              'VALOR CONTIDO NO XML AUTOMATICAMENTE.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 136.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 86.400000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD. BARRAS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'NCM CADASTRO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'NCM XML')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD. FABRICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'NFCI CADASTRADO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '%CI CADASTRADO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'NFCI XML')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '%CI XML')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 240.000000000000000000
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            
              'RELAT'#211'RIO DOS '#205'TENS QUE CONT'#201'M O NCM OU FCI NO CADASTRO DIVERGEN' +
              'TE DO CONTIDO NO XML')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1200.000000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
      end
    end
  end
  object frxReportJ_ClaIPI: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40141.361759432900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure mmoCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<frxDBClaIpi."ITE_CLAIPI"> = '#39#39') Then'
      '  Begin              '
      '    mmoCodigo.Text := <frxDBClaIpi."ITE_CODITE"> + '#39'*'#39';'
      '    rllRodape.Visible := True;'
      '  End;              '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 552
    Top = 352
    Datasets = <
      item
        DataSet = frxDBClaIpi
        DataSetName = 'frxDBClaIpi'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 400.630180000000000000
        Width = 1046.929810000000000000
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 96.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
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
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 203.074305000000000000
          Top = 34.000000000000000000
          Width = 640.781200000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'RELAT'#211'RIO DOS '#205'TENS QUE CONT'#201'M O NCM OU FCI NO CADASTRO DIVERGEN' +
              'TE DO CONTIDO NO XML')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllPagina: TfrxMemoView
          Left = 921.635190000000000000
          Top = 34.015770000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 969.414720000000000000
          Top = 58.574830000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 837.055660000000000000
          Top = 58.574830000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 41.574830000000000000
        ParentFont = False
        Top = 177.637910000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Top = 0.779530000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo2: TfrxMemoView
          Left = 75.590600000000000000
          Top = 0.779530000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
        object Memo3: TfrxMemoView
          Left = 355.275820000000000000
          Top = 0.779530000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'REFER'#202'NCIA')
        end
        object Memo4: TfrxMemoView
          Left = 491.338900000000000000
          Top = 0.779530000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'UN')
        end
        object Memo5: TfrxMemoView
          Left = 532.913730000000000000
          Top = 0.779530000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'D. BARRAS')
        end
        object Memo6: TfrxMemoView
          Left = 668.976810000000000000
          Top = 0.779530000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#211'D. FABRICA')
        end
        object Memo7: TfrxMemoView
          Left = 805.039890000000000000
          Top = 0.779530000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'NCM CADASTRADO')
        end
        object Memo8: TfrxMemoView
          Left = 925.984850000000000000
          Top = 0.779530000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'NCM XML')
        end
        object Memo9: TfrxMemoView
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'NFCI CADASTRADO')
        end
        object Memo17: TfrxMemoView
          Left = 404.409710000000000000
          Top = 22.677180000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '%CI CADASTRADO')
        end
        object Memo18: TfrxMemoView
          Left = 521.575140000000000000
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'NFCI XML')
        end
        object Memo19: TfrxMemoView
          Left = 925.984850000000000000
          Top = 22.677180000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '%CI XML')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795300000000000000
        ParentFont = False
        Top = 241.889920000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBClaIpi
        DataSetName = 'frxDBClaIpi'
        RowCount = 0
        Stretched = True
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object mmoCodigo: TfrxMemoView
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'mmoCodigoOnBeforePrint'
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CODITE"]')
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 75.590600000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_DESITE"]')
        end
        object Memo11: TfrxMemoView
          Left = 355.275820000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_REFERE"]')
        end
        object Memo12: TfrxMemoView
          Left = 491.338900000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_SIGUNI"]')
        end
        object Memo13: TfrxMemoView
          Left = 532.913730000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CODBAR"]')
        end
        object Memo14: TfrxMemoView
          Left = 668.976810000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CODFAB"]')
        end
        object Memo15: TfrxMemoView
          Left = 805.039890000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_CLAIPI"]')
        end
        object Memo16: TfrxMemoView
          Left = 925.984850000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NEWIPI"]')
        end
        object Memo20: TfrxMemoView
          Top = 18.897650000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NUMFCI"]')
        end
        object Memo21: TfrxMemoView
          Left = 404.409710000000000000
          Top = 18.897650000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_PER_CI"]')
        end
        object Memo22: TfrxMemoView
          Left = 521.575140000000000000
          Top = 18.897650000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NEWFCI"]')
        end
        object Memo23: TfrxMemoView
          Left = 925.984850000000000000
          Top = 18.897650000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBClaIpi."ITE_NEWPER"]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 302.362400000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 9.220470000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllRodape: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 978.898270000000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '* OS ITENS QUE N'#195'O POSSUEM O NCM OU FCI CADASTRADOS RECEBERAM O ' +
              'VALOR CONTIDO NO XML AUTOMATICAMENTE.')
          ParentFont = False
        end
      end
    end
  end
end
