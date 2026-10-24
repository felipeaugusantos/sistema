inherited frmControleEstoqueCat17: TfrmControleEstoqueCat17
  Width = 503
  Height = 293
  Caption = 'Relat'#243'rio de Controle de estoque - CAT 17/99'
  ExplicitWidth = 503
  ExplicitHeight = 293
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 222
    Width = 497
    ExplicitTop = 222
    ExplicitWidth = 497
    inherited FlwBotoes: TFlowPanel
      Width = 416
      Align = alLeft
      ExplicitTop = 2
      ExplicitWidth = 416
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
      object btnDeletarPeriodo: TBitBtnLocked
        Left = 154
        Top = 0
        Width = 101
        Height = 22
        Align = alLeft
        Caption = '&Deletar Per'#237'odo'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 418
      ExplicitLeft = 418
    end
  end
  inherited pnlDados: TPanel
    Width = 497
    Height = 222
    ExplicitWidth = 497
    ExplicitHeight = 222
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
    object Label1: TLabel [2]
      Left = 73
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
    object Label2: TLabel [3]
      Left = 73
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
    object lblCodEmp: TLabel [4]
      Left = 8
      Top = 120
      Width = 42
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Empresa'
      ParentBiDiMode = False
    end
    object lbl4: TLabel [5]
      Left = 8
      Top = 79
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
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 159
      TabOrder = 6
      ExplicitLeft = 8
      ExplicitTop = 159
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
      Top = 134
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
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
      Top = 134
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
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
      Top = 213
      Width = 495
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 7
    end
    object edtProdutos: TEditFocus
      Tag = 99
      Left = 8
      Top = 93
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      OnExit = edtProdutosExit
      OnKeyPress = edtProdutosKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesProduto: TEditFocus
      Left = 73
      Top = 93
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  inherited pnlStatus: TPanel
    Top = 248
    Width = 497
    ExplicitTop = 248
    ExplicitWidth = 497
    inherited pnlNomeForm: TPanel
      Left = 326
      ExplicitLeft = 326
    end
    inherited pnlInfo: TPanel
      Width = 326
      ExplicitWidth = 326
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
    Top = 24
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 664
    Top = 24
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 808
    Top = 80
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 776
    Top = 80
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 744
    Top = 80
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 712
    Top = 80
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 680
    Top = 80
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = cdsRelatorio
    Left = 296
    Top = 16
  end
  inherited frxGen: TfrxUserDataSet
    Left = 648
    Top = 80
  end
  inherited frxDesigner: TfrxDesigner
    Left = 872
    Top = 80
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 904
    Top = 80
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 808
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 736
    Top = 112
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43108.470125590300000000
    ReportOptions.LastChange = 43137.398489745370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 360
    Top = 16
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
      PaperWidth = 525.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 366.614410000000000000
        Width = 1908.662650000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatorioDATA: TfrxMemoView
          Left = 16.251968503937010000
          Width = 90.708661420000000000
          Height = 18.897650000000000000
          DataField = 'DATA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DATA"]')
          ParentFont = False
        end
        object frxRelatorioNFCOMPRA: TfrxMemoView
          Align = baLeft
          Left = 106.960629923937000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NFCOMPRA"]')
          ParentFont = False
        end
        object frxRelatorioSERIECOMPRA: TfrxMemoView
          Align = baLeft
          Left = 201.448818903937000000
          Width = 78.992125980000000000
          Height = 18.897650000000000000
          DataField = 'SERIECOMPRA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SERIECOMPRA"]')
          ParentFont = False
        end
        object frxRelatorioQTDCOMPRA: TfrxMemoView
          Align = baLeft
          Left = 280.440944883937000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          DataField = 'QTDCOMPRA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDCOMPRA"]')
          ParentFont = False
        end
        object frxRelatorioBASESTCOMPRA: TfrxMemoView
          Align = baLeft
          Left = 356.031496063937000000
          Width = 98.645669290000000000
          Height = 18.897650000000000000
          DataField = 'BASESTCOMPRA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."BASESTCOMPRA"]')
          ParentFont = False
        end
        object frxRelatorioNFVENDA: TfrxMemoView
          Align = baLeft
          Left = 454.677165353937000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          DataField = 'NFVENDA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NFVENDA"]')
          ParentFont = False
        end
        object frxRelatorioSERIEVENDA: TfrxMemoView
          Align = baLeft
          Left = 549.165354333937000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          DataField = 'SERIEVENDA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SERIEVENDA"]')
          ParentFont = False
        end
        object frxRelatorioQTDVENDA: TfrxMemoView
          Align = baLeft
          Left = 632.314960633937000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          DataField = 'QTDVENDA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDVENDA"]')
          ParentFont = False
        end
        object frxRelatorioUNITARIOVENDA: TfrxMemoView
          Align = baLeft
          Left = 707.905511813937000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          DataField = 'UNITARIOVENDA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITARIOVENDA"]')
          ParentFont = False
        end
        object frxRelatorioSAIDACONSUMIDOR: TfrxMemoView
          Align = baLeft
          Left = 806.173228353937000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DataField = 'SAIDACONSUMIDOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAIDACONSUMIDOR"]')
          ParentFont = False
        end
        object frxRelatorioFATOGERADOR: TfrxMemoView
          Align = baLeft
          Left = 923.338582683937000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DataField = 'FATOGERADOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."FATOGERADOR"]')
          ParentFont = False
        end
        object frxRelatorioSAIDAISENTA: TfrxMemoView
          Align = baLeft
          Left = 1040.503937013937000000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
          DataField = 'SAIDAISENTA'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAIDAISENTA"]')
          ParentFont = False
        end
        object frxRelatorioSAIDAOUTROESTADO: TfrxMemoView
          Align = baLeft
          Left = 1142.551181103937000000
          Width = 102.047244090000000000
          Height = 18.897650000000000000
          DataField = 'SAIDAOUTROESTADO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAIDAOUTROESTADO"]')
          ParentFont = False
        end
        object frxRelatorioSAIDACOMERCIALIZACAO: TfrxMemoView
          Align = baLeft
          Left = 1244.598425193937000000
          Width = 113.385826770000000000
          Height = 18.897650000000000000
          DataField = 'SAIDACOMERCIALIZACAO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."SAIDACOMERCIALIZACAO"]')
          ParentFont = False
        end
        object frxRelatorioQTDTOTAL: TfrxMemoView
          Left = 1588.535433070000000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          DataField = 'QTDTOTAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDTOTAL"]')
          ParentFont = False
        end
        object frxRelatorioUNITARIOTOTAL: TfrxMemoView
          Align = baLeft
          Left = 1686.803149610000000000
          Width = 98.267716540000000000
          Height = 18.897650000000000000
          DataField = 'UNITARIOTOTAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITARIOTOTAL"]')
          ParentFont = False
        end
        object frxRelatorioVALORTOTAL: TfrxMemoView
          Align = baLeft
          Left = 1785.070866150000000000
          Width = 113.385826770000000000
          Height = 18.897650000000000000
          DataField = 'VALORTOTAL'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALORTOTAL"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Align = baLeft
          Left = 1357.984251963937000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Align = baLeft
          Left = 1475.149606293937000000
          Width = 113.385826770000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 103.881880000000000000
        Top = 18.897650000000000000
        Width = 1908.662650000000000000
        object rllPagina: TfrxMemoView
          Left = 1798.700990000000000000
          Top = 3.527520000000000000
          Width = 96.302350000000000000
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
          Left = 1848.219110000000000000
          Top = 28.118120000000000000
          Width = 46.563760000000000000
          Height = 13.220470000000000000
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
          Left = 1714.039580000000000000
          Top = 28.307050000000000000
          Width = 124.800000000000000000
          Height = 13.220470000000000000
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
        object Line5: TfrxLineView
          Left = 16.251968500000000000
          Top = 98.236240000000000000
          Height = -51.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Left = 16.251968500000000000
          Top = 47.897650000000000000
          Width = 1882.204724410000000000
          Color = clBlack
          Diagonal = True
        end
        object Line7: TfrxLineView
          Left = 16.251968500000000000
          Top = 98.811070000000000000
          Width = 1882.204724410000000000
          Color = clBlack
          Diagonal = True
        end
        object Line8: TfrxLineView
          Left = 1898.078740160000000000
          Top = 98.267716540000000000
          Height = -51.023622050000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo28: TfrxMemoView
          Left = 22.677180000000000000
          Top = 64.252010000000000000
          Width = 1870.867350000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'CONTROLE DE ESTOQUE - MERCADORIAS ENQUADRADAS NA SUBSTITUI'#199#195'O TR' +
              'IBUT'#193'RIA')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 158.740260000000000000
        Top = 185.196970000000000000
        Width = 1908.662650000000000000
        Condition = 'frxRelatorio."CODITE"'
        object Memo29: TfrxMemoView
          Left = 19.118120000000000000
          Top = 5.779530000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONTRIBUINTE:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo30: TfrxMemoView
          Left = 19.118120000000000000
          Top = 30.456710000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'M'#202'S E ANO DE REFER'#202'NCIA:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo31: TfrxMemoView
          Left = 600.945270000000000000
          Top = 30.456710000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'MERCADORIA:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo32: TfrxMemoView
          Left = 1198.866114880000000000
          Top = 5.779527560000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'INSCRI'#199#195'O ESTADUAL: ')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo33: TfrxMemoView
          Left = 1198.111010000000000000
          Top = 30.456710000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNIDADE:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo34: TfrxMemoView
          Left = 1651.654610000000000000
          Top = 30.456710000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'AL'#205'QUOTA:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Left = 106.826781420000000000
          Top = 75.590585350000000000
          Width = 173.480314960000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO FISCAL')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Left = 106.826781420000000000
          Top = 94.488220710000000000
          Width = 94.488188980000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baLeft
          Left = 201.314970400000000000
          Top = 94.488220710000000000
          Width = 78.992125980000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'S'#201'RIE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Align = baLeft
          Left = 280.307096380000000000
          Top = 75.590587800000000000
          Width = 75.590551180000000000
          Height = 83.149608740000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Align = baLeft
          Left = 355.897647560000000000
          Top = 75.590587800000000000
          Width = 98.645669290000000000
          Height = 83.149660000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR TOTAL DA BASE DE C'#193'LCULO DE RETEN'#199#195'O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 16.118120000000000000
          Top = 56.692950000000000000
          Width = 90.708661420000000000
          Height = 102.047310000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Align = baLeft
          Left = 454.543316850000000000
          Top = 56.692950000000000000
          Width = 1133.858267720000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DAS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          Left = 454.543316850000000000
          Top = 75.590587800000000000
          Width = 177.637795280000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO FISCAL')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Align = baLeft
          Left = 454.543316850000000000
          Top = 94.488225590000000000
          Width = 94.488188980000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Align = baLeft
          Left = 549.031505830000000000
          Top = 94.488225590000000000
          Width = 83.149660000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'S'#201'RIE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Align = baLeft
          Left = 632.181165830000000000
          Top = 75.590600000000000000
          Width = 75.590551180000000000
          Height = 83.149660000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Align = baLeft
          Left = 707.771717010000000000
          Top = 75.590600000000000000
          Width = 650.078740160000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR DA BASE DE C'#193'LCULO DA RETEN'#199#195'O')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baLeft
          Left = 707.771717010000000000
          Top = 94.488220710000000000
          Width = 98.267716540000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR UNIT'#193'RIO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Left = 806.039433550000000000
          Top = 94.488225590000000000
          Width = 117.165430000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DA A CONSUMIDOR OU USU'#193'RIO FINAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Align = baLeft
          Left = 923.204863550000000000
          Top = 94.488225590000000000
          Width = 117.165430000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FATO GERADOR N'#195'O REALIZADO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Align = baLeft
          Left = 1040.370293550000000000
          Top = 94.488225590000000000
          Width = 102.047310000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DA COM ISEN'#199#195'O OU N'#195'O INCID'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Align = baLeft
          Left = 1142.417603550000000000
          Top = 94.488225590000000000
          Width = 102.047310000000000000
          Height = 64.251973390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DA PARA OUTRO ESTADO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Left = 1244.464913550000000000
          Top = 94.488225590000000000
          Width = 113.385900000000000000
          Height = 64.251983150000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SA'#205'DA PARA COMERCIALIZA'#199#195'O SUBSEQUENTE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Left = 1357.850457170000000000
          Top = 75.590600000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR DE CONFRONTO')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baLeft
          Left = 1357.850813550000000000
          Top = 94.488250000000000000
          Width = 117.165430000000000000
          Height = 64.251983150000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'BASE DE C'#193'LCULO EFETIVA NA S'#193'IDA A CONSUMIDOR OU USU'#193'RIO FINAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 1475.016243550000000000
          Top = 94.488250000000000000
          Width = 113.385900000000000000
          Height = 64.251983150000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'BASE DE C'#193'LCULO EFETIVA DA ENTRADA NAS DEMAIS HIP'#211'TESES')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Left = 1588.401584570000000000
          Top = 56.692950000000000000
          Width = 309.921264720000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDOS')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Left = 1588.402143550000000000
          Top = 75.590600000000000000
          Width = 98.267716540000000000
          Height = 83.149660000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Left = 1686.669860090000000000
          Top = 75.590600000000000000
          Width = 211.653680000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR DA BASE DE C'#193'LCULO DA RETEN'#199#195'O')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 1686.669860090000000000
          Top = 105.826840000000000000
          Width = 98.267716540000000000
          Height = 52.913383390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR UNIT'#193'RIO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Left = 1784.937576630000000000
          Top = 105.826840000000000000
          Width = 113.385826770000000000
          Height = 52.913383390000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baLeft
          Left = 106.826781420000000000
          Top = 56.692950000000000000
          Width = 347.716535430000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENTRADAS')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 16.251968500000000000
          Top = 53.913420000000000000
          Width = 1882.204724410000000000
          Color = clBlack
          Diagonal = True
        end
        object Line2: TfrxLineView
          Left = 1898.324060000000000000
          Top = 53.291338580000000000
          Height = -49.889763780000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Left = 16.251968500000000000
          Top = 53.133890000000000000
          Height = -49.889763780000000000
          Color = clBlack
          Diagonal = True
        end
        object Line4: TfrxLineView
          Left = 16.251968500000000000
          Top = 3.779530000000000000
          Width = 1882.204724410000000000
          Color = clBlack
          Diagonal = True
        end
        object frxRelatorioCONTRIBUINTE: TfrxMemoView
          Left = 113.385900000000000000
          Top = 5.669291340000000000
          Width = 1080.945580000000000000
          Height = 18.897650000000000000
          DataField = 'CONTRIBUINTE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CONTRIBUINTE"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxRelatorioMESANO: TfrxMemoView
          Left = 181.417440000000000000
          Top = 30.346456690000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'MESANO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MESANO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxRelatorioDESCRICAO: TfrxMemoView
          Left = 691.653990000000000000
          Top = 30.346456690000000000
          Width = 502.677490000000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESCRICAO"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxRelatorioINSCREST: TfrxMemoView
          Left = 1360.630800000000000000
          Top = 5.669291340000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DataField = 'INSCREST'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."INSCREST"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxRelatorioALQST: TfrxMemoView
          Left = 1734.804270000000000000
          Top = 30.346456690000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'ALQST'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ALQST"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object frxRelatorioUNIDADE: TfrxMemoView
          Left = 1360.630800000000000000
          Top = 30.346456690000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataField = 'UNIDADE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."UNIDADE"]')
          ParentFont = False
          VAlign = vaBottom
        end
      end
    end
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 16
    object cdsRelatorioDATA: TStringField
      FieldName = 'DATA'
    end
    object cdsRelatorioNFCOMPRA: TStringField
      FieldName = 'NFCOMPRA'
    end
    object cdsRelatorioSERIECOMPRA: TStringField
      FieldName = 'SERIECOMPRA'
    end
    object cdsRelatorioQTDCOMPRA: TFloatField
      FieldName = 'QTDCOMPRA'
    end
    object cdsRelatorioBASESTCOMPRA: TFloatField
      FieldName = 'BASESTCOMPRA'
    end
    object cdsRelatorioNFVENDA: TStringField
      FieldName = 'NFVENDA'
    end
    object cdsRelatorioSERIEVENDA: TStringField
      FieldName = 'SERIEVENDA'
    end
    object cdsRelatorioQTDVENDA: TFloatField
      FieldName = 'QTDVENDA'
    end
    object cdsRelatorioUNITARIOVENDA: TFloatField
      FieldName = 'UNITARIOVENDA'
    end
    object cdsRelatorioSAIDACONSUMIDOR: TFloatField
      FieldName = 'SAIDACONSUMIDOR'
    end
    object cdsRelatorioFATOGERADOR: TFloatField
      FieldName = 'FATOGERADOR'
    end
    object cdsRelatorioSAIDAISENTA: TFloatField
      FieldName = 'SAIDAISENTA'
    end
    object cdsRelatorioSAIDAOUTROESTADO: TFloatField
      FieldName = 'SAIDAOUTROESTADO'
    end
    object cdsRelatorioSAIDACOMERCIALIZACAO: TFloatField
      FieldName = 'SAIDACOMERCIALIZACAO'
    end
    object cdsRelatorioQTDTOTAL: TFloatField
      FieldName = 'QTDTOTAL'
    end
    object cdsRelatorioUNITARIOTOTAL: TFloatField
      FieldName = 'UNITARIOTOTAL'
    end
    object cdsRelatorioVALORTOTAL: TFloatField
      Alignment = taCenter
      FieldName = 'VALORTOTAL'
    end
    object cdsRelatorioCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsRelatorioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object cdsRelatorioCONTRIBUINTE: TStringField
      FieldName = 'CONTRIBUINTE'
      Size = 100
    end
    object cdsRelatorioINSCREST: TStringField
      FieldName = 'INSCREST'
      Size = 30
    end
    object cdsRelatorioMESANO: TStringField
      FieldName = 'MESANO'
    end
    object cdsRelatorioALQST: TFloatField
      FieldName = 'ALQST'
    end
    object cdsRelatorioUNIDADE: TStringField
      FieldName = 'UNIDADE'
    end
  end
end
