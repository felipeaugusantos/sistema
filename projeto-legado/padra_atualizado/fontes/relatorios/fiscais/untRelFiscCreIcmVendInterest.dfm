inherited frmRelFiscCreIcmVendInterest: TfrmRelFiscCreIcmVendInterest
  Width = 425
  Height = 288
  Caption = 
    'Relat'#243'rio de Cr'#233'dito de ICMS sobre Vendas Interestaduais - CAT 1' +
    '7'
  OnDestroy = FormDestroy
  ExplicitWidth = 425
  ExplicitHeight = 288
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 217
    Width = 419
    ExplicitTop = 217
    ExplicitWidth = 419
    inherited FlwBotoes: TFlowPanel
      Width = 302
      Align = alLeft
      ExplicitTop = 2
      ExplicitWidth = 302
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 340
      ExplicitLeft = 340
    end
  end
  inherited pnlDados: TPanel
    Width = 419
    Height = 217
    ExplicitWidth = 419
    ExplicitHeight = 217
    object lbl1: TLabel [0]
      Left = 8
      Top = 3
      Width = 51
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object lbl3: TLabel [1]
      Left = 8
      Top = 40
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
    object lblCodEmp: TLabel [2]
      Left = 8
      Top = 75
      Width = 42
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Empresa'
      ParentBiDiMode = False
    end
    object Label1: TLabel [3]
      Left = 77
      Top = 23
      Width = 105
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object Label2: TLabel [4]
      Left = 77
      Top = 59
      Width = 105
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 225
      Top = 118
      Width = 181
      TabOrder = 5
      ExplicitLeft = 225
      ExplicitTop = 118
      ExplicitWidth = 181
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 17
      Width = 63
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
      Left = 8
      Top = 53
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 89
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
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
    object edtNomEmp: TEditFocus
      Left = 73
      Top = 89
      Width = 333
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 208
      Width = 417
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 6
      Visible = False
    end
    object rdgOrdem: TRadioGroup
      Left = 8
      Top = 119
      Width = 180
      Height = 45
      Caption = 'Ordem:'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Data'
        'Documento')
      TabOrder = 4
    end
    object chkEnviaConsumidorFinal: TCheckBox
      Left = 8
      Top = 170
      Width = 295
      Height = 17
      Caption = 'Enviar notas de cliente consumidor final'
      TabOrder = 7
    end
    object chkNaoExibirCreditos: TCheckBox
      Left = 8
      Top = 188
      Width = 295
      Height = 17
      Caption = 'N'#227'o exibir cr'#233'ditos'
      TabOrder = 8
    end
  end
  inherited pnlStatus: TPanel
    Top = 243
    Width = 419
    ExplicitTop = 243
    ExplicitWidth = 419
    inherited pnlNomeForm: TPanel
      Left = 248
      ExplicitLeft = 248
    end
    inherited pnlInfo: TPanel
      Width = 248
      ExplicitWidth = 248
      object Shape1: TShape
        Left = 231
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 447
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 475
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 476
    Top = 105
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 448
    Top = 105
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 503
    Top = 72
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 475
    Top = 72
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 447
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 503
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 475
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 531
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 503
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 447
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 105
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40997.671954571800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '    '
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
    OnStartReport = 'frxReportMOnStartReport'
    OnStopReport = 'frxReportMOnStopReport'
    Left = 209
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 272.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo7: TfrxDMPMemoView
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
          TruncOutboundText = False
        end
        object rllPraMed: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]'
            '')
          TruncOutboundText = False
        end
        object rllCam_UNI_CRED_ICM: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNI_CRED_ICMS"]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BAS_CRED_ICMS"]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQ_CRED_ICMS"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CRED_ICMS"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
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
          Left = 931.200000000000000000
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
        Height = 51.000000000000000000
        Top = 170.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo12: TfrxDMPMemoView
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'COD.ITEM')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.VENDA')
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.VENDA')
          TruncOutboundText = False
        end
        object rllTit_UNI_CRED_ICM: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.CUSTO')
          TruncOutboundText = False
        end
        object rllTit_BAS_CRED_ICM: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL CUSTO')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP')
          TruncOutboundText = False
        end
        object rllTit_ALQ_CRED_ICM: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.INTERNA')
          TruncOutboundText = False
        end
        object rllTit_VLR_CRED_ICM: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. CREDITO')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 119.000000000000000000
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
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 768.000000000000000000
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
          Left = 1228.800000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
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
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#15#27#80#27#67#65'
        end
        object DMPMemo5: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 614.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMPRES]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baCenter
          Left = 297.600000000000000000
          Top = 51.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          TruncOutboundText = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1305.600000000000000000
        object DMPMemo2: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        object DMPMemo25: TfrxDMPMemoView
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DATA SAIDA: [frxRelatorio."DTAENT"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DOCUMENTO: [frxRelatorio."DOCUME"]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 585.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE: [frxRelatorio."CLIENTE"]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UF: [frxRelatorio."ESTADO"]')
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 323.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1296.000000000000000000
          Color = clBlack
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC:')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 393.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
          TruncOutboundText = False
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
    ReportOptions.LastChange = 41037.695527338000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '      '
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
      ''
      'end.')
    OnStartReport = 'frxReportJOnStartReport'
    OnStopReport = 'frxReportJOnStopReport'
    Left = 241
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456700240000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 718.110236220000000000
          Height = 26.456700240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object rllPraMed: TfrxMemoView
          Left = 69.047310000000000000
          Top = 12.236240000000000000
          Width = 43.842505040000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object rllPrazo: TfrxMemoView
          Left = 212.536920000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
        end
        object Memo15: TfrxMemoView
          Left = 119.622140000000000000
          Top = 12.236240000000000000
          Width = 85.417335040000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
        end
        object Memo3: TfrxMemoView
          Left = 0.377952760000000000
          Top = 12.236240000000000000
          Width = 50.645674170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
        end
        object rllCam_UNI_CRED_ICM: TfrxMemoView
          Left = 353.598640000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNI_CRED_ICMS"]')
        end
        object Memo33: TfrxMemoView
          Left = 447.645950000000000000
          Top = 12.236240000000000000
          Width = 92.598434960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BAS_CRED_ICMS"]')
        end
        object Memo34: TfrxMemoView
          Left = 309.228510000000000000
          Top = 12.236240000000000000
          Width = 39.685014960000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
        end
        object Memo35: TfrxMemoView
          Left = 549.472790000000000000
          Top = 12.236240000000000000
          Width = 73.700784960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQ_CRED_ICMS"]')
        end
        object Memo36: TfrxMemoView
          Left = 629.622450000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CRED_ICMS"]')
        end
        object Memo37: TfrxMemoView
          Left = 0.377952760000000000
          Top = 0.377952760000000000
          Width = 557.102694170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.000000000000000000
        ParentFont = False
        Top = 427.086890000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
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
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 397.744650000000000000
          Top = 17.000000000000000000
          Width = 317.404700000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
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
        Height = 32.118120000000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Fill.BackColor = clSilver
        end
        object Memo17: TfrxMemoView
          Left = 212.536920000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.VENDA')
        end
        object Memo27: TfrxMemoView
          Left = 69.047310000000000000
          Top = 15.677180000000000000
          Width = 43.842505040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
        end
        object Memo7: TfrxMemoView
          Left = 0.377952760000000000
          Top = 15.677180000000000000
          Width = 50.645674170000000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            'C'#211'D.ITEM')
        end
        object Memo11: TfrxMemoView
          Left = 119.622140000000000000
          Top = 15.677180000000000000
          Width = 85.417335040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.VENDA')
        end
        object rllTit_UNI_CRED_ICM: TfrxMemoView
          Left = 353.598640000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.CUSTO')
        end
        object rllTit_BAS_CRED_ICM: TfrxMemoView
          Left = 447.645950000000000000
          Top = 15.677180000000000000
          Width = 92.598434960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL CUSTO')
        end
        object Memo6: TfrxMemoView
          Left = 309.228510000000000000
          Top = 15.677180000000000000
          Width = 39.685014960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP')
        end
        object rllTit_ALQ_CRED_ICM: TfrxMemoView
          Left = 549.472790000000000000
          Top = 15.677180000000000000
          Width = 73.700784960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.INTERNA')
        end
        object rllTit_VLR_CRED_ICM: TfrxMemoView
          Left = 629.622450000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CR'#201'DITO ICMS')
        end
        object Memo9: TfrxMemoView
          Left = 0.377952760000000000
          Top = 3.779530000000000000
          Width = 65.763794170000000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.039306610000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 92.220780000000000000
          Top = 17.000000000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 92.220780000000000000
          Top = 34.000000000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 599.539950000000000000
          Top = 34.000000000000000000
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
        object Time: TfrxMemoView
          Left = 651.319480000000000000
          Top = 51.000000000000000000
          Width = 63.420470000000000000
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
        object Date: TfrxMemoView
          Left = 562.139950000000000000
          Top = 51.000000000000000000
          Width = 87.004700000000000000
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
        object Line1: TfrxLineView
          Align = baWidth
          Top = 83.940940000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 71.456710000000000000
          Width = 357.391960000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRES]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 181.455350000000000000
          Top = 45.811070000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 389.291590000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
        end
        object Memo14: TfrxMemoView
          Left = 212.536920000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo18: TfrxMemoView
          Left = 455.205010000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo20: TfrxMemoView
          Left = 640.961040000000000000
          Width = 73.700784960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        object Memo24: TfrxMemoView
          Left = 9.338590000000000000
          Top = 1.118120000000000000
          Width = 130.015804170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DATA SAIDA: [frxRelatorio."DTAENT"]')
        end
        object Memo25: TfrxMemoView
          Left = 144.590600000000000000
          Top = 1.118120000000000000
          Width = 213.165464170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DOCUMENTO: [frxRelatorio."DOCUME"]')
        end
        object Memo30: TfrxMemoView
          Left = 364.921460000000000000
          Top = 1.118120000000000000
          Width = 296.315124170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'CLIENTE: [frxRelatorio."CLIENTE"]')
        end
        object Memo31: TfrxMemoView
          Left = 671.094930000000000000
          Top = 1.118120000000000000
          Width = 43.086614170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'UF: [frxRelatorio."ESTADO"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 309.921460000000000000
        Width = 718.110700000000000000
        object Memo21: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC.:')
        end
        object Memo22: TfrxMemoView
          Left = 212.536920000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo26: TfrxMemoView
          Left = 455.205010000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo38: TfrxMemoView
          Left = 640.961040000000000000
          Width = 73.700784960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 17.118120000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxReportJMod2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41037.695527338000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '      '
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
      ''
      'end.')
    OnStartReport = 'frxReportJOnStartReport'
    OnStopReport = 'frxReportJOnStopReport'
    Left = 331
    Top = 16
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456700240000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 1084.725110000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 26.456700240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object rllPraMed: TfrxMemoView
          Left = 52.913385830000000000
          Top = 12.236240000000000000
          Width = 39.685039370000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object rllPrazo: TfrxMemoView
          Left = 173.858267720000000000
          Top = 12.236240000000000000
          Width = 73.700784960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
        end
        object Memo15: TfrxMemoView
          Left = 94.488188980000000000
          Top = 12.236240000000000000
          Width = 77.480314960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
        end
        object Memo3: TfrxMemoView
          Top = 12.236240000000000000
          Width = 50.645674170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
        end
        object Memo32: TfrxMemoView
          Left = 249.448818900000000000
          Top = 12.236240000000000000
          Width = 77.480314960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNI_CRED_ICMS"]')
        end
        object Memo33: TfrxMemoView
          Left = 328.818897640000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BAS_CRED_ICMS"]')
        end
        object Memo34: TfrxMemoView
          Left = 415.748031500000000000
          Top = 12.236240000000000000
          Width = 35.905484960000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
        end
        object Memo35: TfrxMemoView
          Left = 453.543307090000000000
          Top = 12.236240000000000000
          Width = 66.141724960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQ_CRED_ICMS"]%')
        end
        object Memo36: TfrxMemoView
          Left = 888.188976380000000000
          Top = 12.236240000000000000
          Width = 69.921254960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CRED_ICMS"]')
        end
        object Memo37: TfrxMemoView
          Left = 0.377952760000000000
          Top = 0.377952760000000000
          Width = 557.102694170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
        end
        object Memo40: TfrxMemoView
          Left = 563.149606300000000000
          Top = 12.236240000000000000
          Width = 66.141724960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRUNI_E"]')
        end
        object Memo41: TfrxMemoView
          Left = 631.181102360000000000
          Top = 12.236240000000000000
          Width = 73.700784960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRTOT_E"]')
        end
        object Memo42: TfrxMemoView
          Left = 706.771653540000000000
          Top = 12.236240000000000000
          Width = 39.685014960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."IVA_E"]%')
        end
        object Memo43: TfrxMemoView
          Left = 748.346456690000000000
          Top = 12.236240000000000000
          Width = 51.023604960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQ_E"]%')
        end
        object Memo44: TfrxMemoView
          Left = 563.149606300000000000
          Top = 0.377952760000000000
          Width = 379.842714960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCENT_E"] - [frxRelatorio."FORNEC_E"]')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Left = 563.149606300000000000
          Height = 26.456692910000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo46: TfrxMemoView
          Left = 801.259842520000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLRICM_E"]')
        end
        object Line10: TfrxLineView
          Left = 960.000620000000000000
          Height = 26.456692910000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo53: TfrxMemoView
          Left = 960.000620000000000000
          Top = 12.236240000000000000
          Width = 51.023604960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQ_R"]%')
        end
        object Memo54: TfrxMemoView
          Left = 1013.913949690000000000
          Top = 12.236240000000000000
          Width = 69.921254960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLCREC"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456692913385830000
        ParentFont = False
        Top = 427.086890000000000000
        Width = 1084.725110000000000000
        object rllNomeForm: TfrxMemoView
          Align = baLeft
          Top = 13.228346460000000000
          Width = 351.722820000000000000
          Height = 13.228346460000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          VAlign = vaBottom
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 721.966050000000000000
          Top = 13.228346460000000000
          Width = 362.759060000000000000
          Height = 13.228346460000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          VAlign = vaBottom
        end
        object Line2: TfrxLineView
          Align = baWidth
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo49: TfrxMemoView
          Align = baCenter
          Left = 366.614410000000000000
          Top = 13.228346460000000000
          Width = 351.496290000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RESSARCIMENTO ST = VR.UNIT.ENTRADA * QTD.SA'#205'DA * ALQ.ST')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Align = baCenter
          Left = 366.614410000000000000
          Width = 351.496290000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'VR.CR'#201'DITO = VR.UNIT.ENTRADA * QUANT.SA'#205'DA * AL'#205'Q.ENTRADA')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 35.149606300000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 1084.725110000000000000
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Width = 1084.725110000000000000
          Height = 34.015748030000000000
          Fill.BackColor = clSilver
        end
        object Memo17: TfrxMemoView
          Left = 173.858267720000000000
          Top = 17.007874020000000000
          Width = 73.700784960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.VENDA')
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 52.913385830000000000
          Top = 17.007874020000000000
          Width = 39.685039370000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Top = 17.007874020000000000
          Width = 50.645674170000000000
          Height = 17.007874020000000000
          Memo.UTF8W = (
            'C'#211'D.ITEM')
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 94.488188980000000000
          Top = 17.007874020000000000
          Width = 77.480314960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.VENDA')
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 249.448818900000000000
          Top = 17.007874020000000000
          Width = 77.480314960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.CUSTO')
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 328.818897640000000000
          Top = 17.007874020000000000
          Width = 85.039374960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL CUSTO')
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 415.748031500000000000
          Top = 17.007874020000000000
          Width = 35.905484960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP')
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 453.543307090000000000
          Top = 17.007874020000000000
          Width = 66.141724960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.INTERNA')
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 888.188976380000000000
          Top = 17.007874020000000000
          Width = 69.921254960000000000
          Height = 17.007874020000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CR'#201'DITO')
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Width = 65.763794170000000000
          Height = 17.007874020000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 563.149606300000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CUSTO DA NOTA FISCAL SEM IPI')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 563.149606300000000000
          Top = 17.007874020000000000
          Width = 66.141724960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. UNIT.')
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 631.181102360000000000
          Top = 17.007874020000000000
          Width = 73.700784960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. TOTAL')
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 706.771653540000000000
          Top = 17.007874020000000000
          Width = 39.685014960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'IVA')
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 748.346456690000000000
          Top = 17.007874020000000000
          Width = 51.023604960000000000
          Height = 17.007874020000000000
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'Q.')
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 801.259842520000000000
          Top = 17.007874020000000000
          Width = 85.039374960000000000
          Height = 17.007874020000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. ICMS')
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Left = 563.149606300000000000
          Height = 34.015748030000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo50: TfrxMemoView
          Left = 1013.913949690000000000
          Top = 17.007874020000000000
          Width = 69.921254960000000000
          Height = 17.007874020000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.RESSARC.')
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 960.000620000000000000
          Top = 17.007874020000000000
          Width = 51.023604960000000000
          Height = 17.007874020000000000
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'Q.')
          VAlign = vaCenter
        end
        object Line9: TfrxLineView
          Left = 960.000620000000000000
          Height = 34.015748030000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo52: TfrxMemoView
          Left = 960.000620000000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RESSARCIMENTO S.T.')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.039306610000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 275.527985000000000000
          Top = 16.102350000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 969.525110000000000000
          Top = 34.000000000000000000
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
        object Time: TfrxMemoView
          Align = baRight
          Left = 1021.304640000000000000
          Top = 51.000000000000000000
          Width = 63.420470000000000000
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
        object Date: TfrxMemoView
          Align = baRight
          Left = 934.299940000000000000
          Top = 51.000000000000000000
          Width = 87.004700000000000000
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
        object Line1: TfrxLineView
          Align = baWidth
          Top = 83.940940000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 71.456710000000000000
          Width = 357.391960000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRES]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 364.762555000000000000
          Top = 30.913420000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 275.527985000000000000
          Top = 2.102350000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 389.291590000000000000
        Width = 1084.725110000000000000
        object Memo8: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
        end
        object Memo14: TfrxMemoView
          Left = 173.858267720000000000
          Width = 73.700784960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo18: TfrxMemoView
          Left = 328.818897640000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo20: TfrxMemoView
          Left = 888.188976380000000000
          Width = 69.921254960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
        end
        object Line7: TfrxLineView
          Left = 563.149606300000000000
          Height = 15.118110240000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo45: TfrxMemoView
          Left = 631.181102360000000000
          Width = 73.700784960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRTOT_E">,rlbDetalhes)]')
        end
        object Memo48: TfrxMemoView
          Left = 801.259842520000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRICM_E">,rlbDetalhes)]')
        end
        object Line12: TfrxLineView
          Left = 960.000620000000000000
          Height = 15.118110240000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo56: TfrxMemoView
          Left = 1013.913949690000000000
          Width = 69.921254960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLCREC">,rlbDetalhes)]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 1084.725110000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        object Memo24: TfrxMemoView
          Top = 1.118120000000000000
          Width = 128.503937010000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DATA SA'#205'DA: [frxRelatorio."DTAENT"]')
        end
        object Memo25: TfrxMemoView
          Left = 130.393700790000000000
          Top = 1.118120000000000000
          Width = 173.858267720000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DOCUMENTO: [frxRelatorio."DOCUME"]')
        end
        object Memo30: TfrxMemoView
          Left = 306.228510000000000000
          Top = 1.118120000000000000
          Width = 211.653543307086600000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'CLIENTE: [frxRelatorio."CLIENTE"]')
        end
        object Memo31: TfrxMemoView
          Left = 519.685039370000000000
          Top = 1.118120000000000000
          Width = 39.685039370078740000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'UF: [frxRelatorio."ESTADO"]')
        end
        object Line8: TfrxLineView
          Left = 563.149606300000000000
          Height = 15.118110240000000000
          Color = clBlack
          Diagonal = True
        end
        object Line13: TfrxLineView
          Left = 960.000620000000000000
          Height = 15.118110240000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 309.921460000000000000
        Width = 1084.725110000000000000
        object Memo21: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC.:')
        end
        object Memo22: TfrxMemoView
          Left = 173.858267720000000000
          Width = 73.700784960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo26: TfrxMemoView
          Left = 328.818897640000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo38: TfrxMemoView
          Left = 888.188976380000000000
          Width = 69.921254960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
        end
        object Line6: TfrxLineView
          Left = 563.149606300000000000
          Height = 17.007864250000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo29: TfrxMemoView
          Left = 631.181102360000000000
          Width = 73.700784960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRTOT_E">,rlbDetalhes)]')
        end
        object Memo39: TfrxMemoView
          Left = 801.259842520000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLRICM_E">,rlbDetalhes)]')
        end
        object Line11: TfrxLineView
          Left = 960.000620000000000000
          Height = 17.007864250000000000
          Color = clBlack
          Diagonal = True
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 17.118120000000000000
          Width = 1084.725110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo55: TfrxMemoView
          Left = 1013.913949690000000000
          Width = 69.921254960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLCREC">,rlbDetalhes)]')
        end
      end
    end
  end
  object frxReportJMod3: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42473.447340740700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnStartReport = 'frxReportJOnStartReport'
    OnStopReport = 'frxReportJOnStopReport'
    Left = 376
    Top = 16
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
      PaperWidth = 238.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456700240000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 823.937540000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 823.937540000000000000
          Height = 26.456700240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object rllPraMed: TfrxMemoView
          Left = 69.047310000000000000
          Top = 12.236240000000000000
          Width = 43.842505040000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object rllPrazo: TfrxMemoView
          Left = 212.536920000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
        end
        object Memo15: TfrxMemoView
          Left = 119.622140000000000000
          Top = 12.236240000000000000
          Width = 85.417335040000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
        end
        object Memo3: TfrxMemoView
          Left = 0.377952760000000000
          Top = 12.236240000000000000
          Width = 50.645674170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
        end
        object rllCam_UNI_CRED_ICM: TfrxMemoView
          Left = 353.598640000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNI_CRED_ICMS"]')
        end
        object Memo33: TfrxMemoView
          Left = 447.645950000000000000
          Top = 12.236240000000000000
          Width = 92.598434960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BAS_CRED_ICMS"]')
        end
        object Memo34: TfrxMemoView
          Left = 309.228510000000000000
          Top = 12.236240000000000000
          Width = 39.685014960000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
        end
        object Memo35: TfrxMemoView
          Left = 549.472790000000000000
          Top = 12.236240000000000000
          Width = 73.700784960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALQ_CRED_ICMS"]')
        end
        object Memo36: TfrxMemoView
          Left = 629.622450000000000000
          Top = 12.236240000000000000
          Width = 88.818897640000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CRED_ICMS"]')
        end
        object Memo37: TfrxMemoView
          Left = 0.377952760000000000
          Top = 0.377952760000000000
          Width = 557.102694170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
        end
        object Memo4: TfrxMemoView
          Left = 725.669291340000000000
          Top = 12.094488190000000000
          Width = 88.818897640000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VLR_CRED_ICMS_ST"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.000000000000000000
        ParentFont = False
        Top = 427.086890000000000000
        Width = 823.937540000000000000
        object rllNomeForm: TfrxMemoView
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
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 397.744650000000000000
          Top = 17.000000000000000000
          Width = 317.404700000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
          Width = 823.937540000000000000
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
        Height = 32.118120000000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 823.937540000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 823.937540000000000000
          Height = 32.118120000000000000
          Fill.BackColor = clSilver
        end
        object Memo17: TfrxMemoView
          Left = 212.536920000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.VENDA')
        end
        object Memo27: TfrxMemoView
          Left = 69.047310000000000000
          Top = 15.677180000000000000
          Width = 43.842505040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
        end
        object Memo7: TfrxMemoView
          Left = 0.377952760000000000
          Top = 15.677180000000000000
          Width = 50.645674170000000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            'C'#211'D.ITEM')
        end
        object Memo11: TfrxMemoView
          Left = 119.622140000000000000
          Top = 15.677180000000000000
          Width = 85.417335040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.VENDA')
        end
        object rllTit_UNI_CRED_ICM: TfrxMemoView
          Left = 353.598640000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.CUSTO')
        end
        object rllTit_BAS_CRED_ICM: TfrxMemoView
          Left = 447.645950000000000000
          Top = 15.677180000000000000
          Width = 92.598434960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOTAL CUSTO')
        end
        object Memo6: TfrxMemoView
          Left = 309.228510000000000000
          Top = 15.677180000000000000
          Width = 39.685014960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP')
        end
        object rllTit_ALQ_CRED_ICM: TfrxMemoView
          Left = 549.472790000000000000
          Top = 15.677180000000000000
          Width = 73.700784960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.INTERNA')
        end
        object rllTit_VLR_CRED_ICM: TfrxMemoView
          Left = 629.622450000000000000
          Top = 15.677180000000000000
          Width = 88.818904960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CR'#201'DITO ICMS')
        end
        object Memo9: TfrxMemoView
          Left = 0.377952760000000000
          Top = 3.779530000000000000
          Width = 65.763794170000000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
        object Memo2: TfrxMemoView
          Left = 725.669760000000000000
          Top = 15.496062990000000000
          Width = 88.818904960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.CR'#201'DITO ST')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.039306610000000000
        Top = 18.897650000000000000
        Width = 823.937540000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 145.134200000000000000
          Top = 17.000000000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 145.134200000000000000
          Top = 34.000000000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 699.539950000000000000
          Top = 34.000000000000000000
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
        object Time: TfrxMemoView
          Left = 751.319480000000000000
          Top = 51.000000000000000000
          Width = 63.420470000000000000
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
        object Date: TfrxMemoView
          Left = 662.139950000000000000
          Top = 51.000000000000000000
          Width = 87.004700000000000000
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
        object Line1: TfrxLineView
          Align = baWidth
          Top = 83.940940000000000000
          Width = 823.937540000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 71.456710000000000000
          Width = 357.391960000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRES]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 234.368770000000000000
          Top = 45.811070000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 389.291590000000000000
        Width = 823.937540000000000000
        object Memo8: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
        end
        object Memo14: TfrxMemoView
          Left = 212.536920000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo18: TfrxMemoView
          Left = 455.205010000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo20: TfrxMemoView
          Left = 629.669291340000000000
          Width = 88.818897640000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo10: TfrxMemoView
          Left = 725.669291340000000000
          Width = 88.818904960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS_ST">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 222.992270000000000000
        Width = 823.937540000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        object Memo24: TfrxMemoView
          Left = 9.338590000000000000
          Top = 1.118120000000000000
          Width = 130.015804170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DATA SAIDA: [frxRelatorio."DTAENT"]')
        end
        object Memo25: TfrxMemoView
          Left = 144.590600000000000000
          Top = 1.118120000000000000
          Width = 213.165464170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DOCUMENTO: [frxRelatorio."DOCUME"]')
        end
        object Memo30: TfrxMemoView
          Left = 364.921460000000000000
          Top = 1.118120000000000000
          Width = 296.315124170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'CLIENTE: [frxRelatorio."CLIENTE"]')
        end
        object Memo31: TfrxMemoView
          Left = 671.094930000000000000
          Top = 1.118120000000000000
          Width = 43.086614170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'UF: [frxRelatorio."ESTADO"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 309.921460000000000000
        Width = 823.937540000000000000
        object Memo21: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC.:')
        end
        object Memo22: TfrxMemoView
          Left = 212.536920000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo26: TfrxMemoView
          Left = 455.205010000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BAS_CRED_ICMS">,rlbDetalhes)]')
        end
        object Memo38: TfrxMemoView
          Left = 629.669291340000000000
          Width = 88.818897640000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS">,rlbDetalhes)]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 17.118120000000000000
          Width = 823.937540000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo12: TfrxMemoView
          Left = 725.669291340000000000
          Width = 88.818897640000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VLR_CRED_ICMS_ST">,rlbDetalhes)]')
        end
      end
    end
  end
  object frxReportJMod4: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41037.695527338000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '      '
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
      ''
      'end.')
    OnStartReport = 'frxReportJOnStartReport'
    OnStopReport = 'frxReportJOnStopReport'
    Left = 321
    Top = 76
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnBeforePrint = 'qckPaginaOnBeforePrint'
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 26.456700240000000000
        ParentFont = False
        Top = 298.582870000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Width = 718.110236220000000000
          Height = 26.456700240000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object rllPraMed: TfrxMemoView
          Left = 69.047310000000000000
          Top = 12.236240000000000000
          Width = 43.842505040000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object rllPrazo: TfrxMemoView
          Left = 212.536920000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
        end
        object Memo15: TfrxMemoView
          Left = 119.622140000000000000
          Top = 12.236240000000000000
          Width = 85.417335040000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
        end
        object Memo3: TfrxMemoView
          Left = 0.377952760000000000
          Top = 12.236240000000000000
          Width = 50.645674170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
        end
        object rllCam_UNI_CRED_ICM: TfrxMemoView
          Left = 353.598640000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BASE_ICMS"]')
        end
        object Memo33: TfrxMemoView
          Left = 447.645950000000000000
          Top = 12.236240000000000000
          Width = 92.598434960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALOR_ICMS"]')
        end
        object Memo34: TfrxMemoView
          Left = 309.228510000000000000
          Top = 12.236240000000000000
          Width = 39.685014960000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
        end
        object Memo35: TfrxMemoView
          Left = 549.472790000000000000
          Top = 12.236240000000000000
          Width = 73.700784960000000000
          Height = 13.228346460000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ALIQUOTA_ICMS"]')
        end
        object Memo36: TfrxMemoView
          Left = 629.622450000000000000
          Top = 12.236240000000000000
          Width = 85.039374960000000000
          Height = 13.228346460000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."NCM"]')
        end
        object Memo37: TfrxMemoView
          Left = 0.377952760000000000
          Top = 0.377952760000000000
          Width = 557.102694170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESCRI"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 34.000000000000000000
        ParentFont = False
        Top = 506.457020000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
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
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 397.744650000000000000
          Top = 17.000000000000000000
          Width = 317.404700000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 8.500000000000000000
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
        Height = 32.118120000000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object frxShapeView1: TfrxShapeView
          Align = baWidth
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Fill.BackColor = clSilver
        end
        object Memo17: TfrxMemoView
          Left = 212.536920000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.VENDA')
        end
        object Memo27: TfrxMemoView
          Left = 69.047310000000000000
          Top = 15.677180000000000000
          Width = 43.842505040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
        end
        object Memo7: TfrxMemoView
          Left = 0.377952760000000000
          Top = 15.677180000000000000
          Width = 50.645674170000000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            'COD.ITEM')
        end
        object Memo11: TfrxMemoView
          Left = 119.622140000000000000
          Top = 15.677180000000000000
          Width = 85.417335040000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.VENDA')
        end
        object rllTit_UNI_CRED_ICM: TfrxMemoView
          Left = 353.598640000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'BC.ICMS')
        end
        object rllTit_BAS_CRED_ICM: TfrxMemoView
          Left = 447.645950000000000000
          Top = 15.677180000000000000
          Width = 92.598434960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'VR.ICMS')
        end
        object Memo6: TfrxMemoView
          Left = 309.228510000000000000
          Top = 15.677180000000000000
          Width = 39.685014960000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CFOP')
        end
        object rllTit_ALQ_CRED_ICM: TfrxMemoView
          Left = 549.472790000000000000
          Top = 15.677180000000000000
          Width = 73.700784960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'ALQ.ICMS')
        end
        object rllTit_VLR_CRED_ICM: TfrxMemoView
          Left = 629.622450000000000000
          Top = 15.677180000000000000
          Width = 85.039374960000000000
          Height = 13.220470000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'NCM ITEM')
        end
        object Memo9: TfrxMemoView
          Left = 0.377952760000000000
          Top = 3.779530000000000000
          Width = 65.763794170000000000
          Height = 11.338590000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.039306610000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 92.220780000000000000
          Top = 17.000000000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 92.220780000000000000
          Top = 34.000000000000000000
          Width = 533.669140000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 599.539950000000000000
          Top = 34.000000000000000000
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
        object Time: TfrxMemoView
          Left = 651.319480000000000000
          Top = 51.000000000000000000
          Width = 63.420470000000000000
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
        object Date: TfrxMemoView
          Left = 562.139950000000000000
          Top = 51.000000000000000000
          Width = 87.004700000000000000
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
        object Line1: TfrxLineView
          Align = baWidth
          Top = 83.940940000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Top = 71.456710000000000000
          Width = 357.391960000000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRES]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 181.455350000000000000
          Top = 45.811070000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118110240000000000
        ParentFont = False
        Top = 468.661720000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
        end
        object Memo14: TfrxMemoView
          Left = 212.536920000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo18: TfrxMemoView
          Left = 353.763779530000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASE_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 455.055118110000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 15.118120000000000000
        ParentFont = False
        Top = 260.787570000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."NUMDOC"'
        object Memo24: TfrxMemoView
          Left = 9.338590000000000000
          Top = 1.118120000000000000
          Width = 130.015804170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DATA SAIDA: [frxRelatorio."DTAENT"]')
        end
        object Memo25: TfrxMemoView
          Left = 144.590600000000000000
          Top = 1.118120000000000000
          Width = 213.165464170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'DOCUMENTO: [frxRelatorio."DOCUME"]')
        end
        object Memo30: TfrxMemoView
          Left = 364.921460000000000000
          Top = 1.118120000000000000
          Width = 296.315124170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'CLIENTE: [frxRelatorio."CLIENTE"]')
        end
        object Memo31: TfrxMemoView
          Left = 671.094930000000000000
          Top = 1.118120000000000000
          Width = 43.086614170000000000
          Height = 13.228346460000000000
          Memo.UTF8W = (
            'UF: [frxRelatorio."ESTADO"]')
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 347.716760000000000000
        Width = 718.110700000000000000
        object Memo21: TfrxMemoView
          Left = 2.440940000000000000
          Width = 61.984264170000000000
          Height = 13.606299210000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOC.:')
        end
        object Memo22: TfrxMemoView
          Left = 212.536920000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
        end
        object Memo26: TfrxMemoView
          Left = 455.205010000000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_ICMS">,rlbDetalhes)]')
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 17.118120000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo13: TfrxMemoView
          Left = 353.763779530000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASE_ICMS">,rlbDetalhes)]')
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 222.992270000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."CLAFIS"'
        object Memo2: TfrxMemoView
          Left = 9.448818900000000000
          Width = 39.685014960000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CFOP:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 52.133890000000000000
          Width = 81.259844960000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CLAFIS"]')
          ParentFont = False
        end
      end
      object GroupFooter2: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 389.291590000000000000
        Width = 718.110700000000000000
        object Memo10: TfrxMemoView
          Left = 2.267716540000000000
          Width = 65.763794170000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL CFOP:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 212.409448820000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 353.763779530000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."BASE_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 455.055118110000000000
          Width = 85.039374960000000000
          Height = 13.606299210000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALOR_ICMS">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 17.007874015748030000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
