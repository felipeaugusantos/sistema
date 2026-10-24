inherited frmRelEntCriticasPreNota: TfrmRelEntCriticasPreNota
  Width = 404
  Height = 257
  Caption = 'Relat'#243'rio de Cr'#237'ticas de Pr'#233'-Nota de Entrada'
  ExplicitWidth = 404
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 186
    Width = 398
    ExplicitTop = 186
    ExplicitWidth = 398
    inherited FlwBotoes: TFlowPanel
      Width = 317
      ExplicitWidth = 317
      inherited btnImprimir: TBitBtnLocked
        ModalResult = 1
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 319
      ModalResult = 2
      ExplicitLeft = 319
    end
  end
  inherited pnlStatus: TPanel
    Top = 212
    Width = 398
    ExplicitTop = 212
    ExplicitWidth = 398
    inherited pnlNomeForm: TPanel
      Left = 227
      ExplicitLeft = 227
    end
    inherited pnlInfo: TPanel
      Width = 227
      ExplicitWidth = 227
    end
  end
  inherited pnlDados: TPanel
    Width = 398
    Height = 186
    ExplicitWidth = 398
    ExplicitHeight = 186
    object grpDadosNE: TGroupBox [0]
      Left = 1
      Top = 1
      Width = 396
      Height = 137
      Align = alTop
      Caption = 'Dados da Nota de Entrada'
      TabOrder = 0
      TabStop = True
      object Label6: TLabel
        Left = 6
        Top = 60
        Width = 54
        Height = 14
        Caption = 'Documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEspecie: TLabel
        Left = 97
        Top = 60
        Width = 38
        Height = 14
        Caption = 'Esp'#233'cie'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblSerie: TLabel
        Left = 139
        Top = 60
        Width = 25
        Height = 14
        Caption = 'S'#233'rie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblEmpresaNE: TLabel
        Left = 171
        Top = 60
        Width = 42
        Height = 14
        Caption = 'Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 6
        Top = 96
        Width = 56
        Height = 14
        Caption = 'Fornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 6
        Top = 21
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 71
        Top = 21
        Width = 47
        Height = 14
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtDocumento: TEditFocus
        Left = 6
        Top = 74
        Width = 88
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 12
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 12
        TipoTexto = ttNumerico
      end
      object edtEspecie: TEditFocus
        Tag = 99
        Left = 97
        Top = 74
        Width = 38
        Height = 21
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 3
        Text = 'NF'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object edtSerie: TEditFocus
        Left = 139
        Top = 74
        Width = 29
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
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtCodEmpresaNE: TEditFocus
        Tag = 99
        Left = 171
        Top = 74
        Width = 38
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 5
        OnExit = edtCodEmpresaNEExit
        OnKeyPress = edtCodEmpresaNEKeyPress
        NormalColor = clWhite
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesEmpresaNE: TEditFocus
        Left = 212
        Top = 74
        Width = 174
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtForNot: TEditFocus
        Tag = 99
        Left = 6
        Top = 110
        Width = 57
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnExit = edtForNotExit
        OnKeyPress = edtForNotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesForNot: TEditFocus
        Left = 66
        Top = 110
        Width = 320
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mskDtaEntIni: TMaskEditFocus
        Tag = 99
        Left = 6
        Top = 35
        Width = 62
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaEntFin: TMaskEditFocus
        Tag = 99
        Left = 71
        Top = 35
        Width = 62
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    inherited gpbDestino: TGroupBox
      Left = 255
      Top = 135
      Width = 140
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 2
      ExplicitLeft = 255
      ExplicitTop = 135
      ExplicitWidth = 140
    end
    object rdgOrientacao: TRadioGroup
      Left = 7
      Top = 135
      Width = 243
      Height = 45
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Orienta'#231#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Retrato'
        'Paisagem')
      TabOrder = 1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 192
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 0
    Top = 224
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 384
    Top = 224
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 336
    Top = 224
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 280
    Top = 224
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 232
    Top = 224
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 192
    Top = 224
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 96
    Top = 224
  end
  inherited frxGen: TfrxUserDataSet
    Left = 144
    Top = 224
  end
  inherited frxDesigner: TfrxDesigner
    Left = 192
    Top = 184
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 144
    Top = 184
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 96
    Top = 184
  end
  object frxdbCriticas: TfrxDBDataset
    UserName = 'frxdbCriticas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 224
    Top = 8
  end
  object frxDBCadastro: TfrxDBDataset
    UserName = 'frxDBCadastro'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 144
    Top = 4
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
    ReportOptions.LastChange = 41856.442942986100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  intContador : Integer;           '
      '  '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + intToStr(in' +
        'tContador);                                                     ' +
        '               '
      'end;'
      '  '
      'procedure CFretePedidoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CFretePedido.Visible := (<frxdbCriticas."CODITE"> = '#39'00000'#39'); ' +
        '               '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbDetalhes.Visible := (<frxdbCriticas."CODITE"> <> '#39'00000'#39');'
      '  intContador := intContador + 1;      '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  intContador := intContador + 1;                               ' +
        '                               '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  GroupFooter1.Visible := (<frxdbCriticas."CODITE"> <> '#39#39');  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 352
    Datasets = <
      item
        DataSet = frxDBCadastro
        DataSetName = 'frxDBCadastro'
      end
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 510.000000000000000000
        Width = 1248.000000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 883.200000000000000000
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
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object mmoDEQTPC: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[DEQTPC]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxReportM.CFretePedido
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        PrintChildIfInvisible = True
        RowCount = 0
        object frxdbCriticasCODITE: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          TruncOutboundText = False
        end
        object frxdbCriticasDESITE: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1228.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          TruncOutboundText = False
        end
        object mmoQtdPed: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDPED"]')
          TruncOutboundText = False
        end
        object mmoQtdNfe: TfrxDMPMemoView
          Left = 556.799999999999900000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDNFE"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 249.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."LOCFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."UNIPED"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 739.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."UNINFE"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."IPIPED"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."IPINFE"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SUBPED"]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SUBNFE"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."TOTGER"]')
          TruncOutboundText = False
        end
      end
      object CFretePedido: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'CFretePedidoOnBeforePrint'
        PrintChildIfInvisible = True
        object DMPMemo39: TfrxDMPMemoView
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 68.000000000000000000
        Width = 1248.000000000000000000
        Condition = 'frxdbCriticas."AUTNFE"'
        StartNewPage = True
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 259.200000000000000000
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
          Top = 17.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object mmoNFE: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[NFE]')
          TruncOutboundText = False
        end
        object mmoFornecedor: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 102.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FORNECEDOR]')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOTA ELET.:')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORNECEDOR:')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOJA:')
          TruncOutboundText = False
        end
        object mmoLoja: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[LOJA]')
          TruncOutboundText = False
        end
        object mmoPedido: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 51.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[PEDIDO]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PEDIDO:')
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.PED.')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 556.799999999999900000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.NFE')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 249.600000000000000000
          Top = 170.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDOS')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 170.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'LOC.FISICA')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 170.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT.PED.')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT.NFE')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 170.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO DE FABRICA')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'IPI PED.')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 170.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'IPI NFE')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 170.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUB PED.')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1075.200000000000000000
          Top = 170.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SUB NFE')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 136.000000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERGENCIA DE QUANTIDADES, VALORES E IMPOSTOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 195.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
        object mmoComprador: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 1113.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Memo.UTF8W = (
            '[COMPRADOR]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'COMPRADOR:')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 170.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOT ITE')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        Child = frxReportM.Child1
        object DMPMemo33: TfrxDMPMemoView
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            'FRETE DO PEDIDO:')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 163.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."FREPED"]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            'FRETE DA NFE:')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."FREPED"]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 835.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."FREPED"]')
          TruncOutboundText = False
        end
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1248.000000000000000000
        object Subreport2: TfrxSubreport
          Align = baWidth
          Width = 1248.000000000000000000
          Height = 17.000000000000000000
          Page = frxReportM.Page2
        end
      end
    end
    object Page2: TfrxDMPPage
      PaperWidth = 335.279783465139800000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      FontStyle = []
      object ReportTitle2: TfrxReportTitle
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1248.000000000000000000
        object DMPCommand3: TfrxDMPCommand
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 136.000000000000000000
        Width = 1248.000000000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBCadastro
        DataSetName = 'frxDBCadastro'
        Filter = '<frxDBCadastro."AUTNFE"> = <frxdbCriticas."AUTNFE">'
        RowCount = 0
        object DMPMemo46: TfrxDMPMemoView
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDBCadastro."CODITE"]')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[<frxDBCadastro."DESUNI">]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 988.800000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[<frxDBCadastro."CODBAR">]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[<frxDBCadastro."NFEEAN">]')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[<frxDBCadastro."DESITE">]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[<frxDBCadastro."INFADI">]')
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 68.000000000000000000
        Width = 1248.000000000000000000
        object DMPMemo40: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 34.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 34.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO DE BARRAS CADASTRO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 34.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CODIGO DE BARRAS XML')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 34.000000000000000000
          Width = 566.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 268.800000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERGENCIA DE DADOS CADASTRAIS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1238.400000000000000000
          Color = clBlack
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
    ReportOptions.LastChange = 43055.497798993100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      
        '  intContador : Integer;                                        ' +
        '               '
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + IntToStr(in' +
        'tContador);                                                     ' +
        '               '
      'end;'
      '  '
      'procedure CFretePedidoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CFretePedido.Visible := (<frxdbCriticas."CODITE"> = '#39'00000'#39'); ' +
        '                 '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbDetalhes.Visible := (<frxdbCriticas."CODITE"> <> '#39'00000'#39');'
      
        '  intContador := intContador + 1;                               ' +
        '   '
      'end;'
      ''
      'procedure rlbCabecalhoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  intContador := 0;                   '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  intContador := intContador + 1;                          '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    GroupFooter1.Visible := (<frxdbCriticas."CODITE"> <> '#39#39');  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 288
    Top = 8
    Datasets = <
      item
        DataSet = frxDBCadastro
        DataSetName = 'frxDBCadastro'
      end
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
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
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 9.393630000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbCabecalhoOnBeforePrint'
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.102350000000000000
        ParentFont = False
        Top = 514.016080000000000000
        Width = 755.906000000000000000
        object rllNomeForm: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 15.102350000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          ParentFont = False
        end
        object mmoDEQTPC: TfrxMemoView
          Left = 0.779530000000000000
          Top = 1.779530000000020000
          Width = 978.898270000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEQTPC]')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 24.559060000000000000
        ParentFont = False
        Top = 294.803340000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxReportJ.CFretePedido
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        PrintChildIfInvisible = True
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 24.559060000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
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
        object frxdbCriticasfrxdbCriticas: TfrxMemoView
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Top = 11.897650000000000000
          Width = 668.976810000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 148.913385830000000000
          Width = 18.897650000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          WordWrap = False
        end
        object mmoQtdPed: TfrxMemoView
          Left = 286.960629920000000000
          Width = 52.913363860000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDPED"]')
          WordWrap = False
        end
        object mmoQtdNfe: TfrxMemoView
          Left = 343.834645670000000000
          Width = 49.133833860000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDNFE"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 230.551181100000000000
          Width = 52.913363860000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 173.480314960000000000
          Width = 52.913398030000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."LOCFIS"]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 396.393700790000000000
          Width = 52.913380940000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."UNIPED"]')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 452.984540000000000000
          Width = 49.133846060000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."UNINFE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 40.354455200000000000
          Width = 105.826840000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 505.559055120000000000
          Width = 41.574790940000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."IPIPED"]')
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 550.692913390000000000
          Width = 37.795256060000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."IPINFE"]')
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 593.480314960000000000
          Width = 52.913380940000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SUBPED"]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 650.331170000000000000
          Width = 49.133850940000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SUBNFE"]')
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 702.330708660000000000
          Width = 49.133865590000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."TOTGER"]')
          WordWrap = False
        end
      end
      object CFretePedido: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 343.937230000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'CFretePedidoOnBeforePrint'
        PrintChildIfInvisible = True
        object Memo39: TfrxMemoView
          Left = 0.779530000000000000
          Top = 0.779530000000000000
          Width = 752.126470000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
      end
      object grpNFE: TfrxGroupHeader
        FillType = ftBrush
        Height = 181.417440000000000000
        Top = 90.708720000000000000
        Width = 755.906000000000000000
        Condition = 'frxdbCriticas."AUTNFE"'
        StartNewPage = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -35.980890000000000000
          Top = 3.779529999999990000
          Width = 827.867780000000000000
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
          Left = 133.153000000000000000
          Top = 20.779530000000000000
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
          Align = baRight
          Left = 640.706000000000000000
          Top = 20.779530000000000000
          Width = 115.200000000000000000
          Height = 13.984251970000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 688.706000000000000000
          Top = 37.779530000000000000
          Width = 67.200000000000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 563.906000000000000000
          Top = 37.779530000000000000
          Width = 124.800000000000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object mmoPedido: TfrxMemoView
          Left = 87.012430000000000000
          Top = 53.855700000000000000
          Width = 71.735250000000000000
          Height = 13.984251970000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object mmoLoja: TfrxMemoView
          Left = 87.012430000000000000
          Top = 84.900330000000000000
          Width = 479.924490000000000000
          Height = 13.984251970000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOJA]')
          ParentFont = False
        end
        object mmoFornecedor: TfrxMemoView
          Left = 87.012430000000000000
          Top = 102.606370000000000000
          Width = 479.924490000000000000
          Height = 13.984251970000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 1.965120000000000000
          Top = 53.855700000000000000
          Width = 83.073840000000000000
          Height = 13.984251970000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 1.965120000000000000
          Top = 84.900330000000000000
          Width = 83.073840000000000000
          Height = 13.984251970000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOJA:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 1.965120000000000000
          Top = 102.606370000000000000
          Width = 83.073840000000000000
          Height = 13.984251970000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object mmoNFE: TfrxMemoView
          Left = 87.012430000000000000
          Top = 38.929190000000000000
          Width = 71.735250000000000000
          Height = 13.984251970000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NFE]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 1.965120000000000000
          Top = 38.929190000000000000
          Width = 83.073840000000000000
          Height = 13.984251970000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOTA ELET.:')
          ParentFont = False
        end
        object Shape2: TfrxShapeView
          Align = baBottom
          Top = 124.724490000000000000
          Width = 755.906000000000000000
          Height = 56.692950000000000000
          Fill.BackColor = clSilver
        end
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Top = 158.740260000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 149.047310000000000000
          Top = 158.740260000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 287.008040000000000000
          Top = 158.740260000000000000
          Width = 52.913363860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PED.')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 343.819110000000000000
          Top = 158.740260000000000000
          Width = 49.133833860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. NFE')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 230.653680000000000000
          Top = 158.740260000000000000
          Width = 52.913363860000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SAL. EST.')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 173.622140000000000000
          Top = 158.740260000000000000
          Width = 52.913398030000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOC.FISI.')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 396.512060000000000000
          Top = 158.740260000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT. PED.')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 452.764070000000000000
          Top = 158.740260000000000000
          Width = 49.133846060000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT. NFE')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 44.133890000000000000
          Top = 158.740260000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO DE FABRICA')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 505.590910000000000000
          Top = 158.740260000000000000
          Width = 41.574790940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'IPI PED.')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 550.842920000000000000
          Top = 158.740260000000000000
          Width = 37.795256060000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'IPI NFE')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 593.299630000000000000
          Top = 158.740260000000000000
          Width = 52.913380940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUB. PED.')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 650.110700000000000000
          Top = 158.740260000000000000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUB. NFE')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 164.409555000000000000
          Top = 133.842610000000000000
          Width = 396.850650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERG'#202'NCIA DE QUANTIDADES, VALORES E IMPOSTOS')
          ParentFont = False
        end
        object mmoComprador: TfrxMemoView
          Left = 86.826840000000000000
          Top = 70.031540000000000000
          Width = 661.341930000000000000
          Height = 13.984251970000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPRADOR]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 1.779530000000000000
          Top = 70.031540000000000000
          Width = 83.073840000000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COMPRADOR:')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 702.331170000000000000
          Top = 158.740260000000000000
          Width = 49.133850940000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOT.ITE')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 381.732530000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        Child = frxReportJ.Child2
        object Memo36: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000020000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FRETE DO PEDIDO: [frxdbCriticas."FREPED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 196.535560000000000000
          Top = 3.779530000000020000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FRETE DA NFE: [frxdbCriticas."FRENFE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 389.291590000000000000
          Top = 3.779530000000020000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 18.897650000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 427.086890000000000000
        Width = 755.906000000000000000
        object Subreport1: TfrxSubreport
          Left = 3.779530000000000000
          Top = 3.779530000000020000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Page = frxReportJ.Page2
        end
      end
      object rllTotalImpresso: TfrxMemoView
        Align = baBottom
        Top = 1069.622760000000000000
        Width = 755.906000000000000000
        Height = 15.102350000000000000
        OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
        DisplayFormat.DecimalSeparator = ','
        Frame.Typ = [ftTop]
        HAlign = haRight
        Memo.UTF8W = (
          '[COUNT(rlbDetalhes)]')
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 43.456710000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 43.456710000000000000
          Fill.BackColor = clSilver
        end
        object Memo28: TfrxMemoView
          Top = 26.456710000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo41: TfrxMemoView
          Left = 375.921460000000000000
          Top = 26.456710000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
        end
        object Memo45: TfrxMemoView
          Left = 408.055350000000000000
          Top = 26.456710000000000000
          Width = 143.622118030000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO DE BARRAS XML')
        end
        object Memo48: TfrxMemoView
          Left = 40.354360000000000000
          Top = 26.456710000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 160.630025000000000000
          Top = 1.559060000000000000
          Width = 396.850650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERG'#202'NCIA DE DADOS CADASTRAIS')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 555.590910000000000000
          Top = 26.456710000000000000
          Width = 158.740238030000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO DE BARRAS CADASTRO')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236240000000000000
        ParentFont = False
        Top = 86.929190000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBCadastro
        DataSetName = 'frxDBCadastro'
        Filter = '<frxDBCadastro."AUTNFE"> = <frxdbCriticas."AUTNFE">'
        RowCount = 0
        object mmoDetalhe2: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
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
        object Memo43: TfrxMemoView
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."CODITE"]')
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 375.921460000000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."DESUNI"]')
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 40.354455200000000000
          Width = 332.598640000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxdbCadastro."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 408.055350000000000000
          Width = 143.622118030000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."NFEEAN"]')
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 555.590910000000000000
          Width = 158.740238030000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."CODBAR"]')
          WordWrap = False
        end
        object Memo50: TfrxMemoView
          Top = 13.118120000000000000
          Width = 714.331170000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxdbCadastro."INFADI"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReportJP: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41813.609650104200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      '  intContador : Integer;'
      '    '
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + intToStr(in' +
        'tContador);                                                     ' +
        '               '
      'end;'
      ''
      ''
      'procedure CFretePedidoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  CFretePedido.Visible := (<frxdbCriticas."CODITE"> = '#39'00000'#39'); ' +
        '                 '
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbDetalhes.Visible := (<frxdbCriticas."CODITE"> <> '#39'00000'#39');'
      
        '  intContador := intContador + 1;                               ' +
        '  '
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  intContador := intContador + 1;                               ' +
        '                                   '
      'end;'
      ''
      'procedure GroupFooter1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  GroupFooter1.Visible := (<frxdbCriticas."CODITE"> <> '#39#39');     ' +
        '                      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 288
    Top = 56
    Datasets = <
      item
        DataSet = frxDBCadastro
        DataSetName = 'frxDBCadastro'
      end
      item
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
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
      LeftMargin = 4.500000000000000000
      RightMargin = 4.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.000000000000000000
        ParentFont = False
        Top = 498.897960000000000000
        Width = 1088.504640000000000000
        object rllNomeForm: TfrxMemoView
          Align = baClient
          Width = 1088.504640000000000000
          Height = 34.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baBottom
          Top = 18.897650000000000000
          Width = 1088.504640000000000000
          Height = 15.102350000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object mmoDEQTPC: TfrxMemoView
          Top = 0.779530000000022500
          Width = 1088.504640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEQTPC]')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Height = 1.834570000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1088.504640000000000000
        PrintChildIfInvisible = True
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236240000000000000
        ParentFont = False
        Top = 275.905690000000000000
        Width = 1088.504640000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        Child = frxReportJP.CFretePedido
        DataSet = frxdbCriticas
        DataSetName = 'frxdbCriticas'
        PrintChildIfInvisible = True
        RowCount = 0
        object mmoDetalhe: TfrxMemoView
          Align = baClient
          Width = 1088.504640000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxdbCriticasfrxdbCriticas: TfrxMemoView
          Width = 37.795300000000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODITE"]')
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Top = 12.897650000000000000
          Width = 1046.929810000000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 148.054942360000000000
          Width = 18.897650000000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."DESUNI"]')
          WordWrap = False
        end
        object mmoQtdPed: TfrxMemoView
          Left = 296.676957870000000000
          Width = 56.692893860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDPED"]')
          WordWrap = False
        end
        object mmoQtdNfe: TfrxMemoView
          Left = 356.047034170000000000
          Width = 56.692893860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."QTDNFE"]')
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 232.204536460000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SALDOS"]')
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 170.952567950000000000
          Width = 56.692950000000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."LOCFIS"]')
          WordWrap = False
        end
        object Memo22: TfrxMemoView
          Left = 482.866420000000000000
          Width = 45.354316060000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."UNIPED"]')
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 532.873786300000000000
          Width = 60.472436060000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."UNINFE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 42.354360000000000000
          Width = 102.047310000000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxdbCriticas."CODFAB"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 596.928904409999700000
          Width = 60.472436060000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxdbCriticas."UNIPED"> - <frxdbCriticas."UNINFE">]')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 416.550968740000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxdbCriticas."QTDPED"> - <frxdbCriticas."QTDNFE">]')
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 704.607212130000000000
          Width = 64.251953860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."IPIPED"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 768.512316300000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."IPINFE"]')
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 832.795780870000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxdbCriticas."IPIPED"> - <frxdbCriticas."IPINFE">]')
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 896.425790000000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SUBPED"]')
          WordWrap = False
        end
        object Memo46: TfrxMemoView
          Left = 961.330894170000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxdbCriticas."SUBNFE"]')
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 1024.614358740000000000
          Width = 60.472423860000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxdbCriticas."SUBPED"> - <frxdbCriticas."SUBNFE">]')
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 661.417750000000000000
          Width = 45.354316060000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(<frxdbCriticas."UNIPED"> > 0, (<frxdbCriticas."UNIPED"> - <' +
              'frxdbCriticas."UNINFE">) / <frxdbCriticas."UNIPED">*100, - (<frx' +
              'dbCriticas."UNINFE"> - <frxdbCriticas."UNIPED">) / <frxdbCritica' +
              's."UNINFE">*100)] %')
          WordWrap = False
        end
      end
      object CFretePedido: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 328.819110000000000000
        Width = 1088.504640000000000000
        OnBeforePrint = 'CFretePedidoOnBeforePrint'
        PrintChildIfInvisible = True
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Width = 1077.166050000000000000
          Height = 13.228346460000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCriticas."DESITE"]')
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 170.078850000000000000
        ParentFont = False
        Top = 83.149660000000000000
        Width = 1088.504640000000000000
        Condition = 'frxdbCriticas."AUTNFE"'
        StartNewPage = True
        object Memo89: TfrxMemoView
          Left = 1123.850684170000000000
          Top = 31.456710000000000000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DA N.F.E.')
        end
        object Shape2: TfrxShapeView
          Top = 107.724490000000000000
          Width = 1088.504640000000000000
          Height = 58.574830000000000000
          Fill.BackColor = clSilver
        end
        object Memo64: TfrxMemoView
          Top = 146.606370000000200000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo65: TfrxMemoView
          Left = 148.054942360000000000
          Top = 146.724490000000000000
          Width = 18.897650000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
        end
        object Memo66: TfrxMemoView
          Left = 296.676957870000000000
          Top = 146.724490000000000000
          Width = 56.692893860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DO PEDIDO')
        end
        object Memo67: TfrxMemoView
          Left = 356.047034170000000000
          Top = 146.724490000000000000
          Width = 56.692893860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DA N.F.E.')
        end
        object Memo68: TfrxMemoView
          Left = 232.204536460000000000
          Top = 146.724490000000000000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'SALDO EST.')
        end
        object Memo69: TfrxMemoView
          Left = 170.952567950000000000
          Top = 146.724490000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'LOC.F'#205'SICA')
        end
        object Memo70: TfrxMemoView
          Left = 480.960407799999700000
          Top = 146.724490000000000000
          Width = 45.354316060000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PEDIDO')
        end
        object Memo71: TfrxMemoView
          Left = 532.873786300000000000
          Top = 146.724490000000000000
          Width = 60.472436060000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DA N.F.E.')
        end
        object Memo72: TfrxMemoView
          Left = 42.354360000000000000
          Top = 146.283550000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO DE F'#193'BRICA')
        end
        object Memo73: TfrxMemoView
          Left = 596.928904409999700000
          Top = 146.724490000000000000
          Width = 60.472436060000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A')
        end
        object Memo74: TfrxMemoView
          Left = 416.550968740000000000
          Top = 146.724490000000000000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A')
        end
        object Memo75: TfrxMemoView
          Left = 289.362400000000000000
          Top = 130.385900000000000000
          Width = 186.330698899999900000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'QUANTIDADE')
        end
        object Memo76: TfrxMemoView
          Left = 481.401347800000000000
          Top = 130.385900000000000000
          Width = 176.125972050000100000
          Height = 15.118120000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR UNIT'#193'RIO')
        end
        object Memo77: TfrxMemoView
          Left = 704.607212130000000000
          Top = 146.724490000000200000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DO PEDIDO')
        end
        object Memo78: TfrxMemoView
          Left = 768.512316300000000000
          Top = 146.724490000000200000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DA N.F.E.')
        end
        object Memo79: TfrxMemoView
          Left = 832.795780870000000000
          Top = 146.724490000000200000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A')
        end
        object Memo80: TfrxMemoView
          Left = 704.607212130000000000
          Top = 130.385900000000100000
          Width = 187.464566930000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR IPI')
        end
        object Memo81: TfrxMemoView
          Left = 896.425790000000000000
          Top = 146.724490000000200000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DO PEDIDO')
        end
        object Memo82: TfrxMemoView
          Left = 961.330894170000000000
          Top = 146.724490000000200000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DA N.F.E.')
        end
        object Memo83: TfrxMemoView
          Left = 1024.614358740000000000
          Top = 146.724490000000000000
          Width = 60.472423860000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DIFEREN'#199'A')
        end
        object Memo84: TfrxMemoView
          Left = 896.425790000000000000
          Top = 130.385900000000100000
          Width = 187.464566930000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR SUB.')
        end
        object Memo85: TfrxMemoView
          Left = 245.102585550000000000
          Top = 109.606370000000000000
          Width = 556.724638900000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERG'#202'NCIA DE QUANTIDADES, VALORES E IMPOSTOS')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 126.538900000000000000
          Top = 1.000000000000000000
          Width = 827.867780000000000000
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
        object Memo87: TfrxMemoView
          Left = 295.672790000000000000
          Top = 15.000000000000000000
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
          Left = 969.525110000000000000
          Top = 14.220470000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 1017.525110000000000000
          Top = 31.220470000000010000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 892.725110000000000000
          Top = 31.220470000000010000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object mmoPedido: TfrxMemoView
          Left = 86.047310000000000000
          Top = 46.220469999999990000
          Width = 71.735250000000000000
          Height = 13.228346460000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PEDIDO]')
          ParentFont = False
        end
        object mmoLoja: TfrxMemoView
          Left = 86.047310000000000000
          Top = 77.370129999999970000
          Width = 479.924490000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LOJA]')
          ParentFont = False
        end
        object mmoFornecedor: TfrxMemoView
          Left = 86.047310000000000000
          Top = 92.267779999999970000
          Width = 479.924490000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Top = 46.354360000000000000
          Width = 83.073840000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO:')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Top = 77.149659999999970000
          Width = 83.073840000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOJA:')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Top = 92.267779999999970000
          Width = 83.073840000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR:')
          ParentFont = False
        end
        object mmoNFE: TfrxMemoView
          Left = 86.047310000000000000
          Top = 32.236239999999990000
          Width = 71.735250000000000000
          Height = 13.228346460000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NFE]')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Top = 32.370130000000000000
          Width = 83.073840000000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOTA ELET.:')
          ParentFont = False
        end
        object mmoComprador: TfrxMemoView
          Left = 85.047310000000000000
          Top = 60.472480000000000000
          Width = 997.720100000000000000
          Height = 13.984251970000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPRADOR]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 60.472480000000000000
          Width = 83.073840000000000000
          Height = 13.984251970000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COMPRADOR:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 661.417749999999900000
          Top = 147.401670000000000000
          Width = 41.574773860000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'DIF. %')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 366.614410000000000000
        Width = 1088.504640000000000000
        OnBeforePrint = 'GroupFooter1OnBeforePrint'
        Child = frxReportJP.Child2
        object Memo1: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FRETE DO PEDIDO: [frxdbCriticas."FREPED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 196.535560000000000000
          Top = 3.779530000000022000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FRETE DA NFE: [frxdbCriticas."FRENFE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 389.291590000000000000
          Top = 3.779530000000022000
          Width = 151.181200000000000000
          Height = 11.338590000000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 411.968770000000000000
        Width = 1088.504640000000000000
        object Subreport1: TfrxSubreport
          Align = baWidth
          Top = 3.779530000000022000
          Width = 1088.504640000000000000
          Height = 18.897650000000000000
          Page = frxReportJP.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 4.500000000000000000
      RightMargin = 4.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object Header1: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 43.456710000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1088.504640000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1088.504640000000000000
          Height = 43.456710000000000000
          Fill.BackColor = clSilver
        end
        object Memo52: TfrxMemoView
          Top = 26.456710000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
        end
        object Memo53: TfrxMemoView
          Left = 553.559370000000000000
          Top = 26.456710000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UN')
        end
        object Memo54: TfrxMemoView
          Left = 585.693260000000000000
          Top = 26.456710000000000000
          Width = 143.622118030000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO DE BARRAS XML')
        end
        object Memo55: TfrxMemoView
          Left = 40.354360000000000000
          Top = 26.456710000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 325.039580000000000000
          Top = 1.559060000000000000
          Width = 396.850650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIVERG'#202'NCIA DE DADOS CADASTRAIS')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 733.228820000000000000
          Top = 26.456710000000000000
          Width = 158.740238030000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO DE BARRAS CADASTRO')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236240000000000000
        ParentFont = False
        Top = 86.929190000000000000
        Width = 1088.504640000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxDBCadastro
        DataSetName = 'frxDBCadastro'
        Filter = '<frxDBCadastro."AUTNFE"> = <frxdbCriticas."AUTNFE">'
        RowCount = 0
        object mmoDetalhe2: TfrxMemoView
          Align = baClient
          Width = 1088.504640000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object Memo58: TfrxMemoView
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."CODITE"]')
          WordWrap = False
        end
        object Memo59: TfrxMemoView
          Left = 553.559370000000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."DESUNI"]')
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 40.354455200000000000
          Width = 506.457020000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxdbCadastro."DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo61: TfrxMemoView
          Left = 585.693260000000000000
          Width = 143.622118030000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."NFEEAN"]')
          WordWrap = False
        end
        object Memo62: TfrxMemoView
          Left = 733.228820000000000000
          Width = 158.740238030000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Memo.UTF8W = (
            '[frxdbCadastro."CODBAR"]')
          WordWrap = False
        end
        object Memo63: TfrxMemoView
          Top = 13.118120000000000000
          Width = 1031.811690000000000000
          Height = 11.338582680000000000
          DataSet = frxdbCriticas
          DataSetName = 'frxdbCriticas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxdbCadastro."INFADI"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
