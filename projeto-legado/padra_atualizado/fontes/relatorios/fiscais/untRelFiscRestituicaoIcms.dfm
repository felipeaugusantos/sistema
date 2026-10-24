inherited frmRelFiscRestituicaoIcms: TfrmRelFiscRestituicaoIcms
  Width = 501
  Height = 325
  Caption = 
    'Restitui'#231#227'o de ICMS e ICMS ST decorrente de vendas para outros e' +
    'stados'
  OnDestroy = FormDestroy
  ExplicitWidth = 501
  ExplicitHeight = 325
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 254
    Width = 495
    ExplicitTop = 254
    ExplicitWidth = 495
    inherited FlwBotoes: TFlowPanel
      Width = 414
      Align = alLeft
      ExplicitWidth = 414
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
        OnClick = btnDeletarPeriodoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 416
    end
  end
  inherited pnlDados: TPanel
    Width = 495
    Height = 246
    ExplicitWidth = 495
    ExplicitHeight = 246
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
      Top = 20
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
      Top = 56
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
      Top = 156
      Width = 42
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = 'Empresa'
      ParentBiDiMode = False
    end
    object Label3: TLabel [5]
      Left = 8
      Top = 77
      Width = 54
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = 'Documento'
      ParentBiDiMode = False
    end
    object lblCodCla: TLabel [6]
      Left = 8
      Top = 116
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Class. Fiscal'
    end
    inherited gpbDestino: TGroupBox
      Left = 8
      Top = 193
      TabOrder = 7
      ExplicitLeft = 8
      ExplicitTop = 193
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
      Top = 170
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 74
      Top = 170
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDocumento: TEditFocus
      Tag = 99
      Left = 8
      Top = 91
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodClaFis: TEditFocus
      Tag = 99
      Left = 8
      Top = 130
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 4
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesClaFis: TEditFocus
      Left = 74
      Top = 130
      Width = 341
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
  end
  inherited pnlStatus: TPanel
    Top = 280
    Width = 495
    ExplicitTop = 280
    ExplicitWidth = 495
    inherited pnlNomeForm: TPanel
      Left = 324
      ExplicitLeft = 324
    end
    inherited pnlInfo: TPanel
      Width = 324
      ExplicitWidth = 324
    end
  end
  object pgbProgresso: TProgressBar [4]
    Left = 0
    Top = 246
    Width = 495
    Height = 8
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 816
    Top = 56
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 784
    Top = 56
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 1040
    Top = 56
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 1008
    Top = 56
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 976
    Top = 56
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 944
    Top = 56
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 912
    Top = 56
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 848
    Top = 56
  end
  inherited frxGen: TfrxUserDataSet
    Left = 880
    Top = 56
  end
  inherited frxDesigner: TfrxDesigner
    Left = 1104
    Top = 56
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 1136
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1168
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 1072
    Top = 56
  end
  object frxDBDataset1: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxDataSetCompras'
    CloseDataSource = False
    DataSet = cdsRestituicaoIcmsSt
    BCDToCurrency = False
    Left = 312
    Top = 16
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43067.452888611100000000
    ReportOptions.LastChange = 43068.633799664300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 280
    Top = 16
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDataSetCompras'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 411.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 88.763760000000000000
        Top = 18.897650000000000000
        Width = 1477.796230000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 315.704485000000000000
          Top = 4.000000000000000000
          Width = 846.387260000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
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
          Left = 364.120255000000000000
          Top = 21.000000000000000000
          Width = 749.555720000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1364.700990000000000000
          Top = 28.559060000000000000
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
          Left = 1414.219110000000000000
          Top = 53.118120000000000000
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
          Left = 1268.700990000000000000
          Top = 53.118120000000000000
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
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 403.540725000000000000
          Top = 57.574830000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Align = baCenter
          Left = 403.540725000000000000
          Top = 73.692950000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CLAFIS]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Align = baCenter
          Left = 403.540725000000000000
          Top = 42.574830000000000000
          Width = 670.714780000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[REFERE]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.023622050000000000
        Top = 170.078850000000000000
        Width = 1477.796230000000000000
        object Memo1: TfrxMemoView
          Left = 5.559060000000000000
          Top = 26.456710000000000000
          Width = 255.118110236220500000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo2: TfrxMemoView
          Left = 5.559060000000000000
          Top = 6.779530000000000000
          Width = 1226.456653860000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Origem do Cr'#233'dito')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 267.905690000000000000
          Top = 26.456710000000000000
          Width = 255.118110236220500000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo4: TfrxMemoView
          Left = 526.244070080000000000
          Top = 26.456710000000000000
          Width = 73.700787400000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo5: TfrxMemoView
          Left = 607.134200000000000000
          Top = 26.456710000000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UF')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo6: TfrxMemoView
          Left = 636.370440000000000000
          Top = 26.456710000000000000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. Compra')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo7: TfrxMemoView
          Left = 739.417750000000000000
          Top = 26.456710000000000000
          Width = 96.000000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'BC. ST unit.')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo8: TfrxMemoView
          Left = 842.465060000000000000
          Top = 26.456710000000000000
          Width = 61.984230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo9: TfrxMemoView
          Left = 911.189550000000100000
          Top = 26.456710000000000000
          Width = 84.661410000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'BC. ST Total')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo10: TfrxMemoView
          Left = 1001.898270000000000000
          Top = 26.456710000000000000
          Width = 61.984230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Aliq. Interna')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo12: TfrxMemoView
          Left = 1070.929810000000000000
          Top = 26.456710000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vlr. ST Retido')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo13: TfrxMemoView
          Left = 1154.079470000000000000
          Top = 26.456710000000000000
          Width = 79.370081180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ICMS Pr'#243'prio')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo14: TfrxMemoView
          Left = 1238.307030470000000000
          Top = 6.779530000000000000
          Width = 229.795334170000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Origem do D'#233'bito')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 1325.244900000000000000
          Top = 26.456710000000000000
          Width = 61.984230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Left = 1393.276440000000000000
          Top = 26.346456690000000000
          Width = 75.590553620000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Documento')
          ParentFont = False
          VAlign = vaBottom
        end
        object Line1: TfrxLineView
          Left = 3.559060000000000000
          Top = 25.456710000000000000
          Width = 1469.480314960630000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 3.338590000000000000
          Top = 47.133890000000000000
          Width = 1469.480314960630000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line3: TfrxLineView
          Left = 264.567100000000000000
          Top = 25.700787401574800000
          Height = 21.165354330000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Left = 524.354670000000100000
          Top = 25.590551180000000000
          Height = 20.787401574803150000
          Color = clBlack
          Diagonal = True
        end
        object Line6: TfrxLineView
          Left = 603.724800000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line7: TfrxLineView
          Left = 633.961040000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line8: TfrxLineView
          Left = 736.008350000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line9: TfrxLineView
          Left = 839.055660000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line10: TfrxLineView
          Left = 907.866730000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line11: TfrxLineView
          Left = 998.575450000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line12: TfrxLineView
          Left = 1067.606990000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line13: TfrxLineView
          Left = 1150.756650000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line14: TfrxLineView
          Left = 1234.906310000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line15: TfrxLineView
          Left = 1389.867040000000000000
          Top = 25.590551180000000000
          Height = 20.787401574803100000
          Color = clBlack
          Diagonal = True
        end
        object Line16: TfrxLineView
          Left = 1234.906310000000000000
          Top = 2.779530000000000000
          Height = 22.677165350000000000
          Color = clBlack
          Diagonal = True
        end
        object Line17: TfrxLineView
          Left = 1473.016700000000000000
          Top = 2.913385830000000000
          Height = 44.598425200000000000
          Color = clBlack
          Diagonal = True
        end
        object Line18: TfrxLineView
          Left = 3.338590000000000000
          Top = 2.779530000000000000
          Width = 1469.480314960000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line19: TfrxLineView
          Left = 2.779530000000000000
          Top = 2.779530000000000000
          Height = 44.598425200000000000
          Color = clBlack
          Diagonal = True
        end
        object Line21: TfrxLineView
          Left = 1322.835500000000000000
          Top = 26.456710000000000000
          Height = 20.787401570000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo25: TfrxMemoView
          Left = 1235.906310000000000000
          Top = 26.456710000000000000
          Width = 83.149611180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ST Retida Prop.')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 13.228346460000000000
        Top = 291.023810000000000000
        Width = 1477.796230000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDataSetCompras'
        RowCount = 0
        object frxDataSetComprasPRODUTO: TfrxMemoView
          Left = 5.669291340000000000
          Width = 255.118110236220500000
          Height = 13.228346456692910000
          DataField = 'PRODUTO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCompras."PRODUTO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasFORNECEDOR: TfrxMemoView
          Left = 267.968491730000000000
          Width = 255.118110236220500000
          Height = 13.228346456692910000
          DataField = 'FORNECEDOR'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCompras."FORNECEDOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasDOCUMENTO_E: TfrxMemoView
          Left = 526.110211810000000000
          Width = 73.700787400000000000
          Height = 13.228346456692910000
          DataField = 'DOCUMENTO_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCompras."DOCUMENTO_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasUF_FORNECEDOR: TfrxMemoView
          Left = 606.992101570000000000
          Width = 22.677165350000000000
          Height = 13.228346456692910000
          DataField = 'UF_FORNECEDOR'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCompras."UF_FORNECEDOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasVLR_E: TfrxMemoView
          Left = 636.472416540000000000
          Width = 96.000000000000000000
          Height = 13.228346456692910000
          DataField = 'VLR_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."VLR_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasBC_ST_UNIT_E: TfrxMemoView
          Left = 739.275566140000000000
          Width = 96.000000000000000000
          Height = 13.228346456692910000
          DataField = 'BC_ST_UNIT_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."BC_ST_UNIT_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasQTD_E: TfrxMemoView
          Left = 842.456668500000000000
          Width = 61.984251970000000000
          Height = 13.228346456692910000
          DataField = 'QTD_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."QTD_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasBC_ST_TOTAL_E: TfrxMemoView
          Left = 915.023600080000100000
          Width = 84.661417322834640000
          Height = 13.228346456692910000
          DataField = 'BC_ST_TOTAL_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."BC_ST_TOTAL_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasALIQ_INTERNA_E: TfrxMemoView
          Left = 1005.732254170000000000
          Width = 61.984251970000000000
          Height = 13.228346456692910000
          DataField = 'ALIQ_INTERNA_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."ALIQ_INTERNA_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasCRED_ST_E: TfrxMemoView
          Left = 1074.897608500000000000
          Width = 75.590551180000010000
          Height = 13.228346456692910000
          DataField = 'CRED_ST_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."CRED_ST_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasCRED_ICM_E: TfrxMemoView
          Left = 1154.267672600000000000
          Width = 79.370081180000000000
          Height = 13.228346456692910000
          DataField = 'CRED_ICM_E'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."CRED_ICM_E"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasQTD_V: TfrxMemoView
          Left = 1325.102362200000000000
          Width = 61.984251970000000000
          Height = 13.228346456692910000
          DataField = 'QTD_V'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetCompras."QTD_V"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object frxDataSetComprasDOCUMENTO_V: TfrxMemoView
          Left = 1393.133858270000000000
          Width = 75.590551180000000000
          Height = 13.228346456692910000
          DataField = 'DOCUMENTO_V'
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCompras."DOCUMENTO_V"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Memo26: TfrxMemoView
          Left = 1239.685840000000000000
          Width = 75.590551180000010000
          Height = 13.228346460000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(<frxDataSetCompras."CRED_ST_E"> * <frxDataSetCompras."QTD_V">)' +
              ']')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
      end
      object grpDocumentosVenda: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 245.669450000000000000
        Visible = False
        Width = 1477.796230000000000000
        Condition = 'frxDataSetCompras."DOCUMENTO_V"'
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 23.456710000000000000
        Top = 328.819110000000000000
        Width = 1477.796230000000000000
        object Memo17: TfrxMemoView
          Left = 771.024120000000000000
          Top = 6.338590000000010000
          Width = 272.126160000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOCUMENTO:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo20: TfrxMemoView
          Left = 1074.897608500000000000
          Top = 6.338590000000010000
          Width = 75.590551180000010000
          Height = 13.228346456692910000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataSetCompras."CRED_ST_E">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Memo21: TfrxMemoView
          Left = 1154.267672600000000000
          Top = 6.338590000000010000
          Width = 79.370078740000000000
          Height = 13.228346456692910000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataSetCompras."CRED_ICM_E">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Line4: TfrxLineView
          Left = 3.779530000000000000
          Width = 1469.480314960630000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo27: TfrxMemoView
          Left = 1239.685039370000000000
          Top = 6.559059999999988000
          Width = 75.590551180000000000
          Height = 13.228346460000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDataSetCompras."CRED_ST_E">*<frxDataSetCompras."QTD_V">' +
              ', rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 37.464586460000000000
        Top = 374.173470000000000000
        Width = 1477.796230000000000000
        object Memo18: TfrxMemoView
          Left = 771.402075200000000000
          Top = 5.338590000000000000
          Width = 272.126160000000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo19: TfrxMemoView
          Left = 1074.897637795276000000
          Top = 5.338590000000000000
          Width = 75.590551180000010000
          Height = 13.228346460000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataSetCompras."CRED_ST_E">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Memo22: TfrxMemoView
          Left = 1154.267716540000000000
          Top = 5.338590000000000000
          Width = 79.370078740000000000
          Height = 13.228346460000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataSetCompras."CRED_ICM_E">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
        object Line20: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 1469.480314960000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          Left = 771.024120000000000000
          Top = 22.677180000000000000
          Width = 272.126160000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL IMPOSTO CREDITAR:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo24: TfrxMemoView
          Left = 1074.897608500000000000
          Top = 22.677180000000000000
          Width = 75.590551180000010000
          Height = 13.228346460000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDataSetCompras."CRED_ST_E">, rlbDetalhes) + SUM(<frxDat' +
              'aSetCompras."CRED_ICM_E">, rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
          Formats = <
            item
              DecimalSeparator = ','
              FormatStr = '%2.2f'
              Kind = fkNumeric
            end
            item
            end>
        end
        object Memo28: TfrxMemoView
          Left = 1239.685840000000000000
          Top = 5.291338582677156000
          Width = 75.590551180000010000
          Height = 13.228346460000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDataSetCompras'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxDataSetCompras."CRED_ST_E">*<frxDataSetCompras."QTD_V">' +
              ', rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
          VAlign = vaBottom
        end
      end
    end
  end
  object cdsRestituicaoIcmsSt: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 16
    object cdsRestituicaoIcmsStPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 100
    end
    object cdsRestituicaoIcmsStFORNECEDOR: TStringField
      FieldName = 'FORNECEDOR'
      Size = 100
    end
    object cdsRestituicaoIcmsStDOCUMENTO_E: TStringField
      FieldName = 'DOCUMENTO_E'
    end
    object cdsRestituicaoIcmsStUF_FORNECEDOR: TStringField
      FieldName = 'UF_FORNECEDOR'
    end
    object cdsRestituicaoIcmsStVLR_E: TFloatField
      FieldName = 'VLR_E'
    end
    object cdsRestituicaoIcmsStBC_ST_UNIT_E: TFloatField
      FieldName = 'BC_ST_UNIT_E'
    end
    object cdsRestituicaoIcmsStQTD_E: TFloatField
      FieldName = 'QTD_E'
    end
    object cdsRestituicaoIcmsStBC_ST_TOTAL_E: TFloatField
      FieldName = 'BC_ST_TOTAL_E'
    end
    object cdsRestituicaoIcmsStALIQ_INTERNA_E: TFloatField
      FieldName = 'ALIQ_INTERNA_E'
    end
    object cdsRestituicaoIcmsStCRED_ST_E: TFloatField
      FieldName = 'CRED_ST_E'
    end
    object cdsRestituicaoIcmsStCRED_ICM_E: TFloatField
      FieldName = 'CRED_ICM_E'
    end
    object cdsRestituicaoIcmsStQTD_V: TFloatField
      FieldName = 'QTD_V'
    end
    object cdsRestituicaoIcmsStDOCUMENTO_V: TStringField
      FieldName = 'DOCUMENTO_V'
    end
    object cdsRestituicaoIcmsStINCCOM: TStringField
      FieldName = 'INCCOM'
    end
    object cdsRestituicaoIcmsStQTD_UTILIZADA_E: TFloatField
      FieldName = 'QTD_UTILIZADA_E'
    end
    object cdsRestituicaoIcmsStINCVEN: TStringField
      FieldName = 'INCVEN'
    end
  end
end
