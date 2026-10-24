inherited frmRelPedVerbas: TfrmRelPedVerbas
  Left = 378
  Top = 144
  Width = 346
  Height = 456
  Caption = 'Relat'#243'rio de Verbas'
  ExplicitWidth = 346
  ExplicitHeight = 456
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 384
    Width = 340
    TabOrder = 3
    ExplicitTop = 384
    ExplicitWidth = 340
    inherited btnSair: TBitBtnLocked
      Left = 259
      ExplicitLeft = 259
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 7
      ExplicitLeft = 7
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 83
      ExplicitLeft = 83
    end
  end
  inherited pnlDados: TPanel
    Top = 77
    Width = 340
    Height = 307
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 77
    ExplicitWidth = 340
    ExplicitHeight = 307
    object lblEmpresa: TLabel [0]
      Left = 11
      Top = 146
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
    object Label2: TLabel [1]
      Left = 11
      Top = 34
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
    object lblNumLot: TLabel [2]
      Left = 11
      Top = 0
      Width = 93
      Height = 14
      Caption = 'Fornecedor do Item'
    end
    object Label4: TLabel [3]
      Left = 11
      Top = 109
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
    object lblRegiao: TLabel [4]
      Left = 11
      Top = 72
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Supervisor'
    end
    inherited gpbDestino: TGroupBox
      Left = 11
      Top = 248
      Width = 156
      Height = 52
      TabOrder = 12
      ExplicitLeft = 11
      ExplicitTop = 248
      ExplicitWidth = 156
      ExplicitHeight = 52
    end
    object edtNomEmp: TEditFocus
      Left = 44
      Top = 160
      Width = 281
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 9
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
      Left = 11
      Top = 123
      Width = 32
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
      TabOrder = 6
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
    object edtNomVen: TEditFocus
      Left = 44
      Top = 123
      Width = 281
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 11
      Top = 48
      Width = 57
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 70
      Top = 48
      Width = 256
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 11
      Top = 160
      Width = 32
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
      TabOrder = 8
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
    object edtNomFor: TEditFocus
      Left = 70
      Top = 13
      Width = 256
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 11
      Top = 13
      Width = 57
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
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object rdgTipPed: TRadioGroup
      Left = 11
      Top = 185
      Width = 313
      Height = 39
      Caption = 'Pedidos'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Faturados'
        'N'#227'o Faturados')
      TabOrder = 10
    end
    object edtCodSup: TEditFocus
      Tag = 99
      Left = 11
      Top = 86
      Width = 32
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 4
      OnExit = edtCodSupExit
      OnKeyPress = edtCodSupKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomSup: TEditFocus
      Left = 44
      Top = 86
      Width = 281
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object chkUtiVba: TCheckBox
      Left = 11
      Top = 229
      Width = 310
      Height = 17
      Caption = 'Exibir somente pedidos com utiliza'#231#227'o de verba.'
      TabOrder = 11
    end
  end
  object pnlData: TPanel [3]
    Left = 0
    Top = 0
    Width = 340
    Height = 77
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object Label5: TLabel
      Left = 11
      Top = 2
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
    object Label6: TLabel
      Left = 11
      Top = 39
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
    object lbl1: TLabel
      Left = 91
      Top = 34
      Width = 123
      Height = 14
      Caption = '(CADASTRO DE VERBA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 11
      Top = 16
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
      Left = 11
      Top = 51
      Width = 66
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
  inherited pnlStatus: TPanel
    Top = 412
    Width = 340
    TabOrder = 2
    ExplicitTop = 412
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 144
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 424
    Top = 144
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 384
    Top = 72
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 424
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 384
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 424
    Top = 104
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 384
    Top = 104
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 384
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 424
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 424
    Top = 176
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 424
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 176
  end
  object frxVerbasJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 0.900000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42261.501791574070000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltTotVba : Double;'
      '  fltTotVbaFor : Double;'
      '  fltTotVbaCli : Double;'
      '  fltTotVbaDta : Double;'
      
        '  fltTotVbaVen : Double;                                        ' +
        '          '
      '  Quebra: Integer;                                        '
      ''
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := '#39'PAGINA: '#39' + rllPagina.Text;     ' +
        '                                                           '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxMemoView(Sender).Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTota' +
        'lImpresso.Text;                                                 ' +
        '                   '
      'end;'
      ''
      'procedure rllVbaSolForOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxRelatorio."VBASOL"> <> 0 Then'
      '  Begin              '
      '    fltTotVbaFor := fltTotVbaFor + <frxRelatorio."VBASOL">;'
      '    fltTotVba := fltTotVba + <frxRelatorio."VBASOL">;'
      '    fltTotVbaDta := fltTotVbaDta + fltTotVbaFor;'
      '    fltTotVbaCli := fltTotVbaCli + fltTotVbaFor;'
      '    fltTotVbaVen := fltTotVbaVen + fltTotVbaFor;        '
      '  End;  '
      'end;'
      ''
      'procedure rllZebra2OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  Quebra := Quebra + 1;  '
      'end;'
      ''
      'procedure GroupHeaderFornecOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  Quebra := 0;                       '
      '  fltTotVbaFor := 0;'
      'end;'
      ''
      'procedure GroupHeaderDtaEmiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotVbaDta := 0;  '
      'end;'
      ''
      'procedure GroupHeaderClientOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotVbaCli := 0;  '
      'end;'
      ''
      'procedure GroupHeaderVendedOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  fltTotVbaVen := 0;  '
      'end;'
      ''
      'begin'
      '  fltTotVba := 0;'
      '  fltTotVbaFor := 0;'
      '  fltTotVbaCli := 0;'
      '  fltTotVbaDta := 0;'
      '  fltTotVbaVen := 0;'
      '  Quebra := 0;                    '
      'end.')
    Left = 232
    Top = 56
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
      end
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 4.500000000000000000
      RightMargin = 4.500000000000000000
      TopMargin = 2.500000000000000000
      BottomMargin = 2.500000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 445.984540000000000000
        Width = 759.685530000000000000
        Child = frxVerbasJ.Child1
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Align = baClient
          Width = 759.685530000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllZebraOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Quebra> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo15: TfrxMemoView
          Left = 180.118120000000000000
          Width = 374.173379690000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ITEM: [(<frxRelatorio."PRODUT">)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo16: TfrxMemoView
          Left = 841.324180000000000000
          Width = 96.377952755905500000
          Height = 17.000000000000000000
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
            '[frxRelatorio."VBASOL"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo24: TfrxMemoView
          Left = 940.062933539999000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."PERVBA"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo86: TfrxMemoView
          Left = 4.409429290000000000
          Width = 162.519731420000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO: [(<frxRelatorio."DOCUME">)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 22.661410000000000000
        Top = 774.803650000000000000
        Width = 759.685530000000000000
        object rllNomeForm: TfrxMemoView
          Top = 3.000000000000000000
          Width = 353.838960000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 353.536610000000000000
          Top = 3.000000000000000000
          Width = 405.316450000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 400.630180000000000000
        Width = 759.685530000000000000
        ReprintOnNewPage = True
        object rllCorFundo: TfrxMemoView
          Align = baClient
          Width = 759.685530000000000000
          Height = 20.763760000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object DMPMemo6: TfrxMemoView
          Left = 170.935250000000000000
          Top = 1.661409999999989000
          Width = 46.261410000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT.')
          ParentFont = False
        end
        object DMPMemo7: TfrxMemoView
          Left = 220.458070000000000000
          Top = 1.661409999999989000
          Width = 83.225170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.ORIG.')
          ParentFont = False
        end
        object DMPMemo8: TfrxMemoView
          Left = 306.724180000000000000
          Top = 1.661409999999989000
          Width = 79.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.PRAT.')
          ParentFont = False
        end
        object DMPMemo9: TfrxMemoView
          Left = 389.210760000000000000
          Top = 1.661409999999989000
          Width = 75.968460000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.ORIG.')
          ParentFont = False
        end
        object DMPMemo10: TfrxMemoView
          Left = 467.779220000000000000
          Top = 1.661409999999989000
          Width = 77.404700000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR.TOT.PRAT.')
          ParentFont = False
        end
        object DMPMemo11: TfrxMemoView
          Left = 547.783920000000000000
          Top = 1.661409999999989000
          Width = 73.625170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESC.TOTAL')
          ParentFont = False
        end
        object DMPMemo12: TfrxMemoView
          Left = 624.331910000000000000
          Top = 1.661409999999989000
          Width = 81.259842519685000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VERBA SOLIC.')
          ParentFont = False
        end
        object DMPMemo26: TfrxMemoView
          Left = 147.212430000000000000
          Top = 1.661409999999989000
          Width = 21.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object DMPMemo30: TfrxMemoView
          Left = 709.494000000000000000
          Top = 1.661409999999989000
          Width = 48.377952760000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '%VERBA')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 18.897650000000000000
        Width = 759.685530000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 24.680675000000000000
          Top = 17.000000000000000000
          Width = 710.324180000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
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
          Left = 137.348455000000000000
          Top = 34.000000000000000000
          Width = 484.988620000000000000
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
          Left = 654.991650000000000000
          Top = 34.000000000000000000
          Width = 100.081880000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 697.976370630000000000
          Top = 51.000000000000000000
          Width = 57.902350000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 622.023190000000000000
          Top = 51.000000000000000000
          Width = 71.886580000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object DMPMemo1: TfrxMemoView
          Align = baCenter
          Left = 140.863390000000200000
          Top = 51.000000000000000000
          Width = 477.958749999999700000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIOD]')
        end
        object DMPMemo2: TfrxMemoView
          Align = baLeft
          Top = 102.000000000000000000
          Width = 377.952755905512000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODSUP]')
        end
        object DMPMemo3: TfrxMemoView
          Align = baRight
          Left = 381.732774090000000000
          Top = 119.000000000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CODEMP]')
        end
        object DMPMemo4: TfrxMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[TIPPED]')
        end
        object DMPMemo25: TfrxMemoView
          Align = baRight
          Left = 381.732774094488000000
          Top = 102.000000000000000000
          Width = 377.952755905512000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CODVEN]')
        end
        object DMPMemo28: TfrxMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 377.952755905512000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODFOR]')
        end
        object DMPMemo29: TfrxMemoView
          Align = baRight
          Left = 381.732774094488000000
          Top = 85.000000000000000000
          Width = 377.952755905512000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[CODCLI]')
        end
        object DMPMemo27: TfrxMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 377.952755910000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[UTIVBA]')
        end
      end
      object GroupHeaderVended: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 234.330860000000000000
        Width = 759.685530000000000000
        OnBeforePrint = 'GroupHeaderVendedOnBeforePrint'
        Condition = 'frxRelatorio."VENDED"'
        object rllCodVen: TfrxMemoView
          Width = 757.417130000000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllCodVenOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VENDEDOR: [(<frxRelatorio."VENDED">)]')
          ParentFont = False
        end
      end
      object GroupFooterVend: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 653.858690000000000000
        Width = 759.685530000000000000
        object DMPMemo35: TfrxMemoView
          Left = 170.935250000000000000
          Top = 1.661410000000046000
          Width = 46.110236220000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."QUANTI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo36: TfrxMemoView
          Left = 220.458070000000000000
          Top = 1.661410000000046000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo37: TfrxMemoView
          Left = 306.724180000000000000
          Top = 1.661410000000046000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo38: TfrxMemoView
          Left = 389.210760000000000000
          Top = 1.661410000000046000
          Width = 75.968503940000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo39: TfrxMemoView
          Left = 467.779220000000000000
          Top = 1.661410000000046000
          Width = 77.480314960000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo40: TfrxMemoView
          Left = 547.783920000000000000
          Top = 1.661410000000046000
          Width = 73.700787400000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."DESTOT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllVbaSolVen: TfrxMemoView
          Left = 624.331910000000000000
          Top = 1.661410000000046000
          Width = 81.259842520000010000
          Height = 17.000000000000000000
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
            '[(<fltTotVbaVen>)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo52: TfrxMemoView
          Left = 4.363760000000000000
          Top = 1.661410000000046000
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL VENDEDOR ([(<frxRelatorio."CODVEN">)]):')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo74: TfrxMemoView
          Left = 709.494000000000000000
          Top = 1.661410000000046000
          Width = 48.377952760000000000
          Height = 17.000000000000000000
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
            
              '[IIF((<fltTotVbaVen>) <> 0, ((SUM(<frxRelatorio."DESTOT">,rlbDet' +
              'alhes) / (<fltTotVbaVen>))*100), 0.00)]%')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Width = 759.685530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line5: TfrxLineView
          Top = 18.897650000000000000
          Width = 759.685530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeaderFornec: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 359.055350000000000000
        Width = 759.685530000000000000
        OnBeforePrint = 'GroupHeaderFornecOnBeforePrint'
        Condition = 'frxRelatorio."FORNEC"'
        object DMPMemo43: TfrxMemoView
          Left = 56.692950000000010000
          Width = 700.724372830000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FORNECEDOR: [(<frxRelatorio."FORNEC">)]')
          ParentFont = False
        end
      end
      object GroupFooterFornec: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 529.134200000000000000
        Width = 759.685530000000000000
        object DMPMemo34: TfrxMemoView
          Left = 170.935250000000000000
          Top = 1.661410000000046000
          Width = 46.110236220000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."QUANTI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo44: TfrxMemoView
          Left = 220.458070000000000000
          Top = 1.661410000000046000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo45: TfrxMemoView
          Left = 306.724180000000000000
          Top = 1.661410000000046000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo46: TfrxMemoView
          Left = 389.210760000000000000
          Top = 1.661410000000046000
          Width = 75.968503940000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo47: TfrxMemoView
          Left = 467.779220000000000000
          Top = 1.661410000000046000
          Width = 77.480314960000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo48: TfrxMemoView
          Left = 547.783920000000000000
          Top = 1.661410000000046000
          Width = 73.700787400000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."DESTOT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllVbaSolFor: TfrxMemoView
          Left = 624.331910000000000000
          Top = 1.661410000000046000
          Width = 81.259842520000010000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllVbaSolForOnBeforePrint'
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
            '[frxRelatorio."VBASOL"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo51: TfrxMemoView
          Left = 56.692950000000010000
          Top = 1.661410000000046000
          Width = 110.362170550000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL FOR. ([(<frxRelatorio."CODFOR">)]):')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo71: TfrxMemoView
          Left = 709.494000000000000000
          Top = 1.661410000000046000
          Width = 48.377952760000000000
          Height = 17.000000000000000000
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
            
              '[IIF((<frxRelatorio."VBASOL">) <> 0, ((SUM(<frxRelatorio."DESTOT' +
              '">,rlbDetalhes) / (<frxRelatorio."VBASOL">))*100), 0.00)]%')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Width = 759.685530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeaderDtaEmi: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 317.480520000000000000
        Width = 759.685530000000000000
        OnBeforePrint = 'GroupHeaderDtaEmiOnBeforePrint'
        Condition = 'frxRelatorio."DTAENT"'
        object rllDtaEmi: TfrxMemoView
          Left = 37.795300000000000000
          Width = 719.622022830000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllDtaEmiOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMISS'#195'O PEDIDO: [(<frxRelatorio."DTAENT">)]')
          ParentFont = False
        end
      end
      object GroupHeaderClient: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 275.905690000000000000
        Width = 759.685530000000000000
        OnBeforePrint = 'GroupHeaderClientOnBeforePrint'
        Condition = 'frxRelatorio."CLIENT"'
        object rllCodCli: TfrxMemoView
          Left = 18.897650000000000000
          Width = 738.519672830000000000
          Height = 17.000000000000000000
          OnAfterPrint = 'rllCodCliOnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CLIENTE: [(<frxRelatorio."CLIENT">)]')
          ParentFont = False
        end
      end
      object GroupFooterDtaEmi: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 570.709030000000000000
        Width = 759.685530000000000000
        object DMPMemo53: TfrxMemoView
          Left = 170.935250000000000000
          Top = 0.661410000000046200
          Width = 46.110236220000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."QUANTI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo54: TfrxMemoView
          Left = 220.458070000000000000
          Top = 0.661410000000046200
          Width = 83.149606300000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo55: TfrxMemoView
          Left = 306.724180000000000000
          Top = 0.661410000000046200
          Width = 79.370078740000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo56: TfrxMemoView
          Left = 389.210760000000000000
          Top = 0.661410000000046200
          Width = 75.968503940000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo57: TfrxMemoView
          Left = 467.779220000000000000
          Top = 0.661410000000046200
          Width = 77.480314960000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo58: TfrxMemoView
          Left = 547.783920000000000000
          Top = 0.661410000000046200
          Width = 73.700787400000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."DESTOT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllVbaSolDta: TfrxMemoView
          Left = 624.331910000000000000
          Top = 0.661410000000046200
          Width = 81.259842520000010000
          Height = 17.000000000000000000
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
            '[(<fltTotVbaDta>)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo61: TfrxMemoView
          Left = 37.795300000000000000
          Top = 0.661410000000046200
          Width = 129.259820550000100000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL DO DIA ([(<frxRelatorio."DTAENT">)]):')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo72: TfrxMemoView
          Left = 709.494000000000000000
          Top = 0.661410000000046200
          Width = 48.377952760000000000
          Height = 17.000000000000000000
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
            
              '[IIF((<fltTotVbaDta>) <> 0, ((SUM(<frxRelatorio."DESTOT">,rlbDet' +
              'alhes) / (<fltTotVbaDta>))*100), 0.00)]%')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Width = 759.685530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooterClient: TfrxGroupFooter
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 612.283860000000000000
        Width = 759.685530000000000000
        object DMPMemo62: TfrxMemoView
          Left = 170.935250000000000000
          Top = 0.440939999999955000
          Width = 46.110236220000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."QUANTI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo63: TfrxMemoView
          Left = 220.458070000000000000
          Top = 0.440939999999955000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo64: TfrxMemoView
          Left = 306.724180000000000000
          Top = 0.440939999999955000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo65: TfrxMemoView
          Left = 389.210760000000000000
          Top = 0.440939999999955000
          Width = 75.968503940000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo66: TfrxMemoView
          Left = 467.779220000000000000
          Top = 0.440939999999955000
          Width = 77.480314960000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo67: TfrxMemoView
          Left = 547.783920000000000000
          Top = 0.440939999999955000
          Width = 73.700787400000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."DESTOT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object rllVbaSolCli: TfrxMemoView
          Left = 624.331910000000000000
          Top = 0.440939999999955000
          Width = 81.259842520000010000
          Height = 17.000000000000000000
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
            '[(<fltTotVbaCli>)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo70: TfrxMemoView
          Left = 18.897650000000000000
          Top = 0.440939999999955000
          Width = 148.157470550000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL CLIENTE ([(<frxRelatorio."CODCLI">)]):')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo73: TfrxMemoView
          Left = 709.494000000000000000
          Top = 0.440939999999955000
          Width = 48.377952760000000000
          Height = 17.000000000000000000
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
            
              '[IIF((<fltTotVbaCli>) <> 0, ((SUM(<frxRelatorio."DESTOT">,rlbDet' +
              'alhes) / (<fltTotVbaCli>))*100), 0.00)]%')
          ParentFont = False
          WordWrap = False
        end
        object Line3: TfrxLineView
          Width = 759.685530000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 695.433520000000000000
        Width = 759.685530000000000000
        object DMPMemo75: TfrxMemoView
          Left = 4.363760000000000000
          Top = 0.881880000000023800
          Width = 163.275590550000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAL GERAL:')
          ParentFont = False
        end
        object DMPMemo76: TfrxMemoView
          Left = 170.935250000000000000
          Top = 0.881880000000023800
          Width = 46.110236220000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."QUANTI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo77: TfrxMemoView
          Left = 220.458070000000000000
          Top = 0.881880000000023800
          Width = 83.149606300000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo78: TfrxMemoView
          Left = 306.724180000000000000
          Top = 0.881880000000023800
          Width = 79.370078740000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."VLRPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo79: TfrxMemoView
          Left = 389.210760000000000000
          Top = 0.881880000000023800
          Width = 75.968503940000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTORI">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo80: TfrxMemoView
          Left = 467.779220000000000000
          Top = 0.881880000000023800
          Width = 77.480314960000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."TOTPRA">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo81: TfrxMemoView
          Left = 547.783920000000000000
          Top = 0.881880000000023800
          Width = 73.700787400000000000
          Height = 17.000000000000000000
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
            '[SUM(<frxRelatorio."DESTOT">,rlbDetalhes)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo82: TfrxMemoView
          Left = 624.331910000000000000
          Top = 0.881880000000023800
          Width = 81.259842520000010000
          Height = 17.000000000000000000
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
            '[(<fltTotVba>)]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo84: TfrxMemoView
          Left = 709.494000000000000000
          Top = 0.881880000000023800
          Width = 48.377952760000000000
          Height = 17.000000000000000000
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
            
              '[IIF((<fltTotVba>) <> 0, ((SUM(<frxRelatorio."DESTOT">,rlbDetalh' +
              'es) / (<fltTotVba>))*100), 0.00)]%')
          ParentFont = False
          WordWrap = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 487.559370000000000000
        Width = 759.685530000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        object rllZebra2: TfrxMemoView
          Align = baClient
          Width = 759.685530000000000000
          Height = 18.897637800000000000
          OnAfterPrint = 'rllZebra2OnAfterPrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -11
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Quebra> mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo18: TfrxMemoView
          Left = 147.212430000000000000
          Width = 21.165354330000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."UNIDAD"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo19: TfrxMemoView
          Left = 170.935250000000000000
          Width = 46.110236220000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."QUANTI"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo20: TfrxMemoView
          Left = 220.458070000000000000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."VLRORI"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo21: TfrxMemoView
          Left = 306.724180000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."VLRPRA"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo22: TfrxMemoView
          Left = 389.210760000000000000
          Width = 75.968503940000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."TOTORI"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo23: TfrxMemoView
          Left = 467.779220000000000000
          Width = 77.480314960000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."TOTPRA"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo14: TfrxMemoView
          Left = 547.783919999999900000
          Width = 73.700787400000000000
          Height = 17.000000000000000000
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
            '[frxRelatorio."DESTOT"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object DMPCommand1: TfrxDMPCommand
        Left = 9.600000000000000000
        Top = 17.000000000000000000
        Width = 105.600000000000000000
        Height = 17.000000000000000000
        Command = '#27#64#18#27#80#15#27#77'
      end
    end
  end
end
