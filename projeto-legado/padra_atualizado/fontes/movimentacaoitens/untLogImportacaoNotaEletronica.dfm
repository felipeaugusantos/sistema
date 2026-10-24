inherited frmLogImportacaoNotaEletronica: TfrmLogImportacaoNotaEletronica
  Width = 1060
  Height = 750
  Caption = 'Log Importa'#231#227'o de Nota Eletr'#244'nica'
  Position = poScreenCenter
  ExplicitTop = -22
  ExplicitWidth = 1060
  ExplicitHeight = 750
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 677
    Width = 1054
    ExplicitTop = 677
    ExplicitWidth = 1054
    inherited FlwBotoes: TFlowPanel
      Width = 1050
      ExplicitWidth = 1050
      object btnRelErr: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 25
        Align = alLeft
        Caption = 'Imprimir'
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 971
      ExplicitLeft = 971
    end
  end
  inherited pnlStatus: TPanel
    Top = 705
    Width = 1054
    ExplicitTop = 705
    ExplicitWidth = 1054
    inherited pnlNomeForm: TPanel
      Left = 883
      ExplicitLeft = 883
    end
    inherited pnlInfo: TPanel
      Width = 883
      ExplicitWidth = 883
    end
  end
  object Panel4: TPanel [2]
    Left = 0
    Top = 450
    Width = 1054
    Height = 225
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 1054
      Height = 25
      Align = alTop
      Caption = 'XML n'#227'o importado por ser Devolu'#231#227'o sem Nota de Entrada'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object cxgDevolucoes: TcxGridCitel
      Left = 0
      Top = 25
      Width = 1054
      Height = 200
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvDevolucoes: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsDevolucoes
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Editing = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxvDevolucoesDOCAUT: TcxGridDBColumn
          Caption = 'Documento Autcom - Entrada N'#227'o Realizada'
          DataBinding.FieldName = 'DOCAUT'
          Width = 510
        end
        object cxvDevolucoesNOMARQ: TcxGridDBColumn
          Caption = 'Arquivo XML de Devolu'#231#227'o'
          DataBinding.FieldName = 'NOMARQ'
          Width = 510
        end
      end
      object cxlDevolucoes: TcxGridLevel
        GridView = cxvDevolucoes
      end
    end
  end
  object Panel5: TPanel [3]
    Left = 0
    Top = 225
    Width = 1054
    Height = 225
    Align = alTop
    TabOrder = 3
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 1052
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 
        'XML de Cancelamento no SEFAZ - Documentos que devem ser Cancelad' +
        'os no Autcom'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object cxgXMLCancelamento: TcxGridCitel
      Left = 1
      Top = 26
      Width = 1052
      Height = 198
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvXMLCancelamento: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsXMLCancelamento
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Editing = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxvXMLCancelamentoDOCAUT: TcxGridDBColumn
          Caption = 'Documento Autcom - Cancelar'
          DataBinding.FieldName = 'DOCAUT'
          Width = 510
        end
        object cxvXMLCancelamentoNOMARQ: TcxGridDBColumn
          Caption = 'Arquivo XML de Cancelamento'
          DataBinding.FieldName = 'NOMARQ'
          Width = 510
        end
      end
      object cxlXMLCancelamento: TcxGridLevel
        GridView = cxvXMLCancelamento
      end
    end
  end
  object Panel6: TPanel [4]
    Left = 0
    Top = 0
    Width = 1054
    Height = 225
    Align = alTop
    TabOrder = 4
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1052
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'XML Cancelados no SEFAZ'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object cxgCancelados: TcxGridCitel
      Left = 1
      Top = 26
      Width = 1052
      Height = 198
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxvCancelados: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsCancelados
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Editing = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridB08_NNF: TcxGridDBColumn
          Caption = 'Nota Fiscal'
          DataBinding.FieldName = 'B08_NNF'
          Width = 80
        end
        object cxGridB07_SERIE: TcxGridDBColumn
          Caption = 'Serie'
          DataBinding.FieldName = 'B07_SERIE'
          Width = 40
        end
        object cxGridC03_XNOME: TcxGridDBColumn
          Caption = 'Fornecedor'
          DataBinding.FieldName = 'C03_XNOME'
          Width = 250
        end
        object cxGridNOMARQ: TcxGridDBColumn
          Caption = 'Nome do Arquivo'
          DataBinding.FieldName = 'NOMARQ'
          Width = 500
        end
        object cxGridSTATUS: TcxGridDBColumn
          Caption = 'Status SEFAZ'
          DataBinding.FieldName = 'STATUS'
          Width = 170
        end
      end
      object cxlCancelados: TcxGridLevel
        GridView = cxvCancelados
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 672
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 552
    Top = 56
  end
  object cdsCancelados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 56
    object cdsCanceladosB08_NNF: TStringField
      FieldName = 'B08_NNF'
      Size = 12
    end
    object cdsCanceladosB07_SERIE: TStringField
      FieldName = 'B07_SERIE'
      Size = 3
    end
    object cdsCanceladosC03_XNOME: TStringField
      FieldName = 'C03_XNOME'
      Size = 60
    end
    object cdsCanceladosNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 255
    end
    object cdsCanceladosSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 30
    end
  end
  object cdsXMLCancelamento: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 272
    object cdsXMLCancelamentoNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 255
    end
    object cdsXMLCancelamentoDOCAUT: TStringField
      FieldName = 'DOCAUT'
      Size = 255
    end
  end
  object cdsDevolucoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 512
    object cdsDevolucoesNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 255
    end
    object cdsDevolucoesDOCAUT: TStringField
      FieldName = 'DOCAUT'
      Size = 255
    end
  end
  object dtsCancelados: TDataSource
    DataSet = cdsCancelados
    Left = 80
    Top = 104
  end
  object dtsXMLCancelamento: TDataSource
    DataSet = cdsXMLCancelamento
    Left = 72
    Top = 320
  end
  object dtsDevolucoes: TDataSource
    DataSet = cdsDevolucoes
    Left = 88
    Top = 560
  end
  object cdsErros: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'NUMDOC'
    Params = <>
    Left = 336
    Top = 352
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
  object frxDBErros: TfrxDBDataset
    UserName = 'frxDBErros'
    CloseDataSource = False
    DataSet = cdsErros
    BCDToCurrency = False
    Left = 392
    Top = 352
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
    Left = 448
    Top = 352
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
          Top = 1.779530000000000000
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
end
