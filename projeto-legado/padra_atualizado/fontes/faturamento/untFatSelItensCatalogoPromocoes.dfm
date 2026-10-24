inherited frmFatSelItensCatalogoPromocoes: TfrmFatSelItensCatalogoPromocoes
  Width = 1024
  Height = 684
  Caption = 'Sele'#231#227'o de produtos para gera'#231#227'o de cat'#225'logo (Promo'#231#245'es)'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 684
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 611
    Width = 1018
    ExplicitTop = 611
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Left = 779
      Width = 160
      TabOrder = 7
      ExplicitLeft = 779
      ExplicitWidth = 160
    end
    inherited btnSair: TBitBtnLocked
      Left = 939
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 6
      ExplicitLeft = 939
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnGerarRelatorio: TBitBtnLocked
      Left = 342
      Top = 2
      Width = 131
      Height = 24
      Align = alLeft
      Caption = '[F10] Gerar Relat'#243'rio'
      TabOrder = 3
      OnClick = btnGerarRelatorioClick
    end
    object btnDesmarcarTodos: TBitBtnLocked
      Left = 102
      Top = 2
      Width = 120
      Height = 24
      Align = alLeft
      Caption = '[F6] Desmarcar Todos'
      TabOrder = 1
      OnClick = btnDesmarcarTodosClick
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 100
      Height = 24
      Align = alLeft
      Caption = '[F5] Marcar Todos'
      TabOrder = 0
      OnClick = btnMarcarTodosClick
    end
    object btnPadrao: TBitBtnLocked
      Left = 644
      Top = 2
      Width = 135
      Height = 24
      Align = alLeft
      Caption = '&Restaurar Padr'#227'o'
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
      OnClick = btnPadraoClick
    end
    object btnInverterSelecao: TBitBtnLocked
      Left = 222
      Top = 2
      Width = 120
      Height = 24
      Align = alLeft
      Caption = '[F7] Inverter sele'#231#227'o'
      TabOrder = 2
      OnClick = btnInverterSelecaoClick
    end
    object btnEnviarEmailRelatorio: TBitBtnLocked
      Left = 473
      Top = 2
      Width = 171
      Height = 24
      Align = alLeft
      Caption = '[F11] Enviar Relat'#243'rio por E-mail'
      TabOrder = 4
      OnClick = btnEnviarEmailRelatorioClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 639
    Width = 1018
    ExplicitTop = 639
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
      object Shape1: TShape
        Left = 830
        Top = 2
        Width = 15
        Height = 12
        Align = alRight
        Brush.Color = clBlue
        ExplicitLeft = 349
        ExplicitTop = 1
        ExplicitHeight = 15
      end
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 385
    Width = 1018
    Height = 226
    Align = alClient
    TabOrder = 2
    object grdItens: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1016
      Height = 193
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdItensTableView: TcxGridDBTableViewCitel
        OnDblClick = grdItensTableViewDblClick
        OnKeyDown = grdItensTableViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdItensTableViewCustomDrawCell
        DataController.DataSource = dtsDados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OnColumnPosChanged = grdItensTableViewColumnPosChanged
        OnColumnSizeChanged = grdItensTableViewColumnSizeChanged
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
      end
      object grdItensLevel1: TcxGridLevel
        GridView = grdItensTableView
      end
    end
    object pnlLegendas: TPanel
      Left = 1
      Top = 194
      Width = 1016
      Height = 31
      Align = alBottom
      BorderWidth = 5
      TabOrder = 1
      object pnlLegendaSelecionados: TPanel
        Left = 6
        Top = 6
        Width = 96
        Height = 19
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 0
        object Shape2: TShape
          Left = 1
          Top = 3
          Width = 15
          Height = 13
          Brush.Color = clBlue
        end
        object Label5: TLabel
          Left = 18
          Top = 3
          Width = 65
          Height = 14
          Caption = 'Selecionados'
        end
      end
      object pnlLegendaEmPromocao: TPanel
        Left = 102
        Top = 6
        Width = 96
        Height = 19
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        Ctl3D = False
        ParentBackground = False
        ParentCtl3D = False
        TabOrder = 1
        object shpPromocao: TShape
          Left = 1
          Top = 3
          Width = 15
          Height = 13
          Brush.Color = clGreen
        end
        object Label4: TLabel
          Left = 18
          Top = 3
          Width = 65
          Height = 14
          Caption = 'Em promo'#231#227'o'
        end
      end
    end
  end
  object pnlFiltros: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 385
    Align = alTop
    BorderStyle = bsSingle
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object pnlBotoesPesquisa: TPanel
      Left = 1
      Top = 350
      Width = 1012
      Height = 30
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
      DesignSize = (
        1012
        30)
      object btnPesquisar: TBitBtnLocked
        Left = 811
        Top = 5
        Width = 92
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '&Pesquisar'
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
        OnClick = btnPesquisarClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 909
        Top = 5
        Width = 92
        Height = 22
        Anchors = [akRight, akBottom]
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
        OnClick = btnCancelarClick
      end
    end
    inline frameFiltrosCatPromocao: TframeFiltrosCatPromocao
      Left = 1
      Top = 1
      Width = 1012
      Height = 349
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 1012
      ExplicitHeight = 349
      inherited pnlFiltrosProdutos: TPanel
        Width = 1012
        ExplicitWidth = 1012
        inherited grpProdutos: TGroupBox
          Width = 1012
          ExplicitWidth = 1012
          inherited lblDepartamento: TLabel
            Left = 19
            Width = 70
            Height = 14
            ExplicitLeft = 19
            ExplicitWidth = 70
            ExplicitHeight = 14
          end
          inherited lblDesCon: TLabel
            Left = 595
            Width = 70
            Height = 14
            ExplicitLeft = 595
            ExplicitWidth = 70
            ExplicitHeight = 14
          end
          inherited lblTabPreco: TLabel
            Width = 54
            Height = 14
            ExplicitWidth = 54
            ExplicitHeight = 14
          end
          inherited Label59: TLabel
            Height = 14
            ExplicitHeight = 14
          end
          inherited edtDesDepPrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtCodMarPrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtDesMarPrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtDescri: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtCodItePrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtDesItePrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited cmbComSaldo: TComboBoxFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited cbTabPreco: TComboBoxFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtNomForPrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtCodEmpPrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited edtDesEmpPrm: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
        end
      end
      inherited pnlFiltrosPromocao: TPanel
        Width = 1012
        ExplicitWidth = 1012
        inherited grpPromocao: TGroupBox
          Width = 1012
          ExplicitWidth = 1012
          inherited lblTabPrecoPromocinal: TLabel
            Width = 112
            Height = 14
            ExplicitWidth = 112
            ExplicitHeight = 14
          end
          inherited edtDesPro: TEditFocus
            Height = 22
            ExplicitHeight = 22
          end
          inherited cbTabPrecoProm: TComboBoxFocus
            Height = 22
            ExplicitHeight = 22
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 268
    Top = 324
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 424
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 268
    Top = 372
  end
  object dtsDados: TDataSource
    Left = 224
    Top = 324
  end
  object frxRelJato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    EngineOptions.MaxMemSize = 10000
    EngineOptions.UseFileCache = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.PagesInCache = 6
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.PictureCacheInFile = True
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43130.492521354200000000
    ReportOptions.LastChange = 43850.679751851850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   pCarregarImagemProduto;  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 568
    Top = 444
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 279.400000000000000000
      PaperHeight = 215.900000000000000000
      PaperSize = 1
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      OnAfterPrint = 'Page1OnAfterPrint'
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 130.015748030000000000
        Top = 181.417440000000000000
        Width = 1018.205382000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Columns = 4
        ColumnWidth = 254.362204724409000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object shpBorda: TfrxShapeView
          Width = 254.362204720000000000
          Height = 130.015748030000000000
        end
        object ImgProduto: TfrxPictureView
          Left = 3.000000000000000000
          Top = 3.913385830000010000
          Width = 103.385900000000000000
          Height = 116.409456140000000000
          OnAfterData = 'ImgProdutoOnAfterData'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo1: TfrxMemoView
          Left = 110.000000000000000000
          Top = 77.913419999999970000
          Width = 141.732278580000000000
          Height = 15.118112680000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ref: [frxRelatorio."Refer'#234'ncia"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 110.000000000000000000
          Top = 22.677165350000000000
          Width = 141.732278580000000000
          Height = 45.354330710000000000
          DataField = 'Descri'#231#227'o'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."Descri'#231#227'o"]')
          ParentFont = False
        end
        object memPrePromo: TfrxMemoView
          Left = 178.031540000000000000
          Top = 99.173160000000000000
          Width = 73.700738580000010000
          Height = 22.677172680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."Pre'#231'o"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 109.984251970000000000
          Top = 99.023619610000030000
          Width = 62.362148580000000000
          Height = 22.677167800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."Marca"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 109.606370000000000000
          Top = 3.779529999999994000
          Width = 141.732278580000000000
          Height = 15.118112680000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd: [frxRelatorio."C'#243'digo"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 100.913420000000000000
        Top = 18.897650000000000000
        Width = 1018.205382000000000000
        object Memo5: TfrxMemoView
          Align = baCenter
          Left = 292.673237499999900000
          Top = 44.252010000000000000
          Width = 432.858907000000000000
          Height = 49.133890000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -40
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMP_FONE01]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Align = baRight
          Left = 736.527674999999900000
          Top = 22.677177560000000000
          Width = 281.677707000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[OPE_NOMOPE]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baRight
          Left = 736.527674999999900000
          Top = 45.354360000000000000
          Width = 281.677707000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[OPE_EMAIL_]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baRight
          Left = 736.870734499999900000
          Top = 68.031540000000010000
          Width = 281.334647500000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[EMP_HOMEPA]')
          ParentFont = False
          VAlign = vaCenter
        end
        object imgLogo: TfrxPictureView
          Align = baLeft
          Top = 3.779530000000001000
          Width = 150.047310000000000000
          Height = 85.795275590000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo8: TfrxMemoView
          Align = baCenter
          Left = 291.779715999999900000
          Top = 3.779530000000001000
          Width = 434.645950000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITULO]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 96.488257320000000000
        Top = 370.393940000000000000
        Width = 1018.205382000000000000
        object memObsPromocao: TfrxMemoView
          Align = baRight
          Left = 678.846951149999900000
          Width = 339.358430850000000000
          Height = 49.133875350000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Promo'#231#227'o v'#225'lida at'#233' 00/00/0000')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Align = baLeft
          Top = 0.000007320000008804
          Width = 603.453050850000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data e Hora da Emiss'#227'o da Promo'#231#227'o: [REL_EXEC]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 26.456717320000000000
          Width = 603.453050850000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP_ENDERE]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Top = 54.913427319999980000
          Width = 603.453050850000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP_NOMCID]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 873.071430000000000000
          Top = 75.590607320000000000
          Width = 141.656710000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page]/[TotalPages]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 572
    Top = 393
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 640
    Top = 392
  end
  object cxImageCollection1: TcxImageCollection
    Left = 853
    Top = 141
  end
end
