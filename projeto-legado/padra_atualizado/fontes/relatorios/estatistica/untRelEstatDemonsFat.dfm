inherited frmRelEstatDemonsFat: TfrmRelEstatDemonsFat
  Width = 443
  Height = 389
  Caption = 'Relat'#243'rio Demonstrativo de Faturamento'
  ExplicitWidth = 443
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 318
    Width = 437
    ExplicitTop = 318
    ExplicitWidth = 437
    inherited FlwBotoes: TFlowPanel
      Width = 356
      ExplicitWidth = 356
      inherited btnImprimir: TBitBtnLocked
        Anchors = [akLeft, akBottom]
      end
      inherited btnConfigurar: TBitBtnLocked
        Anchors = [akLeft, akBottom]
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 358
      ExplicitLeft = 358
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 437
    ExplicitTop = 344
    ExplicitWidth = 437
    inherited pnlNomeForm: TPanel
      Left = 266
      TabOrder = 1
      ExplicitLeft = 266
    end
    inherited pnlInfo: TPanel
      Width = 266
      TabOrder = 0
      ExplicitWidth = 266
    end
  end
  inherited pnlDados: TPanel
    Width = 437
    Height = 318
    ExplicitWidth = 437
    ExplicitHeight = 318
    object lbl1: TLabel [0]
      Left = 8
      Top = 8
      Width = 48
      Height = 14
      Caption = 'M'#234's / Ano'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [1]
      Left = 8
      Top = 50
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
    object lbl5: TLabel [2]
      Left = 8
      Top = 88
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
    object Label8: TLabel [3]
      Left = 8
      Top = 127
      Width = 151
      Height = 14
      Caption = 'Composi'#231#227'o do Pre'#231'o de Custo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 287
      Top = 246
      Height = 62
      TabOrder = 11
      ExplicitLeft = 287
      ExplicitTop = 246
      ExplicitHeight = 62
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 25
        ExplicitLeft = 29
        ExplicitTop = 25
      end
      inherited edtDestino: TEditFocus
        Left = 6
        Top = 21
        ExplicitLeft = 6
        ExplicitTop = 21
      end
    end
    object mskMesAno: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 49
      Height = 22
      EditMask = '99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 64
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
      Left = 52
      Top = 64
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 102
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
      TabOrder = 3
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVen: TEditFocus
      Left = 52
      Top = 102
      Width = 373
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgTipVen: TRadioGroup
      Left = 8
      Top = 246
      Width = 93
      Height = 62
      Caption = 'Tipo Vendedor'
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Interno'
        'Externo')
      TabOrder = 8
    end
    object rdgTipCal: TRadioGroup
      Left = 103
      Top = 246
      Width = 80
      Height = 62
      Caption = 'Tipo C'#225'lculo'
      ItemIndex = 0
      Items.Strings = (
        'Margem'
        'Markup')
      TabOrder = 9
      TabStop = True
    end
    object cbbComCus: TComboBoxFocus
      Tag = 99
      Left = 8
      Top = 142
      Width = 417
      Height = 22
      Style = csDropDownList
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object ckbResumoVendedor: TCheckBox
      Left = 8
      Top = 170
      Width = 281
      Height = 17
      Caption = 'Exibir resumo por Vendedor/Representante'
      TabOrder = 6
    end
    object rdgEmpresa: TRadioGroup
      Left = 184
      Top = 246
      Width = 101
      Height = 62
      Caption = 'Empresa'
      ItemIndex = 0
      Items.Strings = (
        'Faturamento'
        'Origem')
      TabOrder = 10
    end
    object rdgTipoCalculo: TRadioGroup
      Left = 8
      Top = 190
      Width = 417
      Height = 54
      Caption = 'C'#225'lculo do Objetivo/Metas'
      ItemIndex = 0
      Items.Strings = (
        'Considerar meta projetada do ano'
        'Considerar meta projetada apenas do m'#234's escolhido')
      TabOrder = 7
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 616
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
    Top = 8
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 584
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 584
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 552
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 520
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 488
    Top = 40
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 456
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = cdsDiario
    Left = 280
    Top = 16
  end
  inherited frxGen: TfrxUserDataSet
    Left = 616
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 520
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 488
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 64
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41235.433919988400000000
    ReportOptions.LastChange = 41254.558290833330000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'function fCalcPerc(fltVal1, fltVal2: Double):Double;'
      'begin'
      '  If fltVal2 > 0 Then'
      '    Result := (fltVal1 / fltVal2) * 100'
      '  Else'
      '    Result := 0;                                         '
      'end;'
      ''
      'function fCalcMarkup(fltTotVen, fltTotCus: Double): Double;'
      'begin'
      '  If TIPCAL = '#39'Margem'#39' Then'
      '  Begin'
      
        '    If fltTotVen > 0 Then                                       ' +
        '                        '
      '      Result := (1 - (fltTotCus / fltTotVen)) * 100'
      '    Else'
      
        '      Result := 0;                                              ' +
        ' '
      '  End'
      '  Else'
      '  Begin              '
      '    If fltTotCus > 0 Then'
      '      Result := ((fltTotVen / fltTotCus) -1) * 100'
      '    Else'
      '      Result := 0;'
      '  End;                          '
      'end;'
      ''
      'function fTicketMedioDoc: Double;'
      'begin'
      '  If VEN_TICKETINT + VEN_TICKETREP > 0 Then'
      
        '    Result := (VEN_VALORINT + VEN_VALORREP) / (VEN_TICKETINT + V' +
        'EN_TICKETREP)'
      '  Else'
      '    Result := 0;                                         '
      'end;'
      ''
      'function fTicketMedioCli: Double;'
      'begin'
      '  If VEN_CLIINT + VEN_CLIREP > 0 Then'
      
        '    Result := (VEN_VALORINT + VEN_VALORREP) / (VEN_CLIINT + VEN_' +
        'CLIREP)'
      '  Else'
      '    Result := 0;                                         '
      'end;    '
      ''
      'begin'
      ''
      'end.')
    Left = 344
    Top = 16
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end
      item
        DataSet = frxResumoVendedor
        DataSetName = 'frxResumoVendedor'
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
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object PageHeader: TfrxPageHeader
        Description = 
          'N'#227'o imprime na primeira p'#225'gina, pois j'#225' tem o ReportTitle para i' +
          'sso'
        FillType = ftBrush
        Height = 79.370108030000000000
        Top = 600.945270000000000000
        Width = 1046.929810000000000000
        PrintOnFirstPage = False
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 220.498115000000000000
          Top = 20.779529999999960000
          Width = 605.933580000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
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
          Left = 931.615750470000000000
          Top = 3.661410000000046000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 898.204680470000000000
          Top = 20.779529999999960000
          Width = 148.611070000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
        end
        object Memo1: TfrxMemoView
          Left = 2.800310000000000000
          Top = 37.779529999999970000
          Width = 515.754050000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 2.910545000000000000
          Top = 56.692950000000050000
          Width = 515.754050000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 525.354670000000000000
          Top = 56.692950000000050000
          Width = 519.533580000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 117.165759530000000000
          Top = 3.779530000000022000
          Width = 812.598290940000000000
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
        object Memo50: TfrxMemoView
          Left = 525.134200000000000000
          Top = 37.795300000000170000
          Width = 519.533580000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 801.260360000000000000
        Width = 1046.929810000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        object Memo135: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."STRDIA"]')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 71.811070000000000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTVEN"]')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 188.976500000000000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTCUS"]')
          ParentFont = False
        end
        object rllMup: TfrxMemoView
          Left = 306.141930000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcMarkup(<frxRelatorio."TOTVEN">, <frxRelatorio."TOTCUS">)]%')
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          Left = 366.614410000000000000
          Width = 117.165354330709000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTPER"]')
          ParentFont = False
        end
        object rllPercPerda: TfrxMemoView
          Left = 483.779840000000000000
          Width = 60.472440940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcPerc(<frxRelatorio."TOTPER">, <frxRelatorio."TOTVEN"> + <f' +
              'rxRelatorio."TOTPER">)]%')
          ParentFont = False
        end
        object Memo141: TfrxMemoView
          Left = 544.252320000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTPED"]')
          ParentFont = False
        end
        object Memo142: TfrxMemoView
          Left = 668.976810000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PEDPEN"]')
          ParentFont = False
        end
        object rllValVen: TfrxMemoView
          Left = 752.126470000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."VALVEN"]')
          ParentFont = False
        end
        object rllCMVVen: TfrxMemoView
          Left = 869.291900000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."CUSVEN"]')
          ParentFont = False
        end
        object rllMKPVen: TfrxMemoView
          Left = 982.677800000000000000
          Width = 60.472440940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            
              '[fCalcMarkup(<frxRelatorio."VALVEN">, <frxRelatorio."CUSVEN">)][' +
              'IIF(fCalcMarkup(<frxRelatorio."VALVEN">, <frxRelatorio."CUSVEN">' +
              ') > 0, '#39'%'#39', '#39#39')]')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 710.551640000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."PEDFAT"]')
          ParentFont = False
        end
      end
      object PageFooter: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1069.606990000000000000
        Width = 1046.929810000000000000
        object rllNomeForm: TfrxMemoView
          Left = 3.779530000000000000
          Width = 780.925850000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 785.235500000000000000
          Width = 261.694310000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 740.787880000000000000
        Width = 1046.929810000000000000
        PrintChildIfInvisible = True
        ReprintOnNewPage = True
        object Memo122: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Dia')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo123: TfrxMemoView
          Left = 71.811070000000000000
          Width = 117.165430000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor de Venda')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo124: TfrxMemoView
          Left = 188.976500000000000000
          Width = 117.165354330000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'C.M.V.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo125: TfrxMemoView
          Left = 306.141930000000000000
          Width = 60.472480000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPCAL] (%)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo126: TfrxMemoView
          Left = 366.614410000000000000
          Width = 117.165354330000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor de Perda')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo127: TfrxMemoView
          Left = 483.779840000000000000
          Width = 60.472440940000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Perda (%)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo128: TfrxMemoView
          Left = 544.252320000000000000
          Width = 124.724490000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor PD Aberto')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo129: TfrxMemoView
          Left = 668.976810000000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Qtd. Pedido')
          ParentFont = False
        end
        object Memo132: TfrxMemoView
          Left = 752.126470000000000000
          Width = 117.165430000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Vendedor')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo133: TfrxMemoView
          Left = 869.291900000000000000
          Width = 113.385900000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'C.M.V.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo134: TfrxMemoView
          Left = 982.677800000000000000
          Width = 60.472440940000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPCAL] (%)')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo130: TfrxMemoView
          Left = 668.976810000000000000
          Top = 18.897650000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Pend')
          ParentFont = False
        end
        object Memo131: TfrxMemoView
          Left = 710.551640000000000000
          Top = 18.897650000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Fat')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 24.338590000000000000
        Top = 842.835190000000000000
        Width = 1046.929810000000000000
        object Memo147: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haCenter
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 71.811070000000000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTVEN">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 188.976500000000000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTCUS">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 306.141930000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcMarkup(SUM(<frxRelatorio."TOTVEN">, rlbDetalhes), SUM(<frx' +
              'Relatorio."TOTCUS">, rlbDetalhes))]%')
          ParentFont = False
        end
        object Memo151: TfrxMemoView
          Left = 366.614410000000000000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTPER">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo152: TfrxMemoView
          Left = 483.779840000000000000
          Width = 60.472440940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcPerc(SUM(<frxRelatorio."TOTPER">, rlbDetalhes), SUM(<frxRe' +
              'latorio."TOTVEN">, rlbDetalhes) + SUM(<frxRelatorio."TOTPER">, r' +
              'lbDetalhes))]%')
          ParentFont = False
        end
        object Memo153: TfrxMemoView
          Left = 544.252320000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTPED">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo154: TfrxMemoView
          Left = 668.976810000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PEDPEN">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo155: TfrxMemoView
          Left = 752.126470000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALVEN">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo156: TfrxMemoView
          Left = 869.291900000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."CUSVEN">, rlbDetalhes)]')
          ParentFont = False
        end
        object Memo157: TfrxMemoView
          Left = 982.677800000000000000
          Width = 60.472440940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            
              '[fCalcMarkup(SUM(<frxRelatorio."VALVEN">, rlbDetalhes), SUM(<frx' +
              'Relatorio."CUSVEN">, rlbDetalhes))][IIF(fCalcMarkup(SUM(<frxRela' +
              'torio."VALVEN">, rlbDetalhes), SUM(<frxRelatorio."CUSVEN">, rlbD' +
              'etalhes)) > 0, '#39'%'#39','#39#39')]')
          ParentFont = False
        end
        object Memo158: TfrxMemoView
          Left = 710.551640000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."PEDFAT">, rlbDetalhes)]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 105.826840000000000000
        Top = 362.834880000000000000
        Width = 1046.929810000000000000
        Child = frxReport.ChildLitProRea
        PrintChildIfInvisible = True
        object Memo87: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 757.795263390000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Vendas')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.677180000000020000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Grupo')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 109.606370000000000000
          Top = 22.677180000000020000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Qtd. Clientes')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 260.787401574803100000
          Top = 22.677180000000020000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Venda')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 381.732283460000000000
          Top = 22.677180000000020000
          Width = 49.133850940000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            '% Fat')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 430.866141732283500000
          Top = 22.677180000000020000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor Frete')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 517.795263389999900000
          Top = 22.677180000000020000
          Width = 56.692910940000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            '% Frete')
          ParentFont = False
        end
        object Memo94: TfrxMemoView
          Left = 574.488176770000000000
          Top = 22.677180000000020000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Comiss'#227'o')
          ParentFont = False
        end
        object Memo95: TfrxMemoView
          Left = 691.653531100000000000
          Top = 22.677180000000020000
          Width = 73.700787400000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            '% Comis.')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 891.410020000000000000
          Top = 3.779530000000022000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Ticket M'#233'dio')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 7.559060000000000000
          Top = 41.574830000000020000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Interno')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 109.606370000000000000
          Top = 41.574830000000020000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_CLIINT]')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 260.787401574803100000
          Top = 41.574830000000020000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_VALORINT]')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 381.732283460000000000
          Top = 41.574830000000020000
          Width = 49.133850940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(VEN_VALORINT, VEN_VALORINT + VEN_VALORREP)]%')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 430.866141732283500000
          Top = 41.574830000000020000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_FRETEINT]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 517.795263389999900000
          Top = 41.574830000000020000
          Width = 56.692910940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(VEN_FRETEINT, VEN_VALORINT)]%')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Left = 574.488176770000000000
          Top = 41.574830000000020000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_COMINT]')
          ParentFont = False
        end
        object Memo104: TfrxMemoView
          Left = 691.653531100000000000
          Top = 41.574830000000020000
          Width = 73.700787400000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(VEN_COMINT, VEN_VALORINT)]%')
          ParentFont = False
        end
        object Memo105: TfrxMemoView
          Left = 891.410020000000000000
          Top = 41.574830000000020000
          Width = 75.590551180000000000
          Height = 56.692950000000010000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fTicketMedioDoc]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo106: TfrxMemoView
          Left = 7.559060000000000000
          Top = 60.472479999999960000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Representante')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Left = 7.559060000000000000
          Top = 79.370129999999960000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo107: TfrxMemoView
          Left = 109.606370000000000000
          Top = 60.472480000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_CLIREP]')
          ParentFont = False
        end
        object Memo108: TfrxMemoView
          Left = 260.787401574803100000
          Top = 60.472480000000010000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_VALORREP]')
          ParentFont = False
        end
        object Memo109: TfrxMemoView
          Left = 381.732283464566900000
          Top = 60.472480000000010000
          Width = 49.133850940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(VEN_VALORREP, VEN_VALORINT + VEN_VALORREP)]%')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 430.866141732283500000
          Top = 60.472480000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_FRETEREP]')
          ParentFont = False
        end
        object Memo111: TfrxMemoView
          Left = 517.795263389999900000
          Top = 60.472480000000010000
          Width = 56.692910940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(VEN_FRETEREP,VEN_VALORREP)]%')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Left = 574.488176770000000000
          Top = 60.472480000000010000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_COMREP]')
          ParentFont = False
        end
        object Memo113: TfrxMemoView
          Left = 691.653531100000000000
          Top = 60.472480000000010000
          Width = 73.700787400000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(VEN_COMREP, VEN_VALORREP)]%')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Left = 109.606370000000000000
          Top = 79.370130000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_CLIINT + VEN_CLIREP]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Left = 260.787401574803100000
          Top = 79.370130000000010000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_VALORINT + VEN_VALORREP]')
          ParentFont = False
        end
        object Memo117: TfrxMemoView
          Left = 381.732283464566900000
          Top = 79.370130000000010000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 430.866141732283500000
          Top = 79.370130000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_FRETEINT + VEN_FRETEREP]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 517.795263389999900000
          Top = 79.370130000000010000
          Width = 56.692910940000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcPerc(VEN_FRETEINT + VEN_FRETEREP, VEN_VALORINT + VEN_VALOR' +
              'REP)]%')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 574.488176770000000000
          Top = 79.370130000000010000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_COMINT + VEN_COMREP]')
          ParentFont = False
        end
        object Memo121: TfrxMemoView
          Left = 691.653531100000000000
          Top = 79.370130000000010000
          Width = 73.700787400000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcPerc(VEN_COMINT + VEN_COMREP, VEN_VALORINT + VEN_VALORREP)' +
              ']%')
          ParentFont = False
        end
        object Memo162: TfrxMemoView
          Left = 196.535560000000000000
          Top = 22.677180000000020000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Tickets')
          ParentFont = False
        end
        object Memo163: TfrxMemoView
          Left = 196.535560000000000000
          Top = 41.574830000000020000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_TICKETINT]')
          ParentFont = False
        end
        object Memo164: TfrxMemoView
          Left = 196.535560000000000000
          Top = 60.472480000000010000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_TICKETREP]')
          ParentFont = False
        end
        object Memo165: TfrxMemoView
          Left = 196.535560000000000000
          Top = 79.370130000000010000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[VEN_TICKETINT + VEN_TICKETREP]')
          ParentFont = False
        end
        object Memo166: TfrxMemoView
          Left = 967.000620000000000000
          Top = 41.574830000000020000
          Width = 75.590600000000000000
          Height = 56.692950000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fTicketMedioCli]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo167: TfrxMemoView
          Left = 891.410020000000000000
          Top = 22.677180000000020000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Por Docto.')
          ParentFont = False
        end
        object Memo168: TfrxMemoView
          Left = 967.000620000000000000
          Top = 22.677180000000020000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Por Cliente')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 772.685530000000000000
          Top = 3.779530000000022000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'M'#233'dia Doc. (Qtd)')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Left = 772.685530000000000000
          Top = 22.677180000000020000
          Width = 60.472431180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Itens')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 772.685530000000000000
          Top = 41.574830000000020000
          Width = 60.472431180000000000
          Height = 56.692950000000010000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MED_MEDQTD]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo206: TfrxMemoView
          Left = 833.007874020000000000
          Top = 22.677180000000020000
          Width = 52.913371180000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'SKU')
          ParentFont = False
        end
        object Memo207: TfrxMemoView
          Left = 833.007874020000000000
          Top = 41.574830000000020000
          Width = 52.913371180000000000
          Height = 56.692950000000010000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MED_MEDSKU]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object ChildEntSaiMer: TfrxChild
        Description = 'Imprime somente se usu'#225'rio tiver acesso.'
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 226.771800000000000000
        Width = 1046.929810000000000000
        Child = frxReport.Child1
        PrintChildIfInvisible = True
        object Memo21: TfrxMemoView
          Left = 7.559060000000000000
          Top = 11.338590000000010000
          Width = 506.457020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Entrada de Mercadoria')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 7.559060000000000000
          Top = 30.236239999999980000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Condi'#231#227'o')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 136.063080000000000000
          Top = 30.236239999999980000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 264.567100000000000000
          Top = 30.236239999999980000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Div. Compras')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 393.071120000000000000
          Top = 30.236239999999980000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'P.M.C. (Dias)')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 7.559060000000000000
          Top = 49.133890000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'A Vista')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 136.063080000000000000
          Top = 49.133890000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ENT_VISTA]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 264.567100000000000000
          Top = 49.133890000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(ENT_VISTA, ENT_VISTA + ENT_PRAZO)]%')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 393.071120000000000000
          Top = 49.133890000000040000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '0,00')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 7.559060000000000000
          Top = 68.031540000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'A Prazo')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 136.063080000000000000
          Top = 68.031540000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ENT_PRAZO]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 264.567100000000000000
          Top = 68.031540000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(ENT_PRAZO, ENT_VISTA + ENT_PRAZO)]%')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 393.071120000000000000
          Top = 68.031540000000040000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ENT_PMCPRAZO]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 7.559060000000000000
          Top = 86.929190000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 136.063080000000000000
          Top = 86.929190000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ENT_VISTA + ENT_PRAZO]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 264.567100000000000000
          Top = 86.929190000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 393.071120000000000000
          Top = 86.929190000000040000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ENT_PMCTOTAL]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 536.134199999999900000
          Top = 11.338590000000010000
          Width = 506.457020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Sa'#237'da de Mercadoria')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 536.134199999999900000
          Top = 30.236239999999980000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Condi'#231#227'o')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 664.638220000000000000
          Top = 30.236239999999980000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 793.142240000000000000
          Top = 30.236239999999980000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Div. Vendas')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 921.646260000000000000
          Top = 30.236239999999980000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'P.M.V. (Dias)')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 536.134199999999900000
          Top = 49.133890000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'A Vista')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 664.638220000000000000
          Top = 49.133890000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SAI_VISTA]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 793.142240000000000000
          Top = 49.133890000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(SAI_VISTA, SAI_VISTA + SAI_PRAZO)]%')
          ParentFont = False
        end
        object Memo70: TfrxMemoView
          Left = 921.646260000000000000
          Top = 49.133890000000040000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SAI_PMVVISTA]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 536.134199999999900000
          Top = 68.031540000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'A Prazo')
          ParentFont = False
        end
        object Memo72: TfrxMemoView
          Left = 664.638220000000000000
          Top = 68.031540000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SAI_PRAZO]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 793.142240000000000000
          Top = 68.031540000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[fCalcPerc(SAI_PRAZO, SAI_VISTA + SAI_PRAZO)]%')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Left = 921.646260000000000000
          Top = 68.031540000000040000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SAI_PMVPRAZO]')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 536.134199999999900000
          Top = 86.929190000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Left = 664.638220000000000000
          Top = 86.929190000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SAI_VISTA + SAI_PRAZO]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 793.142240000000000000
          Top = 86.929190000000040000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '100,00%')
          ParentFont = False
        end
        object Memo86: TfrxMemoView
          Left = 921.646260000000000000
          Top = 86.929190000000040000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SAI_PMVTOTAL]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        Description = 'S'#243' imprime na primeira p'#225'gina'
        FillType = ftBrush
        Height = 79.488228030000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxReport.ChildMeta
        object Memo138: TfrxMemoView
          Align = baCenter
          Left = 220.498115000000000000
          Top = 20.897650000000000000
          Width = 605.933580000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
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
        object Memo140: TfrxMemoView
          Left = 931.594970470000000000
          Top = 3.779530000000001000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo143: TfrxMemoView
          Left = 898.183900470000000000
          Top = 20.897650000000000000
          Width = 148.611070000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date] [Time]')
        end
        object Memo144: TfrxMemoView
          Left = 2.779530000000000000
          Top = 37.897650000000000000
          Width = 515.754050000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 2.889765000000000000
          Top = 56.811070000000000000
          Width = 515.754050000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo159: TfrxMemoView
          Left = 525.333890000000000000
          Top = 56.811070000000000000
          Width = 519.533580000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VENDEDOR]')
          ParentFont = False
        end
        object Memo160: TfrxMemoView
          Align = baCenter
          Left = 117.165759530000000000
          Top = 3.897649999999999000
          Width = 812.598290940000000000
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
        object Memo161: TfrxMemoView
          Left = 525.113420000000000000
          Top = 37.913420000000000000
          Width = 519.533580000000000000
          Height = 18.897628030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
        end
      end
      object ChildMeta: TfrxChild
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 120.944960000000000000
        Width = 1046.929810000000000000
        Child = frxReport.ChildEntSaiMer
        PrintChildIfInvisible = True
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779529999999994000
          Width = 411.968770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Meta M'#234's')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.677180000000010000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Objetivo')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 177.637910000000000000
          Top = 22.677180000000010000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Dias '#218'teis')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 257.008040000000000000
          Top = 22.677180000000010000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Venda Dia')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 7.559060000000000000
          Top = 41.574830000000010000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES_OBJETIVO]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 177.637910000000000000
          Top = 41.574830000000010000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[MES_DIASUTEIS]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 257.008040000000000000
          Top = 41.574830000000010000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES_OBJETIVO / MES_DIASUTEIS]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 461.102660000000000000
          Top = 3.779529999999994000
          Width = 582.047620000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Meta M'#234's')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 461.102660000000000000
          Top = 22.677180000000010000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Realizado')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 631.181510000000000000
          Top = 22.677180000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Dias Corridos')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 718.110236220000000000
          Top = 22.677180000000010000
          Width = 162.519685039370100000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'M'#233'dia Dia')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 461.102660000000000000
          Top = 41.574830000000010000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES_REALIZADO]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 631.181510000000000000
          Top = 41.574830000000010000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[MES_DIASCORRIDOS]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 718.110236220000000000
          Top = 41.574830000000010000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MES_REALIZADO / MES_DIASCORRIDOS]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 880.630490000000000000
          Top = 22.677180000000010000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Projetado')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 880.630490000000000000
          Top = 41.574830000000010000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[(MES_REALIZADO / MES_DIASCORRIDOS) * MES_DIASUTEIS]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 461.102660000000000000
          Top = 60.472480000000000000
          Width = 257.008040000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haCenter
          Memo.UTF8W = (
            'Resultado')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 718.110236220000000000
          Top = 60.472480000000000000
          Width = 162.519685039370100000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[((MES_REALIZADO / MES_DIASCORRIDOS) / (MES_OBJETIVO / MES_DIASU' +
              'TEIS)) * 100] %')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 880.630490000000000000
          Top = 60.472480000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(((MES_REALIZADO / MES_DIASCORRIDOS) * MES_DIASUTEIS) / MES_OBJ' +
              'ETIVO) * 100] %')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 37.795275590000000000
        Top = 888.189550000000000000
        Width = 1046.929810000000000000
        StartNewPage = True
        object Memo25: TfrxMemoView
          Left = 3.873530000000000000
          Width = 992.503937010000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Resumo de Vendas (Vendedor / Respresentante)')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 65.000000000000000000
          Top = 18.416820000000030000
          Width = 68.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 4.000000000000000000
          Top = 18.416820000000030000
          Width = 61.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Ven/Rep')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 133.000000000000000000
          Top = 18.416820000000030000
          Width = 306.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Nome')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 440.338590000000000000
          Top = 18.416820000000030000
          Width = 99.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Tickets')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 539.118120000000000000
          Top = 18.416820000000030000
          Width = 164.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Total Vendas ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          Left = 704.015770000000000000
          Top = 18.416820000000030000
          Width = 164.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Ticket M'#233'dio')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo66: TfrxMemoView
          Left = 869.291900000000000000
          Top = 18.519685040000010000
          Width = 126.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPCAL] (%)')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 990.236860000000000000
        Width = 1046.929810000000000000
        object Memo58: TfrxMemoView
          Left = 372.000000000000000000
          Width = 68.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haCenter
          Memo.UTF8W = (
            'Totais')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 440.338590000000000000
          Width = 99.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haCenter
          Memo.UTF8W = (
            '[SUM(<frxResumoVendedor."TICKET">, rlbResumoVendedor)]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 539.118120000000000000
          Width = 164.708720000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxResumoVendedor."TOTVEN">, rlbResumoVendedor)]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 704.015770000000000000
          Width = 164.708720000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            
              '[IIF(SUM(<frxResumoVendedor."TICKET">, rlbResumoVendedor)=0,0,SU' +
              'M(<frxResumoVendedor."TOTVEN">, rlbResumoVendedor)/SUM(<frxResum' +
              'oVendedor."TICKET">, rlbResumoVendedor))]')
          ParentFont = False
        end
        object Memo68: TfrxMemoView
          Left = 869.291900000000000000
          Width = 126.913420000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 13421772
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcMarkup(SUM(<frxResumoVendedor."TOTVEN">, rlbResumoVendedor' +
              '), SUM(<frxResumoVendedor."TOTCUS">, rlbResumoVendedor))]%')
          ParentFont = False
        end
      end
      object rlbResumoVendedor: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 948.662030000000000000
        Width = 1046.929810000000000000
        DataSet = frxResumoVendedor
        DataSetName = 'frxResumoVendedor'
        RowCount = 0
        object Memo41: TfrxMemoView
          Left = 65.000000000000000000
          Width = 68.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoVendedor."CODOPE"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 133.000000000000000000
          Width = 306.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxResumoVendedor."NOMOPE"]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 440.338590000000000000
          Width = 99.031540000000010000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoVendedor."TICKET"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 539.118120000000000000
          Width = 164.708720000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendedor."TOTVEN"]')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 704.015770000000000000
          Width = 164.708720000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxResumoVendedor."TICMED"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 4.000000000000000000
          Width = 61.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxResumoVendedor."VENREP"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 869.291900000000000000
          Width = 126.913420000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[fCalcMarkup(<frxResumoVendedor."TOTVEN">, <frxResumoVendedor."T' +
              'OTCUS">)]%')
          ParentFont = False
        end
      end
      object ChildLitProRea: TfrxChild
        FillType = ftBrush
        Height = 86.929190000000000000
        Top = 491.338900000000000000
        Width = 1046.929810000000000000
        object Memo76: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 1035.590548740000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'Litragem Projetada e Realizada')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.677182440000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'M'#234's/Ano')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 7.559060000000000000
          Top = 41.574832440000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Projetada')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 7.559060000000000000
          Top = 60.472482440000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = 15000804
          HAlign = haCenter
          Memo.UTF8W = (
            'Realizada')
          ParentFont = False
        end
        object Memo84: TfrxMemoView
          Left = 113.385900000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES1]')
          ParentFont = False
        end
        object Memo85: TfrxMemoView
          Left = 185.196970000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES2]')
          ParentFont = False
        end
        object Memo169: TfrxMemoView
          Left = 257.008040000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES3]')
          ParentFont = False
        end
        object Memo170: TfrxMemoView
          Left = 328.819110000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES4]')
          ParentFont = False
        end
        object Memo171: TfrxMemoView
          Left = 400.630180000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES5]')
          ParentFont = False
        end
        object Memo172: TfrxMemoView
          Left = 472.441250000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES6]')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 544.252320000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES7]')
          ParentFont = False
        end
        object Memo174: TfrxMemoView
          Left = 616.063390000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES8]')
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          Left = 687.874460000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES9]')
          ParentFont = False
        end
        object Memo176: TfrxMemoView
          Left = 759.685530000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES10]')
          ParentFont = False
        end
        object Memo177: TfrxMemoView
          Left = 831.496600000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES11]')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 903.307670000000000000
          Top = 22.677182440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MES12]')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 113.385900000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO1]')
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          Left = 185.196970000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO2]')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 257.008040000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO3]')
          ParentFont = False
        end
        object Memo183: TfrxMemoView
          Left = 328.819110000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO4]')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 400.630180000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO5]')
          ParentFont = False
        end
        object Memo185: TfrxMemoView
          Left = 472.441250000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO6]')
          ParentFont = False
        end
        object Memo186: TfrxMemoView
          Left = 544.252320000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO7]')
          ParentFont = False
        end
        object Memo187: TfrxMemoView
          Left = 616.063390000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO8]')
          ParentFont = False
        end
        object Memo188: TfrxMemoView
          Left = 687.874460000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO9]')
          ParentFont = False
        end
        object Memo189: TfrxMemoView
          Left = 759.685530000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO10]')
          ParentFont = False
        end
        object Memo190: TfrxMemoView
          Left = 831.496600000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO11]')
          ParentFont = False
        end
        object Memo191: TfrxMemoView
          Left = 903.307670000000000000
          Top = 41.574832440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PRO12]')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 113.385900000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA1]')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 185.196970000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA2]')
          ParentFont = False
        end
        object Memo194: TfrxMemoView
          Left = 257.008040000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA3]')
          ParentFont = False
        end
        object Memo195: TfrxMemoView
          Left = 328.819110000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA4]')
          ParentFont = False
        end
        object Memo196: TfrxMemoView
          Left = 400.630180000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA5]')
          ParentFont = False
        end
        object Memo197: TfrxMemoView
          Left = 472.441250000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA6]')
          ParentFont = False
        end
        object Memo198: TfrxMemoView
          Left = 544.252320000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA7]')
          ParentFont = False
        end
        object Memo199: TfrxMemoView
          Left = 616.063390000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA8]')
          ParentFont = False
        end
        object Memo200: TfrxMemoView
          Left = 687.874460000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA9]')
          ParentFont = False
        end
        object Memo201: TfrxMemoView
          Left = 759.685530000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA10]')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          Left = 831.496600000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA11]')
          ParentFont = False
        end
        object Memo203: TfrxMemoView
          Left = 903.307670000000000000
          Top = 60.472482440000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REA12]')
          ParentFont = False
        end
        object Memo204: TfrxMemoView
          Left = 975.118740000000000000
          Top = 41.574832440000000000
          Width = 68.031493620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_PROTOT]')
          ParentFont = False
        end
        object Memo205: TfrxMemoView
          Left = 975.118740000000000000
          Top = 60.472482440000000000
          Width = 68.031493620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_REATOT]')
          ParentFont = False
        end
        object Memo179: TfrxMemoView
          Left = 975.118740000000000000
          Top = 22.677182440000000000
          Width = 68.031493620000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[MET_MESTOT]')
          ParentFont = False
        end
      end
    end
  end
  object cdsDiario: TUniClientDataSet
    Aggregates = <
      item
        Visible = False
      end>
    IndexFieldNames = 'INTDIA'
    Params = <>
    Left = 312
    Top = 16
    object cdsDiarioINTDIA: TIntegerField
      FieldName = 'INTDIA'
      LookupCache = True
    end
    object cdsDiarioSTRDIA: TStringField
      FieldName = 'STRDIA'
      Size = 6
    end
    object cdsDiarioTOTVEN: TFloatField
      FieldName = 'TOTVEN'
    end
    object cdsDiarioTOTCUS: TFloatField
      FieldName = 'TOTCUS'
    end
    object cdsDiarioTOTPER: TFloatField
      FieldName = 'TOTPER'
    end
    object cdsDiarioTOTPED: TFloatField
      FieldName = 'TOTPED'
    end
    object cdsDiarioPEDPEN: TIntegerField
      FieldName = 'PEDPEN'
    end
    object cdsDiarioPEDFAT: TIntegerField
      FieldName = 'PEDFAT'
    end
    object cdsDiarioVALVEN: TFloatField
      FieldName = 'VALVEN'
    end
    object cdsDiarioCUSVEN: TFloatField
      FieldName = 'CUSVEN'
    end
  end
  object frxResumoVendedor: TfrxDBDataset
    Description = 'Resumo por Vendedores'
    UserName = 'frxResumoVendedor'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 352
    Top = 72
  end
  object cdsMeta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 329
    Top = 164
    object cdsMetaINDEX: TIntegerField
      FieldName = 'INDEX'
    end
    object cdsMetaDIAUTI: TFloatField
      DisplayLabel = 'Dias '#218'teis'
      FieldName = 'DIAUTI'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaMESANO: TStringField
      DisplayLabel = 'M'#234's/Ano'
      FieldName = 'MESANO'
      Size = 8
    end
    object cdsMetaMETDIA: TFloatField
      DisplayLabel = 'Meta Diaria Proj.'
      FieldName = 'METDIA'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaMETPRO: TFloatField
      DisplayLabel = 'Meta Projetada'
      FieldName = 'METPRO'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaMETREA: TFloatField
      DisplayLabel = 'Meta Realizada'
      FieldName = 'METREA'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaRESULT: TFloatField
      DisplayLabel = 'Resultado'
      FieldName = 'RESULT'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaMARMES: TFloatField
      FieldName = 'MARMES'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaMARREA: TFloatField
      FieldName = 'MARREA'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaLITPRO: TFloatField
      FieldName = 'LITPRO'
      DisplayFormat = '#,##0.00'
    end
    object cdsMetaLITREA: TFloatField
      FieldName = 'LITREA'
      DisplayFormat = '#,##0.00'
    end
  end
end
