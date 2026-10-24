inherited frmProcArqSerasaPEFIN: TfrmProcArqSerasaPEFIN
  Width = 463
  Height = 116
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmProcArqSerasaPEFIN'
  Position = poMainFormCenter
  ExplicitWidth = 463
  ExplicitHeight = 116
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 24
    Top = 30
    Width = 91
    Height = 14
    Caption = 'Arquivo de retorno'
  end
  inherited pnlBotoes: TPanel
    Top = 74
    Width = 463
    Height = 26
    TabOrder = 1
    ExplicitTop = 74
    ExplicitWidth = 463
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 382
      Height = 22
      ExplicitWidth = 382
      ExplicitHeight = 22
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 81
        Height = 22
        Caption = '&Processar'
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
      Left = 384
      Top = 2
      Align = alRight
      ExplicitLeft = 384
      ExplicitTop = 2
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 463
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Processar arquivo de retorno do Serasa (PEFIN)'
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
  object edtArqRetorno: TFilenameEditFocus [4]
    Left = 120
    Top = 26
    Properties.Buttons = <
      item
        Default = True
        Glyph.SourceDPI = 96
        Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000004020FF406040FF406040FF4060
          40FF004020FF0000000000000000000000000000000000000000806040FFC080
          60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
          80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
          FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
          60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
          FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
          60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
          FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
          60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
          FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
          FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
          60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
          FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
          80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
          FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
          A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
          FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
          FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
          80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
          80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
          80FFC0A080FF808060FF000000000000000000000000}
        Kind = bkGlyph
      end>
    StyleFocused.Color = clInfoBk
    TabOrder = 0
    Width = 331
  end
  inherited pnlStatus: TPanel
    Top = 100
    Width = 463
    TabOrder = 2
    ExplicitTop = 100
    ExplicitWidth = 463
    inherited pnlNomeForm: TPanel
      Left = 292
      ExplicitLeft = 292
    end
    inherited pnlInfo: TPanel
      Width = 292
      ExplicitWidth = 292
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 120
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 376
    Top = 72
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
    ReportOptions.LastChange = 39779.676074027780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      
        '   teste: Boolean;                                              ' +
        '  '
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
      ''
      'procedure qckPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  teste := True;                              '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 184
    Top = 72
    Datasets = <
      item
        DataSet = frxDBDatasetDetalhes
        DataSetName = 'frxDBDatasetDetalhes'
      end
      item
        DataSet = dbErros
        DataSetName = 'frxDBDatasetErros'
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
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 17.007874020000000000
        ParentFont = False
        Top = 241.889920000000000000
        Width = 730.205196000000000000
        DataSet = frxDBDatasetDetalhes
        DataSetName = 'frxDBDatasetDetalhes'
        RowCount = 0
        object frxDBDatasetDetalhesDUPESP: TfrxMemoView
          Width = 139.842610000000000000
          Height = 17.007874020000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDatasetDetalhesCODNOMCLI: TfrxMemoView
          Left = 196.535560000000000000
          Width = 415.748300000000000000
          Height = 17.007874020000000000
          DataField = 'CLIENT'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."CLIENT"]')
          ParentFont = False
        end
        object frxDBDatasetDetalhesCODERR: TfrxMemoView
          Left = 668.976810000000000000
          Width = 60.472480000000000000
          Height = 17.007874020000000000
          DataField = 'CODEMP'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 143.622140000000000000
          Width = 18.897650000000000000
          Height = 17.007874020000000000
          DataField = 'PARCEL'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."PARCEL"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 166.299320000000000000
          Width = 26.456710000000000000
          Height = 17.007874020000000000
          DataField = 'ESPDOC'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."ESPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 612.283860000000000000
          Width = 56.692950000000000000
          Height = 17.007874020000000000
          DataField = 'TABELA'
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetDetalhes."TABELA"]')
          ParentFont = False
          WordWrap = False
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
        Top = 362.834880000000000000
        Width = 730.205196000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
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
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 200.315090000000000000
        Width = 730.205196000000000000
        ReprintOnNewPage = True
        object Memo4: TfrxMemoView
          Left = 668.976810000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            'Empresa')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 196.535560000000000000
          Width = 415.748300000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 612.283860000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            'Tabela')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 119.000000000000000000
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
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[PARAM1]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 365.405196000000000000
          Top = 85.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[PARAM2]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 283.464750000000000000
        Width = 730.205196000000000000
        Stretched = True
        object subErros: TfrxSubreport
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRelRetorno.pagErros
        end
      end
    end
    object pagErros: TfrxReportPage
      PaperWidth = 203.200000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      object rlbCadErr: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 730.205196000000000000
        object Memo8: TfrxMemoView
          Left = 287.622233000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Tabela de Erros')
          ParentFont = False
        end
      end
      object rlbErros: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 98.267780000000000000
        Width = 730.205196000000000000
        DataSet = dbErros
        DataSetName = 'frxDBDatasetErros'
        RowCount = 0
        object Memo12: TfrxMemoView
          Left = 1.559060000000000000
          Width = 725.669760000000000000
          Height = 18.897650000000000000
          DataField = 'DESERR'
          DataSet = dbErros
          DataSetName = 'frxDBDatasetErros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetErros."DESERR"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxDBDatasetDetalhes: TfrxDBDataset
    UserName = 'frxDBDatasetDetalhes'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDUP=NUMDUP'
      'PARCEL=PARCEL'
      'ESPDOC=ESPDOC'
      'CODEMP=CODEMP'
      'CLIENT=CLIENT'
      'TABELA=TABELA')
    DataSet = dbDetalhes
    BCDToCurrency = False
    Left = 248
    Top = 72
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 152
    Top = 72
  end
  object dbDetalhes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 72
    object dbDetalhesNUMDUP: TStringField
      FieldKind = fkCalculated
      FieldName = 'NUMDUP'
      Size = 12
      Calculated = True
    end
    object dbDetalhesPARCEL: TStringField
      FieldKind = fkCalculated
      FieldName = 'PARCEL'
      Size = 1
      Calculated = True
    end
    object dbDetalhesESPDOC: TStringField
      FieldKind = fkCalculated
      FieldName = 'ESPDOC'
      Size = 2
      Calculated = True
    end
    object dbDetalhesCODEMP: TStringField
      FieldKind = fkCalculated
      FieldName = 'CODEMP'
      Size = 3
      Calculated = True
    end
    object dbDetalhesCLIENT: TStringField
      FieldKind = fkCalculated
      FieldName = 'CLIENT'
      Size = 71
      Calculated = True
    end
    object dbDetalhesTABELA: TStringField
      FieldKind = fkCalculated
      FieldName = 'TABELA'
      Size = 10
      Calculated = True
    end
    object dbDetalhesRETORNO: TStringField
      FieldName = 'RETORNO'
      Size = 300
    end
  end
  object dbErros: TfrxDBDataset
    UserName = 'frxDBDatasetErros'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DESERR=DESERR')
    DataSet = cdsErros
    BCDToCurrency = False
    Left = 344
    Top = 72
  end
  object cdsErros: TUniClientDataSet
    PersistDataPacket.Data = {
      350000009619E0BD010000001800000001000000000003000000350006444553
      455252010049000000010005574944544802000200C8000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 72
    object cdsErrosDESERR: TStringField
      FieldName = 'DESERR'
      Size = 200
    end
  end
end
