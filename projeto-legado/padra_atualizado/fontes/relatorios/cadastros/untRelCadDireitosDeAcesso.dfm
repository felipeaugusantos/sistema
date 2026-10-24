inherited frmRelCadDireitosDeAcesso: TfrmRelCadDireitosDeAcesso
  Left = 417
  Top = 205
  Width = 402
  Height = 341
  Caption = 'Relat'#243'rio de Direitos de Acesso'
  ExplicitWidth = 402
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 269
    Width = 396
    ExplicitTop = 269
    ExplicitWidth = 396
    inherited btnSair: TBitBtnLocked
      Left = 313
      ExplicitLeft = 313
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 80
      ExplicitLeft = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 396
    Height = 269
    ExplicitWidth = 396
    ExplicitHeight = 269
    object Label1: TLabel [0]
      Left = 9
      Top = 175
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [1]
      Left = 8
      Top = 8
      Width = 100
      Height = 14
      Caption = '&Grupos de Usu'#225'rios:'
      FocusControl = cklGrupos
    end
    inherited gpbDestino: TGroupBox
      Left = 247
      Top = 200
      TabOrder = 3
      ExplicitLeft = 247
      ExplicitTop = 200
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 62
      Top = 171
      Width = 43
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttInteiro
    end
    object edtNomOpe: TEditFocus
      Left = 106
      Top = 171
      Width = 279
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cklGrupos: TCheckListBox
      Left = 8
      Top = 24
      Width = 377
      Height = 137
      Columns = 2
      ItemHeight = 14
      TabOrder = 0
      OnKeyDown = cklGruposKeyDown
    end
    object prgProgresso: TProgressBar
      Left = 1
      Top = 252
      Width = 394
      Height = 16
      Align = alBottom
      Smooth = True
      TabOrder = 5
    end
    object rdgDireitos: TRadioGroup
      Left = 8
      Top = 200
      Width = 233
      Height = 45
      Caption = 'Direitos por'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Usu'#225'rio'
        'Grupo'
        'Todos')
      TabOrder = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 297
    Width = 396
    ExplicitTop = 297
    ExplicitWidth = 396
    inherited pnlNomeForm: TPanel
      Left = 225
      ExplicitLeft = 225
    end
    inherited pnlInfo: TPanel
      Width = 225
      ExplicitWidth = 225
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 200
    Top = 56
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 168
    Top = 56
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 328
    Top = 88
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 296
    Top = 88
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 264
    Top = 88
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 232
    Top = 88
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 200
    Top = 88
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 232
    Top = 56
  end
  inherited frxGen: TfrxUserDataSet
    Left = 264
    Top = 56
  end
  inherited frxDesigner: TfrxDesigner
    Left = 432
    Top = 144
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 464
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 120
  end
  object frxReportM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40200.410429502300000000
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
    Left = 24
    Top = 40
    Datasets = <
      item
        DataSet = frxDBRelat
        DataSetName = 'frxDBRelat'
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
        Top = 255.000000000000000000
        Width = 1305.600000000000000000
        DataSet = frxDBRelat
        DataSetName = 'frxDBRelat'
        RowCount = 0
        object mmoCamList: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRelat."NOMGRU"]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 710.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRelat."NOMFUN"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 340.000000000000000000
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
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
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
        object mmoTitulo2: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'GRUPO')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OPERACAO')
          TruncOutboundText = False
        end
        object mmoTitulo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OPERADOR:')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        Stretched = True
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
          Left = 412.800000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
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
          Top = 51.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[OPERADOR]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80'
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 1296.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[GRUPOS]')
          TruncOutboundText = False
        end
      end
      object GroupHeader: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxDBRelat."CODOPE"'
        ReprintOnNewPage = True
        object mmoHeader: TfrxDMPMemoView
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRelat."CODOPE"] - [frxDBRelat."NOMOPE"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40200.638670243100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
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
      '  '
      'begin'
      ''
      'end.')
    Left = 56
    Top = 40
    Datasets = <
      item
        DataSet = frxDBRelat
        DataSetName = 'frxDBRelat'
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
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 268.346630000000000000
        Width = 737.008350000000000000
        DataSet = frxDBRelat
        DataSetName = 'frxDBRelat'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 737.385829210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object mmoCamList: TfrxMemoView
          Left = 188.976500000000000000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          DataSet = frxDBRelat
          DataSetName = 'frxDBRelat'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRelat."NOMGRU"]')
        end
        object Memo6: TfrxMemoView
          Left = 408.189240000000000000
          Width = 325.039580000000000000
          Height = 15.118120000000000000
          DataSet = frxDBRelat
          DataSetName = 'frxDBRelat'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRelat."NOMFUN"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 381.732530000000000000
        Width = 737.008350000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 1.881880000000024000
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
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 382.261410000000000000
          Top = 1.881880000000024000
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
          Width = 737.008350000000000000
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
        Height = 17.000000000000000000
        ParentFont = False
        Top = 181.417440000000000000
        Width = 737.008350000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 736.629706460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object mmoTitulo1: TfrxMemoView
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OPERADOR')
        end
        object mmoTitulo2: TfrxMemoView
          Left = 188.976500000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'GRUPO')
        end
        object Memo4: TfrxMemoView
          Left = 408.189240000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'OPERA'#199#195'O')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 100.102350000000000000
        Top = 18.897650000000000000
        Width = 737.008350000000000000
        Stretched = True
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 3.704175000000000000
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
          Left = 123.704175000000000000
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
          Left = 618.481880000000000000
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
          Left = 666.481880000000000000
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
          Left = 583.256710000000000000
          Top = 51.000000000000000000
          Width = 79.445640000000000000
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
          Top = 50.984230000000000000
          Width = 576.756030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OPERADOR]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 94.929190000000000000
          Width = 737.008350000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Top = 71.811070000000000000
          Width = 735.496290000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[GRUPOS]')
          ParentFont = False
        end
      end
      object GroupHeader: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677180000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 737.008350000000000000
        Condition = 'frxDBRelat."CODOPE"'
        ReprintOnNewPage = True
        object mmoHeader: TfrxMemoView
          Top = 1.779529999999994000
          Width = 472.441250000000000000
          Height = 18.897650000000000000
          DataSet = frxDBRelat
          DataSetName = 'frxDBRelat'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDBRelat."CODOPE"] - [frxDBRelat."NOMOPE"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 11.338590000000000000
        Top = 309.921460000000000000
        Width = 737.008350000000000000
        object Line3: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 737.008350000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object cdsRelat: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'NOMOPE;ORDEM_'
    Params = <>
    Left = 24
    Top = 72
    object cdsRelatNOMOPE: TStringField
      FieldName = 'NOMOPE'
      Size = 30
    end
    object cdsRelatNOMGRU: TStringField
      FieldName = 'NOMGRU'
      Size = 30
    end
    object cdsRelatNOMFUN: TStringField
      FieldName = 'NOMFUN'
      Size = 100
    end
    object cdsRelatCODOPE: TStringField
      FieldName = 'CODOPE'
      Size = 3
    end
    object cdsRelatORDEM_: TIntegerField
      FieldName = 'ORDEM_'
    end
  end
  object frxDBRelat: TfrxDBDataset
    UserName = 'frxDBRelat'
    CloseDataSource = False
    DataSet = cdsRelat
    BCDToCurrency = False
    Left = 56
    Top = 72
  end
end
