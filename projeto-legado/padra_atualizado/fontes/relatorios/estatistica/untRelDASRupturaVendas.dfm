inherited frmRelDASRupturaVendas: TfrmRelDASRupturaVendas
  Left = 540
  Top = 284
  Width = 346
  Height = 272
  ActiveControl = mskDtaIni
  Caption = 'Relat'#243'rio de Ruptura de Vendas'
  ExplicitWidth = 346
  ExplicitHeight = 272
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 203
    Width = 340
    ExplicitTop = 200
    ExplicitWidth = 340
    inherited btnSair: TBitBtnLocked
      Left = 257
      ExplicitLeft = 257
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 80
      Width = 81
      ExplicitLeft = 80
      ExplicitWidth = 81
    end
  end
  inherited pnlStatus: TPanel
    Top = 231
    Width = 340
    ExplicitTop = 228
    ExplicitWidth = 340
    inherited pnlNomeForm: TPanel
      Left = 169
      ExplicitLeft = 169
    end
    inherited pnlInfo: TPanel
      Width = 169
      ExplicitWidth = 169
    end
  end
  inherited pnlDados: TPanel
    Width = 340
    Height = 203
    ExplicitWidth = 340
    ExplicitHeight = 200
    object Label5: TLabel [0]
      Left = 8
      Top = 10
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
    object Label7: TLabel [1]
      Left = 96
      Top = 32
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [2]
      Left = 96
      Top = 72
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [3]
      Left = 8
      Top = 50
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
    object lblEmpresa: TLabel [4]
      Left = 8
      Top = 90
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
    inherited gpbDestino: TGroupBox
      Left = 184
      Top = 136
      Width = 145
      Height = 48
      TabOrder = 5
      ExplicitLeft = 184
      ExplicitTop = 136
      ExplicitWidth = 145
      ExplicitHeight = 48
      inherited ColorLabel1: TColorLabel
        Top = 21
        ExplicitTop = 21
      end
      inherited edtDestino: TEditFocus
        Top = 17
        ExplicitTop = 17
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 24
      Width = 77
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Top = 64
      Width = 78
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object gpbClientes: TGroupBox
      Left = 8
      Top = 136
      Width = 169
      Height = 48
      Caption = 'Clientes:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 21
        Width = 128
        Height = 14
        Caption = '(A)tivos (I)nativos (T)odos'
        CorDestaque = clRed
      end
      object edtClientes: TEditFocus
        Tag = 99
        Left = 7
        Top = 17
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object edtDesEmpresa: TEditFocus
      Left = 54
      Top = 104
      Width = 275
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 104
      Width = 45
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
      TabOrder = 2
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 648
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 240
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 712
    Top = 240
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 776
    Top = 88
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 712
    Top = 136
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 776
    Top = 136
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 712
    Top = 184
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 776
    Top = 184
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 584
    Top = 136
  end
  inherited frxGen: TfrxUserDataSet
    Left = 648
    Top = 136
  end
  inherited frxDesigner: TfrxDesigner
    Left = 648
    Top = 184
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 584
    Top = 88
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40366.662021296300000000
    ReportOptions.LastChange = 40371.732079895830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 208
    Top = 32
    Datasets = <
      item
        DataSet = frxGen
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
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object rllNomeEmpresa: TfrxMemoView
          Left = 11.338582680000000000
          Top = 7.559059999999999000
          Width = 1058.267716540000000000
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
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Left = 11.338590000000000000
          Top = 25.559060000000000000
          Width = 885.921150000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 903.080210000000000000
          Top = 25.559060000000000000
          Width = 169.020470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 985.700680000000000000
          Top = 44.559060000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 11.338590000000000000
          Top = 44.559060000000000000
          Width = 979.880210000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object rllEmpCab: TfrxMemoView
          Left = 11.338582680000000000
          Top = 66.267633540000000000
          Width = 1058.267716540000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRES]')
          ParentFont = False
        end
        object rllPeriodo: TfrxMemoView
          Left = 11.338590000000000000
          Top = 80.929190000000000000
          Width = 1058.267716540000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Top = 98.267780000000010000
          Width = 1084.725110000000000000
          Height = 24.566929130000000000
          Fill.BackColor = clSilver
        end
        object Memo1: TfrxMemoView
          Left = 3.023619610000000000
          Top = 106.157541340000000000
          Width = 271.370215430000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 279.685061340000000000
          Top = 106.204787870000000000
          Width = 109.606260160000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REGIAO')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 400.630021340000000000
          Top = 99.779583700000000000
          Width = 68.031496060000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DA')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 400.629808980000000000
          Top = 111.118173700000000000
          Width = 68.031496060000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ULT. COMPRA')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 472.440979060000000000
          Top = 106.204787870000000000
          Width = 139.842500160000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 616.063119060000000000
          Top = 106.204787870000000000
          Width = 132.283506060000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ATIVIDADE')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 752.126470000000000000
          Top = 99.779583700000010000
          Width = 83.149616060000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ATUALIZACAO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 752.126470000000000000
          Top = 111.118181020000000000
          Width = 83.149606300000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DE CADASTRO')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 839.055660000000000000
          Top = 99.779583700000010000
          Width = 83.149606300000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IDENTIFICACAO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 839.055660000000000000
          Top = 111.118181020000000000
          Width = 83.149550160000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DE MOTIVOS')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 925.984850000000000000
          Top = 106.204787870000000000
          Width = 83.149616060000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ACAO CORRETIVA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 1012.913827640000000000
          Top = 106.204787870000000000
          Width = 68.031496060000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REATIVACAO')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxHeader
        FillType = ftBrush
        Height = 3.779529999999999000
        Top = 204.094620000000000000
        Width = 1084.725110000000000000
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 230.551330000000000000
        Width = 1084.725110000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.000000000000000000
          Width = 272.126160000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GER_CODCLI"]-[frxRelatorio."GER_NOMCON"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 279.685220000000000000
          Top = 2.000000000000000000
          Width = 109.606326060000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."REG_DESREG"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 472.441250000000000000
          Top = 2.000000000000000000
          Width = 139.842566060000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 400.630180000000000000
          Top = 2.000000000000000000
          Width = 68.031496060000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."GER_VLRCON"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 616.063390000000000000
          Top = 2.000000000000000000
          Width = 132.283506060000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ATI_DESATI"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 306.141930000000000000
        Width = 1084.725110000000000000
        object rllNomeForm: TfrxMemoView
          Left = 2.040940000000000000
          Top = 5.000000000000000000
          Width = 754.318120000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 627.234570000000000000
          Top = 5.000000000000000000
          Width = 451.804700000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorioM: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40366.662021296300000000
    ReportOptions.LastChange = 40371.739823310180000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 280
    Top = 32
    Datasets = <
      item
        DataSet = frxGen
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
    object Page1: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.199999985190000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1324.800000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllEmpCab: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[EMPRES]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPeriodo: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 1488.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo2: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 119.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'REGIAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo3: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DA')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo4: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'ULT. COMPRA')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo5: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 119.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'VENDEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo6: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 119.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'ATIVIDADE')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo7: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'ATUALIZACAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo8: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DE CADASTRO')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo9: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'IDENTIFICACAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo16: TfrxDMPMemoView
          Left = 1104.000000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'DE MOTIVOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo17: TfrxDMPMemoView
          Left = 1238.400000000000000000
          Top = 119.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'ACAO CORRETIVA')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo18: TfrxDMPMemoView
          Left = 1392.000000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'REATIVACAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#77'
        end
      end
      object rlbCabecalho: TfrxHeader
        FillType = ftBrush
        Top = 221.000000000000000000
        Width = 1507.199999985190000000
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1507.199999985190000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo10: TfrxDMPMemoView
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."GER_CODCLI"]-[frxRelatorio."GER_NOMCON"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo11: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."REG_DESREG"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo12: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo13: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."GER_VLRCON"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo14: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."ATI_DESATI"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 289.000000000000000000
        Width = 1507.199999985190000000
        object rllNomeForm: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 1056.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1046.400000000000000000
          Top = 17.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
end
