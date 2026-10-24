inherited frmRelRelCtaDuplicatas: TfrmRelRelCtaDuplicatas
  Left = 236
  Top = 212
  Width = 359
  Height = 155
  BorderStyle = bsNone
  Caption = 'frmRelRelCtaDuplicatas'
  Position = poMainFormCenter
  ExplicitWidth = 359
  ExplicitHeight = 155
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 113
    Width = 359
    ExplicitTop = 113
    ExplicitWidth = 359
    inherited FlwBotoes: TFlowPanel
      Width = 278
      ExplicitWidth = 278
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Width = 81
        Align = alLeft
        ExplicitWidth = 81
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 280
      ExplicitLeft = 280
    end
  end
  inherited pnlStatus: TPanel
    Top = 139
    Width = 359
    ExplicitTop = 139
    ExplicitWidth = 359
    inherited pnlNomeForm: TPanel
      Left = 208
      Width = 151
      ExplicitLeft = 208
      ExplicitWidth = 151
    end
    inherited pnlInfo: TPanel
      Width = 208
      ExplicitWidth = 208
    end
  end
  inherited pnlDados: TPanel
    Width = 359
    Height = 113
    BevelOuter = bvNone
    ExplicitWidth = 359
    ExplicitHeight = 113
    inherited gpbDestino: TGroupBox
      Enabled = False
      TabOrder = 1
      Visible = False
    end
    object pnlFundo: TPanel
      Left = 0
      Top = 0
      Width = 359
      Height = 113
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label5: TLabel
        Left = 3
        Top = 37
        Width = 59
        Height = 14
        Caption = 'Fornecedor:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 16
        Top = 57
        Width = 45
        Height = 14
        Caption = 'Empresa:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object pnlTopo: TPanel
        Left = 2
        Top = 2
        Width = 355
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Relat'#243'rio de Duplicatas'
        Color = clNavy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 17
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object edtFornecedor: TEditFocus
        Tag = 99
        Left = 62
        Top = 35
        Width = 57
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        OnExit = edtFornecedorExit
        OnKeyPress = edtFornecedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtEmpresa: TEditFocus
        Tag = 99
        Left = 62
        Top = 55
        Width = 57
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        OnExit = edtEmpresaExit
        OnKeyPress = edtEmpresaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesFornecedor: TEdit
        Left = 120
        Top = 35
        Width = 221
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 3
      end
      object edtDesEmpresa: TEdit
        Left = 120
        Top = 55
        Width = 221
        Height = 19
        AutoSize = False
        Enabled = False
        TabOrder = 4
      end
    end
  end
  object qryDuplicatasRem: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  CONCAT(PGI_NUMDUP, PGI_PARCEL) AS NUMDUP, '
      '  PGI_CODEMP AS CODEMP, '
      '  PGI_CODFOR AS CODFOR, '
      '  FOR_NOMFOR AS NOMFOR, '
      '  PGI_DTACAD AS DTACAD, '
      '  PGI_DTAVEN AS DTAVEN, '
      
        '  ((IFNULL(PGI_VALDUP,0) * IFNULL(PGI_VALJUR,0)) /100) AS PORCEN' +
        ', '
      '  PGI_VALDUP AS VALDUP, '
      
        '  PGI_VALDUP + IFNULL(PGI_OUTENT, 0) - IFNULL(PGI_VALDES, 0) AS ' +
        'VALTOT, '
      '  PGI_FORPGT AS FORPGTO, '
      '  IFNULL(PGI_VALDES, 0) AS DESCON, '
      '  PGI_OUTENT AS OUTENT '
      'FROM '
      '  CADPGI '
      '  JOIN CADFOR ON FOR_CODFOR = PGI_CODFOR ')
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 224
    Top = 64
    object qryDuplicatasRemNUMDUP: TStringField
      FieldName = 'NUMDUP'
      Size = 13
    end
    object qryDuplicatasRemCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryDuplicatasRemCODFOR: TStringField
      FieldName = 'CODFOR'
      Required = True
      Size = 8
    end
    object qryDuplicatasRemNOMFOR: TStringField
      FieldName = 'NOMFOR'
      Size = 60
    end
    object qryDuplicatasRemDTACAD: TDateField
      FieldName = 'DTACAD'
      Required = True
    end
    object qryDuplicatasRemDTAVEN: TDateField
      FieldName = 'DTAVEN'
      Required = True
    end
    object qryDuplicatasRemPORCEN: TFloatField
      FieldName = 'PORCEN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDuplicatasRemVALDUP: TFloatField
      FieldName = 'VALDUP'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDuplicatasRemVALTOT: TFloatField
      FieldName = 'VALTOT'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDuplicatasRemFORPGTO: TStringField
      FieldName = 'FORPGTO'
      OnGetText = qryDuplicatasRemFORPGTOGetText
      Size = 3
    end
    object qryDuplicatasRemDESCON: TFloatField
      FieldName = 'DESCON'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object qryDuplicatasRemOUTENT: TFloatField
      FieldName = 'OUTENT'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'CODFOR=CODFOR'
      'NOMFOR=NOMFOR'
      'DTACAD=DTACAD'
      'DTAVEN=DTAVEN'
      'PORCEN=PORCEN'
      'VALDUP=VALDUP'
      'VALTOT=VALTOT'
      'FORPGTO=FORPGTO'
      'DESCON=DESCON'
      'OUTENT=OUTENT')
    DataSet = qryDuplicatasRem
    BCDToCurrency = False
    Left = 136
    Top = 64
  end
  object frxDuplicatasRem: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44118.646229988400000000
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
      ''
      'begin'
      ''
      'end.')
    Left = 40
    Top = 64
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
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
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 53.015770000000000000
        Top = 328.819110000000000000
        Width = 774.803650000000000000
        object Memo11: TfrxMemoView
          Left = 437.205010000000000000
          Top = 5.779530000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAIS:')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = -3.220470000000000000
          Width = 778.583180000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo12: TfrxMemoView
          Left = 483.000310000000000000
          Top = 5.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."OUTENT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 552.472790000000000000
          Top = 5.559060000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."PORCEN">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 596.827150000000000000
          Top = 5.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."DESCON">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 649.740570000000000000
          Top = 5.559060000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."VALDUP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 716.992580000000000000
          Top = 5.559060000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."VALTOT">,rlbDetalhes)]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 559.446260000000000000
          Top = 36.015770000000000000
          Width = 215.357390000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 0.779530000000000000
          Top = 30.236240000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.015770000000000000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEFORM]')
          ParentFont = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 249.448980000000000000
        Width = 774.803650000000000000
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 778.960659210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = cl3DLight
        end
        object frxDBDataset1CODEMP: TfrxMemoView
          Left = 94.606370000000000000
          Top = 1.000000000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataField = 'CODEMP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1CODFOR: TfrxMemoView
          Left = 122.724490000000000000
          Top = 1.000000000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CODFOR'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."CODFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1FORPGTO: TfrxMemoView
          Left = 299.700990000000000000
          Top = 0.440940000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'frxDBDataset1FORPGTOOnBeforePrint'
          DataField = 'FORPGTO'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."FORPGTO"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTACAD: TfrxMemoView
          Left = 358.055350000000000000
          Top = 1.000000000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataField = 'DTACAD'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DTACAD"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTAVEN: TfrxMemoView
          Left = 420.086890000000000000
          Top = 1.000000000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'DTAVEN'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1OUTENT: TfrxMemoView
          Left = 479.000310000000000000
          Top = 1.000000000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'OUTENT'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."OUTENT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1PORCEN: TfrxMemoView
          Left = 552.590910000000000000
          Top = 1.220470000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'PORCEN'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PORCEN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DESCON: TfrxMemoView
          Left = 591.606680000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          DataField = 'DESCON'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALDUP: TfrxMemoView
          Left = 649.079160000000000000
          Top = 1.000000000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'VALDUP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NUMDUP: TfrxMemoView
          Left = 2.000000000000000000
          Top = 0.559060000000000000
          Width = 92.598420310000000000
          Height = 15.118120000000000000
          DataField = 'NUMDUP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBDataset1."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALTOT: TfrxMemoView
          Left = 714.772110000000000000
          Top = 1.220470000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DataField = 'VALTOT'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALTOT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NOMFOR: TfrxMemoView
          Left = 177.637910000000000000
          Top = 1.000000000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          DataField = 'NOMFOR'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDataset1."NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Fill.BackColor = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 15.874015750000000000
        ParentFont = False
        Top = 211.653680000000000000
        Width = 774.803650000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 2.779530000000000000
          Top = 2.000000000000000000
          Width = 92.598408110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'No. DUPLICATA')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 95.606370000000000000
          Top = 2.000000000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 123.063080000000000000
          Top = 2.000000000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 299.819110000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'PGTO.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 357.055350000000000000
          Top = 2.000000000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DAT.CAD.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 419.205010000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DAT.VEN.')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 479.000310000000000000
          Top = 2.000000000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'OUTRAS. ENT.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 551.811380000000000000
          Top = 2.000000000000000000
          Width = 37.795300000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'JUROS')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 590.606680000000000000
          Top = 2.000000000000000000
          Width = 56.692950000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 648.079160000000000000
          Top = 2.000000000000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DUP.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 713.331170000000000000
          Top = 2.000000000000000000
          Width = 60.472480000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOT.')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 176.519790000000000000
          Top = 2.000000000000000000
          Width = 120.944960000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'FORNECEDOR')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 130.338590000000000000
        Top = 18.897650000000000000
        Width = 774.803650000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 186.066420000000000000
          Top = 23.440940000000000000
          Width = 402.670810000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE DUPLICATAS PARA REMESSA - CONTAS A PAGAR')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 689.839890000000000000
          Top = 3.984230000000000000
          Width = 84.963760000000000000
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
        object Date: TfrxMemoView
          Left = 681.630490000000000000
          Top = 25.543290000000000000
          Width = 90.784230000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[DATAHORA]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 128.504020000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 187.011380000000000000
          Top = 3.779530000000000000
          Width = 400.780890000000000000
          Height = 17.000000000000000000
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
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Align = baLeft
          Top = 79.370130000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[FORNECEDOR]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Align = baLeft
          Top = 99.047310000000000000
          Width = 474.481880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 625.842920000000000000
          Top = 26.677180000000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM')
          ParentFont = False
        end
      end
    end
  end
end
