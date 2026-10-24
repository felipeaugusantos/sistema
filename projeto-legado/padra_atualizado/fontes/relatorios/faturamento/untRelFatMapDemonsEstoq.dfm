inherited frmRelFatMapDemonsEstoq: TfrmRelFatMapDemonsEstoq
  Left = 253
  Top = 9
  Width = 391
  Height = 264
  BorderStyle = bsDialog
  Caption = 'Mapa Demonstrativo de Estoque'
  Position = poMainFormCenter
  ExplicitWidth = 391
  ExplicitHeight = 264
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 191
    Width = 385
    ExplicitTop = 191
    ExplicitWidth = 385
    inherited FlwBotoes: TFlowPanel
      Width = 381
    end
    inherited btnSair: TBitBtnLocked
      Left = 313
      Width = 67
      ExplicitLeft = 313
      ExplicitWidth = 67
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 7
      Width = 70
      ExplicitLeft = 7
      ExplicitWidth = 70
    end
    inherited btnConfigurar: TBitBtnLocked
      Width = 86
      ExplicitWidth = 86
    end
  end
  inherited pnlDados: TPanel
    Width = 385
    Height = 191
    ExplicitWidth = 385
    ExplicitHeight = 191
    object Label1: TLabel [0]
      Left = 9
      Top = 7
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
    object Label2: TLabel [1]
      Left = 104
      Top = 7
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
    object Label3: TLabel [2]
      Left = 9
      Top = 44
      Width = 75
      Height = 14
      AutoSize = False
      Caption = 'Linha / Grupo'
    end
    object Label11: TLabel [3]
      Left = 9
      Top = 81
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
      Left = 179
      Top = 123
      Width = 191
      Caption = 'Destino:'
      TabOrder = 7
      ExplicitLeft = 179
      ExplicitTop = 123
      ExplicitWidth = 191
      inherited ColorLabel1: TColorLabel
        Left = 34
        Width = 104
        Caption = '(V)'#237'deo (I)mpressora '
        ExplicitLeft = 34
        ExplicitWidth = 104
      end
      inherited edtDestino: TEditFocus
        Top = 17
        ExplicitTop = 17
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 21
      Width = 86
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
      Left = 104
      Top = 21
      Width = 88
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
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 59
      Width = 48
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 2
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 57
      Top = 59
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
      Top = 181
      Width = 383
      Height = 9
      Align = alBottom
      Smooth = True
      TabOrder = 8
      Visible = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 9
      Top = 95
      Width = 37
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
      Left = 47
      Top = 95
      Width = 323
      Height = 22
      TabStop = False
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
    object rdgLitUni: TRadioGroup
      Left = 9
      Top = 123
      Width = 164
      Height = 45
      Caption = 'Litragem / Unidade '
      Columns = 2
      Items.Strings = (
        'Litragem'
        'Unidade')
      TabOrder = 6
    end
  end
  inherited pnlStatus: TPanel
    Top = 219
    Width = 385
    ExplicitTop = 219
    ExplicitWidth = 385
    inherited pnlNomeForm: TPanel
      Left = 215
      Width = 170
      TabOrder = 1
      ExplicitLeft = 215
      ExplicitWidth = 170
    end
    inherited pnlInfo: TPanel
      Width = 215
      TabOrder = 0
      ExplicitWidth = 215
      inherited shpMultSel: TShape
        Left = 497
        Top = 2
        Visible = True
        ExplicitLeft = 497
        ExplicitTop = 2
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 8
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 656
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 480
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 448
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 416
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 384
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 352
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 288
  end
  inherited frxGen: TfrxUserDataSet
    Left = 320
  end
  inherited frxDesigner: TfrxDesigner
    Left = 544
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 576
  end
  object frxRelJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41129.617882303200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'Begin'
      'End.          ')
    Left = 256
    Top = 8
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <
      item
        Name = ' Resumo'
        Value = Null
      end
      item
        Name = 'fltQtdDia'
        Value = Null
      end
      item
        Name = 'fltQtdDoc'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetGrupo: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 39.677180000000000000
        ParentFont = False
        Top = 430.866420000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'MSDESPDOCOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo13: TfrxMemoView
          Left = 5.669291340000000000
          Width = 363.590551180000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DESGRU"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 368.889920000000000000
          Width = 129.259893780000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SALANT"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 497.984540000000000000
          Width = 86.929133860000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDCOM"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 585.134200000000000000
          Width = 86.929133860000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDOUE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 672.063390000000000000
          Width = 86.929133860000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 758.992580000000000000
          Width = 86.929133860000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDOUS"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 845.921770000000000000
          Width = 86.929133860000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."QTDCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 932.850960000000000000
          Width = 106.582677170000000000
          Height = 39.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."SALFIN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 88.881880000000000000
        ParentFont = False
        Top = 317.480520000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object rllTitDta: TfrxMemoView
          Left = 5.669291340000000000
          Width = 363.590753780000000000
          Height = 32.125984250000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Left = 368.889920000000000000
          Width = 129.259893780000000000
          Height = 32.125984250000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO EM [DTAINI]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 498.205010000000000000
          Width = 86.929133860000000000
          Height = 32.125984250000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'COMPRAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 585.134200000000000000
          Width = 86.929133860000000000
          Height = 32.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS ENTRADAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 672.063390000000000000
          Width = 86.929133860000000000
          Height = 32.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VENDAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 758.772110000000000000
          Width = 86.929133860000000000
          Height = 32.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'OUTRAS SA'#205'DAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 845.921770000000000000
          Width = 86.929133860000000000
          Height = 32.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'CONSUMO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 932.850960000000000000
          Width = 106.582677170000000000
          Height = 32.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'SALDO FINAL EM [DTAFIN]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 5.779530000000000000
          Top = 32.236240000000000000
          Width = 363.590634170000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 368.889920000000000000
          Top = 32.236240000000000000
          Width = 129.259774170000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 498.205010000000000000
          Top = 32.236240000000000000
          Width = 86.929133860000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 585.134200000000000000
          Top = 32.236240000000000000
          Width = 86.929133860000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 672.063390000000000000
          Top = 32.236240000000000000
          Width = 86.929133860000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 758.992580000000000000
          Top = 32.236240000000000000
          Width = 86.929133860000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 845.921770000000000000
          Top = 32.236240000000000000
          Width = 86.929133860000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 932.850960000000000000
          Top = 32.236240000000000000
          Width = 106.582677170000000000
          Height = 56.645640000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 45.338590000000000000
        ParentFont = False
        Top = 691.653990000000000000
        Width = 1046.929810000000000000
      end
      object PageHeader2: TfrxPageHeader
        FillType = ftBrush
        Height = 239.283550000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo27: TfrxMemoView
          Left = 5.559060000000000000
          Top = 39.133890000000000000
          Width = 475.085960000000000000
          Height = 102.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            ' Secretar'#237'a de Seguran'#231'a P'#250'blica'
            ' Departamento da Pol'#237'cia Civil'
            ' Divis'#227'o de Pol'#237'cia Especializada'
            ' Delegacia de Explosivos, Armas e Muni'#231#245'es D.E.A.M.')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 481.205010000000000000
          Top = 39.133890000000000000
          Width = 558.235620000000000000
          Height = 18.850340000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 481.205010000000000000
          Top = 58.252010000000000000
          Width = 558.235620000000000000
          Height = 83.102350000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop]
          Frame.Width = 1.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'MAPA DEMONSTRATIVO DE ESTOQUE'
            'DE COMPRAS, VENDAS E CONSUMO')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 5.559060000000000000
          Top = 140.842610000000000000
          Width = 1033.700809370000000000
          Height = 52.866110000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            ' Empresa: [frxGen."EMP_NOMEMP"], Estabelecida '#225' [ENDERECO]'
            
              ' Cidade: [CIDADE] - Estado: [ESTADO] Cep: [CEP], Fone: [FONE], C' +
              'NPJ: [CNPJ]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 5.559060000000000000
          Top = 193.976500000000000000
          Width = 1033.700809370000000000
          Height = 45.307050000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            ' Per'#237'odo: [DTAINI] a [DTAFIN]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object fotTotal: TfrxFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 136.015770000000000000
        ParentFont = False
        Top = 495.118430000000000000
        Width = 1046.929810000000000000
        object Memo24: TfrxMemoView
          Left = 5.559060000000000000
          Width = 363.590551180000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 368.669450000000000000
          Width = 129.259774170000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Left = 497.984540000000000000
          Width = 86.929133860000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 584.913730000000000000
          Width = 86.929133860000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 671.842920000000000000
          Width = 86.929133860000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 758.772110000000000000
          Width = 86.929133860000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Left = 845.701300000000000000
          Width = 86.929133860000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 932.630490000000000000
          Width = 106.582677170000000000
          Height = 136.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
end
