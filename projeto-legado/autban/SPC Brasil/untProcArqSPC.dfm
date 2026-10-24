inherited frmProcArqSPC: TfrmProcArqSPC
  Height = 220
  BorderStyle = bsNone
  Caption = 'frmProcArqSPC'
  Position = poMainFormCenter
  ExplicitHeight = 220
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 4
    Top = 32
    Width = 91
    Height = 14
    Caption = 'Arquivo de retorno'
  end
  inherited pnlBotoes: TPanel
    Top = 178
    Width = 489
    Height = 26
    ExplicitTop = 178
    ExplicitWidth = 489
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 408
      Height = 22
      ExplicitWidth = 485
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 88
        Height = 22
        Caption = '&Confirma'
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
      Left = 410
      Top = 2
      Align = alRight
      ExplicitLeft = 406
    end
  end
  inherited pnlStatus: TPanel
    Top = 204
    Width = 489
    ExplicitTop = 204
    ExplicitWidth = 489
    inherited pnlNomeForm: TPanel
      Left = 318
      ExplicitLeft = 318
    end
    inherited pnlInfo: TPanel
      Width = 318
      ExplicitWidth = 318
    end
  end
  object pnlTopo: TPanel [4]
    Left = 0
    Top = 0
    Width = 489
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Processar arquivo de retorno do SPC - Brasil'
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = 17
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 60
    Width = 489
    Height = 118
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 58
    object lstArquivo: TFileListBox
      Left = 1
      Top = 1
      Width = 487
      Height = 116
      Align = alClient
      BevelKind = bkSoft
      FileType = [ftReadOnly, ftDirectory, ftNormal]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Mask = '*.txt;*.ret;*.dat;*.rst;*.html;*.bat;*.bar'
      MultiSelect = True
      ParentFont = False
      ParentShowHint = False
      ShowGlyphs = True
      ShowHint = False
      TabOrder = 0
      OnKeyDown = lstArquivoKeyDown
    end
  end
  inline fraArqRetorno: TfraDirectoryEditFocus [6]
    Left = 99
    Top = 28
    TabOrder = 5
    Width = 384
    Height = 24
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    inherited edtDirectory: TEditFocus
      OnExit = fraArqRetornoedtDirectoryExit
      OnEnter = fraArqRetornoedtDirectoryEnter
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 29
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 392
    Top = 29
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 456
    Top = 77
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    Left = 300
    Top = 30
  end
  object frxRelRetorno: TfrxReport
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
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltTotalD := fltTotalD + <frxDBDatasetDetalhes."VALOR">;      ' +
        '                                                        '
      'end;'
      ''
      'procedure memTotalDetalheOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      
        '  memTotalDetalhe.Text := '#39'R$'#39' + (FormatFloat('#39'#,##0.00'#39', fltTot' +
        'alD));                                                       '
      'end;'
      ''
      'procedure rlbNEncontradosOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  fltTotalN := fltTotalN + <frxDBDatasetNEncontrados."VALOR">;  ' +
        '  '
      'end;'
      ''
      
        'procedure memTotalNEncontradoOnAfterPrint(Sender: TfrxComponent)' +
        ';'
      'begin'
      
        '  memTotalNEncontrado.Text := '#39'R$'#39' + (FormatFloat('#39'#,##0.00'#39', fl' +
        'tTotalN));  '
      'end;'
      ''
      'procedure memTotalDetalheOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  memTotalDetalhe.Text := '#39'R$'#39' + (FormatFloat('#39'#,##0.00'#39', fltTot' +
        'alD));      '
      'end;'
      ''
      
        'procedure memTotalNEncontradoOnBeforePrint(Sender: TfrxComponent' +
        ');'
      'begin'
      
        '  memTotalNEncontrado.Text := '#39'R$'#39' + (FormatFloat('#39'#,##0.00'#39', fl' +
        'tTotalN));  '
      'end;'
      ''
      'begin'
      ' fltTotalD := 0;'
      ' fltTotalN := 0;                   '
      'end.')
    Left = 24
    Top = 126
    Datasets = <
      item
        DataSet = frxDBDatasetDetalhes
        DataSetName = 'frxDBDatasetDetalhes'
      end
      item
        DataSet = frxDBDatasetNEncontrados
        DataSetName = 'frxDBDatasetNEncontrados'
      end
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
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
      object TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 32.125994020000000000
        ParentFont = False
        Top = 298.582870000000000000
        Width = 730.205196000000000000
        DataSet = frxDBDatasetNEncontrados
        DataSetName = 'frxDBDatasetNEncontrados'
        RowCount = 1
        object Memo15: TfrxMemoView
          Top = 0.102350000000001000
          Width = 730.205196000000000000
          Height = 32.125994020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Top = 0.338590000000011000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicatas n'#227'o encontradas')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 15.677180000000100000
          Width = 102.047244090000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 104.944960000000000000
          Top = 15.677180000000100000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 143.637910000000000000
          Top = 15.677180000000100000
          Width = 253.228346460000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo/Nome Cliente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 536.693260000000000000
          Top = 15.677180000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dta. Venc.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 608.504330000000000000
          Top = 15.677180000000100000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor D'#233'bito')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 34.000000000000000000
        ParentFont = False
        Top = 476.220780000000000000
        Width = 730.205196000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 374.702350000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
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
        Height = 96.322820000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 730.205196000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 0.302598000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
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
          Left = 120.302598000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
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
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 537.800000000000000000
          Top = 51.000000000000000000
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
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 187.502598000000000000
          Top = 51.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 73.000000000000000000
          Width = 731.716760000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'Memo2OnAfterPrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 177.637910000000000000
        Width = 730.205196000000000000
        DataSet = frxDBDatasetDetalhes
        DataSetName = 'frxDBDatasetDetalhes'
        RowCount = 1
        object Memo7: TfrxMemoView
          Left = -1.000000000000000000
          Width = 733.984726000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 95.000000000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emp.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 125.637910000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo/Nome Cliente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 323.370440000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dta. SPC')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 376.299630000000000000
          Width = 60.472440940000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dta. Conf.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 437.693260000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Dta. Venc.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 662.283803860000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor D'#233'bito')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 497.827150000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Status')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 551.811380000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Motivo')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbDetalhes: TfrxDetailData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 215.433210000000000000
        Width = 730.205196000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxDBDatasetDetalhes
        DataSetName = 'frxDBDatasetDetalhes'
        RowCount = 0
        object frxDBDatasetDetalhesDUPESP: TfrxMemoView
          Top = 1.000000000000000000
          Width = 98.267701890000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."NUMDUP"]')
          ParentFont = False
        end
        object frxDBDatasetDetalhesCODNOMCLI: TfrxMemoView
          Left = 100.000000000000000000
          Top = 1.000000000000000000
          Width = 26.456673390000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."CODEMP"]')
          ParentFont = False
        end
        object frxDBDatasetDetalhesCODERR: TfrxMemoView
          Left = 376.299630000000000000
          Top = 1.000000000000000000
          Width = 60.472440940000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."DTCSPC"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 127.637910000000000000
          Top = 1.000000000000000000
          Width = 192.755895750000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."CLIENTE"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 323.370440000000000000
          Top = 1.000000000000000000
          Width = 49.133850940000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."DTASPC"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 437.693260000000000000
          Top = 1.000000000000000000
          Width = 60.472423860000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."DTAVEN"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 661.504330000000000000
          Top = 1.000000000000000000
          Width = 68.031483860000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."VALOR"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 497.827150000000000000
          Top = 1.000000000000000000
          Width = 52.913363860000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."STATUS"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 551.590910000000000000
          Top = 1.000000000000000000
          Width = 109.606291890000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."MOTIVO"]')
          ParentFont = False
        end
      end
      object rlbNEncontrados: TfrxDetailData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 355.275820000000000000
        Width = 730.205196000000000000
        OnBeforePrint = 'rlbNEncontradosOnBeforePrint'
        DataSet = frxDBDatasetNEncontrados
        DataSetName = 'frxDBDatasetNEncontrados'
        RowCount = 0
        object Memo16: TfrxMemoView
          Top = 1.000000000000000000
          Width = 102.047244090000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNEncontrados."NUMDUP"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 108.944960000000000000
          Top = 1.000000000000000000
          Width = 26.456692910000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNEncontrados."CODEMP"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 143.637910000000000000
          Top = 1.000000000000000000
          Width = 253.228346460000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetNEncontrados."CLIENTE"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 536.693260000000000000
          Top = 1.000000000000000000
          Width = 71.811013860000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetNEncontrados."DTAVEN"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 608.504330000000000000
          Top = 1.000000000000000000
          Width = 120.944903860000000000
          Height = 13.228344020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetNEncontrados."VALOR"]')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 257.008040000000000000
        Width = 730.205196000000000000
        DataSet = frxDBDatasetDetalhes
        DataSetName = 'frxDBDatasetDetalhes'
        RowCount = 1
        object memTotalDetalhe: TfrxMemoView
          Left = 616.063390000000000000
          Top = 1.779530000000000000
          Width = 113.385843860000000000
          Height = 13.228344020000000000
          OnAfterPrint = 'memTotalDetalheOnAfterPrint'
          OnBeforePrint = 'memTotalDetalheOnBeforePrint'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 548.031850000000000000
          Top = 1.779530000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 396.850650000000000000
        Width = 730.205196000000000000
        DataSet = frxDBDatasetNEncontrados
        DataSetName = 'frxDBDatasetNEncontrados'
        RowCount = 1
        object memTotalNEncontrado: TfrxMemoView
          Left = 616.063390000000000000
          Top = 1.779530000000000000
          Width = 113.385843860000000000
          Height = 13.228344020000000000
          OnAfterPrint = 'memTotalNEncontradoOnAfterPrint'
          OnBeforePrint = 'memTotalNEncontradoOnBeforePrint'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 548.031850000000000000
          Top = 1.779530000000000000
          Width = 60.472480000000000000
          Height = 13.228346460000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDatasetDetalhes: TfrxDBDataset
    UserName = 'frxDBDatasetDetalhes'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'CLIENTE=CLIENTE'
      'DTASPC=DTASPC'
      'DTCSPC=DTCSPC'
      'DTAVEN=DTAVEN'
      'VALOR=VALOR'
      'STATUS=STATUS'
      'MOTIVO=MOTIVO')
    DataSet = cdsDetalhes
    BCDToCurrency = False
    Left = 424
    Top = 30
  end
  object frxDBDatasetNEncontrados: TfrxDBDataset
    UserName = 'frxDBDatasetNEncontrados'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'CLIENTE=CLIENTE'
      'DTAVEN=DTAVEN'
      'VALOR=VALOR')
    DataSet = cdsNEncontrados
    BCDToCurrency = False
    Left = 360
    Top = 30
  end
  object cdsDetalhes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 26
    object cdsDetalhesNUMDUP: TStringField
      FieldName = 'NUMDUP'
    end
    object cdsDetalhesCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsDetalhesCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 65
    end
    object cdsDetalhesDTASPC: TDateField
      FieldName = 'DTASPC'
    end
    object cdsDetalhesDTCSPC: TDateField
      FieldName = 'DTCSPC'
    end
    object cdsDetalhesDTAVEN: TDateTimeField
      FieldName = 'DTAVEN'
    end
    object cdsDetalhesVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsDetalhesSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 8
    end
    object cdsDetalhesMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 100
    end
  end
  object cdsNEncontrados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 26
    object cdsNEncontradosNUMDUP: TStringField
      FieldName = 'NUMDUP'
    end
    object cdsNEncontradosCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsNEncontradosCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Size = 65
    end
    object cdsNEncontradosDTAVEN: TDateTimeField
      FieldName = 'DTAVEN'
    end
    object cdsNEncontradosVALOR: TFloatField
      FieldName = 'VALOR'
    end
  end
end
