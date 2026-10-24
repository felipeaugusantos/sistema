inherited frmRelEstComparativoPrecosFornec: TfrmRelEstComparativoPrecosFornec
  Width = 800
  Height = 441
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Comparativo de Pre'#231'os na forma'#231#227'o de custos por fornecedor'
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 441
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 359
    Width = 784
    Height = 27
    TabOrder = 3
    ExplicitTop = 359
    ExplicitWidth = 784
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 703
      Height = 23
      ExplicitWidth = 703
      ExplicitHeight = 23
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Height = 23
      TabOrder = 3
      ExplicitLeft = 705
      ExplicitHeight = 23
    end
    object btnSeleciona: TBitBtnLocked
      Left = 169
      Top = 3
      Width = 176
      Height = 22
      Caption = '[  SPACE ] Marca / Desmarca'
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
      TabOrder = 1
      OnClick = btnSelecionaClick
    end
    object btnBasCom: TBitBtnLocked
      Left = 350
      Top = 3
      Width = 235
      Height = 22
      Caption = '[Ctrl +  SPACE] Seleciona Base de Compara'#231#227'o'
      TabOrder = 2
      OnClick = btnBasComClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 386
    Width = 784
    ExplicitTop = 386
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 496
      Width = 288
      ExplicitLeft = 496
      ExplicitWidth = 288
    end
    inherited pnlInfo: TPanel
      Width = 496
      ExplicitWidth = 496
    end
  end
  inherited pnlDados: TPanel
    Top = 306
    Width = 784
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 306
    ExplicitWidth = 784
    ExplicitHeight = 53
    inherited gpbDestino: TGroupBox
      Left = 5
      Top = 3
      Width = 180
      ExplicitLeft = 5
      ExplicitTop = 3
      ExplicitWidth = 180
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
  end
  object cxgTabPre: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 784
    Height = 306
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgTabPreView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsTabPre
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgTabPreViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'd.Tabela'
        DataBinding.FieldName = 'CODTAB'
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 78
      end
      object cxgTabPreViewColumn2: TcxGridDBColumn
        Caption = 'Nome da Tabela'
        DataBinding.FieldName = 'NOMTAB'
        Options.Editing = False
        Width = 191
      end
      object cxgTabPreViewColumn3: TcxGridDBColumn
        Caption = 'C'#243'd.Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 100
      end
      object cxgTabPreViewColumn4: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 154
      end
      object cxgTabPreViewColumn5: TcxGridDBColumn
        Caption = 'Ativa Compras'
        DataBinding.FieldName = 'ATICMP'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 81
      end
      object TabPreBASCOM: TcxGridDBColumn
        Caption = 'Base Compara'#231#227'o'
        DataBinding.FieldName = 'BASCOM'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgTabPreViewBASCOMPropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 101
      end
      object TabPreCOMPAR: TcxGridDBColumn
        Caption = 'Comparar'
        DataBinding.FieldName = 'COMPAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = TabPreCOMPARPropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 68
      end
    end
    object cxgTabPreLevel1: TcxGridLevel
      GridView = cxgTabPreView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 128
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 16
    Top = 96
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 272
    Top = 96
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 240
    Top = 96
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 208
    Top = 96
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 176
    Top = 96
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 144
    Top = 96
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 80
    Top = 96
  end
  inherited frxGen: TfrxUserDataSet
    Left = 112
    Top = 96
  end
  inherited frxDesigner: TfrxDesigner
    Left = 336
    Top = 96
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 368
    Top = 96
  end
  object dtsTabPre: TDataSource
    Left = 448
    Top = 176
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
    ReportOptions.LastChange = 41057.665690462960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 168
    Top = 200
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 287.866480752897800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 272.000000000000000000
        Width = 1305.600000000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object frxDBItensfrxDBItens: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo2OnBeforePrint'
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 672.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoCusRea1: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoVariac2: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoCusRea2: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoVariac3: TfrxDMPMemoView
          Left = 1238.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoCusRea3: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoVariac1: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 323.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
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
        Height = 136.000000000000000000
        Top = 119.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 432.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO-DESCRICAO DO ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 672.000000000000000000
          Top = 102.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR1]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 68.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[TABELA1]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR2]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 68.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[TABELA2]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 34.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[FORNECEDOR3]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 68.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[TABELA3]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitCus1: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitCus2: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitVar2: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 102.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitCus3: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoTitVar3: TfrxDMPMemoView
          Left = 1238.400000000000000000
          Top = 102.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR.')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 916.800000000000000000
          Top = 8.500000000000000000
          Height = 119.000000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Left = 1108.800000000000000000
          Top = 8.500000000000000000
          Height = 119.000000000000000000
          Color = clBlack
        end
        object mmoTitVar1: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 102.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Visible = False
          DataSet = frxDBItens
          DataSetName = 'frxDBItens'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Left = 724.800000000000000000
          Top = 8.500000000000000000
          Height = 119.000000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Left = 724.800000000000000000
          Top = 59.500000000000000000
          Width = 576.000000000000000000
          Color = clBlack
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPLine10: TfrxDMPLineView
          Left = 1300.800000000000000000
          Top = 8.500000000000000000
          Height = 119.000000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 950.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 51.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
      end
    end
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
    ReportOptions.LastChange = 40961.780128935200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 224
    Top = 200
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 718.110700000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 718.488179210000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
        end
        object Memo4: TfrxMemoView
          Left = 42.133890000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
        end
        object Memo5: TfrxMemoView
          Left = 238.417440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItens."REFERE"]')
        end
        object Memo6: TfrxMemoView
          Left = 340.803340000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
        end
        object mmoVariac3: TfrxMemoView
          Left = 683.094930000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
        object mmoCusRea3: TfrxMemoView
          Left = 611.283860000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
        object mmoVariac2: TfrxMemoView
          Left = 569.574803149606300000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
        object mmoCusRea2: TfrxMemoView
          Left = 497.007874015748000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
        object mmoVariac1: TfrxMemoView
          Left = 453.866420000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
        object mmoCusRea1: TfrxMemoView
          Left = 381.937230000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 340.157700000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661410000000000000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 363.363760000000000000
          Top = 5.661410000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 81.252010000000000000
        ParentFont = False
        Top = 154.960730000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 717.732056460000000000
          Height = 79.370120240000000000
          Fill.BackColor = clSilver
        end
        object Shape2: TfrxShapeView
          Width = 718.110700000000000000
          Height = 56.692950000000000000
        end
        object Memo10: TfrxMemoView
          Top = 60.015770000000000000
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
        end
        object Memo1: TfrxMemoView
          Left = 238.488181650000000000
          Top = 60.015770000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFER'#202'NCIA')
        end
        object Memo2: TfrxMemoView
          Left = 340.913378500000000000
          Top = 60.795300000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo3: TfrxMemoView
          Left = 382.291590000000000000
          Top = 38.338590000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA1]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 382.291590000000000000
          Top = 4.000000000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR1]')
          WordBreak = True
        end
        object Memo8: TfrxMemoView
          Left = 496.897960000000000000
          Top = 38.338590000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA2]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 496.897960000000000000
          Top = 4.000000000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR2]')
          WordBreak = True
        end
        object Memo11: TfrxMemoView
          Left = 610.283860000000000000
          Top = 38.338590000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA3]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 610.283860000000000000
          Top = 4.000000000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR3]')
          WordBreak = True
        end
        object Line2: TfrxLineView
          Align = baWidth
          Left = 492.897960000000000000
          Top = 56.692950000000000000
          Width = 225.212740000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 380.157480310000000000
          Top = 34.015748030000000000
          Width = 336.378170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 492.897960000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 377.953000000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 607.504330000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitCus1: TfrxMemoView
          Left = 382.291590000000000000
          Top = 60.771653540000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar1: TfrxMemoView
          Left = 454.220780000000000000
          Top = 60.771653540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object mmoTitCus2: TfrxMemoView
          Left = 497.016080000000000000
          Top = 60.771653540000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar2: TfrxMemoView
          Left = 569.582706460000000000
          Top = 60.771653540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object mmoTitCus3: TfrxMemoView
          Left = 609.638220000000000000
          Top = 60.771653540000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar3: TfrxMemoView
          Left = 681.449290000000000000
          Top = 60.771653540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 73.645640000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 78.349815000000000000
          Top = 34.000000000000000000
          Width = 561.411070000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 648.718120000000000000
          Top = 34.000000000000000000
          Width = 66.066110000000000000
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
          Left = 647.584230000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
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
          Left = 553.020470000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
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
    end
  end
  object frxDBItens: TfrxDBDataset
    UserName = 'frxDBItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 392
    Top = 168
  end
  object frxReportJp: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40961.780128935200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 232
    Top = 256
    Datasets = <
      item
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
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
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBItens
        DataSetName = 'frxDBItens'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 1047.307289210000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxDBItens."CODITE"]')
        end
        object Memo4: TfrxMemoView
          Left = 45.913420000000000000
          Width = 188.976500000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItens."DESITE"]')
        end
        object Memo5: TfrxMemoView
          Left = 238.417440000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItens."REFERE"]')
        end
        object Memo6: TfrxMemoView
          Left = 340.803340000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBItens."SIGUNI"]')
        end
        object mmoVariac3: TfrxMemoView
          Left = 683.094930000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoCusRea3: TfrxMemoView
          Left = 611.283860000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoVariac2: TfrxMemoView
          Left = 569.574803150000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoCusRea2: TfrxMemoView
          Left = 497.007874020000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoVariac1: TfrxMemoView
          Left = 453.866420000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoCusRea1: TfrxMemoView
          Left = 381.937230000000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoVariac4: TfrxMemoView
          Left = 789.921770000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoCusRea4: TfrxMemoView
          Left = 718.110700000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoVariac5: TfrxMemoView
          Left = 903.307670000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoCusRea5: TfrxMemoView
          Left = 831.496600000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoVariac6: TfrxMemoView
          Left = 1012.914040000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
        object mmoCusRea6: TfrxMemoView
          Left = 941.102970000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 340.157700000000000000
        Width = 1046.929810000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 5.661410000000000000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 684.623810000000000000
          Top = 5.661410000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 81.252010000000000000
        ParentFont = False
        Top = 154.960730000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 1046.929133858268000000
          Height = 79.370120240000000000
          Fill.BackColor = clSilver
        end
        object Shape2: TfrxShapeView
          Width = 1046.929810000000000000
          Height = 56.692950000000000000
        end
        object Memo10: TfrxMemoView
          Top = 60.015770000000000000
          Width = 234.330860000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
        end
        object Memo1: TfrxMemoView
          Left = 238.488181650000000000
          Top = 60.015770000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFER'#202'NCIA')
        end
        object Memo2: TfrxMemoView
          Left = 340.913378500000000000
          Top = 60.795300000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo3: TfrxMemoView
          Left = 382.291590000000000000
          Top = 38.338590000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA1]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 382.291590000000000000
          Top = 4.000000000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR1]')
          WordBreak = True
        end
        object Memo8: TfrxMemoView
          Left = 496.897960000000000000
          Top = 38.338590000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA2]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 496.897960000000000000
          Top = 4.000000000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR2]')
          WordBreak = True
        end
        object Memo11: TfrxMemoView
          Left = 610.283860000000000000
          Top = 38.338590000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA3]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 610.283860000000000000
          Top = 4.000000000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR3]')
          WordBreak = True
        end
        object Line2: TfrxLineView
          Align = baWidth
          Left = 492.897960000000000000
          Top = 56.692950000000000000
          Width = 554.031850000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 380.157480310000000000
          Top = 34.015748030000000000
          Width = 665.197280000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line4: TfrxLineView
          Left = 492.897960000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 377.953000000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 607.504330000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object mmoTitCus1: TfrxMemoView
          Left = 382.291590000000000000
          Top = 60.771653540000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar1: TfrxMemoView
          Left = 454.220780000000000000
          Top = 60.771653540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Visible = False
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object mmoTitCus2: TfrxMemoView
          Left = 497.016080000000000000
          Top = 60.771653540000000000
          Width = 68.031496060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar2: TfrxMemoView
          Left = 569.582706460000000000
          Top = 60.771653540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object mmoTitCus3: TfrxMemoView
          Left = 609.638220000000000000
          Top = 60.771653540000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar3: TfrxMemoView
          Left = 681.449290000000000000
          Top = 60.771653540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object Line7: TfrxLineView
          Left = 718.110700000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo13: TfrxMemoView
          Left = 718.756340000000000000
          Top = 38.118120000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA4]')
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 718.756340000000000000
          Top = 3.779530000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR4]')
          WordBreak = True
        end
        object mmoTitCus4: TfrxMemoView
          Left = 718.110700000000000000
          Top = 60.551183540000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar4: TfrxMemoView
          Left = 789.921770000000000000
          Top = 60.551183540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object Line8: TfrxLineView
          Left = 827.717070000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo17: TfrxMemoView
          Left = 832.142240000000000000
          Top = 38.118120000000000000
          Width = 105.826796060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA5]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 832.142240000000000000
          Top = 3.779530000000000000
          Width = 105.826796060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR5]')
          WordBreak = True
        end
        object mmoTitCus5: TfrxMemoView
          Left = 831.496600000000000000
          Top = 60.551183540000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar5: TfrxMemoView
          Left = 903.307670000000000000
          Top = 60.551183540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
        object Line9: TfrxLineView
          Left = 941.102970000000000000
          Height = 78.236220470000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo21: TfrxMemoView
          Left = 941.748610000000000000
          Top = 38.118120000000000000
          Width = 102.047266060000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[TABELA6]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 941.748610000000000000
          Top = 3.779530000000000000
          Width = 102.047266060000000000
          Height = 25.700787400000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[FORNECEDOR6]')
          WordBreak = True
        end
        object mmoTitCus6: TfrxMemoView
          Left = 941.102970000000000000
          Top = 60.551183540000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO REAL')
        end
        object mmoTitVar6: TfrxMemoView
          Left = 1009.914040000000000000
          Top = 60.551183540000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '%VAR')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 73.645640000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 5.593940000000000000
          Top = 17.000000000000000000
          Width = 1035.741930000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
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
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 242.759370000000000000
          Top = 34.000000000000000000
          Width = 561.411070000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 974.757700000000000000
          Top = 34.000000000000000000
          Width = 66.066110000000000000
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
          Left = 973.623810000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
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
          Left = 879.060050000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
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
    end
  end
end
