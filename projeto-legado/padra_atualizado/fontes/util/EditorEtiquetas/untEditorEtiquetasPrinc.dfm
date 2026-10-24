object frmEditorEtiquetasPrinc: TfrmEditorEtiquetasPrinc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Editor de Etiquetas'
  ClientHeight = 721
  ClientWidth = 1025
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 120
    Top = 136
    Width = 23
    Height = 22
  end
  object Splitter1: TSplitter
    Left = 417
    Top = 29
    Height = 692
    Color = 16774636
    ParentColor = False
    ExplicitLeft = 429
    ExplicitTop = 28
    ExplicitHeight = 726
  end
  object Splitter3: TSplitter
    Left = 185
    Top = 29
    Height = 692
    Color = 16774636
    ParentColor = False
    ExplicitLeft = 176
    ExplicitTop = 35
    ExplicitHeight = 726
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 29
    Width = 185
    Height = 692
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 0
      Top = 420
      Width = 185
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      Color = 16774636
      ParentColor = False
      ExplicitLeft = -6
      ExplicitTop = 623
    end
    object cxgTabCam: TcxGrid
      Left = 0
      Top = 0
      Width = 185
      Height = 420
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgTabCamView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxgTabCamViewCellClick
        OnCustomDrawCell = cxgTabCamViewCustomDrawCell
        DataController.DataSource = dtsTabCam
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsCustomize.DataRowSizing = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        Styles.Background = cxStyle2
        Styles.Content = cxStyle2
        Styles.Inactive = cxStyle1
        Styles.Selection = cxStyle1
        object cxgTabCamDESCAM: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'CAM_DESCAM'
          OnCustomDrawCell = cxgTabCamDESCAMCustomDrawCell
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Width = 133
        end
        object cxgTabCamCODCAM: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CAM_CODCAM'
          OnCustomDrawCell = cxgTabCamCODCAMCustomDrawCell
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Width = 50
        end
        object cxgTabCamPOSDES: TcxGridDBColumn
          Caption = 'Cor'
          DataBinding.FieldName = 'CAM_POSDES'
          OnCustomDrawCell = cxgTabCamPOSDESCustomDrawCell
          HeaderAlignmentHorz = taCenter
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 25
        end
        object cxgTabCamPOSCAM: TcxGridDBColumn
          DataBinding.FieldName = 'CAM_POSCAM'
          Visible = False
        end
      end
      object cxgTabCamLevel1: TcxGridLevel
        GridView = cxgTabCamView
      end
    end
    object cxgLegendas: TcxGrid
      Left = 0
      Top = 562
      Width = 185
      Height = 130
      Align = alBottom
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgLegendasView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = cxgLegendasViewCustomDrawCell
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxgLegendasDESTIP: TcxGridDBColumn
          Caption = 'LEGENDA DE CORES'
          DataBinding.FieldName = 'DESTIP'
          HeaderAlignmentHorz = taCenter
          Options.Filtering = False
          Options.Sorting = False
          Width = 183
        end
        object cxgLegendasPOSCAM: TcxGridDBColumn
          DataBinding.FieldName = 'POSCAM'
          Visible = False
        end
      end
      object cxgLegendasLevel1: TcxGridLevel
        GridView = cxgLegendasView
      end
    end
    object cxtGrupos: TcxDBTreeList
      Left = 0
      Top = 423
      Width = 185
      Height = 139
      Align = alBottom
      Bands = <
        item
        end>
      DataController.DataSource = dtsGrupos
      DataController.ParentField = 'GRU_PARENT'
      DataController.KeyField = 'GRU_CODGRU'
      LookAndFeel.ScrollbarMode = sbmClassic
      Navigator.Buttons.CustomButtons = <>
      OptionsData.Editing = False
      OptionsData.Deleting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      RootValue = -1
      Styles.Background = cxStyle4
      Styles.Content = cxStyle4
      Styles.Selection = cxStyleSelecao
      Styles.BandContent = cxStyle4
      Styles.Indicator = cxStyleSelecao
      TabOrder = 2
      object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
        Visible = False
        DataBinding.FieldName = 'GRU_CODGRU'
        Width = 100
        Position.ColIndex = 2
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn
        Visible = False
        DataBinding.FieldName = 'GRU_PARENT'
        Width = 100
        Position.ColIndex = 1
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
      object cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn
        Caption.AlignHorz = taCenter
        Caption.Text = 'Grupo de Campos'
        DataBinding.FieldName = 'GRU_DESCRI'
        Width = 368
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 1025
    Height = 29
    ButtonWidth = 26
    Caption = 'ToolBar1'
    Images = ImageList
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object btnExpressao: TToolButton
      Left = 0
      Top = 0
      Hint = 'Incluir Express'#227'o'
      Caption = 'btnExpressao'
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = btnExpressaoClick
    end
    object btnImagem: TToolButton
      Left = 26
      Top = 0
      Hint = 'Incluir Imagem'
      Caption = 'btnImagem'
      ImageIndex = 10
      OnClick = btnImagemClick
    end
    object btnDesmarca: TToolButton
      Left = 52
      Top = 0
      Hint = 'Cancelar inclus'#227'o de campo/express'#227'o'
      Caption = 'btnDesmarca'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDesmarcaClick
    end
    object btnHeranca: TToolButton
      Left = 78
      Top = 0
      Hint = 'Herdar de...'
      Caption = 'Herdar de...'
      ImageIndex = 0
      OnClick = btnHerancaClick
    end
    object ToolButton7: TToolButton
      Left = 104
      Top = 0
      Width = 21
      Caption = 'ToolButton7'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object btnExcluir: TToolButton
      Left = 125
      Top = 0
      Hint = 'Excluir campo'
      Caption = 'btnExcluir'
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = btnExcluirClick
    end
    object ToolButton1: TToolButton
      Left = 151
      Top = 0
      Width = 22
      Caption = 'ToolButton1'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object btnNovo: TToolButton
      Left = 173
      Top = 0
      Hint = 'Novo layout'
      Caption = 'btnNovo'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = btnNovoClick
    end
    object btnSalvar: TToolButton
      Left = 199
      Top = 0
      Hint = 'Salvar layout'
      Caption = 'btnSalvar'
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSalvarClick
    end
    object btnPreview: TToolButton
      Left = 225
      Top = 0
      Hint = 'Teste Preview'
      Caption = 'btnPreview'
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPreviewClick
    end
    object btnPDF: TToolButton
      Left = 251
      Top = 0
      Hint = 'Gerar PDF'
      Caption = 'btnPDF'
      ImageIndex = 11
      OnClick = btnPDFClick
    end
    object ToolButton3: TToolButton
      Left = 277
      Top = 0
      Width = 24
      Caption = 'ToolButton3'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object btnExcLay: TToolButton
      Left = 301
      Top = 0
      Hint = 'Excluir layout'
      Caption = 'btnExcLay'
      ImageIndex = 9
      OnClick = btnExcLayClick
    end
    object ToolButton4: TToolButton
      Left = 327
      Top = 0
      Width = 24
      Caption = 'ToolButton4'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object btnSair: TToolButton
      Left = 351
      Top = 0
      Hint = 'Sair'
      Caption = 'btnSair'
      ImageIndex = 3
      OnClick = btnSairClick
    end
    object ToolButton2: TToolButton
      Left = 377
      Top = 0
      Width = 24
      Caption = 'ToolButton2'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object pnlPadrao: TPanel
      Left = 401
      Top = 0
      Width = 150
      Height = 22
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'LAYOUT PADR'#195'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object pnlDescricao: TPanel
      Left = 551
      Top = 0
      Width = 107
      Height = 22
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Descri'#231#227'o do Layout:'
      TabOrder = 1
    end
    object edtDescri: TEdit
      Left = 658
      Top = 0
      Width = 358
      Height = 22
      Align = alLeft
      CharCase = ecUpperCase
      TabOrder = 2
    end
  end
  object pnlMainRegua: TPanel
    Left = 420
    Top = 29
    Width = 605
    Height = 692
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlReguaSuperior: TPanel
      Left = 0
      Top = 22
      Width = 605
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object frxRulerSuperior: TfrxRuler
        Left = 38
        Top = 14
        Width = 1000
        Height = 22
        Caption = 'frxRulerSuperior'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        Offset = 0
        Scale = 1.000000000000000000
        Start = 0
        Units = ruCM
        Size = 0
      end
    end
    object pnlCentral: TPanel
      Left = 0
      Top = 62
      Width = 605
      Height = 630
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object scrPagina: TScrollBox
        Left = 32
        Top = 0
        Width = 573
        Height = 630
        Align = alClient
        BorderStyle = bsNone
        Color = 14145495
        ParentColor = False
        TabOrder = 0
      end
      object pnlReguaLateral: TPanel
        Left = 0
        Top = 0
        Width = 32
        Height = 630
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object pnlReguaLatAux: TPanel
          Left = 6
          Top = 0
          Width = 23
          Height = 624
          BevelOuter = bvNone
          TabOrder = 0
          object frxRulerLateral: TfrxRuler
            Left = 0
            Top = 0
            Width = 22
            Height = 624
            Align = alLeft
            DoubleBuffered = True
            ParentDoubleBuffered = False
            TabOrder = 0
            Offset = 0
            Scale = 1.000000000000000000
            Start = 0
            Units = ruCM
            Size = 0
          end
        end
      end
    end
    object pnlAlinhamentos: TPanel
      Left = 0
      Top = 0
      Width = 605
      Height = 22
      Align = alTop
      TabOrder = 2
      object btnAliEsq: TSpeedButton
        Left = 104
        Top = 1
        Width = 30
        Height = 20
        Hint = 'Alinhar selecionados a esquerda'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00004D332BFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000051362CFF000000030000000B000000110000001300000013000000130000
          0013000000140000001400000014000000130000000D00000003000000000000
          000055392FFF0000000A1D533DC2287255FF277154FF287154FF287154FF2771
          53FF277052FF277052FF276F52FF266F51FF1B4F3AC40000000C000000000000
          0000593D33FF0000000D2A7658FF9BE7D2FF7CDEC1FF7ADDC0FF79DDBFFF75DB
          BDFF73DABCFF71D9BBFF6FD9B9FF6CD7B7FF287154FF00000010000000000000
          00005D4036FF0000000C2C7A5CFFA8EBD9FF5CD2AEFF5BD2ADFF5AD1ADFF59D1
          ACFF58D1ABFF57D0ABFF56D0AAFF77DBBDFF2A7557FF00000010000000000000
          0000624439FF000000092E7E60FFB4EDDFFFB2EDDEFFAFECDCFFACEBDBFFA9EB
          D9FFA5EAD7FFA3E9D7FF9FE9D5FF9EE7D3FF2C7A5BFF0000000D000000000000
          000066483DFF0000000524614BC2308364FF318263FF2F8262FF308162FF3080
          62FF2F8061FF2E7F61FF2F7F61FF2F7E60FF225E47C400000008000000000000
          00006A4C40FF000000030000000C000000130000001500000017000000170000
          0017000000130000000B00000009000000090000000600000002000000000000
          00006F5044FF0000000624614BBF318667FF328667FF318566FF308666FF3185
          63FF235F47C10000000900000000000000000000000000000000000000000000
          0000745348FF00000008358C6CFF9AECD7FF7CE4C8FF7BE4C9FF7BE4C9FF7BE4
          C8FF328968FF0000000C00000000000000000000000000000000000000000000
          000079574CFF0000000738906FFFA4EEDBFF6CE1C0FF6BE0C0FF6BE0C1FF7EE5
          C9FF368D6DFF0000000C00000000000000000000000000000000000000000000
          00007D5B50FF00000005399475FFADF1DFFFABF0DFFFAAF1DFFFAAEFDFFFA9EF
          DEFF379172FF0000000900000000000000000000000000000000000000000000
          0000825F53FF000000032D715AC03B9878FF3B9877FF3B9777FF3A9676FF3A96
          76FF2B6E57C20000000500000000000000000000000000000000000000000000
          0000876457FF0000000100000002000000040000000400000005000000050000
          0005000000040000000100000000000000000000000000000000000000000000
          00008B675AFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnAliEsqClick
      end
      object btnAliDir: TSpeedButton
        Left = 134
        Top = 1
        Width = 30
        Height = 20
        Hint = 'Alinhar selecionados a direita'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000004D332BFF0000000000000000000000030000
          000B000000110000001300000013000000130000001300000014000000140000
          0014000000130000000D0000000351362CFF00000000000000000000000A1D53
          3DC2287255FF277154FF287154FF287154FF277153FF277052FF277052FF276F
          52FF266F51FF1B4F3AC40000000C55392FFF00000000000000000000000D2A76
          58FF9BE7D2FF7CDEC1FF7ADDC0FF79DDBFFF75DBBDFF73DABCFF71D9BBFF6FD9
          B9FF6CD7B7FF287154FF00000010593D33FF00000000000000000000000C2C7A
          5CFFA8EBD9FF5CD2AEFF5BD2ADFF5AD1ADFF59D1ACFF58D1ABFF57D0ABFF56D0
          AAFF77DBBDFF2A7557FF000000105D4036FF0000000000000000000000092E7E
          60FFB4EDDFFFB2EDDEFFAFECDCFFACEBDBFFA9EBD9FFA5EAD7FFA3E9D7FF9FE9
          D5FF9EE7D3FF2C7A5BFF0000000D624439FF0000000000000000000000052461
          4BC2308364FF318263FF2F8262FF308162FF308062FF2F8061FF2E7F61FF2F7F
          61FF2F7E60FF225E47C40000000866483DFF0000000000000000000000010000
          000400000007000000070000000A000000100000001400000017000000170000
          00170000001700000010000000046A4C40FF0000000000000000000000000000
          000000000000000000000000000624614BBF318667FF328667FF318566FF3086
          66FF318563FF235F47C1000000096F5044FF0000000000000000000000000000
          0000000000000000000000000008358C6CFF9AECD7FF7CE4C8FF7BE4C9FF7BE4
          C9FF7BE4C8FF328968FF0000000C745348FF0000000000000000000000000000
          000000000000000000000000000738906FFFA4EEDBFF6CE1C0FF6BE0C0FF6BE0
          C1FF7EE5C9FF368D6DFF0000000C79574CFF0000000000000000000000000000
          0000000000000000000000000005399475FFADF1DFFFABF0DFFFAAF1DFFFAAEF
          DFFFA9EFDEFF379172FF000000097D5B50FF0000000000000000000000000000
          00000000000000000000000000032D715AC03B9878FF3B9877FF3B9777FF3A96
          76FF3A9676FF2B6E57C200000005825F53FF0000000000000000000000000000
          0000000000000000000000000001000000020000000400000004000000050000
          0005000000050000000400000001876457FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000008B675AFF0000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnAliDirClick
      end
      object btnAliBot: TSpeedButton
        Left = 164
        Top = 1
        Width = 30
        Height = 20
        Hint = 'Alinhar selecionados em baixo'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000067493FFF6648
          3EFF65473DFF63453CFF62453BFF5F4339FF5E4137FF5C3F36FF5A3D35FF583C
          33FF563A32FF553830FF53382FFF51362EFF50352DFF00000000000000000000
          00030000000B0000001100000012000000120000000C000000060000000D0000
          001400000016000000150000000E000000030000000000000000000000000000
          000A235E48C2318364FF318364FF318263FF225D47C3000000161B503BC52670
          52FF266F51FF266F51FF1B503AC50000000D0000000000000000000000000000
          000D358C6BFF91EAD4FF7BE6C9FF7AE4C9FF318464FF00000020287455FF75DA
          BDFF64D4B3FF64D4B2FF267052FF000000130000000000000000000000000000
          000C368E6CFF9AEDD8FF67E0BFFF80E6CBFF328566FF0000001F297556FF7CDC
          C1FF55D0AAFF68D6B5FF277052FF000000130000000000000000000000000000
          000B37906FFFA2EFDBFF69E0BFFF86E8CEFF338868FF0000001C2A7658FF84DF
          C5FF57D0ABFF6DD7B8FF277153FF000000120000000000000000000000000000
          0009389170FFAAF0DEFF6CE1C0FF8CE9D0FF358A6AFF000000192B7859FF8AE1
          C8FF58D0ACFF72D9BBFF287254FF000000110000000000000000000000000000
          0007389272FFB2F2E2FFB0F1E1FFAEF1E0FF368D6CFF000000172B7A5BFF90E3
          CCFF5BD1AEFF76DBBEFF297456FF000000100000000000000000000000000000
          00042A6E56C1389473FF389372FF389372FF286B51C2000000122C7B5DFF96E5
          D0FF5DD2AFFF7ADCC1FF297557FF0000000E0000000000000000000000000000
          000100000003000000050000000600000006000000040000000D2D7C5EFF9EE7
          D3FF5ED3B0FF7FDEC3FF2A7758FF0000000D0000000000000000000000000000
          000000000000000000000000000000000000000000000000000B2D7E5FFFA4EA
          D7FF60D4B2FF83DFC6FF2B795BFF0000000C0000000000000000000000000000
          000000000000000000000000000000000000000000000000000A2E8061FFA9EB
          DAFF62D5B3FF88E1C9FF2C7B5CFF0000000B0000000000000000000000000000
          00000000000000000000000000000000000000000000000000082F8161FFAFED
          DCFFAFEDDCFFADECDCFF2D7D5EFF0000000A0000000000000000000000000000
          0000000000000000000000000000000000000000000000000005236049C22F81
          62FF2F8163FF2F8162FF225E48C3000000060000000000000000000000000000
          0000000000000000000000000000000000000000000000000001000000040000
          0007000000070000000700000005000000010000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnAliBotClick
      end
      object btnAliTop: TSpeedButton
        Left = 194
        Top = 1
        Width = 30
        Height = 20
        Hint = 'Alinhar selecionados no topo'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000030000000D0000
          001400000016000000150000000E000000030000000000000000000000000000
          000000000000000000000000000000000000000000000000000C1B503BC52670
          52FF266F51FF266F51FF1B503AC50000000D0000000000000000000000000000
          0000000000000000000000000000000000000000000000000012287455FF75DA
          BDFF64D4B3FF64D4B2FF267052FF000000130000000000000000000000000000
          0000000000000000000000000000000000000000000000000012297556FF7CDC
          C1FF55D0AAFF68D6B5FF277052FF000000130000000000000000000000000000
          00000000000000000000000000000000000000000000000000102A7658FF84DF
          C5FF57D0ABFF6DD7B8FF277153FF000000120000000000000000000000000000
          00030000000B0000001100000012000000120000000C000000122B7859FF8AE1
          C8FF58D0ACFF72D9BBFF287254FF000000110000000000000000000000000000
          000A235E48C2318364FF318364FF318263FF225D47C3000000182B7A5BFF90E3
          CCFF5BD1AEFF76DBBEFF297456FF000000100000000000000000000000000000
          000D358C6BFF91EAD4FF7BE6C9FF7AE4C9FF318464FF0000001B2C7B5DFF96E5
          D0FF5DD2AFFF7ADCC1FF297557FF0000000E0000000000000000000000000000
          000C368E6CFF9AEDD8FF67E0BFFF80E6CBFF328566FF000000192D7C5EFF9EE7
          D3FF5ED3B0FF7FDEC3FF2A7758FF0000000D0000000000000000000000000000
          000B37906FFFA2EFDBFF69E0BFFF86E8CEFF338868FF000000172D7E5FFFA4EA
          D7FF60D4B2FF83DFC6FF2B795BFF0000000C0000000000000000000000000000
          0009389170FFAAF0DEFF6CE1C0FF8CE9D0FF358A6AFF000000152E8061FFA9EB
          DAFF62D5B3FF88E1C9FF2C7B5CFF0000000B0000000000000000000000000000
          0007389272FFB2F2E2FFB0F1E1FFAEF1E0FF368D6CFF000000112F8161FFAFED
          DCFFAFEDDCFFADECDCFF2D7D5EFF0000000A0000000000000000000000000000
          00042A6E56C1389473FF389372FF389372FF286B51C20000000A236049C22F81
          62FF2F8163FF2F8162FF225E48C3000000060000000000000000000000000000
          0001000000030000000500000006000000060000000400000002000000040000
          000700000007000000070000000500000001000000000000000067493FFF6648
          3EFF65473DFF63453CFF62453BFF5F4339FF5E4137FF5C3F36FF5A3D35FF583C
          33FF563A32FF553830FF53382FFF51362EFF50352DFF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = btnAliTopClick
      end
      object chkAlinhaGrade: TCheckBox
        Left = 6
        Top = 1
        Width = 97
        Height = 17
        Caption = 'Alinhar a grade'
        TabOrder = 0
        OnClick = chkAlinhaGradeClick
      end
    end
  end
  object pnlConfig: TPanel
    Left = 188
    Top = 29
    Width = 229
    Height = 692
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object Splitter5: TSplitter
      Left = 0
      Top = 379
      Width = 229
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = 16774636
      ParentColor = False
      ExplicitTop = 281
    end
    object Splitter4: TSplitter
      Left = 0
      Top = 566
      Width = 229
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = 16774636
      ParentColor = False
      ExplicitLeft = 6
      ExplicitTop = 575
    end
    object pnlDadCam: TPanel
      Left = 0
      Top = 0
      Width = 229
      Height = 379
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 229
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Dados do Campo'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object cxvDadCam: TcxVerticalGrid
        Left = 0
        Top = 16
        Width = 229
        Height = 363
        Align = alClient
        LookAndFeel.ScrollbarMode = sbmClassic
        OptionsView.RowHeaderWidth = 130
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.GoToNextCellOnTab = True
        TabOrder = 1
        Visible = False
        OnItemChanged = cxvDadCamItemChanged
        Version = 1
        object cxvDadCamLeft: TcxEditorRow
          Properties.Caption = 'Esquerda'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadCamLeftEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxvDadCamTop: TcxEditorRow
          Properties.Caption = 'Topo'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadCamTopEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxvDadCamWidth: TcxEditorRow
          Properties.Caption = 'Largura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadCamWidthEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxvDadCamHeight: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadCamHeightEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxvDadCamFont: TcxEditorRow
          Properties.Caption = 'Fonte'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.ViewStyle = vsButtonsOnly
          Properties.EditProperties.OnButtonClick = cxvDadCamFontEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxvDadCamFontMat: TcxEditorRow
          Properties.Caption = 'Fonte'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            '39 Colunas (Expandido)'
            '79 Colunas (10 cpi)'
            '95 Colunas'
            '136 Colunas'
            '159 Colunas')
          Properties.EditProperties.OnChange = cxvDadCamFontMatEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
        object cxvDadCamCorFundo: TcxEditorRow
          Properties.Caption = 'Cor do fundo'
          Properties.EditPropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.EditProperties.CustomColors = <>
          Properties.EditProperties.DefaultColor = clWhite
          Properties.EditProperties.DefaultDescription = 'sem cor'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.NamingConvention = cxncNone
          Properties.EditProperties.PrepareList = cxplHTML4
          Properties.EditProperties.ShowDescriptions = False
          Properties.EditProperties.OnChange = cxvDadCamCorFundoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 6
          ParentID = -1
          Index = 6
          Version = 1
        end
        object cxvDadCamTipCam: TcxEditorRow
          Properties.Caption = 'Tipo'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'Campo'
            'Express'#227'o')
          Properties.EditProperties.OnChange = cxvDadCamTipCamEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 7
          ParentID = -1
          Index = 7
          Version = 1
        end
        object cxvDadCamDado: TcxEditorRow
          Properties.Caption = 'Campo'
          Properties.EditPropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.KeyFieldNames = 'CAM_CODCAM'
          Properties.EditProperties.ListColumns = <
            item
              FieldName = 'CAM_DESCAM'
            end>
          Properties.EditProperties.ListSource = dtsTabCam
          Properties.EditProperties.OnChange = cxvDadCamDadoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 8
          ParentID = -1
          Index = 8
          Version = 1
        end
        object cxvDadCamExpressao: TcxEditorRow
          Properties.Caption = 'Express'#227'o'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.ViewStyle = vsButtonsOnly
          Properties.EditProperties.OnButtonClick = cxvDadCamExpressaoEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          Visible = False
          ID = 9
          ParentID = -1
          Index = 9
          Version = 1
        end
        object cxvDadCamAlign: TcxEditorRow
          Properties.Caption = 'Alinhamento'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'Esquerda'
            'Direita'
            'Centro')
          Properties.EditProperties.OnChange = cxvDadCamAlignEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 10
          ParentID = -1
          Index = 10
          Version = 1
        end
        object cxvDadCamWordWrap: TcxEditorRow
          Properties.Caption = 'Quebrar texto'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamWordWrapEditPropertiesChange
          Properties.DataBinding.ValueType = 'Boolean'
          Properties.Value = True
          ID = 11
          ParentID = -1
          Index = 11
          Version = 1
        end
        object cxvDadCamHideZeros: TcxEditorRow
          Properties.Caption = 'Esconder Zeros'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamHideZerosEditPropertiesChange
          Properties.DataBinding.ValueType = 'Boolean'
          Properties.Value = True
          ID = 12
          ParentID = -1
          Index = 12
          Version = 1
        end
        object cxvDadCamRotacao: TcxEditorRow
          Properties.Caption = 'Rota'#231#227'o'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            '0'
            '90'
            '270'
            '180')
          Properties.EditProperties.OnChange = cxvDadCamRotacaoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 13
          ParentID = -1
          Index = 13
          Version = 1
        end
        object cxvDadCamTipApr: TcxEditorRow
          Properties.Caption = 'Apresenta'#231#227'o'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'Texto'
            'C'#243'digo de Barras'
            'QRCODE')
          Properties.EditProperties.OnChange = cxvDadCamTipAprEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 14
          ParentID = -1
          Index = 14
          Version = 1
        end
        object cxvDadCamBarCode: TcxEditorRow
          Properties.Caption = 'C'#243'digo de barras'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            '2_5_interleaved'
            '2_5_industrial'
            '2_5_matrix'
            '39'
            '39Extended'
            '128'
            '128A'
            '128B'
            '128C'
            '93'
            '93Extended'
            'MS,'
            'PostNe'
            'Codabar'
            'EAN8'
            'EAN13'
            'UPC_A'
            'UPC_E0'
            'UPC_E1'
            'UPC_Supp2 '
            'UPC_Supp5 '
            'EAN128A'
            'EAN128B'
            'EAN128C')
          Properties.EditProperties.OnChange = cxvDadCamBarCodeEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          Visible = False
          ID = 15
          ParentID = -1
          Index = 15
          Version = 1
        end
        object cxvDadCamBarCodeText: TcxEditorRow
          Properties.Caption = 'Mostrar texto'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamBarCodeTextEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'True'
          Visible = False
          ID = 16
          ParentID = -1
          Index = 16
          Version = 1
        end
        object cxvDadCamCenter: TcxEditorRow
          Properties.Caption = 'Centralizar'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamCenterEditPropertiesChange
          Properties.DataBinding.ValueType = 'Boolean'
          Properties.Value = True
          Visible = False
          ID = 17
          ParentID = -1
          Index = 17
          Version = 1
        end
        object cxvDadCamStrech: TcxEditorRow
          Properties.Caption = 'Esticar'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamStrechEditPropertiesChange
          Properties.DataBinding.ValueType = 'Boolean'
          Properties.Value = True
          Visible = False
          ID = 18
          ParentID = -1
          Index = 18
          Version = 1
        end
        object cxvDadCamImagem: TcxEditorRow
          Properties.Caption = 'Imagem'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.ViewStyle = vsButtonsOnly
          Properties.EditProperties.OnButtonClick = cxvDadCamImagemEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          Visible = False
          ID = 19
          ParentID = -1
          Index = 19
          Version = 1
        end
        object cxvDadCamDecimais: TcxEditorRow
          Properties.Caption = 'Casas decimais'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'N'#227'o formatar'
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10')
          Properties.EditProperties.OnChange = cxvDadCamDecimaisEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 20
          ParentID = -1
          Index = 20
          Version = 1
        end
        object cxvDadCamAutoWidth: TcxEditorRow
          Properties.Caption = 'Largura autom'#225'tica'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamAutoWidthEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'True'
          ID = 21
          ParentID = -1
          Index = 21
          Version = 1
        end
        object cxvDadCamAutoHeight: TcxEditorRow
          Properties.Caption = 'Altura Autom'#225'tica'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamAutoHeightEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 22
          ParentID = -1
          Index = 22
          Version = 1
        end
        object cxvDadCamBordas: TcxEditorRow
          Properties.Caption = 'Espessura das Bordas'
          Properties.EditPropertiesClassName = 'TcxSpinEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamBordasEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 23
          ParentID = -1
          Index = 23
          Version = 1
        end
        object cxvDadCamBordaSuperior: TcxEditorRow
          Properties.Caption = 'Superior'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamBordaSuperiorEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 24
          ParentID = 23
          Index = 0
          Version = 1
        end
        object cxvDadCamBordaInferior: TcxEditorRow
          Properties.Caption = 'Inferior'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamBordaInferiorEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 25
          ParentID = 23
          Index = 1
          Version = 1
        end
        object cxvDadCamBordaEsquerda: TcxEditorRow
          Properties.Caption = 'Esquerda'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamBordaEsquerdaEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 26
          ParentID = 23
          Index = 2
          Version = 1
        end
        object cxvDadCamBordaDireita: TcxEditorRow
          Properties.Caption = 'Direita'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamBordaDireitaEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 27
          ParentID = 23
          Index = 3
          Version = 1
        end
        object cxvDadCamCalculaCheckSum: TcxEditorRow
          Properties.Caption = 'Calcula CheckSum'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadCamCalculaCheckSumEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 28
          ParentID = -1
          Index = 24
          Version = 1
        end
        object cxvDadCamQrCode: TcxEditorRow
          Properties.Caption = 'Tipo de C'#243'digo'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'DataMatrix'
            'PDF417'
            'QR')
          Properties.EditProperties.OnChange = cxvDadCamQrCodeEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 29
          ParentID = -1
          Index = 25
          Version = 1
        end
        object cxvDadCamZoom: TcxEditorRow
          Properties.Caption = 'Zoom'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.DecimalPlaces = 3
          Properties.EditProperties.DisplayFormat = '0.000;-0.000'
          Properties.EditProperties.OnValidate = cxvDadCamZoomEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 30
          ParentID = -1
          Index = 26
          Version = 1
        end
        object cxvDadCamZooFix: TcxEditorRow
          Properties.Caption = 'Zoom Fixo'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.DecimalPlaces = 3
          Properties.EditProperties.DisplayFormat = '0.000;-0.000'
          Properties.EditProperties.OnValidate = cxvDadCamZooFixEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 31
          ParentID = -1
          Index = 27
          Version = 1
        end
      end
    end
    object pnlDadEti: TPanel
      Left = 0
      Top = 382
      Width = 229
      Height = 184
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlDadEti'
      TabOrder = 1
      object pnlCabEti: TPanel
        Left = 0
        Top = 0
        Width = 229
        Height = 18
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Dados da Etiqueta'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btnMosEti: TSpeedButton
          Left = 168
          Top = -1
          Width = 23
          Height = 18
          Hint = 'Mostrar/esconder dados da etiqueta'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
            0EEE333377777777777733330FF00FBFB0EE33337F37733F377733330F0BFB0B
            FB0E33337F73FF73337733330FF000BFBFB033337F377733333733330FFF0BFB
            FBF033337FFF733F333733300000BF0FBFB03FF77777F3733F37000FBFB0F0FB
            0BF077733FF7F7FF7337E0FB00000000BF0077F377777777F377E0BFBFBFBFB0
            F0F077F3333FFFF7F737E0FBFB0000000FF077F3337777777337E0BFBFBFBFB0
            FFF077F3333FFFF73FF7E0FBFB00000F000077FF337777737777E00FBFBFB0FF
            0FF07773FFFFF7337F37003000000FFF0F037737777773337F7333330FFFFFFF
            003333337FFFFFFF773333330000000003333333777777777333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          Visible = False
          OnClick = btnMosEtiClick
        end
      end
      object cxvDadEti: TcxVerticalGrid
        Left = 0
        Top = 18
        Width = 229
        Height = 166
        Align = alClient
        LookAndFeel.ScrollbarMode = sbmClassic
        OptionsView.RowHeaderWidth = 126
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.GoToNextCellOnTab = True
        TabOrder = 1
        Version = 1
        object cxvDadEtiWidth: TcxEditorRow
          Properties.Caption = 'Largura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadEtiWidthEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = '0'
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxvDadEtiHeigth: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadEtiHeigthEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxvDadEtiColumns: TcxEditorRow
          Properties.Caption = 'Colunas'
          Properties.EditPropertiesClassName = 'TcxSpinEditProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.MinValue = 1.000000000000000000
          Properties.EditProperties.OnValidate = cxvDadEtiColumnsEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxvDadEtiGapHor: TcxEditorRow
          Properties.Caption = 'Gap Horizontal'
          Properties.Hint = 'Dist'#226'ncia entre as etiquetas'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadEtiGapHorEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxvDadEtiGapVer: TcxEditorRow
          Properties.Caption = 'Gap Vertical'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadEtiGapVerEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxvDadEtiZebra: TcxEditorRow
          Properties.Caption = 'Linha Zebrada'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnEditValueChanged = cxvDadEtiZebraEditPropertiesEditValueChanged
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
        object cxvDadEtiCorZebra: TcxEditorRow
          Properties.Caption = 'Cor da Zebra'
          Properties.EditPropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.EditProperties.CustomColors = <>
          Properties.EditProperties.DefaultColor = clWhite
          Properties.EditProperties.DefaultDescription = 'Sem cor'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.NamingConvention = cxncNone
          Properties.EditProperties.ShowDescriptions = False
          Properties.EditProperties.OnChange = cxvDadEtiCorZebraEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 6
          ParentID = -1
          Index = 6
          Version = 1
        end
        object cxvDadEtiExpZebra: TcxEditorRow
          Properties.Caption = 'Express'#227'o da Zebra'
          Properties.EditPropertiesClassName = 'TcxTextEditProperties'
          Properties.EditProperties.OnValidate = cxvDadEtiExpZebraEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = ''
          ID = 7
          ParentID = -1
          Index = 7
          Version = 1
        end
        object cxvDadEtiMolDad: TcxEditorRow
          Properties.Caption = 'Espessura da Moldura'
          Properties.EditPropertiesClassName = 'TcxSpinEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.MaxValue = 5.000000000000000000
          Properties.EditProperties.OnChange = cxvDadEtiMolDadEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 8
          ParentID = -1
          Index = 8
          Version = 1
        end
        object cxvDadEtiOrdenacao: TcxEditorRow
          Properties.Caption = 'Ordena'#231#227'o'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.ViewStyle = vsButtonsOnly
          Properties.EditProperties.OnButtonClick = cxvDadEtiOrdenacaoEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 9
          ParentID = -1
          Index = 9
          Version = 1
        end
      end
    end
    object pnlDadPag: TPanel
      Left = 0
      Top = 569
      Width = 229
      Height = 123
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object pnlCabPag: TPanel
        Left = 0
        Top = 0
        Width = 229
        Height = 15
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Dados da P'#225'gina'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object btnMosPag: TSpeedButton
          Left = 168
          Top = 0
          Width = 23
          Height = 18
          Hint = 'Mostrar/esconder dados da pagina'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
            0EEE333377777777777733330FF00FBFB0EE33337F37733F377733330F0BFB0B
            FB0E33337F73FF73337733330FF000BFBFB033337F377733333733330FFF0BFB
            FBF033337FFF733F333733300000BF0FBFB03FF77777F3733F37000FBFB0F0FB
            0BF077733FF7F7FF7337E0FB00000000BF0077F377777777F377E0BFBFBFBFB0
            F0F077F3333FFFF7F737E0FBFB0000000FF077F3337777777337E0BFBFBFBFB0
            FFF077F3333FFFF73FF7E0FBFB00000F000077FF337777737777E00FBFBFB0FF
            0FF07773FFFFF7337F37003000000FFF0F037737777773337F7333330FFFFFFF
            003333337FFFFFFF773333330000000003333333777777777333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          Visible = False
          OnClick = btnMosPagClick
        end
      end
      object cxvDadPag: TcxVerticalGrid
        Left = 0
        Top = 15
        Width = 229
        Height = 108
        Align = alClient
        LookAndFeel.ScrollbarMode = sbmClassic
        OptionsView.ScrollBars = ssVertical
        OptionsView.RowHeaderWidth = 141
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.GoToNextCellOnTab = True
        TabOrder = 1
        Version = 1
        object cxvDadPagPapel: TcxEditorRow
          Properties.Caption = 'Papel'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagPapelEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxvDadPagEspacamento: TcxEditorRow
          Properties.Caption = 'Espa'#231'amento das Linhas'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.CaseInsensitive = False
          Properties.EditProperties.DropDownListStyle = lsEditFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            '1/6'
            '1/8')
          Properties.EditProperties.OnChange = cxvDadPagEspacamentoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = ''
          ID = 1
          ParentID = -1
          Index = 1
          Version = 1
        end
        object cxvDadPagLinCommand: TcxEditorRow
          Properties.Caption = 'Linhas Impres. (Command)'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.DecimalPlaces = 0
          Properties.EditProperties.DisplayFormat = '0;-0'
          Properties.EditProperties.OnValidate = cxvDadPagLinCommandEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 2
          ParentID = -1
          Index = 2
          Version = 1
        end
        object cxvDadPagImpressora: TcxEditorRow
          Properties.Caption = 'Comandos ESCAPE'
          Properties.Hint = 'Formata'#231#227'o da Fonte'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'N'#227'o enviar'
            'Epson Gen'#233'rica'
            'HP Gen'#233'rica'
            'IBM Gen'#233'rica')
          Properties.EditProperties.OnChange = cxvDadPagImpressoraEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 3
          ParentID = -1
          Index = 3
          Version = 1
        end
        object cxvDadPagOrientacao: TcxEditorRow
          Properties.Caption = 'Orienta'#231#227'o'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.Items.Strings = (
            'Retrato'
            'Paisagem')
          Properties.EditProperties.OnChange = cxvDadPagOrientacaoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 4
          ParentID = -1
          Index = 4
          Version = 1
        end
        object cxvDadPagSemFim: TcxEditorRow
          Properties.Caption = 'Altura sem fim'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagSemFimEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 5
          ParentID = -1
          Index = 5
          Version = 1
        end
        object cxvDadPagInfAlt: TcxEditorRow
          Properties.Caption = 'Inf. Altura da P'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.ValueChecked = 'S'
          Properties.EditProperties.ValueUnchecked = 'N'
          Properties.EditProperties.OnChange = cxvDadPagInfAltEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 6
          ParentID = -1
          Index = 6
          Version = 1
        end
        object cxvDadPagAvancar: TcxEditorRow
          Properties.Caption = 'Avan'#231'ar P'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.ValueChecked = 'S'
          Properties.EditProperties.ValueUnchecked = 'N'
          Properties.EditProperties.OnChange = cxvDadPagAvancarEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 7
          ParentID = -1
          Index = 7
          Version = 1
        end
        object cxvDadPagAltura: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagAlturaEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 8
          ParentID = -1
          Index = 8
          Version = 1
        end
        object cxvDadPagLargura: TcxEditorRow
          Properties.Caption = 'Largura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagLarguraEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 9
          ParentID = -1
          Index = 9
          Version = 1
        end
        object cxvDadPagMargens: TcxEditorRow
          Properties.Caption = 'Margens'
          Properties.DataBinding.ValueType = 'String'
          Properties.Options.Editing = False
          Properties.Value = Null
          ID = 10
          ParentID = -1
          Index = 10
          Version = 1
        end
        object cxvDadPagMargemSup: TcxEditorRow
          Properties.Caption = 'Superior'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagMargemSupEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 11
          ParentID = 10
          Index = 0
          Version = 1
        end
        object cxvDadPagMargemInf: TcxEditorRow
          Properties.Caption = 'Inferior'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagMargemInfEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 12
          ParentID = 10
          Index = 1
          Version = 1
        end
        object cxvDadPagMargemEsq: TcxEditorRow
          Properties.Caption = 'Esquerda'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagMargemEsqEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 13
          ParentID = 10
          Index = 2
          Version = 1
        end
        object cxvDadPagMargemDir: TcxEditorRow
          Properties.Caption = 'Direita'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagMargemDirEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 14
          ParentID = 10
          Index = 3
          Version = 1
        end
        object cxvDadPagMoldura: TcxEditorRow
          Properties.Caption = 'Espessura das Bordas'
          Properties.EditPropertiesClassName = 'TcxSpinEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagMolduraEditPropertiesChange
          Properties.DataBinding.ValueType = 'Integer'
          Properties.Value = 0
          ID = 15
          ParentID = -1
          Index = 11
          Version = 1
        end
        object cxvDadPagMolSup: TcxEditorRow
          Properties.Caption = 'Superior'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagMolSupEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 16
          ParentID = 15
          Index = 0
          Version = 1
        end
        object cxvDadPagMolInf: TcxEditorRow
          Properties.Caption = 'Inferior'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagMolInfEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 17
          ParentID = 15
          Index = 1
          Version = 1
        end
        object cxvDadPagMolEsq: TcxEditorRow
          Properties.Caption = 'Esquerda'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagMolEsqEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 18
          ParentID = 15
          Index = 2
          Version = 1
        end
        object cxvDadPagMolDir: TcxEditorRow
          Properties.Caption = 'Direita'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagMolDirEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 19
          ParentID = 15
          Index = 3
          Version = 1
        end
        object cxvDadPagHeader: TcxEditorRow
          Properties.Caption = 'Cabe'#231'alho de P'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagHeaderEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 20
          ParentID = -1
          Index = 12
          Version = 1
        end
        object cxvDadPagHeaderFonte: TcxEditorRow
          Properties.Caption = 'Fonte'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.ViewStyle = vsButtonsOnly
          Properties.EditProperties.OnButtonClick = cxvDadPagHeaderFonteEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          Visible = False
          ID = 21
          ParentID = 20
          Index = 0
          Version = 1
        end
        object cxvDadPagHeaAlt: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagHeaAltEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 22
          ParentID = 20
          Index = 1
          Version = 1
        end
        object cxvDadPagCabPri: TcxEditorRow
          Properties.Caption = 'Apenas na primeira p'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.ValueChecked = 'S'
          Properties.EditProperties.ValueUnchecked = 'N'
          Properties.EditProperties.OnEditValueChanged = cxvDadPagCabPriEditPropertiesEditValueChanged
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 23
          ParentID = 20
          Index = 2
          Version = 1
        end
        object cxvDadPagHeaderData: TcxEditorRow
          Properties.Caption = 'Cabe'#231'alho de Dados'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagHeaderDataEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 24
          ParentID = -1
          Index = 13
          Version = 1
        end
        object cxvDadPagHeaderDataFonte: TcxEditorRow
          Properties.Caption = 'Fonte'
          Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
          Properties.EditProperties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.EditProperties.ViewStyle = vsButtonsOnly
          Properties.EditProperties.OnButtonClick = cxvDadPagHeaderDataFonteEditPropertiesButtonClick
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          Visible = False
          ID = 25
          ParentID = 24
          Index = 0
          Version = 1
        end
        object cxvDadPagHeaderDataAlt: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagHeaderDataAltEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 26
          ParentID = 24
          Index = 1
          Version = 1
        end
        object cxvDadPagHeaderDataCorFundo: TcxEditorRow
          Properties.Caption = 'Cor do Fundo'
          Properties.EditPropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.EditProperties.CustomColors = <>
          Properties.EditProperties.DefaultColor = clWhite
          Properties.EditProperties.DefaultDescription = 'Sem cor'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.NamingConvention = cxncNone
          Properties.EditProperties.ShowDescriptions = False
          Properties.EditProperties.OnChange = cxvDadPagHeaderDataCorFundoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 27
          ParentID = 24
          Index = 2
          Version = 1
        end
        object cxvDadPagHeaderDataMoldura: TcxEditorRow
          Properties.Caption = 'Moldura'
          Properties.EditPropertiesClassName = 'TcxSpinEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.MaxValue = 5.000000000000000000
          Properties.EditProperties.OnChange = cxvDadPagHeaderDataMolduraEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 28
          ParentID = 24
          Index = 3
          Version = 1
        end
        object cxvDadPagFooterData: TcxEditorRow
          Properties.Caption = 'Rodap'#233' de Dados'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagFooterDataEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 29
          ParentID = -1
          Index = 14
          Version = 1
        end
        object cxvDadPagFooDataAlt: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagFooDataAltEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 30
          ParentID = 29
          Index = 0
          Version = 1
        end
        object cxvDadPagFooterDataCorFundo: TcxEditorRow
          Properties.Caption = 'Cor do Fundo'
          Properties.EditPropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.EditProperties.CustomColors = <>
          Properties.EditProperties.DefaultColor = clWhite
          Properties.EditProperties.DefaultDescription = 'Sem cor'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.NamingConvention = cxncNone
          Properties.EditProperties.ShowDescriptions = False
          Properties.EditProperties.OnChange = cxvDadPagFooterDataCorFundoEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 31
          ParentID = 29
          Index = 1
          Version = 1
        end
        object cxvDadPagFooterDataMoldura: TcxEditorRow
          Properties.Caption = 'Moldura'
          Properties.EditPropertiesClassName = 'TcxSpinEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.MaxValue = 5.000000000000000000
          Properties.EditProperties.OnChange = cxvDadPagFooterDataMolduraEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 32
          ParentID = 29
          Index = 2
          Version = 1
        end
        object cxvDadPagFooter: TcxEditorRow
          Properties.Caption = 'Rodap'#233' de P'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagFooterEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 33
          ParentID = -1
          Index = 15
          Version = 1
        end
        object cxvDadPagFooUltImp: TcxEditorRow
          Properties.Caption = 'Apenas na '#250'ltima p'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagFooUltImpEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 34
          ParentID = 33
          Index = 0
          Version = 1
        end
        object cxvDadPagFooNewPage: TcxEditorRow
          Properties.Caption = 'Nova P'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagFooNewPageEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 35
          ParentID = 33
          Index = 1
          Version = 1
        end
        object cxvDadPagFooAlt: TcxEditorRow
          Properties.Caption = 'Altura'
          Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.EditProperties.AssignedValues.MinValue = True
          Properties.EditProperties.DisplayFormat = '0.00;-0.00'
          Properties.EditProperties.OnValidate = cxvDadPagFooAltEditPropertiesValidate
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = ''
          ID = 36
          ParentID = 33
          Index = 2
          Version = 1
        end
        object cxvDadPagFooBra: TcxEditorRow
          Properties.Caption = 'Espa'#231'o em branco nas primeiras p'#225'ginas'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagFooBraEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 37
          ParentID = 33
          Index = 3
          Version = 1
        end
        object cxvDadPagMsgProx: TcxEditorRow
          Properties.Caption = 'Mensagem "Continua na Pr'#243'xima P'#225'gina..."'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagMsgProxEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = 'False'
          ID = 38
          ParentID = -1
          Index = 16
          Version = 1
        end
        object cxvDadPagViaPag: TcxEditorRow
          Expanded = False
          Properties.Caption = 'Mais de uma via na mesma p'#225'gina'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.OnChange = cxvDadPagViaPagEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 39
          ParentID = -1
          Index = 17
          Version = 1
        end
        object cxvDadPagPapelViaPag: TcxEditorRow
          Properties.Caption = 'Papel para as vias'
          Properties.EditPropertiesClassName = 'TcxComboBoxProperties'
          Properties.EditProperties.DropDownListStyle = lsFixedList
          Properties.EditProperties.OnChange = cxvDadPagPapelViaPagEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 40
          ParentID = 39
          Index = 0
          Version = 1
        end
        object cxvDadPagMarcaDAgua: TcxEditorRow
          Properties.Caption = 'Imagem de Fundo'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.OnChange = cxvDadPagMarcaDaguaEditPropertiesChange
          Properties.DataBinding.ValueType = 'Boolean'
          Properties.Value = Null
          ID = 41
          ParentID = -1
          Index = 18
          Version = 1
        end
        object cxvDadPagIMPPDF: TcxEditorRow
          Properties.Caption = 'Imprimir sempre em PDF'
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.EditProperties.ImmediatePost = True
          Properties.EditProperties.ValueChecked = 'True'
          Properties.EditProperties.ValueUnchecked = 'False'
          Properties.EditProperties.OnChange = cxvDadPagIMPPDFEditPropertiesChange
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 42
          ParentID = -1
          Index = 19
          Version = 1
        end
      end
    end
  end
  object dtsTabCam: TDataSource
    Left = 96
    Top = 80
  end
  object cxStyleRepositorio: TcxStyleRepository
    Left = 32
    Top = 144
    PixelsPerInch = 96
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 15658734
      TextColor = clBlack
    end
    object cxStyle3: TcxStyle
    end
  end
  object ImageList: TImageList
    Left = 240
    Top = 64
    Bitmap = {
      494C01010C001100040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF0000000000BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      000000FFFF0000FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF008484E7000000FF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      00000000000000FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF000000FF004263E7000000FF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF0000000000FFFFFF00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD0000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF00000000000000000000FFFF0000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000FF0084A5E7000000FF000000
      FF000000FF00F7FFFF004263E700F7FFFF0000000000BDBDBD00FFFFFF00BDBD
      BD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF000000000000FFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF008484E7004263E700F7FFFF0084A5
      E7004221E7004242E7000000FF00F7FFFF0000000000FFFFFF00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFFFF00BDBDBD00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000F7FFFF0084848400848484008484
      840084848400848484008484840084848400848484004221E70084A5E7004242
      E700F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7CEA500F7CEA5004263A5004242E7008484
      E700F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      000000000000FFFF0000BDBDBD0000000000000000000000000000000000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00C6630000C6630000F7FF
      FF00C6A56300C6A56300C6A56300C6A56300F7FFFF008463A5004221E700C6A5
      E700F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF000000000000BDBDBD000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00FFFFFF00FFFFFF00FFFF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF004242C6004263E7008463
      E70000632100F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      00000000FF000000FF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF004263A5004263E7000042
      840042C663000084420000630000F7FFFF000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      00000000FF000000FF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00C6A56300C6A56300FFFF
      FF00C6A56300C6A56300C6A56300C6A56300F7FFFF00848484000063A50042C6
      840042E7840042A5420042A54200F7FFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00C6630000C6630000FFFF
      FF00C6630000C6630000C6630000C6630000F7FFFF0084848400F7FFFF00F7FF
      FF0084E7840000842100F7FFFF00F7FFFF000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00C6630000C6630000FFFF
      FF00C6630000C6630000C6630000C6630000FFFFFF0084848400F7FFFF0084A5
      840084E7A500F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840084C6840042C6
      630042A56300F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000F7FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084C6840084C6840084C68400F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003131310031313100313131003131310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000031313100736B6B007B737300737373008484840031313100313131003131
      3100000000000000000000000000000000000000000000000000000000000000
      6B0000006B000000000000000000000000000000000000000000000000000000
      6B0000006B000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      3100736B73006B636B007B7B7B00292929003939390042424200292929006B6B
      6B0031313100313131003131310000000000000000000000000000006B000018
      EF000010DE0000006B000000000000000000000000000000000000006B000000
      E7000008E70000006B0000000000000000000000000000000000000000000000
      0000000000007B7B7B000000000000000000000000007B7B7B00000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313131006B6B
      6B00737373006B6B6B007B7B7B006B6B6B004A4A4A0018181800000000000000
      000008080800737373007373730042424200000000000000000000006B000018
      E7000018EF000010DE0000006B00000000000000000000006B000000DE000008
      EF000000DE0000006B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000000000000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031313100CECECE00CEC6
      CE009C949C006B636B00E7E7E700DEDEDE00ADADAD008C8C8C00525252002121
      210021182100394A390039523900424242000000000000000000000000000000
      6B000018DE000021EF000010DE0000006B0000006B000000E7000008EF000000
      DE0000006B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF00000000000000000000000000
      0000000000000000000000000000000000003131310094949400D6D6DE00D6D6
      DE00F7F7F700848484006B6B6B00A5A5A500DEDEDE00EFEFEF00E7EFEF00D6DE
      DE00ADADAD006B846B0039843900424242000000000000000000000000000000
      000000006B000018DE000021EF000010E7000008EF000008EF000000DE000000
      6B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000031313100EFEFF700E7E7EF00F7F7
      F700CEADAD00C6A5AD0094949C006B6B6B00525252006B636300A5848400C6AD
      AD00D6D6D600E7E7E700DEDEDE00424242000000000000000000000000000000
      00000000000000006B000018E7000010EF000010EF000008DE0000006B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000031313100FFFFFF00FFFFFF00CE9C
      9400B53931009442420084636300BDADAD00D6D6D600B58C8C007B1010009C39
      3900736B6B006B6B6B0063636300000000000000000000000000000000000000
      00000000000000006B000021E7000018EF000018EF000010DE0000006B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B0000FFFF007B7B
      7B000000000000000000000000000000000031313100FFFFFF00FFFFFF009C31
      3100BD424200A55252007B292900AD6B6B00FFFFFF00D6A5A5007B1010009C31
      3100292929002929290000000000000000000000000000000000000000000000
      000000006B000029E7000031EF000021E7000018E7000021EF000018DE000000
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000003939390031313100CECECE009C31
      3100BD424200AD5252009C5252008C525200CEC6C600CE949400841010009C31
      3100000000000000000000000000000000000000000000000000000000000000
      6B000831E7000839EF000029DE0000006B0000006B000018DE000029EF000018
      DE0000006B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000000000000000000000007B7B7B0000FFFF007B7B
      7B00000000000000000000000000000000000000000000000000313131009C31
      3100BD424200B54A4A00C66B6B00BD636300BD5A5A00BD5A5A00BD5A5A009C31
      310000000000000000000000000000000000000000000000000000006B001042
      E7001042EF000829DE0000006B00000000000000000000006B000021DE000029
      EF000018E70000006B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      3100B5635A00EFD6D600EFDEDE00EFDEDE00EFDEDE00F7E7E700C67B7B009C31
      310000000000000000000000000000000000000000000000000000006B00184A
      E7001031DE0000006B000000000000000000000000000000000000006B000021
      DE000021E70000006B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      3100C67B7B00F7FFFF00C6C6C600C6C6C600C6C6C600E7EFEF00C67B7B009C31
      3100000000000000000000000000000000000000000000000000000000000000
      6B0000006B000000000000000000000000000000000000000000000000000000
      6B0000006B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      3100C67B7B00F7F7F700DEDED600DEDED600DEDED600E7E7E700C67B7B009C31
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      3100C67B7B00F7F7F700C6C6C600C6C6C600C6C6C600E7E7E700C67B7B009C31
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5736B00CEC6C600CEC6C600CEC6C600CEC6C600CEC6C600B5736B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      84000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000BDBDBD0000000000FF000000FF000000FF00
      00000000FF00FF000000FF000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      8400000084000000840000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      840000008400000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000FFFFFF0000000000BDBD
      BD00FFFFFF0000000000FFFFFF000000000000000000000000007B7B7B000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      8400FFFF0000000084000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      8400FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000008001FFFFC003FFFF0000FFF8C0030000
      0000FFF8C0030000000081FFC0030000000081FCC00300000000FFFCC0030000
      0000FFFFC00300000000FFFCC0030000E007F7FCC0030000E007E7FFC0030000
      E0078013C0030000E0078013C0030000E00FE7FFC0030000E01FF7F8C0030000
      E03FFFF8C0030000E07FFFFFC0030000FFFFFFFFFFFFF87FFFFFFFE3F83FF00F
      E7E7FFC3E7CFE001C3C3FB83DFF7C000C183F907B01B8000E007F80FB83B0000
      F00FF01F7C7D0000F81FF03F7E8D0001F81FE01F41050003F00FE00F4105000F
      E007C07F4105C00FC183C1FF818BE00FC3C387FF81FBE00FE7E79FFFDFF7E00F
      FFFFFFFFE7CFE00FFFFFFFFFF83FF01FFF7EFF7EFF00C00790019001FF00C007
      C003C003FF00C007E003E003FF00C007E003E0030000C007E003E0030000C007
      E003E0030000C007000100010000C007800080000023C007E007E0070001C007
      E00FE00F0000C007E00FE00F0023C007E027E0270063C007C073C07300C3C007
      9E799E790107C0077EFE7EFE03FFC00700000000000000000000000000000000
      000000000000}
  end
  object MainMenu: TMainMenu
    Left = 240
    Top = 96
    object mnuLayout: TMenuItem
      Caption = 'Layout'
      object mnuNovo: TMenuItem
        Caption = 'Novo'
        OnClick = mnuNovoClick
      end
      object mnuCarregarPadrao: TMenuItem
        Caption = 'Carregar Padr'#227'o'
        OnClick = mnuCarregarPadraoClick
      end
      object mnuSalvarPadrao: TMenuItem
        Caption = 'Salvar como padr'#227'o'
        OnClick = mnuSalvarPadraoClick
      end
      object mnuPreview: TMenuItem
        Caption = 'Preview'
        OnClick = mnuPreviewClick
      end
      object mnuCarregar: TMenuItem
        Caption = 'Carregar...'
        OnClick = mnuCarregarClick
      end
      object mnuSalvar: TMenuItem
        Caption = 'Salvar'
        OnClick = mnuSalvarClick
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
  object tmrRegua: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrReguaTimer
    Left = 304
    Top = 96
  end
  object dtsGrupos: TDataSource
    Left = 72
    Top = 504
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 32
    Top = 80
    PixelsPerInch = 96
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
  end
end
