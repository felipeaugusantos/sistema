inherited frmExpArqSerPEFIN: TfrmExpArqSerPEFIN
  Left = 426
  Top = 421
  Width = 372
  Height = 152
  BorderStyle = bsNone
  Caption = 'frmExpArqSerPEFIN'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 372
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 110
    Width = 372
    Height = 26
    ExplicitTop = 110
    ExplicitWidth = 372
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 291
      Height = 22
      ExplicitWidth = 291
      ExplicitHeight = 22
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Gerar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          92635DA46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769FF00FFFF00FFFF00FFFF00FF92635DFCF3DEFFEED5FFEED5FFEED5FF
          EED5FEEBD1FEEBD1FEEBD1FEEBD1F7EDD0A46769FF00FFFF00FFFF00FFFF00FF
          92635DF7EAD8FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82F2E2
          C7A46769FF00FFFF00FFFF00FFFF00FF92635DF8EFDEFAE9D5FAE7D4FAE7D3F8
          E6D1F8E6D0F8E6D0F8E6D0F8E6D0F0E2C9A46769FF00FFFF00FFFF00FFFF00FF
          92635DEAE2D4FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82FEBD82E1D3
          BAA46769FF00FFFF00FFFF00FFFF00FF987468AA9F95A69A92A59991A5998EA4
          978BA39689A19587A19384A19183A49381986B65FF00FFFF00FF8C38168C3816
          8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
          168C38168C38168C38168C3816FF00FFA77568E0E9EAE17545E17545E17545E1
          7545E17545E17545E17545E17545D7D8CAA46769FF00FF8B35128C38158C3816
          8C38168C38168C38168C38168C38168C38168C38168C38168C38168C38168C38
          168C38168C38168C3816FF00FFFF00FFB17E6BD7B09CD1AF9ED1AF9ECEAA97CC
          A995CCA793CBA591CAA590CAA38BD4A78CA46769FF00FFFF00FFFF00FFFF00FF
          BB846EFFFFFFFFE3C1FFE2C0FFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFE2BFFFFC
          EFA46769FF00FFFF00FFFF00FFFF00FFC58C70FFFFFFFEBD82FEBD82FEBD82FE
          BD82FEBD82FEBD82FEBD82FEBD82FBF6E9A46769FF00FFFF00FFFF00FFFF00FF
          CB9173FFFFFFFEFFFFFEFFFFFEFEFEFEFBFAFBFAF7FBF8F6FAF7F3F8F4F0FCFA
          F0A46769FF00FFFF00FFFF00FFFF00FFD49876FFFFFFFEBD82FEBD82FEBD82FE
          BD82FEBD82FEBD82FEBD82FEBD82FFFCF4A46769FF00FFFF00FFFF00FFFF00FF
          D49876FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFAFFFF
          FFA46769FF00FFFF00FFFF00FFFF00FFD49876CF8E68CF8E68CF8E68CF8E68CF
          8E68CF8E68CF8E68CF8E68CF8E68CF8E68A46769FF00FFFF00FF}
        ParentFont = False
        TabOrder = 0
        OnClick = btnGerarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 293
      Top = 2
      Align = alRight
      ExplicitLeft = 293
      ExplicitTop = 2
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 372
    Height = 110
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object lblPathRem: TLabel
      Left = 15
      Top = 33
      Width = 84
      Height = 14
      Caption = 'Path p/ Remessa:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblNomArq: TLabel
      Left = 14
      Top = 57
      Width = 85
      Height = 14
      Caption = 'Nome do Arquivo:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 368
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Gera'#231#227'o de Arquivo para Serasa PEFIN'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object edtNomArquivo: TEditFocus
      Left = 101
      Top = 54
      Width = 247
      Height = 24
      Alignment = taLeftJustify
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      Text = 'relato.txt'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    inline fraPathRemessa: TfraDirectoryEditFocus
      Left = 101
      Top = 29
      TabOrder = 0
      Width = 247
      Height = 24
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      inherited edtDirectory: TEditFocus
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 136
    Width = 372
    ExplicitTop = 136
    ExplicitWidth = 372
    inherited pnlNomeForm: TPanel
      Left = 201
      ExplicitLeft = 201
    end
    inherited pnlInfo: TPanel
      Width = 201
      ExplicitWidth = 201
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 112
  end
  object frxRelValidacaoLinhaDigitavel: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42767.623252500000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltTotalD: Double;'
      '  fltTotalN: Double;'
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      ''
      'begin'
      '                   '
      'end.')
    Left = 256
    Top = 54
    Datasets = <
      item
        DataSet = frxdsValLinDig
        DataSetName = 'frxdsValLinDig'
      end>
    Variables = <
      item
        Name = ' Variaveis'
        Value = Null
      end
      item
        Name = 'Registro'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Font.Quality = fqClearType
      PaperWidth = 203.200000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'qckPaginaOnAfterPrint'
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Font.Quality = fqClearType
        Height = 34.000000000000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 730.205196000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 17.000000000000000000
          Width = 400.856710000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 401.159060000000000000
          Top = 17.000000000000000000
          Width = 328.743290000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Font.Quality = fqClearType
        Height = 92.543290000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 730.205196000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 0.302598000000000400
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 120.302598000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 39.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 614.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 662.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 545.359060000000000000
          Top = 51.000000000000000000
          Width = 117.240940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 187.502598000000000000
          Top = 73.677180000000010000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 215.433210000000000000
        Width = 730.205196000000000000
        DataSet = frxdsValLinDig
        DataSetName = 'frxdsValLinDig'
        RowCount = 0
        object Memo7: TfrxMemoView
          Width = 730.205196000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Fill.BackColor = clSilver
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 173.598640000000000000
          Width = 260.787530940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Memo.UTF8W = (
            'Erro')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 439.189183860000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Memo.UTF8W = (
            'Verificar')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Width = 103.936998110000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero Duplicata')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 109.606370000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Memo.UTF8W = (
            'Esp.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 139.842610000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbDetalhes: TfrxDetailData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 253.228510000000000000
        Width = 730.205196000000000000
        DataSet = frxdsValLinDig
        DataSetName = 'frxdsValLinDig'
        RowCount = 0
        object frxDBDatasetDetalhesDUPESP: TfrxMemoView
          Left = 0.440940000000000000
          Top = 1.000000000000000000
          Width = 103.937007870000000000
          Height = 13.228344020000000000
          DataField = 'DUPLICATA'
          DataSet = frxdsValLinDig
          DataSetName = 'frxdsValLinDig'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsValLinDig."DUPLICATA"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 439.189240000000000000
          Top = 1.133858269999990000
          Width = 291.023641570000000000
          Height = 13.228346460000000000
          DataField = 'SOLUCAO'
          DataSet = frxdsValLinDig
          DataSetName = 'frxdsValLinDig'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          Memo.UTF8W = (
            '[frxdsValLinDig."SOLUCAO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 173.858380000000000000
          Top = 1.000000000000000000
          Width = 260.787513860000000000
          Height = 13.228344020000000000
          DataField = 'ERRO'
          DataSet = frxdsValLinDig
          DataSetName = 'frxdsValLinDig'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          Memo.UTF8W = (
            '[frxdsValLinDig."ERRO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 109.606370000000000000
          Top = 1.000000000000000000
          Width = 26.456631890000000000
          Height = 13.228344020000000000
          DataField = 'ESPDOC'
          DataSet = frxdsValLinDig
          DataSetName = 'frxdsValLinDig'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsValLinDig."ESPDOC"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 139.842610000000000000
          Top = 1.000000000000000000
          Width = 30.236161890000000000
          Height = 13.228344020000000000
          DataField = 'CODEMP'
          DataSet = frxdsValLinDig
          DataSetName = 'frxdsValLinDig'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxdsValLinDig."CODEMP"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 173.858380000000000000
        Width = 730.205196000000000000
        Condition = 'frxdsValLinDig."CLIENTE"'
        object Memo3: TfrxMemoView
          Left = 6.220470000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Font.Quality = fqClearType
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 52.913420000000000000
          Width = 672.756093460000000000
          Height = 15.118110240000000000
          DataField = 'CLIENTE'
          DataSet = frxdsValLinDig
          DataSetName = 'frxdsValLinDig'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Font.Quality = fqClearType
          Memo.UTF8W = (
            '[frxdsValLinDig."CLIENTE"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxdsValLinDig: TfrxDBDataset
    UserName = 'frxdsValLinDig'
    CloseDataSource = False
    DataSet = cdsErrosLinDig
    BCDToCurrency = False
    Left = 224
    Top = 55
  end
  object cdsErrosLinDig: TUniClientDataSet
    PersistDataPacket.Data = {
      BF0000009619E0BD010000001800000006000000000003000000BF0007434C49
      454E54450200490000000100055749445448020002002C01094455504C494341
      5441010049000000010005574944544802000200140006455350444F43010049
      0000000100055749445448020002000A0006434F44454D500100490000000100
      055749445448020002000300044552524F020049000000010005574944544802
      0002002C0107534F4C5543414F0200490000000100055749445448020002002C
      010000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 56
    object cdsErrosLinDigCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 300
    end
    object cdsErrosLinDigDUPLICATA: TStringField
      FieldName = 'DUPLICATA'
    end
    object cdsErrosLinDigESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 10
    end
    object cdsErrosLinDigCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsErrosLinDigERRO: TStringField
      FieldName = 'ERRO'
      Size = 300
    end
    object cdsErrosLinDigSOLUCAO: TStringField
      FieldName = 'SOLUCAO'
      Size = 300
    end
  end
end
