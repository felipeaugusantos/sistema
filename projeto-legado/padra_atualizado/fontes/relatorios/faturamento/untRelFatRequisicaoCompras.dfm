inherited frmRelFatRequisicaoCompras: TfrmRelFatRequisicaoCompras
  Left = 277
  Top = 242
  Width = 363
  Height = 479
  BorderStyle = bsDialog
  Caption = 'Relat'#243'rio de Requisi'#231#227'o de Compras'
  ExplicitWidth = 363
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 408
    Width = 357
    ExplicitTop = 408
    ExplicitWidth = 357
    inherited FlwBotoes: TFlowPanel
      Width = 276
      ExplicitWidth = 276
    end
    inherited btnSair: TBitBtnLocked
      Left = 278
      ExplicitLeft = 278
    end
  end
  inherited pnlDados: TPanel
    Width = 357
    Height = 408
    ExplicitWidth = 357
    ExplicitHeight = 408
    object Label2: TLabel [0]
      Left = 8
      Top = 8
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel [1]
      Left = 8
      Top = 46
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [2]
      Left = 8
      Top = 84
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel [3]
      Left = 8
      Top = 122
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Compra'
    end
    object Label4: TLabel [4]
      Left = 8
      Top = 162
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor'
    end
    object shpLiberado: TShape [5]
      Left = 8
      Top = 60
      Width = 8
      Height = 21
    end
    object lblEmpresa: TLabel [6]
      Left = 9
      Top = 203
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa'
      Enabled = False
    end
    object lblNumDoc: TLabel [7]
      Left = 9
      Top = 244
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Ped.:'
      Enabled = False
    end
    inherited gpbDestino: TGroupBox
      Left = 192
      Top = 282
      Width = 156
      Height = 50
      TabOrder = 15
      ExplicitLeft = 192
      ExplicitTop = 282
      ExplicitWidth = 156
      ExplicitHeight = 50
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 72
      Top = 22
      Width = 274
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVendedor: TEditFocus
      Tag = 99
      Left = 16
      Top = 60
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 72
      Top = 60
      Width = 274
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object grbPeridoBaixa: TGroupBox
      Left = 3
      Top = 282
      Width = 177
      Height = 50
      Caption = 'Per'#237'odo de Cadastro'
      TabOrder = 14
      object Label1: TLabel
        Left = 79
        Top = 22
        Width = 6
        Height = 14
        Caption = #224
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 18
        Width = 64
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 91
        Top = 18
        Width = 76
        Height = 22
        EditMask = '99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object edtCodProduto: TEditFocus
      Left = 8
      Top = 98
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodProdutoExit
      OnKeyPress = edtCodProdutoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesProduto: TEditFocus
      Left = 72
      Top = 98
      Width = 274
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOpcaoRel: TRadioGroup
      Left = 3
      Top = 332
      Width = 345
      Height = 64
      Caption = 'Op'#231#227'o Relat'#243'rio'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Resumido'
        'Por Produto'
        'Por Cliente'
        'Por Pedido de Compra'
        'Por Ped. Compra com Cota'#231#227'o'
        'Por Fornecedor')
      TabOrder = 16
      OnClick = rdgOpcaoRelClick
    end
    object edtGruCmp: TEditFocus
      Left = 8
      Top = 137
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 6
      OnExit = edtGruCmpExit
      OnKeyPress = edtGruCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesCmp: TEditFocus
      Left = 72
      Top = 137
      Width = 274
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Left = 8
      Top = 177
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 8
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Left = 72
      Top = 177
      Width = 274
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Left = 8
      Top = 218
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 10
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 72
      Top = 218
      Width = 274
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = True
      Enabled = False
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Left = 8
      Top = 259
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object rdgAssociados: TRadioGroup
      Left = 115
      Top = 246
      Width = 233
      Height = 38
      Caption = 'Associados a Pedido de Compra:'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Sim'
        'N'#227'o'
        'Todos')
      TabOrder = 13
    end
  end
  inherited pnlStatus: TPanel
    Top = 434
    Width = 357
    ExplicitTop = 425
    ExplicitWidth = 357
    inherited pnlNomeForm: TPanel
      Left = 186
      TabOrder = 1
      ExplicitLeft = 186
    end
    inherited pnlInfo: TPanel
      Width = 186
      TabOrder = 0
      ExplicitWidth = 186
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 390
    Top = 100
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 358
    Top = 100
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 422
    Top = 70
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 454
    Top = 70
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 454
    Top = 38
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 422
    Top = 38
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 390
    Top = 38
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 422
    Top = 100
  end
  inherited frxGen: TfrxUserDataSet
    Left = 454
    Top = 100
  end
  inherited frxDesigner: TfrxDesigner
    Left = 358
    Top = 70
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 358
    Top = 38
  end
  object frxReportCliM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41178.434184571760000000
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
    Left = 304
    Top = 4
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 287.866480752897900000
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
        Top = 323.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo8: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          TruncOutboundText = False
        end
        object rllDesIte: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 510.000000000000000000
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
          Left = 950.400000000000000000
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
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 238.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO DO ITEM')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REQ. COMPRA')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
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
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1190.400000000000000000
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
          Left = 1228.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 51.000000000000000000
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 643.200000000000000000
          Top = 68.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Align = baRight
          Left = 643.200000000000000000
          Top = 85.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Align = baRight
          Left = 643.200000000000000000
          Top = 102.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Align = baLeft
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxRelatorio."CODCLI"'
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE:')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"] - [frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO CLIENTE:')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio1: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1305.600000000000000000
        object DMPMemo28: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReportProM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41144.357339224540000000
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
    OnUserFunction = frxReportProJUserFunction
    Left = 240
    Top = 4
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 287.866480752897900000
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
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo8: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio2: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECUS"]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(<frxRelatorio."PRECUS">, <frxRelatorio."PREVEN">)' +
              ']')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 561.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
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
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              '(*) Coluna entrada refere-se a entradas de mercadorias do period' +
              'o informado no relatorio.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 204.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo24: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.CLI.')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          TruncOutboundText = False
        end
        object lblMarMkp: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARKUP')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REQ.COMPRA')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
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
          Left = 316.800000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1132.800000000000000000
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
          Left = 1171.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 316.800000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 624.000000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 144.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Align = baRight
          Left = 624.000000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Align = baRight
          Left = 624.000000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxRelatorio."ITEM"'
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 68.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 68.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 68.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISICA')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR PRINCIPAL')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO FABRICA')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 883.200000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTRADA(*)')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO RES.')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 51.000000000000000000
          Width = 547.200000000000100000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."FORNECEDOR"]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 883.200000000000000000
          Top = 51.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fTotalCompras(<frxRelatorio."CODITE">)]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 51.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fSaldoReservado(<frxRelatorio."CODITE">)]')
          TruncOutboundText = False
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 425.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM:')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio1: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(SUM(<frxRelatorio."PRECUS">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."PREVEN">,rlbDetalhes))]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PRECUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 493.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo30: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(SUM(<frxRelatorio."PRECUS">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."PREVEN">,rlbDetalhes))]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PRECUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportCliJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41178.409752326390000000
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
      '  '
      'end.')
    Left = 272
    Top = 4
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.015748030000000000
        ParentFont = False
        Top = 283.464750000000000000
        Width = 755.906000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 34.015748030000000000
          OnBeforePrint = 'mmoZebraOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object Memo8: TfrxMemoView
          Left = 666.794990000000000000
          Top = 17.007874015748030000
          Width = 87.307050000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          WordWrap = False
        end
        object frxRelatoriofrxRelatorio2: TfrxMemoView
          Top = 17.007874020000000000
          Width = 65.763760000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 154.072480000000000000
          Top = 17.007874020000000000
          Width = 108.170130000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
        end
        object Memo16: TfrxMemoView
          Left = 611.683240000000000000
          Top = 17.007874020000000000
          Width = 53.291280000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
        end
        object rllDesIte: TfrxMemoView
          Width = 747.817440000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"] [frxRelatorio."DESITE"]')
        end
        object Memo12: TfrxMemoView
          Left = 554.731910000000000000
          Top = 17.007874020000000000
          Width = 53.291280000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 423.640630000000000000
          Top = 17.007874020000000000
          Width = 128.503929690000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
        end
        object Memo14: TfrxMemoView
          Left = 392.717810000000000000
          Top = 17.007874020000000000
          Width = 29.102350000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 264.010760000000000000
          Top = 17.007874020000000000
          Width = 124.724392360000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 69.031540000000000000
          Top = 17.007874020000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 453.543600000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 5.820470000000000000
          Width = 374.400000000000000000
          Height = 15.118110236220500000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 397.681570000000000000
          Width = 355.200000000000000000
          Height = 15.118110236220500000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 30.236220472440940000
        ParentFont = False
        Top = 192.756030000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 30.236220472440940000
          Fill.BackColor = clSilver
        end
        object Memo24: TfrxMemoView
          Top = 15.118110236220470000
          Width = 65.763760000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
        end
        object Memo25: TfrxMemoView
          Left = 154.072480000000000000
          Top = 15.118110240000000000
          Width = 108.170130000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
        end
        object Memo28: TfrxMemoView
          Left = 611.683240000000000000
          Top = 15.118110240000000000
          Width = 53.291280000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
        end
        object Memo29: TfrxMemoView
          Left = 666.794990000000000000
          Top = 15.118110236220470000
          Width = 87.307050000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM')
        end
        object Memo6: TfrxMemoView
          Width = 159.117810000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 264.010760000000000000
          Top = 15.118110240000000000
          Width = 124.724392360000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 392.717810000000000000
          Top = 15.118110240000000000
          Width = 29.102350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 423.640630000000000000
          Top = 15.118110240000000000
          Width = 128.503929690000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 554.731910000000000000
          Top = 15.118110240000000000
          Width = 53.291280000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 69.031540000000000000
          Top = 15.118110240000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'REQ. COMPRA')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 13.153000000000000000
          Width = 729.600000000000000000
          Height = 17.007874015748000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 13.039580000000000000
          Top = 18.897637795275600000
          Width = 729.826840000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 637.681570000000000000
          Top = 34.015748031496100000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 676.081570000000000000
          Top = 49.133858267716500000
          Width = 76.800000000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 579.476870000000000000
          Top = 49.133858267716500000
          Width = 90.784230000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 179.338900000000000000
          Top = 34.015748031496100000
          Width = 397.228200000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.251968500000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
        end
        object Memo3: TfrxMemoView
          Left = 387.175450000000000000
          Top = 64.251968503937000000
          Width = 364.951020000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 79.370078740000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
        end
        object Memo5: TfrxMemoView
          Left = 386.512060000000000000
          Top = 79.370078740000000000
          Width = 364.951020000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 112.488250000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.267780000000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
        end
        object Memo11: TfrxMemoView
          Left = 386.512060000000000000
          Top = 93.488250000000000000
          Width = 364.951020000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133890000000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            '[STATUS]')
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 245.669450000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."CODCLI"'
        object Shape4: TfrxShapeView
          Width = 755.527356460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo19: TfrxMemoView
          Left = 83.527520000000000000
          Width = 458.532530000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"] - [frxRelatorio."NOMCLI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
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
            'CLIENTE:')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Align = baWidth
          Top = 15.118110236220500000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 340.157700000000000000
        Width = 755.906000000000000000
        object Shape2: TfrxShapeView
          Width = 755.527356460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo7: TfrxMemoView
          Left = 440.826530000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO CLIENTE:')
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio1: TfrxMemoView
          Left = 661.794990000000000000
          Width = 91.086580000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 15.118110240000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 377.953000000000000000
        Width = 755.906000000000000000
        object Shape3: TfrxShapeView
          Width = 755.527356460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo30: TfrxMemoView
          Left = 440.826530000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 661.794990000000000000
          Width = 91.086580000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 15.118110240000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxReportResumidoM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41144.406420173610000000
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
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportProJUserFunction
    Left = 240
    Top = 37
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 403.859739173918500000
      PaperHeight = 283.368566991133800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo8: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECUS"]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(<frxRelatorio."PRECUS">, <frxRelatorio."PREVEN">)' +
              ']')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fTotalCompras(<frxRelatorio."CODITE">)]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fSaldoReservado(<frxRelatorio."CODITE">)]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          TruncOutboundText = False
        end
        object rllDesIte: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."FORNECEDOR"]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 357.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
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
          Left = 1142.400000000000000000
          Top = 34.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 940.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              '(*) Coluna entrada refere-se a entradas de mercadorias do period' +
              'o informado no relatorio.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPMemo35: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PRODUTO')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VL. CUSTO')
          TruncOutboundText = False
        end
        object lblMarMkp: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'MARKUP')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISICA')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ENTRADA(*)')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO RES.')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD. FABRICA')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
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
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1382.400000000000000000
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
          Left = 1420.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 441.600000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 758.400000000000000000
          Top = 85.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#77#27#67#65'
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 748.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Align = baRight
          Left = 758.400000000000000000
          Top = 102.000000000000000000
          Width = 739.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 272.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo30: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PRECUS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(SUM(<frxRelatorio."PRECUS">,rlbDetalhes),SUM(<frx' +
              'Relatorio."PREVEN">,rlbDetalhes))]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportProJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41144.457438692100000000
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
    OnUserFunction = frxReportProJUserFunction
    Left = 208
    Top = 4
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897630480000000000
        Top = 298.582870000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 18.897630480000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object Memo8: TfrxMemoView
          Left = 612.662770000000000000
          Width = 68.409400000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
        end
        object rllDataCadastro: TfrxMemoView
          Width = 69.543290000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
        end
        object Memo16: TfrxMemoView
          Left = 511.900680000000000000
          Width = 43.691280000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object Memo18: TfrxMemoView
          Left = 340.913444410000000000
          Width = 168.566885200000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NOMCLI"]')
        end
        object Memo19: TfrxMemoView
          Left = 282.330708660000000000
          Width = 54.047244094488200000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]')
        end
        object Memo45: TfrxMemoView
          Left = 557.632900000000000000
          Width = 52.988930000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECUS"]')
        end
        object Memo47: TfrxMemoView
          Left = 685.113110000000000000
          Width = 69.845640000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(<frxRelatorio."PRECUS">, <frxRelatorio."PREVEN">)' +
              ']')
        end
        object Memo53: TfrxMemoView
          Left = 71.811070000000000000
          Width = 81.259842520000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
        end
        object Memo55: TfrxMemoView
          Left = 154.960730000000000000
          Width = 123.288250000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236220480000000000
        Top = 457.323130000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 15.118110240000000000
          Width = 374.400000000000000000
          Height = 15.118110240000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 536.421830000000000000
          Top = 15.118110240000000000
          Width = 215.357390000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 15.118110236220500000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 9.600000000000000000
          Width = 732.925850000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '(*) Coluna entrada refere-se a entradas de mercadorias do period' +
              'o informado no relatorio.')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 177.637910000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 754.771641340000000000
          Height = 30.236230240000000000
          Fill.BackColor = clSilver
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 0.940940000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Width = 65.763760000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CADASTRO')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 282.181200000000000000
          Width = 54.122820000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD.CLI.')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 340.904020000000000000
          Width = 168.566885200000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO CLIENTE')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 511.900680000000000000
          Width = 43.691280000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 612.662770000000000000
          Width = 68.409400000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL ITEM')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 557.632900000000000000
          Width = 52.988930000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
        end
        object lblMarMkp: TfrxMemoView
          Left = 685.113110000000000000
          Width = 69.845640000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARKUP')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 71.811070000000000000
          Width = 81.259842520000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REQ. COMPRA')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 154.960730000000000000
          Width = 123.288250000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 99.263760000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 13.153000000000000000
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
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 141.543600000000000000
          Top = 18.897637795275600000
          Width = 472.818800000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 640.637560940000000000
          Top = 18.897637800000000000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 678.432860940000000000
          Top = 34.015748030000000000
          Width = 76.800000000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 547.358750000000000000
          Top = 34.015748030000000000
          Width = 124.800000000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 207.685375000000000000
          Top = 34.015748030000000000
          Width = 340.535250000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 49.133858270000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 381.354906770000000000
          Top = 49.133858270000000000
          Width = 374.551093230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 97.366110000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Top = 64.251968500000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
        end
        object Memo5: TfrxMemoView
          Align = baRight
          Left = 381.354906770000000000
          Top = 64.251968500000000000
          Width = 374.551093230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
        end
        object Memo33: TfrxMemoView
          Align = baLeft
          Top = 79.370130000000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
        end
        object Memo48: TfrxMemoView
          Align = baRight
          Left = 381.354906770000000000
          Top = 79.370130000000000000
          Width = 374.551093230000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Height = 60.472440950000000000
        Top = 215.433210000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."ITEM"'
        object Shape4: TfrxShapeView
          Width = 754.771641340000000000
          Height = 30.236230240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Left = 2.040940000000000000
          Top = 45.354330710000000000
          Width = 48.000000000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
        end
        object Memo11: TfrxMemoView
          Left = 52.861410000000000000
          Top = 45.354330710000000000
          Width = 366.084910000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
        end
        object Memo12: TfrxMemoView
          Left = 655.133580000000000000
          Top = 45.354330710000000000
          Width = 98.645640000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
        end
        object Memo13: TfrxMemoView
          Left = 570.396660000000000000
          Top = 45.354330710000000000
          Width = 82.695980000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
        end
        object Memo14: TfrxMemoView
          Left = 535.473840000000000000
          Top = 45.354330710000000000
          Width = 32.881880000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
        end
        object Memo15: TfrxMemoView
          Left = 419.105380000000000000
          Top = 45.354330710000000000
          Width = 112.327520000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 60.472440940000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo6: TfrxMemoView
          Left = 2.040940000000000000
          Top = 15.118110240000000000
          Width = 419.905380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 30.236220470000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo20: TfrxMemoView
          Left = 419.089610000000000000
          Top = 15.118110240000000000
          Width = 112.327520000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 543.237600000000000000
          Top = 15.118110240000000000
          Width = 32.881880000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID.')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 570.396660000000000000
          Top = 15.118110240000000000
          Width = 82.695980000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 655.133580000000000000
          Top = 15.118110240000000000
          Width = 98.645640000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 2.040940000000000000
          Width = 102.122820000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 106.204700000000000000
          Width = 346.884910000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR PRINCIPAL')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 452.012430000000000000
          Width = 119.886580000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO FABRICA')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 574.176190000000000000
          Width = 82.695980000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENTRADA(*)')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 658.692640000000000000
          Width = 94.866110000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO RES.')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 2.040940000000000000
          Top = 30.236220470000000000
          Width = 102.122820000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
        end
        object Memo40: TfrxMemoView
          Left = 106.204700000000000000
          Top = 30.236220470000000000
          Width = 346.884910000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."FORNECEDOR"]')
        end
        object Memo41: TfrxMemoView
          Left = 452.248670000000000000
          Top = 30.236220470000000000
          Width = 119.886580000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
        end
        object Memo42: TfrxMemoView
          Left = 574.176190000000000000
          Top = 30.236220470000000000
          Width = 82.695980000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[fTotalCompras(<frxRelatorio."CODITE">)]')
        end
        object Memo43: TfrxMemoView
          Left = 658.913110000000000000
          Top = 30.236220470000000000
          Width = 94.866110000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fSaldoReservado(<frxRelatorio."CODITE">)]')
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 340.157700000000000000
        Width = 755.906000000000000000
        object Shape2: TfrxShapeView
          Width = 754.771641340000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 15.118110240000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line7: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo7: TfrxMemoView
          Left = 277.999690000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM:')
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio1: TfrxMemoView
          Left = 612.661417320000000000
          Width = 68.409448820000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 489.070866140000000000
          Width = 66.519685040000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 685.113110000000000000
          Width = 69.845640000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(SUM(<frxRelatorio."PRECUS">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."PREVEN">,rlbDetalhes))]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 557.632900000000000000
          Width = 52.988930000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PRECUS">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.940940000000000000
        Top = 377.953000000000000000
        Width = 755.906000000000000000
        object Shape3: TfrxShapeView
          Top = 1.000000000000000000
          Width = 754.771641340000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo30: TfrxMemoView
          Left = 277.999690000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 612.661417320000000000
          Width = 68.409448820000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 17.940940000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo50: TfrxMemoView
          Left = 685.113110000000000000
          Width = 69.845640000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(SUM(<frxRelatorio."PRECUS">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."PREVEN">,rlbDetalhes))]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 557.632900000000000000
          Width = 52.988930000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PRECUS">,rlbDetalhes)]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportResumidoJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41144.385838935200000000
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
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoZebra.Visible := not mmoZebra.Visible;                     ' +
        '                                                       '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportProJUserFunction
    Left = 208
    Top = 36
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 4.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897630470000000000
        Top = 234.330860000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 18.897630470000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object Memo8: TfrxMemoView
          Left = 807.979530000000000000
          Top = 1.118110240000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 673.211070000000000000
          Top = 1.118110240000000000
          Width = 52.913371180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 729.256710000000000000
          Top = 1.118110240000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PRECUS"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 886.702350000000000000
          Top = 1.118110240000000000
          Width = 56.692901180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(<frxRelatorio."PRECUS">, <frxRelatorio."PREVEN">)' +
              ']')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 945.527520000000000000
          Top = 1.118110240000000000
          Width = 56.692901180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 5.000000000000000000
          Top = 1.118110240000000000
          Width = 88.440940000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."LOCFIS"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 579.803340000000000000
          Top = 1.118110240000000000
          Width = 90.708658980000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fTotalCompras(<frxRelatorio."CODITE">)]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 1005.352690000000000000
          Top = 1.118110240000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fSaldoReservado(<frxRelatorio."CODITE">)]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 234.403340000000000000
          Top = 1.118110240000000000
          Width = 93.429870000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
        end
        object rllDesIte: TfrxMemoView
          Left = 436.738900000000000000
          Top = 1.118120000000000000
          Width = 141.732271260000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]-[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 95.622047240000000000
          Top = 0.220470000000000000
          Width = 135.685039370000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FORNECEDOR"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 330.819110000000000000
          Top = 1.000000000000000000
          Width = 103.936971260000000000
          Height = 15.118110240000000000
          StretchMode = smActualHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 30.236220480000000000
        Top = 351.496290000000000000
        Width = 1084.725110000000000000
        object rllNomeForm: TfrxMemoView
          Left = 6.118110240000000000
          Top = 15.118110240000000000
          Width = 374.400000000000000000
          Height = 15.118110240000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 725.549350000000000000
          Top = 15.118110240000000000
          Width = 355.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 15.118110236220470000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 6.118110240000000000
          Width = 661.114780000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '(*) Coluna entrada refere-se a entradas de mercadorias do period' +
              'o informado no relatorio.')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 16.118110240000000000
        Top = 196.535560000000000000
        Width = 1084.725110000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 1084.725110000000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo28: TfrxMemoView
          Left = 673.211070000000000000
          Width = 52.913371180000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 807.979530000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. TOTAL')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 729.256710000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. CUSTO')
          ParentFont = False
        end
        object lblMarMkp: TfrxMemoView
          Left = 886.702350000000000000
          Width = 56.692901180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MARKUP')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 945.527520000000000000
          Width = 56.692901180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 7.000000000000000000
          Width = 68.636240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 579.803340000000000000
          Width = 90.708658980000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ENTRADA(*)')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 1005.352690000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO RES.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 234.371800000000000000
          Width = 93.429870000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD. FABRICA')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 437.047620000000000000
          Width = 76.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 95.622140000000000000
          Width = 135.836240000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 330.819110000000000000
          Width = 103.256710000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 118.059060000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 177.562555000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 15.118110236220470000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 332.409865000000000000
          Top = 33.000000000000000000
          Width = 419.905380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 965.549350000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 15.118110236220470000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1003.949350000000000000
          Top = 50.000000000000000000
          Width = 76.800000000000000000
          Height = 15.118110236220470000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 877.108410000000000000
          Top = 50.000000000000000000
          Width = 124.800000000000000000
          Height = 15.118110236220470000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 332.409865000000000000
          Top = 49.000000000000000000
          Width = 419.905380000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Left = 6.118110240000000000
          Top = 66.000000000000000000
          Width = 529.133955910000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
        end
        object Memo3: TfrxMemoView
          Left = 539.811624090000000000
          Top = 66.000000000000000000
          Width = 540.472545910000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 115.161410000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          Left = 6.118110236220472000
          Top = 82.000000000000000000
          Width = 529.133955910000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
        end
        object Memo5: TfrxMemoView
          Left = 6.118110236220472000
          Top = 98.267780000000000000
          Width = 529.133955910000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
        end
        object Memo10: TfrxMemoView
          Left = 539.811624090000000000
          Top = 98.267780000000000000
          Width = 540.472545910000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 275.905690000000000000
        Width = 1084.725110000000000000
        object Shape2: TfrxShapeView
          Width = 1084.725110000000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo30: TfrxMemoView
          Left = 437.118120000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 729.256710000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PRECUS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 15.118110240000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Align = baWidth
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo7: TfrxMemoView
          Left = 807.979530000000000000
          Width = 75.590551180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 886.702350000000000000
          Width = 56.692901180000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fMargemMarkup(SUM(<frxRelatorio."PRECUS">,rlbDetalhes), SUM(<fr' +
              'xRelatorio."PREVEN">,rlbDetalhes))]')
          ParentFont = False
        end
      end
    end
  end
  object frxPedidoCompraM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41485.389412592590000000
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
    OnUserFunction = frxReportProJUserFunction
    Left = 272
    Top = 37
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 287.866480752897900000
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
        Top = 357.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object DMPMemo8: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio2: TfrxDMPMemoView
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RCG_DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."RCD_CODITE"] - [frxRelatorio."RCD_DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."UNI_DESUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RCD_QTDITE"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 527.000000000000000000
        Width = 1248.000000000000000000
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
          Left = 892.800000000000000000
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
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 204.000000000000000000
        Width = 1248.000000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo24: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REQ.')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object lblMarMkp: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 34.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1132.800000000000000000
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
          Left = 1171.200000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 288.000000000000000000
          Top = 51.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 102.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 119.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 136.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDIDO]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[STATUS]')
          TruncOutboundText = False
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 272.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxRelatorio."PEDIDO"'
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo34: TfrxDMPMemoView
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PEDIDO DE COMPRA')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."PEDIDO"]')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 34.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMPRESA"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA PEDIDO/EMPRESA:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."RCD_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_SALDOS">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 459.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo30: TfrxDMPMemoView
          Left = 460.800000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_SALDOS">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."RCD_QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPedidoCompraJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41485.389412592600000000
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
    OnUserFunction = frxReportProJUserFunction
    Left = 304
    Top = 37
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 335.279783470000000000
      PaperHeight = 287.866480750000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 13.220470000000000000
        Top = 309.921460000000000000
        Width = 1248.000000018369000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1248.000000018369000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object Memo8: TfrxMemoView
          Left = 855.000000000000000000
          Width = 105.600000000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
        end
        object frxRelatoriofrxRelatorio2: TfrxMemoView
          Left = 12.000000000000000000
          Width = 80.277180000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
        end
        object Memo16: TfrxMemoView
          Left = 316.291280000000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RCG_DTACAD"]')
        end
        object Memo18: TfrxMemoView
          Left = 94.200000000000000000
          Width = 216.491280000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CLIENTE"]')
        end
        object Memo45: TfrxMemoView
          Left = 544.897650000000000000
          Width = 241.738590000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."RCD_CODITE"] - [frxRelatorio."RCD_DESITE"]')
        end
        object Memo47: TfrxMemoView
          Left = 1138.400000000000000000
          Width = 101.820470000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_SALDOS"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 403.891280000000000000
          Width = 138.406370000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
        end
        object Memo10: TfrxMemoView
          Left = 964.200000000000000000
          Width = 48.000000000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."UNI_DESUNI"]')
        end
        object Memo12: TfrxMemoView
          Left = 1015.800000000000000000
          Width = 118.677180000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
        end
        object Memo14: TfrxMemoView
          Left = 792.456710000000000000
          Width = 59.943290000000000000
          Height = 13.220470000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."RCD_QTDITE"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 468.661720000000000000
        Width = 1248.000000018369000000
        object rllNomeForm: TfrxMemoView
          Left = 9.600000000000000000
          Top = 1.000000000000000000
          Width = 578.494620000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 605.555720000000000000
          Top = 1.000000000000000000
          Width = 634.885220000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 0.720470000000000000
          Width = 1248.000000018369000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 18.141732283464570000
        Top = 211.653680000000000000
        Width = 1248.000000018369000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 1248.000000020000000000
          Height = 16.984230000000000000
          Fill.BackColor = clSilver
        end
        object Memo24: TfrxMemoView
          Left = 12.000000000000000000
          Top = 1.889763780000000000
          Width = 76.497650000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REQUISI'#199#195'O')
        end
        object Memo27: TfrxMemoView
          Left = 93.200000000000000000
          Top = 1.889763780000000000
          Width = 220.270810000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE')
        end
        object Memo28: TfrxMemoView
          Left = 316.291280000000000000
          Top = 1.889763780000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
        end
        object Memo29: TfrxMemoView
          Left = 855.000000000000000000
          Top = 1.889763780000000000
          Width = 105.600000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
        end
        object Memo44: TfrxMemoView
          Left = 544.897650000000000000
          Top = 1.889763780000000000
          Width = 241.738590000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
        end
        object lblMarMkp: TfrxMemoView
          Left = 1138.400000000000000000
          Top = 1.889763780000000000
          Width = 101.820470000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
        end
        object Memo9: TfrxMemoView
          Left = 403.891280000000000000
          Top = 1.889763780000000000
          Width = 138.406370000000000000
          Height = 13.220470000000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
        end
        object Memo11: TfrxMemoView
          Left = 964.200000000000000000
          Top = 1.889763780000000000
          Width = 48.000000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID.')
        end
        object Memo13: TfrxMemoView
          Left = 1015.800000000000000000
          Top = 1.889763780000000000
          Width = 118.677180000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
        end
        object Memo15: TfrxMemoView
          Left = 792.456710000000000000
          Top = 1.889763780000000000
          Width = 59.943290000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 130.322820000000000000
        Top = 18.897650000000000000
        Width = 1248.000000018369000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 182.400000009184600000
          Top = 3.000000000000000000
          Width = 883.200000000000000000
          Height = 13.220470000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 283.200000009184600000
          Top = 20.000000000000000000
          Width = 681.600000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1124.800000000000000000
          Top = 19.000000000000000000
          Width = 115.200000000000000000
          Height = 13.220470000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1163.200000000000000000
          Top = 36.000000000000000000
          Width = 76.800000000000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1028.800000000000000000
          Top = 36.000000000000000000
          Width = 124.800000000000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 283.200000009184600000
          Top = 37.000000000000000000
          Width = 681.600000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Left = 9.000000000000000000
          Top = 60.000000000000000000
          Width = 620.220470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
        end
        object Memo3: TfrxMemoView
          Left = 633.600000000000000000
          Top = 60.000000000000000000
          Width = 606.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo4: TfrxMemoView
          Left = 9.000000000000000000
          Top = 77.000000000000000000
          Width = 620.220470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
        end
        object Memo5: TfrxMemoView
          Left = 633.600000000000000000
          Top = 77.000000000000000000
          Width = 606.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
        end
        object Memo48: TfrxMemoView
          Left = 9.000000000000000000
          Top = 94.000000000000000000
          Width = 620.220470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
        end
        object Memo49: TfrxMemoView
          Left = 633.600000000000000000
          Top = 94.000000000000000000
          Width = 606.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
        object Memo52: TfrxMemoView
          Left = 9.000000000000000000
          Top = 111.000000000000000000
          Width = 620.220470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo53: TfrxMemoView
          Left = 633.600000000000000000
          Top = 111.000000000000000000
          Width = 606.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[PEDIDO]')
        end
        object Memo19: TfrxMemoView
          Left = 9.338590000000000000
          Top = 40.574830000000000000
          Width = 257.385590000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[STATUS]')
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Height = 33.984230000000000000
        Top = 253.228510000000000000
        Width = 1248.000000018369000000
        Condition = 'frxRelatorio."PEDIDO"'
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 1248.000000018369000000
          Height = 33.984230000000000000
          Fill.BackColor = clSilver
        end
        object Line8: TfrxLineView
          Align = baWidth
          Top = 15.500000000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo34: TfrxMemoView
          Left = 9.000000000000000000
          Width = 163.200000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PEDIDO DE COMPRA')
        end
        object Memo35: TfrxMemoView
          Left = 181.800000000000000000
          Width = 585.600000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMPRESA')
        end
        object Memo39: TfrxMemoView
          Left = 9.000000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."PEDIDO"]')
        end
        object Memo40: TfrxMemoView
          Left = 181.800000000000000000
          Top = 17.000000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."EMPRESA"]')
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 16.984230000000000000
        Top = 347.716760000000000000
        Width = 1248.000000018369000000
        object Memo7: TfrxMemoView
          Left = 538.600000000000000000
          Top = 1.133858267716535000
          Width = 172.800000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA PEDIDO/EMPRESA:')
        end
        object Memo17: TfrxMemoView
          Left = 721.000000000000000000
          Top = 1.133858267716535000
          Width = 134.400000000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."RCD_QTDITE">,rlbDetalhes)]')
        end
        object Memo32: TfrxMemoView
          Left = 1036.800000000000000000
          Top = 1.133858270000000000
          Width = 203.640940000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_SALDOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Width = 1248.000000018369000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 389.291590000000000000
        Width = 1248.000000018369000000
        object Memo30: TfrxMemoView
          Left = 537.600000000000000000
          Width = 172.800000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
        end
        object Memo33: TfrxMemoView
          Left = 1036.800000000000000000
          Width = 203.640940000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."ITE_SALDOS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 720.000000000000000000
          Width = 134.400000000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."RCD_QTDITE">,rlbDetalhes)]')
        end
        object Line9: TfrxLineView
          Align = baWidth
          Top = 14.720470000000000000
          Width = 1248.000000018369000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Align = baWidth
          Width = 1248.000000018369000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxReportForJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41178.409752326390000000
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
      '  '
      'end.')
    Left = 208
    Top = 68
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.015748030000000000
        ParentFont = False
        Top = 283.464750000000000000
        Width = 755.906000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 34.015748030000000000
          OnBeforePrint = 'mmoZebraOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object Memo8: TfrxMemoView
          Left = 666.794990000000000000
          Top = 17.007874015748030000
          Width = 87.307050000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          WordWrap = False
        end
        object frxRelatoriofrxRelatorio2: TfrxMemoView
          Top = 17.007874020000000000
          Width = 65.763760000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 154.072480000000000000
          Top = 17.007874020000000000
          Width = 108.170130000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
        end
        object Memo16: TfrxMemoView
          Left = 611.683240000000000000
          Top = 17.007874020000000000
          Width = 53.291280000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          WordWrap = False
        end
        object rllDesIte: TfrxMemoView
          Width = 747.817440000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"] [frxRelatorio."DESITE"]')
        end
        object Memo12: TfrxMemoView
          Left = 554.731910000000000000
          Top = 17.007874020000000000
          Width = 53.291280000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 423.640630000000000000
          Top = 17.007874020000000000
          Width = 128.503929690000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
        end
        object Memo14: TfrxMemoView
          Left = 392.717810000000000000
          Top = 17.007874020000000000
          Width = 29.102350000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 264.010760000000000000
          Top = 17.007874020000000000
          Width = 124.724392360000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 69.031540000000000000
          Top = 17.007874020000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 453.543600000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Left = 5.820470000000000000
          Width = 374.400000000000000000
          Height = 15.118110236220500000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 397.681570000000000000
          Width = 355.200000000000000000
          Height = 15.118110236220500000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 30.236220472440940000
        ParentFont = False
        Top = 192.756030000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 30.236220472440940000
          Fill.BackColor = clSilver
        end
        object Memo24: TfrxMemoView
          Top = 15.118110236220470000
          Width = 65.763760000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
        end
        object Memo25: TfrxMemoView
          Left = 154.072480000000000000
          Top = 15.118110240000000000
          Width = 108.170130000000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
        end
        object Memo28: TfrxMemoView
          Left = 611.683240000000000000
          Top = 15.118110240000000000
          Width = 53.291280000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
        end
        object Memo29: TfrxMemoView
          Left = 666.794990000000000000
          Top = 15.118110236220470000
          Width = 87.307050000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM')
        end
        object Memo6: TfrxMemoView
          Width = 159.117810000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 264.010760000000000000
          Top = 15.118110240000000000
          Width = 124.724392360000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 392.717810000000000000
          Top = 15.118110240000000000
          Width = 29.102350000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 423.640630000000000000
          Top = 15.118110240000000000
          Width = 128.503929690000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 554.731910000000000000
          Top = 15.118110240000000000
          Width = 53.291280000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 69.031540000000000000
          Top = 15.118110240000000000
          Width = 83.149606300000000000
          Height = 15.118110240000000000
          Memo.UTF8W = (
            'REQ. COMPRA')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 13.153000000000000000
          Width = 729.600000000000000000
          Height = 17.007874015748000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 13.039580000000000000
          Top = 18.897637795275600000
          Width = 729.826840000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 637.681570000000000000
          Top = 34.015748031496100000
          Width = 115.200000000000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 676.081570000000000000
          Top = 49.133858267716500000
          Width = 76.800000000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 579.476870000000000000
          Top = 49.133858267716500000
          Width = 90.784230000000000000
          Height = 15.118110240000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 179.338900000000000000
          Top = 34.015748031496100000
          Width = 397.228200000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.251968500000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
        end
        object Memo3: TfrxMemoView
          Left = 387.175450000000000000
          Top = 64.251968503937000000
          Width = 364.951020000000000000
          Height = 15.118110236220500000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 79.370078740000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
        end
        object Memo5: TfrxMemoView
          Left = 386.512060000000000000
          Top = 79.370078740000000000
          Width = 364.951020000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
        end
        object Line6: TfrxLineView
          Align = baWidth
          Top = 112.488250000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 94.267780000000000000
          Width = 378.330550000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
        end
        object Memo11: TfrxMemoView
          Left = 386.512060000000000000
          Top = 93.488250000000000000
          Width = 364.951020000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 245.669450000000000000
        Width = 755.906000000000000000
        Condition = 'frxRelatorio."CODFOR"'
        object Shape4: TfrxShapeView
          Width = 755.527356460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo19: TfrxMemoView
          Left = 94.866110000000000000
          Width = 507.666420000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"] - [frxRelatorio."NOMFOR"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Align = baWidth
          Top = 15.118110236220500000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 340.157700000000000000
        Width = 755.906000000000000000
        object Shape2: TfrxShapeView
          Width = 755.527356460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo7: TfrxMemoView
          Left = 440.826530000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO FORNECEDOR:')
          ParentFont = False
        end
        object frxRelatoriofrxRelatorio1: TfrxMemoView
          Left = 661.794990000000000000
          Width = 91.086580000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 15.118110240000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 377.953000000000000000
        Width = 755.906000000000000000
        object Shape3: TfrxShapeView
          Width = 755.527356460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo30: TfrxMemoView
          Left = 440.826530000000000000
          Width = 172.800000000000000000
          Height = 15.118110240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 661.794990000000000000
          Width = 91.086580000000000000
          Height = 15.118110240000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 15.118110240000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxReportForM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41178.434184571800000000
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
    Left = 240
    Top = 68
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 287.866480752897900000
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
        Top = 323.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo8: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PREVEN"]')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DTACAD"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]-[frxRelatorio."NOMVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          TruncOutboundText = False
        end
        object rllDesIte: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."DESMAR"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."REFERE"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."REQUISICAO"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 510.000000000000000000
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
          Left = 950.400000000000000000
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
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 238.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPE/VENDEDOR')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ITEM')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO DO ITEM')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 34.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'REFERENCIA')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'MARCA')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO ITEM')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'REQ. COMPRA')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
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
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1190.400000000000000000
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
          Left = 1228.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 51.000000000000000000
          Width = 854.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENDEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 643.200000000000000000
          Top = 68.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[EMPRESA]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CLIENTE]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Align = baRight
          Left = 643.200000000000000000
          Top = 85.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[ORDEM]')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[GRUPO DE COMPRA]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Align = baRight
          Left = 643.200000000000000000
          Top = 102.000000000000000000
          Width = 652.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
      end
      object GroupHeadeR: TfrxGroupHeader
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 187.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxRelatorio."CODFOR"'
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"] - [frxRelatorio."NOMFOR"]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object GroupFooter: TfrxGroupFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO FORNECEDOR:')
          TruncOutboundText = False
        end
        object frxRelatoriofrxRelatorio1: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1305.600000000000000000
        object DMPMemo28: TfrxDMPMemoView
          Left = 902.400000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PREVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
    end
  end
end
