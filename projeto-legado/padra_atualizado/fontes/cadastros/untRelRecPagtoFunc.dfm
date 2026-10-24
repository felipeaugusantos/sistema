inherited frmRelRecPagtoFunc: TfrmRelRecPagtoFunc
  Left = 283
  Top = 244
  Width = 525
  Height = 301
  Caption = 'Impress'#227'o dos Recibos de Pagamento'
  ExplicitWidth = 525
  ExplicitHeight = 301
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 230
    Width = 519
    ExplicitTop = 230
    ExplicitWidth = 519
    inherited FlwBotoes: TFlowPanel
      Width = 438
      ExplicitWidth = 438
      inherited btnImprimir: TBitBtnLocked
        Width = 70
        ExplicitWidth = 70
      end
      inherited btnConfigurar: TBitBtnLocked
        Left = 70
        ExplicitLeft = 70
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 440
      ExplicitLeft = 440
    end
  end
  inherited pnlStatus: TPanel
    Top = 256
    Width = 519
    ExplicitTop = 256
    ExplicitWidth = 519
    inherited pnlNomeForm: TPanel
      Left = 348
      ExplicitLeft = 348
    end
    inherited pnlInfo: TPanel
      Width = 348
      ExplicitWidth = 348
      inherited shpMultSel: TShape
        Left = 327
        Top = 2
        ExplicitLeft = 327
        ExplicitTop = 2
      end
    end
  end
  inherited pnlDados: TPanel
    Width = 519
    Height = 230
    ExplicitWidth = 519
    ExplicitHeight = 230
    object Label1: TLabel [0]
      Left = 24
      Top = 84
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'M'#234's Base:'
    end
    object Label3: TLabel [1]
      Left = 30
      Top = 61
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel [2]
      Left = 16
      Top = 130
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Funcion'#225'rio:'
    end
    object Label4: TLabel [3]
      Left = 20
      Top = 153
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Verba:'
    end
    object Label28: TLabel [4]
      Left = 33
      Top = 107
      Width = 42
      Height = 14
      Caption = 'Eventos:'
    end
    object lbl3: TLabel [5]
      Left = 194
      Top = 177
      Width = 50
      Height = 14
      Caption = 'N'#186' de vias'
    end
    inherited gpbDestino: TGroupBox
      Left = 12
      Top = 177
      Width = 178
      TabOrder = 11
      ExplicitLeft = 12
      ExplicitTop = 177
      ExplicitWidth = 178
      inherited ColorLabel1: TColorLabel
        Left = 30
        Width = 140
        Caption = '(V)'#237'deo (I)mpressora (E)-Mail'
        ExplicitLeft = 30
        ExplicitWidth = 140
      end
      inherited edtDestino: TEditFocus
        Left = 8
        ExplicitLeft = 8
      end
    end
    object mskMesBas: TMaskEditFocus
      Tag = 99
      Left = 76
      Top = 80
      Width = 82
      Height = 22
      EditMask = '!99/9999;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 7
      ParentFont = False
      TabOrder = 3
      Text = '  /    '
      OnExit = mskMesBasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 76
      Top = 56
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 160
      Top = 57
      Width = 347
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTipMov: TEditFocus
      Left = 160
      Top = 80
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object edtCodFun: TEditFocus
      Tag = 99
      Left = 76
      Top = 126
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 7
      OnExit = edtCodFunExit
      OnKeyPress = edtCodFunKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesFun: TEditFocus
      Left = 160
      Top = 126
      Width = 347
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVer: TEditFocus
      Tag = 99
      Left = 76
      Top = 149
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 9
      OnExit = edtCodVerExit
      OnKeyPress = edtCodVerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesVer: TEditFocus
      Left = 160
      Top = 149
      Width = 347
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescricaoEvento: TEditFocus
      Left = 160
      Top = 103
      Width = 347
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEvento: TEditFocus
      Left = 76
      Top = 103
      Width = 82
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 5
      OnExit = edtCodEventoExit
      OnKeyPress = edtCodEventoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object rdgTipoPesquisa: TRadioGroup
      Left = 12
      Top = 9
      Width = 254
      Height = 36
      Caption = 'Tipo de Pesquisa'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Mensal'
        'Evento')
      TabOrder = 0
      OnClick = rdgTipoPesquisaClick
    end
    object edtQtdVia: TEditFocus
      Tag = 99
      Left = 194
      Top = 193
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 12
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 659
    Top = 31
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 818
    Top = 27
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 819
    Top = 131
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 690
    Top = 61
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 658
    Top = 61
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 626
    Top = 61
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 787
    Top = 31
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 755
    Top = 31
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 363
    Top = 11
  end
  inherited frxGen: TfrxUserDataSet
    Fields.Strings = (
      'EMP_NOMEMP'
      'EMP_ENDERE'
      'EMP_C_G_C_'
      'REL_NOMREL')
    Left = 722
    Top = 61
  end
  inherited frxDesigner: TfrxDesigner
    Left = 754
    Top = 67
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 786
    Top = 67
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 791
    Top = 132
  end
  object cdsConPag: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 211
    Top = 10
    object cdsConPagCODVER: TStringField
      FieldName = 'CODVER'
      Size = 3
    end
    object cdsConPagDESVER: TStringField
      FieldName = 'DESVER'
      Size = 30
    end
    object fltfldConPagVALLAN: TFloatField
      FieldName = 'VALLAN'
    end
    object cdsConPagCODFUN: TStringField
      FieldName = 'CODFUN'
      Size = 6
    end
    object cdsConPagNOMFUN: TStringField
      FieldName = 'NOMFUN'
      Size = 50
    end
    object cdsConPagDEBCRE: TStringField
      FieldName = 'DEBCRE'
      Size = 1
    end
    object cdsConPagCODDEB: TStringField
      FieldName = 'CODDEB'
      Size = 3
    end
    object cdsConPagDESDEB: TStringField
      FieldName = 'DESDEB'
      Size = 30
    end
    object fltfldConPagVALDEB: TFloatField
      FieldName = 'VALDEB'
    end
    object cdsConPagVER_CODVER: TStringField
      FieldName = 'VER_CODVER'
      Size = 3
    end
    object cdsConPagVER_DESVER: TStringField
      FieldName = 'VER_DESVER'
      Size = 30
    end
    object cdsConPagFUN_NOMFUN: TStringField
      FieldName = 'FUN_NOMFUN'
      Size = 50
    end
    object cdsConPagEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 60
    end
    object cdsConPagEMP_ENDERE: TStringField
      FieldName = 'EMP_ENDERE'
      Size = 60
    end
    object cdsConPagEMP_C_G_C_: TStringField
      FieldName = 'EMP_C_G_C_'
    end
    object cdsConPagAGENCI: TStringField
      FieldName = 'AGENCI'
      Size = 7
    end
    object cdsConPagNUMBCO: TStringField
      FieldName = 'NUMBCO'
      Size = 50
    end
    object cdsConPagCONTA_: TStringField
      FieldName = 'CONTA_'
      Size = 13
    end
    object cdsConPagCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsConPagAUTFUN: TStringField
      FieldName = 'AUTFUN'
    end
    object cdsConPagEMAIL_: TStringField
      FieldName = 'EMAIL_'
      Size = 512
    end
    object cdsConPagHIST01: TStringField
      FieldName = 'HIST01'
      Size = 800
    end
  end
  object dspConPag: TUniDataSetProvider
    Options = []
    Left = 283
    Top = 58
  end
  object dspResumo: TUniDataSetProvider
    Options = []
    Left = 210
    Top = 61
  end
  object frxPagtoFuncJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45049.599601041660000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '//var intGlobal : Integer;  '
      '  '
      'procedure Memo23OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '//  intGlobal := intGlobal + 1;'
      '//    '
      '//  If intGlobal = 3 Then'
      '//  Begin              '
      '//    intGlobal := 0;                    '
      '//    rlbGrupo.StartNewPage := True;'
      '//  End'
      '//  Else'
      
        '//    rlbGrupo.StartNewPage := False;                           ' +
        '     '
      'end;'
      '  '
      
        'procedure DateOnPreviewClick(Sender: TfrxView; Button: TMouseBut' +
        'ton; Shift: Integer; var Modified: Boolean);'
      'begin'
      ''
      'end;'
      ''
      'procedure Shape7OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        ' // If <frxRelatorio."NUMBCO"> <> '#39#39' Then                       ' +
        '                         '
      ' // Begin'
      ' //   Child2.Visible:=True;'
      ' // End'
      ' // Else'
      ' // Begin'
      '  //  Child2.Visible:=False;'
      ' // End;'
      'end;'
      ''
      'procedure Child2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  If <frxRelatorio."NUMBCO"> <> '#39#39' Then                         ' +
        '                       '
      '  Begin'
      '    Child2.Visible:=True;'
      '  End'
      '  Else'
      '  Begin'
      '    Child2.Visible:=False;'
      '  End;                      '
      'end;'
      ''
      'BEGIN'
      '//  intGlobal := 0;                      '
      'END.          ')
    Left = 287
    Top = 12
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
    object qckPaginaA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'Memo23OnAfterPrint'
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 1.871366670000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 20.031496060000000000
        Top = 347.716760000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Columns = 1
        ColumnWidth = 359.055118110236000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rlbDesCre: TfrxMemoView
          Left = 11.338582680000000000
          Top = 1.133858267716562000
          Width = 154.960420000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbDesCreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESVER"]')
          ParentFont = False
        end
        object rlbValCre: TfrxMemoView
          Left = 234.177860000000000000
          Top = 1.133858269999962000
          Width = 92.220470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbValCreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."VALLAN"]')
          ParentFont = False
        end
        object rlbValDeb: TfrxMemoView
          Left = 605.724800000000000000
          Top = 1.133858269999962000
          Width = 92.220470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbValCreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."VALDEB"]')
          ParentFont = False
        end
        object rlbDesDeb: TfrxMemoView
          Left = 382.110236220000000000
          Top = 1.133858267716562000
          Width = 154.960420000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbDesCreOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESDEB"]')
          ParentFont = False
        end
        object Line7: TfrxLineView
          Left = 3.779530000000000000
          Height = 24.566929133858300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 714.331170000000000000
          Height = 24.566929133858300000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 65.850386380000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Child = frxPagtoFuncJ.Child2
        Condition = 
          'VarToStr(<frxRelatorio."CODFUN">)+'#39'.'#39'+VarToStr(<frxRelatorio."CO' +
          'DEMP">)+'#39'.'#39'+VarToStr(<frxRelatorio."AUTFUN">)'
        KeepTogether = True
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 3.779530000000000000
          Top = 3.779529999999994000
          Width = 710.551640000000000000
          Height = 62.362204720000000000
        end
        object rllNomeEmpresa: TfrxMemoView
          Left = 122.834645670000000000
          Top = 7.338589999999996000
          Width = 343.710080000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 9.600000000000000000
          Top = 7.338589999999996000
          Width = 75.363450000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMPRESA:')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 11.338590000000000000
          Top = 27.015770000000000000
          Width = 45.127210000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 476.779840000000000000
          Top = 7.338589999999996000
          Width = 169.851700000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'RECIBO DE PAGAMENTO')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 476.779840000000000000
          Top = 27.015770000000000000
          Width = 79.142980000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'M'#202'S BASE:')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 122.759060000000000000
          Top = 47.472479999999960000
          Width = 344.617130000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NOMFUN"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 11.338590000000000000
          Top = 47.472479999999960000
          Width = 103.861410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FUNCION'#193'RIO:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 563.709030000000000000
          Top = 27.015770000000000000
          Width = 82.922510000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 122.834645670000000000
          Top = 27.015770000000000000
          Width = 343.710080000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_C_G_C_"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 672.417750000000000000
          Top = 27.015770000000000000
          Width = 33.788620000000000000
          Height = 13.220470000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '01/01')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 117.149660000000000000
        Top = 389.291590000000000000
        Width = 718.110700000000000000
        object Shape5: TfrxShapeView
          Left = 3.779530000000000000
          Top = 60.031540000000010000
          Width = 710.551640000000000000
          Height = 37.795300000000000000
        end
        object Shape4: TfrxShapeView
          Left = 3.779527560000000000
          Top = 3.779530000000022000
          Width = 332.598640000000000000
          Height = 22.677180000000000000
        end
        object Memo6: TfrxMemoView
          Left = 210.626530000000000000
          Top = 7.220469999999977000
          Width = 114.897650000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALLAN">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1104.377952755910000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALDEB">,rlbDetalhes)]')
        end
        object Memo8: TfrxMemoView
          Left = 11.262770000000000000
          Top = 7.220469999999977000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL CR'#201'DITO(S):')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 961.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL LIQUIDO:')
        end
        object Memo10: TfrxMemoView
          Left = 1104.377952755910000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."VALLAN">,rlbDetalhes) - SUM(<frxRelatorio."V' +
              'ALDEB">,rlbDetalhes)]')
        end
        object Memo4: TfrxMemoView
          Left = 971.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DEBITO:')
        end
        object Shape2: TfrxShapeView
          Left = 381.732283464567000000
          Top = 3.779530000000022000
          Width = 332.598425200000000000
          Height = 22.677180000000000000
        end
        object Memo17: TfrxMemoView
          Left = 382.110236220000000000
          Top = 7.559059999999988000
          Width = 126.840940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL D'#201'BITO(S):')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 528.220780000000000000
          Top = 7.559059999999988000
          Width = 171.590600000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."VALDEB">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 253.228510000000000000
          Top = 87.149659999999990000
          Width = 423.307360000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo23: TfrxMemoView
          Left = 82.472480000000000000
          Top = 72.252009999999990000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          OnAfterPrint = 'Memo23OnAfterPrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '____/____/________')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 108.944960000000000000
          Width = 710.551640000000000000
          Color = clBlack
          ArrowSolid = True
          Frame.Style = fsDot
          Frame.Typ = [ftTop]
        end
        object Shape6: TfrxShapeView
          Left = 3.779530000000000000
          Top = 31.795300000000000000
          Width = 332.598640000000000000
          Height = 22.677180000000000000
        end
        object Memo27: TfrxMemoView
          Left = 210.626532440000000000
          Top = 35.236240000000010000
          Width = 114.897650000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxRelatorio."VALLAN">,rlbDetalhes)-SUM(<frxRelatorio."VAL' +
              'DEB">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 11.262772440000000000
          Top = 35.236240000000010000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL L'#205'QUIDO:')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Left = -343.937230000000000000
          Top = 22.677180000000020000
          Height = 15.118120000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 1.881880000000000000
        Top = 83.149660000000000000
        Width = 718.110700000000000000
        object Memo14: TfrxMemoView
          Left = 1104.377952760000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
        end
        object Time: TfrxMemoView
          Left = 1124.800000000000000000
          Top = 1.784786670000003000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1006.400000000000000000
          Top = 1.784786670000003000
          Width = 113.461410000000000000
          Height = 17.000000000000000000
          OnPreviewClick = 'DateOnPreviewClick'
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
      end
      object rllPagina: TfrxMemoView
        Left = 1076.800000000000000000
        Top = 20.784786670000000000
        Width = 124.800000000000000000
        Height = 17.000000000000000000
        OnBeforePrint = 'rllPaginaOnBeforePrint'
        DataSet = frxGen
        DataSetName = 'frxGen'
        DisplayFormat.DecimalSeparator = ','
        HAlign = haRight
        Memo.UTF8W = (
          'PAGINA: [Page]')
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 294.803340000000000000
        Width = 718.110700000000000000
        object Gradient3: TfrxGradientView
          Left = 377.732530000000000000
          Top = 3.000000000000000000
          Width = 336.755905510000000000
          Height = 22.677180000000000000
          BeginColor = clSilver
          EndColor = clSilver
          Style = gsHorizontal
          Color = clSilver
        end
        object Gradient4: TfrxGradientView
          Left = 5.338590000000000000
          Top = 3.000000000000000000
          Width = 343.937230000000000000
          Height = 22.677180000000000000
          BeginColor = clSilver
          EndColor = clSilver
          Style = gsHorizontal
          Color = clSilver
        end
        object Memo33: TfrxMemoView
          Left = 11.338582680000000000
          Top = 4.000000000000000000
          Width = 73.625170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CR'#201'DITOS')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 276.661334330000000000
          Top = 4.000000000000000000
          Width = 50.947990000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 381.953000000000000000
          Top = 4.000000000000000000
          Width = 73.625170000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'D'#201'BITOS')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 645.834811650000000000
          Top = 4.000000000000000000
          Width = 50.947990000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 3.779530000000000000
          Top = 1.220469999999977000
          Height = 35.527566380000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 714.331170000000000000
          Top = 1.220469999999977000
          Height = 35.527566380000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 75.590548740000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'Child2OnBeforePrint'
        Child = frxPagtoFuncJ.Child1
        PrintChildIfInvisible = True
        object Shape7: TfrxShapeView
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Height = 75.590600000000000000
          OnBeforePrint = 'Shape7OnBeforePrint'
          ShowHint = True
        end
        object Memo5: TfrxMemoView
          Left = 11.559060000000000000
          Top = 5.000000000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONTA CORRENTE')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 72.488250000000000000
          Top = 29.236240000000010000
          Width = 393.071120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMBCO"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 13.000000000000000000
          Top = 29.236240000000010000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'BANCO:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 11.559060000000000000
          Top = 51.913420000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'AG'#202'NCIA:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 79.590600000000000000
          Top = 51.913420000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."AGENCI"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 196.756030000000000000
          Top = 51.913420000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'M.CONTA:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 287.464750000000000000
          Top = 51.913420000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CONTA_"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReport_M_Evento: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 40343.742533993100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      '                              '
      'end.')
    Left = 332
    Top = 104
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
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
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 510.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object frxUserVALREC: TfrxDMPMemoView
          Left = 163.200000000000000000
          Top = 68.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxRelatorio."VALREC">)]')
          TruncOutboundText = False
        end
        object frxUserNOMASS: TfrxDMPMemoView
          Left = 374.400000000000000000
          Top = 442.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMREC"]')
          TruncOutboundText = False
        end
        object frxUserNROVIA: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 476.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxRelatorio."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object frxUserCIDREC: TfrxDMPMemoView
          Left = -115.200000000000000000
          Top = 306.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          TruncOutboundText = False
        end
        object frxUserNOMREC: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 119.000000000000000000
          Width = 720.000000000000000000
          Height = 136.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '    Eu, [frxRelatorio."NOMREC"], declaro que recebi a importanci' +
              'a de R$ [FormatFloat('#39'#,##0.00'#39',<frxRelatorio."VALREC">)] ( [frx' +
              'Relatorio."VLREXT"] ), referente as seguintes festas trabalhadas' +
              ':'
            ''
            '[frxRelatorio."HISREC"].')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 501.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 172.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
      end
    end
  end
  object frxReport_J_Evento: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 40343.563931203700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 334
    Top = 160
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
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
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 483.779840000000000000
        Top = 94.488250000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo24: TfrxMemoView
          Width = 755.906000000000000000
          Height = 30.236240000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape1: TfrxShapeView
          Width = 755.906000000000000000
          Height = 411.968770000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 275.905690000000000000
          Top = 332.598640000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."NOMREC"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 22.677180000000000000
          Top = 385.512060000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxRelatorio."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 15.118120000000000000
          Top = 212.724490000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 49.133890000000010000
          Width = 699.213050000000000000
          Height = 45.354360000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxRelatorio."VALREC">)]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 26.456710000000000000
          Top = 105.826840000000000000
          Width = 702.992580000000000000
          Height = 90.708720000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '    Eu, [frxRelatorio."NOMREC"], declaro  que recebi a importanc' +
              'ia de R$ [FormatFloat('#39'#,##0.00'#39',<frxRelatorio."VALREC">)] ( [fr' +
              'xRelatorio."VLREXT"] ), referente as seguintes festas trabalhada' +
              's:'
            ''
            '[frxRelatorio."HISREC"].')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
    end
  end
  object frxOSJ_Evento: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 42730.430167546300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 434
    Top = 164
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
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
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 483.779840000000000000
        Top = 41.574830000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxOrdemServico: TfrxMemoView
          Left = 34.015770000000010000
          Top = 49.133890000000000000
          Width = 702.992580000000000000
          Height = 56.692913390000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Sr.[frxRelatorio."NOMREC"], '
            
              'CPF [frxRelatorio."CPFFUN"], para exerc'#237'cio da fun'#231#227'o de extra (' +
              'cozinha/gar'#231'om/ajudante de cozinha/ ajudante de limpeza)  exclus' +
              'ivamente para o evento a ser realizado no dia [frxRelatorio."DTA' +
              'EVE"], no seguinte local:')
          ParentFont = False
        end
        object frxmvCiente: TfrxMemoView
          Left = 120.724490000000000000
          Top = 163.181200000000000000
          Width = 385.512060000000000000
          Height = 41.574830000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Nome'
            'CPF')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 3.779530000000001000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'ORDEM DE SERVI'#199'O - RECIBO DE PAGAMENTO DE DI'#193'RIA DE SERVI'#199'O')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = -3.779530000000000000
          Top = 26.456709999999990000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Ordem de Servi'#231'o')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = -3.779530000000000000
          Top = 249.889920000000000000
          Width = 755.906000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Recibo de pagamento de di'#225'ria de servi'#231'o')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 45.354360000000000000
          Top = 280.126160000000000000
          Width = 702.992580000000000000
          Height = 105.826840000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Pelo presente, recebi de [frxRelatorio."NOMREC"] a import'#226'ncia d' +
              'e R$ [FormatFloat('#39'#,##0.00'#39',<frxRelatorio."VALREC">)] ( [frxRel' +
              'atorio."VLREXT"] ), referente a servi'#231'os prestados conforme Orde' +
              'm de Servi'#231'o acima.'
            ''
            '                     Ribeir'#227'o Preto, [frxRelatorio."DTAEVEINC"].')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 130.283550000000000000
          Top = 385.512059999999900000
          Width = 385.512060000000000000
          Height = 41.574830000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Nome'
            'CPF')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 460.323130000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxRelatorio."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 228.212740000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '- ( [frxRelatorio."NROVIA"]a. Via ) -')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 37.795300000000000000
          Top = 108.251968500000000000
          Width = 600.945270000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo7: TfrxMemoView
          Left = 119.165430000000000000
          Top = 123.724490000000000000
          Width = 385.512060000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ciente e de acordo em [frxRelatorio."DTAEVE"]:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 643.299630000000000000
          Top = 95.708720000000000000
          Width = 200.315090000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '.')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
    end
  end
  object frxOSM_Evento: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 42730.379693842600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      '                              '
      'end.')
    Left = 432
    Top = 104
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
      item
        DataSet = frmPaiRelatorio.frxGen
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
    object Page1: TfrxDMPPage
      PaperWidth = 203.199868766751400000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 510.000000000000000000
        Top = 17.000000000000000000
        Width = 768.000000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxUserNOMREC: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 119.000000000000000000
          Width = 720.000000000000000000
          Height = 85.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Sr.[frxRelatorio."NOMREC"],'
            
              'CPF [frxRelatorio."CPFFUN"], para exercicio da funcao de extra (' +
              'cozinha/garcom/ajudante de cozinha/ ajudante de limpeza)  exclus' +
              'ivamente para o evento a ser realizado no dia[frxRelatorio."DTAE' +
              'VE"], no seguinte local :'
            '                     '
            
              '                                   Ciente e de acordo em [frxRel' +
              'atorio."DTAEVE"]:')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 501.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#70'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 172.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#67#33'
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 297.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 255.000000000000000000
          Width = 355.200000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Nome'
            'CPF')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 323.000000000000000000
          Width = 720.000000000000000000
          Height = 102.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              'Pelo presente, recebi de [frxRelatorio."NOMREC"] a importancia d' +
              'e R$ [FormatFloat('#39'#,##0.00'#39',<frxRelatorio."VALREC">)] ( [frxRel' +
              'atorio."VLREXT"] ), referente a servicos prestados conforme Orde' +
              'm de Servico acima.'
            ''
            '                     Ribeir'#227'o Preto, [frxRelatorio."DTAEVEINC"].')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 442.000000000000000000
          Width = 412.800000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'Nome'
            'CPF')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 306.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Recibo de pagamento de diaria de servico')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = -76.800000000000000000
          Top = 85.000000000000000000
          Width = 720.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Ordem de Servico')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 34.000000000000000000
          Width = 720.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          Memo.UTF8W = (
            'ORDEM DE SERVICO - RECIBO DE PAGAMENTO DE DIARIA DE SERVICO')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxUserNROVIA: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 476.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '- ([frxRelatorio."NROVIA"]a. Via ) -')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 272.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '- ([frxRelatorio."NROVIA"]a. Via ) -')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 110.400000000000000000
          Top = 212.500000000000000000
          Width = 528.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object cdsRecibo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 452
    Top = 48
    object cdsReciboVALREC: TStringField
      FieldName = 'VALREC'
      Size = 10
    end
    object cdsReciboNOMREC: TStringField
      FieldName = 'NOMREC'
      Size = 50
    end
    object cdsReciboVLREXT: TStringField
      FieldName = 'VLREXT'
      Size = 255
    end
    object cdsReciboHISREC: TStringField
      FieldName = 'HISREC'
      Size = 1000
    end
    object cdsReciboNROVIA: TStringField
      FieldName = 'NROVIA'
      Size = 10
    end
    object cdsReciboDTAREC: TStringField
      DisplayWidth = 200
      FieldName = 'DTAREC'
      Size = 200
    end
    object cdsReciboCPFFUN: TStringField
      DisplayWidth = 20
      FieldName = 'CPFFUN'
    end
    object cdsReciboDTAEVE: TStringField
      FieldName = 'DTAEVE'
    end
    object cdsReciboDTAEVEINC: TStringField
      DisplayWidth = 20
      FieldName = 'DTAEVEINC'
    end
    object cdsReciboEMAIL_: TStringField
      FieldName = 'EMAIL_'
      Size = 512
    end
    object cdsReciboCODFUN: TStringField
      FieldName = 'CODFUN'
      Size = 6
    end
  end
  object frxGradientObject1: TfrxGradientObject
    Left = 432
    Top = 16
  end
  object cdsConPagFunc: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 146
    object cdsConPagFuncCODVER: TStringField
      FieldName = 'CODVER'
      Size = 3
    end
    object cdsConPagFuncDESVER: TStringField
      FieldName = 'DESVER'
      Size = 30
    end
    object cdsConPagFuncVALLAN: TFloatField
      FieldName = 'VALLAN'
    end
    object cdsConPagFuncCODFUN: TStringField
      FieldName = 'CODFUN'
      Size = 6
    end
    object cdsConPagFuncNOMFUN: TStringField
      FieldName = 'NOMFUN'
      Size = 50
    end
    object cdsConPagFuncDEBCRE: TStringField
      FieldName = 'DEBCRE'
      Size = 1
    end
    object cdsConPagFuncCODDEB: TStringField
      FieldName = 'CODDEB'
      Size = 3
    end
    object cdsConPagFuncDESDEB: TStringField
      FieldName = 'DESDEB'
      Size = 30
    end
    object cdsConPagFuncVALDEB: TFloatField
      FieldName = 'VALDEB'
    end
    object cdsConPagFuncVER_CODVER: TStringField
      FieldName = 'VER_CODVER'
      Size = 3
    end
    object cdsConPagFuncVER_DESVER: TStringField
      FieldName = 'VER_DESVER'
      Size = 30
    end
    object cdsConPagFuncFUN_NOMFUN: TStringField
      FieldName = 'FUN_NOMFUN'
      Size = 50
    end
    object cdsConPagFuncEMP_NOMEMP: TStringField
      FieldName = 'EMP_NOMEMP'
      Size = 60
    end
    object cdsConPagFuncEMP_ENDERE: TStringField
      FieldName = 'EMP_ENDERE'
      Size = 60
    end
    object cdsConPagFuncEMP_C_G_C_: TStringField
      FieldName = 'EMP_C_G_C_'
    end
    object cdsConPagFuncAGENCI: TStringField
      FieldName = 'AGENCI'
      Size = 7
    end
    object cdsConPagFuncNUMBCO: TStringField
      FieldName = 'NUMBCO'
      Size = 50
    end
    object cdsConPagFuncCONTA_: TStringField
      FieldName = 'CONTA_'
      Size = 13
    end
    object cdsConPagFuncCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsConPagFuncAUTFUN: TStringField
      FieldName = 'AUTFUN'
    end
    object cdsConPagFuncEMAIL_: TStringField
      FieldName = 'EMAIL_'
      Size = 512
    end
    object cdsConPagFuncHIST01: TStringField
      FieldName = 'HIST01'
      Size = 800
    end
  end
  object cdsLogEnvEmail: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 218
    object cdsLogEnvEmailCODFUN: TStringField
      DisplayWidth = 6
      FieldName = 'CODFUN'
      Size = 6
    end
    object cdsLogEnvEmailNOMFUN: TStringField
      FieldName = 'NOMFUN'
      Size = 50
    end
    object cdsLogEnvEmailEMAIL_: TStringField
      FieldName = 'EMAIL_'
      Size = 512
    end
    object cdsLogEnvEmailENVIOU: TIntegerField
      FieldName = 'ENVIOU'
    end
    object cdsLogEnvEmailSTATUS: TStringField
      DisplayWidth = 50
      FieldName = 'STATUS'
      Size = 50
    end
  end
  object frxDBLog: TfrxDBDataset
    Description = 'Dados do Log de E-Mail'
    UserName = 'frxDBLogEmail'
    CloseDataSource = False
    DataSet = cdsLogEnvEmail
    BCDToCurrency = False
    Left = 280
    Top = 216
  end
  object frxRepLogEmail: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45051.603088252300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo23OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '                                '
      'end;'
      '  '
      
        'procedure DateOnPreviewClick(Sender: TfrxView; Button: TMouseBut' +
        'ton; Shift: Integer; var Modified: Boolean);'
      'begin'
      ''
      'end;'
      ''
      'procedure Shape7OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure Child2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '                      '
      'end;'
      ''
      'procedure GroupFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'BEGIN'
      ''
      'END.            ')
    Left = 223
    Top = 220
    Datasets = <
      item
        DataSet = frxDBLog
        DataSetName = 'frxDBLogEmail'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPaginaA: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      OnAfterPrint = 'Memo23OnAfterPrint'
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.052566670000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllPagina: TfrxMemoView
          Left = 755.905511811024000000
          Top = 1.887136670000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DataSet = frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
        end
        object mmoNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 75.590783070000000000
          Top = 3.779530000000000000
          Width = 566.929133860000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[VarToStr(<NOME_EMPRESA>)]')
          ParentFont = False
        end
        object mmoNomeRelatorio502378: TfrxMemoView
          Align = baCenter
          Left = 148.271120000000000000
          Top = 22.677167800000000000
          Width = 421.568460000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ENVIO DE E-MAILS - RECIBOS DE PAGAMENTO DE FUNCION'#193'RIOS')
          ParentFont = False
        end
        object mmoHora502378: TfrxMemoView
          Align = baRight
          Left = 538.356340000000000000
          Top = 23.440940000000000000
          Width = 142.790600000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date]')
          ParentFont = False
          Formats = <
            item
              FormatStr = 'dd/mm/yyyy'
              Kind = fkDateTime
            end
            item
            end>
        end
        object Memo1: TfrxMemoView
          Left = 647.299141810000000000
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 52.913420000000000000
          Width = 699.213050000000000000
          Height = 79.370130000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tipo de Pesquisa: [TIPO_PESQUISA]'
            'Empresa: [EMPRESA]'
            'M'#234's Base: [MES_BASE]'
            'Eventos: [EVENTO]'
            'Funcion'#225'rio: [FUNCIONARIO]'
            'Tipo Verba: [TIPO_VERBA]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Align = baRight
          Left = 681.146940000000000000
          Top = 21.677180000000000000
          Width = 36.963760000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'hh:mm'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time] ')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 20.031496060000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Columns = 1
        ColumnWidth = 359.055118110236000000
        DataSet = frxDBLog
        DataSetName = 'frxDBLogEmail'
        RowCount = 0
        object rlbCodFun: TfrxMemoView
          Top = 0.755905510000000000
          Width = 71.810760000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbDesCreOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxDBLogEmail."CODFUN">)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          Left = 78.708720000000000000
          Top = 0.779530000000000000
          Width = 370.393700790000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxDBLogEmail."NOMFUN">)]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 453.102660000000000000
          Top = 0.755905510000000000
          Width = 264.566929130000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxDBLogEmail."EMAIL_">)]')
          ParentFont = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 22.677162910000000000
        Top = 260.787570000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'rlbGrupoOnBeforePrint'
        Condition = 'VarToStr(<frxDBLogEmail."STATUS">)'
        KeepTogether = True
        ReprintOnNewPage = True
        object rllStatus: TfrxMemoView
          Top = 3.338590000000000000
          Width = 351.269140000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxdbLogEmail."STATUS"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 30.236220470000000000
        Top = 347.716760000000000000
        Width = 718.110700000000000000
        OnAfterPrint = 'GroupFooter1OnAfterPrint'
        object rlbTotal: TfrxMemoView
          Top = 3.220470000000000000
          Width = 114.897650000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total: [COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        object mmoFundoTitulo502378: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 22.677180000000000000
          Fill.BackColor = clSilver
        end
        object Memo14: TfrxMemoView
          Left = 1104.377952760000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
        end
        object Time: TfrxMemoView
          Left = 1124.800000000000000000
          Top = 1.784786670000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1006.400000000000000000
          Top = 1.784786670000000000
          Width = 113.461410000000000000
          Height = 17.000000000000000000
          OnPreviewClick = 'DateOnPreviewClick'
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Memo4: TfrxMemoView
          Top = 3.779530000000000000
          Width = 71.810760000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rlbDesCreOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N. FUNC.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 76.370137320000000000
          Top = 3.803154490000000000
          Width = 370.393700787401600000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 450.764077320000000000
          Top = 3.779530000000000000
          Width = 264.566929130000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'E-MAIL')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 438.425480000000000000
        Width = 718.110700000000000000
        object mnoRelatorioEspecifico0502378: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 464.882190000000000000
          Height = 15.118110240000000000
          AllowExpressions = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frmRelRecPagtoFunc]')
          ParentFont = False
          WordWrap = False
        end
        object mmoContaRegistro0502378: TfrxMemoView
          Align = baRight
          Left = 464.882190000000000000
          Top = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [VarToStr(<TOT_REGISTROS>)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Top = 0.677180000000000000
          Width = 718.110236220472400000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object cdsReciboFunc: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 388
    Top = 72
    object cdsReciboFuncVALREC: TStringField
      FieldName = 'VALREC'
      Size = 10
    end
    object cdsReciboFuncNOMREC: TStringField
      FieldName = 'NOMREC'
      Size = 50
    end
    object cdsReciboFuncVLREXT: TStringField
      FieldName = 'VLREXT'
      Size = 255
    end
    object cdsReciboFuncHISREC: TStringField
      FieldName = 'HISREC'
      Size = 1000
    end
    object cdsReciboFuncNROVIA: TStringField
      FieldName = 'NROVIA'
      Size = 10
    end
    object cdsReciboFuncDTAREC: TStringField
      DisplayWidth = 200
      FieldName = 'DTAREC'
      Size = 200
    end
    object cdsReciboFuncCPFFUN: TStringField
      DisplayWidth = 20
      FieldName = 'CPFFUN'
    end
    object cdsReciboFuncDTAEVE: TStringField
      FieldName = 'DTAEVE'
    end
    object cdsReciboFuncDTAEVEINC: TStringField
      DisplayWidth = 20
      FieldName = 'DTAEVEINC'
    end
    object cdsReciboFuncEMAIL_: TStringField
      DisplayWidth = 512
      FieldName = 'EMAIL_'
      Size = 512
    end
    object cdsReciboFuncCODFUN: TStringField
      FieldName = 'CODFUN'
      Size = 6
    end
  end
end
