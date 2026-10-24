inherited frmRelRetBcoCta: TfrmRelRetBcoCta
  Left = 452
  Top = 278
  Width = 425
  Height = 212
  BorderStyle = bsNone
  Caption = 'frmRelRetBcoCta'
  Position = poMainFormCenter
  ExplicitWidth = 425
  ExplicitHeight = 212
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 170
    Width = 425
    ExplicitTop = 170
    ExplicitWidth = 425
    inherited FlwBotoes: TFlowPanel
      Width = 344
      ExplicitWidth = 344
    end
    inherited btnSair: TBitBtnLocked
      Left = 346
      ExplicitLeft = 346
    end
  end
  inherited pnlStatus: TPanel
    Top = 196
    Width = 425
    ExplicitTop = 196
    ExplicitWidth = 425
    inherited pnlNomeForm: TPanel
      Left = 254
      ExplicitLeft = 254
    end
    inherited pnlInfo: TPanel
      Width = 254
      ExplicitWidth = 254
    end
  end
  inherited pnlDados: TPanel
    Width = 425
    Height = 170
    ExplicitWidth = 425
    ExplicitHeight = 170
    inherited gpbDestino: TGroupBox
      Top = 78
      Width = 164
      TabOrder = 2
      ExplicitTop = 78
      ExplicitWidth = 164
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 423
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Relat'#243'rio de Arq. Retorno'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
    object gpbOrdem: TGroupBox
      Left = 8
      Top = 30
      Width = 163
      Height = 49
      Caption = 'Ordenar por...'
      TabOrder = 0
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 24
        Width = 130
        Height = 14
        Caption = '(V)encimento (D)ocumento'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'V'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object GroupBox1: TGroupBox
      Left = 268
      Top = 30
      Width = 151
      Height = 49
      Caption = 'Mostrar dados'
      TabOrder = 1
      object ColorLabel3: TColorLabel
        Left = 28
        Top = 24
        Width = 113
        Height = 14
        Caption = '(F)ornecedor (A)rquivo'
        CorDestaque = clRed
      end
      object edtDados: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'F'
        OnChange = edtDadosChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 48
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 256
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
  end
  object frxRetBcoCta: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44124.426929236120000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'P'#193'GINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '    i : Integer;'
      '    tam : Integer;'
      '    str : string;                                    '
      'begin'
      ''
      '  tam := 6 - Length([COUNT(rlbDetalhes)]);              '
      '  str := '#39#39';                         '
      '  For i := 0 to tam-1 Do'
      '    str := str + '#39'0'#39';'
      ''
      
        '  rllTotalImpresso.Text := str + rllTotalImpresso.Text;         ' +
        '                           '
      '    '
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;'
      'end;'
      ''
      
        'procedure frxDBRetBcoCtaOcorrCODOCOOnBeforePrint(Sender: TfrxCom' +
        'ponent);'
      'begin'
      '  '
      'end;'
      ''
      
        'procedure frxDBRetBcoCtaOcorrCODOCOOnAfterPrint(Sender: TfrxComp' +
        'onent);'
      'begin'
      '  '
      'end;'
      ''
      'procedure rlldescOcoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlldescOco.text := IIF( (<frxDBRetBcoCtaOcorr."MOTOCO"> = '#39#39'),' +
        ' fRetDescOco( trim(<frxDBRetBcoCtaOcorr."CODOCO">) ), <frxDBRetB' +
        'coCtaOcorr."MOTOCO"> );  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxRetBcoCtaUserFunction
    Left = 48
    Top = 120
    Datasets = <
      item
        DataSet = frxDBRetBcoCta
        DataSetName = 'frxDBRetBcoCta'
      end
      item
        DataSet = frxDBRetBcoCtaOcorr
        DataSetName = 'frxDBRetBcoCtaOcorr'
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
        Height = 79.472480000000000000
        Top = 320.000000000000000000
        Width = 774.803650000000000000
        Child = frxRetBcoCta.Child1
        object Line3: TfrxLineView
          Left = -3.220470000000000000
          Width = 778.583180000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Left = 0.779530000000000000
          Top = 52.913420000000000000
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Subreport1: TfrxSubreport
          Left = 0.559060000000000000
          Top = 57.252010000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxRetBcoCta.Page1
        end
        object Memo11: TfrxMemoView
          Left = 440.645950000000000000
          Top = 5.669291338582677000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 508.685027170000000000
          Top = 5.669291340000000000
          Width = 71.811035830000000000
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
            '[SUM(<frxDBRetBcoCta."VALPAG">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 581.881899530000000000
          Top = 5.669291340000000000
          Width = 49.133846060000000000
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
            '[SUM(<frxDBRetBcoCta."OUTENT">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 631.818897640000000000
          Top = 5.669291340000000000
          Width = 37.795275590000000000
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
            '[SUM(<frxDBRetBcoCta."JURMOR">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 669.661417320000000000
          Top = 5.669291340000000000
          Width = 37.795273150000000000
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
            '[SUM(<frxDBRetBcoCta."DESCON">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 709.905511810000000000
          Top = 5.669291338582677000
          Width = 60.472438500000000000
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
            '[SUM(<frxDBRetBcoCta."VALDUP">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Top = 35.015770000000000000
          Width = 534.803418110000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            
              '(*) - Dependendo da ocorr'#234'ncia de retorno do t'#237'tulo, os campos D' +
              'TA. PAG e VR. PAGO s'#227'o meramente informativos.')
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
        Top = 244.000000000000000000
        Width = 774.803650000000000000
        DataSet = frxDBRetBcoCta
        DataSetName = 'frxDBRetBcoCta'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Top = 1.779530000000000000
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
        object frxDBDataset1CEPFOR: TfrxMemoView
          Left = 152.842610000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          DataField = 'CEPFOR'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCta."CEPFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1OCO: TfrxMemoView
          Left = 205.417440000000000000
          Width = 30.236240000000000000
          Height = 15.118110240000000000
          DataField = 'CODOCO'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCta."CODOCO"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NUMDUP: TfrxMemoView
          Left = 304.244280000000000000
          Width = 80.881899530000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'frxDBDataset1FORPGTOOnBeforePrint'
          DataField = 'NUMDUP'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCta."NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1CODEMP: TfrxMemoView
          Left = 384.378170000000000000
          Width = 22.677180000000000000
          Height = 15.118110240000000000
          DataField = 'CODEMP'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCta."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTAVEN: TfrxMemoView
          Left = 409.173470000000000000
          Width = 55.937007870000000000
          Height = 15.118110240000000000
          DataField = 'DTAVEN'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCta."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DTAPAG: TfrxMemoView
          Left = 465.645950000000000000
          Width = 60.472480000000000000
          Height = 15.118110240000000000
          DataField = 'DTAPAG'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRetBcoCta."DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALPAG: TfrxMemoView
          Left = 527.921267170000000000
          Width = 52.913385830000000000
          Height = 15.118110240000000000
          DataField = 'VALPAG'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
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
            '[frxDBRetBcoCta."VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1OUTENT: TfrxMemoView
          Left = 582.881899530000000000
          Width = 49.133846060000000000
          Height = 15.118110240000000000
          DataField = 'OUTENT'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
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
            '[frxDBRetBcoCta."OUTENT"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1JURMOR: TfrxMemoView
          Left = 633.818897640000000000
          Width = 37.795275590000000000
          Height = 15.118110240000000000
          DataField = 'JURMOR'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
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
            '[frxDBRetBcoCta."JURMOR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1CODFOR: TfrxMemoView
          Width = 151.181102362204700000
          Height = 15.118110240000000000
          DataField = 'CODFOR'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            '[frxDBRetBcoCta."CODFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1DESCON: TfrxMemoView
          Left = 674.220477320000000000
          Width = 34.015743150000000000
          Height = 15.118110240000000000
          DataField = 'DESCON'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
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
            '[frxDBRetBcoCta."DESCON"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1NOSNUM: TfrxMemoView
          Left = 238.110236220000000000
          Width = 64.251968500000000000
          Height = 15.118110240000000000
          DataField = 'NOSNUM'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCta."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object frxDBDataset1VALDUP: TfrxMemoView
          Left = 707.905511810000000000
          Width = 64.251968500000000000
          Height = 15.118110236220470000
          DataField = 'VALDUP'
          DataSet = frxDBRetBcoCta
          DataSetName = 'frxDBRetBcoCta'
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
            '[frxDBRetBcoCta."VALDUP"]')
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
        Top = 208.000000000000000000
        Width = 774.803650000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 0.779530000000000000
          Top = 1.511811020000000000
          Width = 150.803149606299200000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'CODIGO / NOME FORNECEDOR')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 153.606370000000000000
          Top = 1.511811020000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'CEP')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 206.519790000000000000
          Top = 1.511811020000000000
          Width = 28.346464020000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'OC')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 305.362400000000000000
          Top = 1.511811020000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NUM. DUP')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 383.590551180000000000
          Top = 1.511811020000000000
          Width = 23.811023620000000000
          Height = 11.338590000000000000
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
        object Memo9: TfrxMemoView
          Left = 409.291590000000000000
          Top = 1.511811020000000000
          Width = 55.937007870000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'DTA. VENC.')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 465.307360000000000000
          Top = 1.511811020000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DTA. PAG')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 527.338900000000000000
          Top = 1.732281020000000000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'VR PAGO')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 581.590910000000000000
          Top = 1.511811020000000000
          Width = 49.133858270000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'OUT. ENT.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 633.842920000000000000
          Top = 1.511811020000000000
          Width = 35.905511810000000000
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
        object Memo14: TfrxMemoView
          Left = 672.755905511810900000
          Top = 1.511811020000000000
          Width = 34.015748030000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          HAlign = haRight
          Memo.UTF8W = (
            'DESC')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 238.110236220472400000
          Top = 1.511811020000000000
          Width = 64.252010000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'NOSSO NUM.')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 716.551640000000000000
          Top = 1.511811020000000000
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
            'VR. DUPLIC')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 130.338590000000000000
        Top = 16.000000000000000000
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
            '[NOMEREL]')
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
        object rllNomeBanco: TfrxMemoView
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
            '[NOMEBCO]')
          ParentFont = False
        end
        object rllOrdem: TfrxMemoView
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
            '')
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
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 420.000000000000000000
        Width = 774.803650000000000000
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 559.446260000000000000
          Top = 4.047195280000000000
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
        object Memo18: TfrxMemoView
          Left = 2.000000000000000000
          Top = 4.047195280000000000
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
        object Line4: TfrxLineView
          Width = 774.803650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 2.500000000000000000
      RightMargin = 2.500000000000000000
      TopMargin = 4.500000000000000000
      BottomMargin = 4.500000000000000000
      ColumnWidth = 2.500000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 80.000000000000000000
        Width = 774.803650000000000000
        DataSet = frxDBRetBcoCtaOcorr
        DataSetName = 'frxDBRetBcoCtaOcorr'
        RowCount = 0
        object frxDBRetBcoCtaOcorrCODOCO: TfrxMemoView
          Left = 4.559060000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          OnAfterPrint = 'frxDBRetBcoCtaOcorrCODOCOOnAfterPrint'
          OnBeforePrint = 'frxDBRetBcoCtaOcorrCODOCOOnBeforePrint'
          DataField = 'CODOCO'
          DataSet = frxDBRetBcoCtaOcorr
          DataSetName = 'frxDBRetBcoCtaOcorr'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBRetBcoCtaOcorr."CODOCO"]')
          ParentFont = False
        end
        object frxDBRetBcoCtaOcorrQTDDUP: TfrxMemoView
          Left = 495.118430000000000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DataField = 'QTDDUP'
          DataSet = frxDBRetBcoCtaOcorr
          DataSetName = 'frxDBRetBcoCtaOcorr'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRetBcoCtaOcorr."QTDDUP"]')
          ParentFont = False
        end
        object frxDBRetBcoCtaOcorrVALDUP: TfrxMemoView
          Left = 623.622450000000000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DataSet = frxDBRetBcoCtaOcorr
          DataSetName = 'frxDBRetBcoCtaOcorr'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBRetBcoCtaOcorr."VALDUP"]')
          ParentFont = False
        end
        object rlldescOco: TfrxMemoView
          Left = 61.252010000000000000
          Width = 428.976578110000000000
          Height = 15.118110240000000000
          OnBeforePrint = 'rlldescOcoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'rlldescoco')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 16.000000000000000000
        Width = 774.803650000000000000
        object Memo23: TfrxMemoView
          Left = 0.559060000000000000
          Top = 31.118115120000000000
          Width = 54.803108110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 59.031540000000000000
          Top = 31.118115120000000000
          Width = 432.756108110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 495.118430000000000000
          Top = 31.118115120000000000
          Width = 115.275588110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QUANT. DUPLICATAS')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 623.622450000000000000
          Top = 31.118115120000000000
          Width = 115.275588110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DUPLICATAS')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baCenter
          Left = 178.582830945000000000
          Width = 417.637988110000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clWhite
          GapX = 5.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#211'DIGOS DE OCORR'#202'NCIAS')
          ParentFont = False
        end
      end
    end
  end
  object frxDBRetBcoCta: TfrxDBDataset
    UserName = 'frxDBRetBcoCta'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'NOSNUM=NOSNUM'
      'NUMDUP=NUMDUP'
      'CODEMP=CODEMP'
      'DTAVEN=DTAVEN'
      'DTAPAG=DTAPAG'
      'VALPAG=VALPAG'
      'JURMOR=JURMOR'
      'DESCON=DESCON'
      'OUTENT=OUTENT'
      'VALDUP=VALDUP'
      'VALTOT=VALTOT'
      'CODFOR=CODFOR'
      'NOMARQ=NOMARQ'
      'CEPFOR=CEPFOR')
    DataSet = qryRetBcoCta
    BCDToCurrency = False
    Left = 152
    Top = 80
  end
  object qryRetBcoCta: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      ''
      'SELECT '
      '  RET_CODOCO AS CODOCO,'
      '  RET_NOSNUM AS NOSNUM,'
      '  CONCAT(RET_NUMDUP, RET_PARCEL) AS NUMDUP,'
      '  RET_CODEMP AS CODEMP,'
      '  RET_DTAVEN AS DTAVEN,'
      '  RET_DTAPAG AS DTAPAG,'
      '  RET_VALPAG AS VALPAG,'
      '  IFNULL(RET_VALJUR, 0) AS JURMOR,'
      '  IFNULL(RET_VALDES, 0) AS DESCON,'
      '  IFNULL(RET_OUTENT, 0) AS OUTENT,'
      '  RET_VALDUP AS VALDUP,'
      
        '  RET_VALDUP + IFNULL(RET_VALJUR, 0) + IFNULL(RET_OUTENT, 0) - I' +
        'FNULL(RET_VALDES, 0) AS VALTOT,'
      '  CONCAT(RET_CODFOR, '#39'-'#39', FOR_NOMFOR) AS CODFOR,'
      '  CONCAT('
      '    RET_NOMARQ,'
      '    '#39' - '#39','
      '    RET_DTAARQ,'
      '    '#39' - '#39','
      '    RET_HORARQ'
      '  ) AS NOMARQ,'
      '  FOR_C_E_P_ AS CEPFOR '
      'FROM'
      '  RETCTP '
      '  LEFT JOIN CADFOR '
      '    ON FOR_CODFOR = RET_CODFOR '
      'GROUP BY RET_NUMDUP,'
      '  RET_PARCEL '
      'ORDER BY RET_CODOCO,'
      '  RET_DTAVEN ')
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 256
    Top = 80
    object qryRetBcoCtaCODOCO: TStringField
      FieldName = 'CODOCO'
      Required = True
      Size = 5
    end
    object qryRetBcoCtaNOSNUM: TStringField
      FieldName = 'NOSNUM'
      Size = 12
    end
    object qryRetBcoCtaNUMDUP: TStringField
      FieldName = 'NUMDUP'
      Size = 13
    end
    object qryRetBcoCtaCODEMP: TStringField
      FieldName = 'CODEMP'
      Required = True
      FixedChar = True
      Size = 3
    end
    object qryRetBcoCtaDTAVEN: TDateField
      FieldName = 'DTAVEN'
    end
    object qryRetBcoCtaDTAPAG: TDateField
      FieldName = 'DTAPAG'
    end
    object qryRetBcoCtaVALPAG: TFloatField
      FieldName = 'VALPAG'
    end
    object qryRetBcoCtaJURMOR: TFloatField
      FieldName = 'JURMOR'
    end
    object qryRetBcoCtaDESCON: TFloatField
      FieldName = 'DESCON'
    end
    object qryRetBcoCtaOUTENT: TFloatField
      FieldName = 'OUTENT'
    end
    object qryRetBcoCtaVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
    object qryRetBcoCtaVALTOT: TFloatField
      FieldName = 'VALTOT'
    end
    object qryRetBcoCtaCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 22
    end
    object qryRetBcoCtaNOMARQ: TStringField
      FieldName = 'NOMARQ'
      Size = 46
    end
    object qryRetBcoCtaCEPFOR: TStringField
      FieldName = 'CEPFOR'
      Size = 9
    end
  end
  object frxDBRetBcoCtaOcorr: TfrxDBDataset
    UserName = 'frxDBRetBcoCtaOcorr'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODOCO=CODOCO'
      'MOTOCO=MOTOCO'
      'QTDDUP=QTDDUP'
      'VALDUP=VALDUP')
    DataSet = qryRetBcoCtaOcorr
    BCDToCurrency = False
    Left = 152
    Top = 128
  end
  object qryRetBcoCtaOcorr: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT '
      '  RET_CODOCO AS CODOCO, '
      '  RET_MOTOCO AS MOTOCO, '
      '  COUNT(RET_CODOCO) AS QTDDUP,'
      '  SUM(RET_VALDUP) AS VALDUP '
      'FROM '
      '  RETCTP '
      'GROUP BY '
      '  RET_CODOCO '
      'ORDER BY '
      '  RET_CODOCO ')
    ReadOnly = True
    Options.SetFieldsReadOnly = False
    Constraints = <>
    Left = 256
    Top = 128
    object qryRetBcoCtaOcorrCODOCO: TStringField
      FieldName = 'CODOCO'
      Required = True
      Size = 5
    end
    object qryRetBcoCtaOcorrMOTOCO: TStringField
      FieldName = 'MOTOCO'
    end
    object qryRetBcoCtaOcorrQTDDUP: TLargeintField
      FieldName = 'QTDDUP'
    end
    object qryRetBcoCtaOcorrVALDUP: TFloatField
      FieldName = 'VALDUP'
    end
  end
end
