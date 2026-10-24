inherited frmRelEstKardexFiscal: TfrmRelEstKardexFiscal
  Left = 386
  Top = 219
  Width = 402
  Height = 430
  Caption = 'Ficha Kardex Fiscal de Produtos'
  OnDestroy = FormDestroy
  ExplicitWidth = 402
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 359
    Width = 396
    ExplicitTop = 359
    ExplicitWidth = 396
    inherited FlwBotoes: TFlowPanel
      Width = 315
    end
    inherited btnSair: TBitBtnLocked
      Left = 317
      ExplicitLeft = 317
    end
  end
  inherited pnlDados: TPanel
    Width = 396
    Height = 359
    ExplicitWidth = 396
    ExplicitHeight = 359
    object pnlTopo: TPanel [0]
      Left = 1
      Top = 1
      Width = 394
      Height = 165
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object Label10: TLabel
        Left = 12
        Top = 5
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
      object Label11: TLabel
        Left = 12
        Top = 42
        Width = 30
        Height = 14
        Caption = 'Marca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 12
        Top = 79
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
      object lblNumLot: TLabel
        Left = 12
        Top = 116
        Width = 21
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lote'
        Enabled = False
      end
      object shpLibPre: TShape
        Left = 4
        Top = 19
        Width = 8
        Height = 21
      end
      object edtProdutos: TEditFocus
        Tag = 99
        Left = 12
        Top = 19
        Width = 53
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
        TabOrder = 0
        OnEnter = edtProdutosEnter
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
        Left = 67
        Top = 19
        Width = 314
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesMarca: TEditFocus
        Left = 12
        Top = 56
        Width = 369
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEmpresa: TEditFocus
        Tag = 99
        Left = 12
        Top = 93
        Width = 37
        Height = 22
        Alignment = taLeftJustify
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
        OnEnter = edtEmpresaEnter
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
      object edtDesEmpresa: TEditFocus
        Left = 46
        Top = 93
        Width = 335
        Height = 22
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
      object edtNumLot: TEditFocus
        Tag = 99
        Left = 12
        Top = 130
        Width = 189
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 5
        OnExit = edtNumLotExit
        OnKeyPress = edtNumLotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlGeral: TPanel [1]
      Left = 1
      Top = 166
      Width = 394
      Height = 192
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object Label5: TLabel
        Left = 8
        Top = 8
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
      object Label7: TLabel
        Left = 98
        Top = 26
        Width = 75
        Height = 14
        Caption = '(MOVIMENTO)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 98
        Top = 64
        Width = 75
        Height = 14
        Caption = '(MOVIMENTO)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 46
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
      object lblComCus: TLabel
        Left = 179
        Top = 97
        Width = 151
        Height = 14
        Caption = 'Composi'#231#227'o do Pre'#231'o de Custo'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 8
        Top = 22
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
        Top = 60
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
      object gpbOpcao: TGroupBox
        Left = 179
        Top = 8
        Width = 202
        Height = 84
        Caption = 'Op'#231#227'o'
        TabOrder = 2
        object ColorLabel2: TColorLabel
          Left = 29
          Top = 19
          Width = 166
          Height = 14
          Caption = '(1) Pre'#231'o de Entrada/Sa'#237'da sem IPI'
          CorDestaque = clRed
        end
        object ColorLabel3: TColorLabel
          Left = 29
          Top = 49
          Width = 91
          Height = 14
          Caption = '(3) Pre'#231'o de Custo'
          CorDestaque = clRed
        end
        object ColorLabel4: TColorLabel
          Left = 29
          Top = 34
          Width = 166
          Height = 14
          Caption = '(2) Pre'#231'o de Entrada/Sa'#237'da com IPI'
          CorDestaque = clRed
        end
        object ColorLabel5: TColorLabel
          Left = 29
          Top = 64
          Width = 146
          Height = 14
          Caption = '(4) Pre'#231'o de Custo + Impostos'
          CorDestaque = clRed
        end
        object edtOpcao: TEditFocus
          Tag = 99
          Left = 7
          Top = 33
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = '1'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object pgbProgresso: TProgressBar
        Left = 1
        Top = 185
        Width = 392
        Height = 6
        Align = alBottom
        Smooth = True
        TabOrder = 3
        Visible = False
      end
      object cbbComCus: TComboBoxFocus
        Tag = 99
        Left = 179
        Top = 111
        Width = 202
        Height = 22
        Style = csDropDownList
        Enabled = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    inherited gpbDestino: TGroupBox
      Left = 180
      Top = 300
      Width = 202
      TabOrder = 2
      ExplicitLeft = 180
      ExplicitTop = 300
      ExplicitWidth = 202
      inherited ColorLabel1: TColorLabel
        Left = 29
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitWidth = 138
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 385
    Width = 396
    ExplicitTop = 385
    ExplicitWidth = 396
    inherited pnlNomeForm: TPanel
      Left = 225
      ExplicitLeft = 225
    end
    inherited pnlInfo: TPanel
      Width = 225
      ExplicitWidth = 225
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 120
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 360
    Top = 120
  end
  inherited frxExpRTF: TfrxRTFExport
    Top = 88
  end
  inherited frxExpXLS: TfrxXLSExport
    Top = 88
  end
  inherited frxExpHtml: TfrxHTMLExport
    Top = 88
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 360
    Top = 56
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 264
    Top = 120
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 200
    Top = 120
  end
  inherited frxGen: TfrxUserDataSet
    Left = 232
    Top = 120
  end
  inherited frxDesigner: TfrxDesigner
    Top = 88
  end
  inherited frxComandos: TfrxUserDataSet
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 120
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42551.389319270800000000
    ReportOptions.LastChange = 42570.675954513890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltQtdEnt: Double;'
      '  fltQtdSai: Double;'
      '    '
      'procedure rdbCodCliOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."TIP_FC"> = '#39'C'#39') Then                  '
      
        '    rdbCodCli.Text := fImprimeClienteFornecedor(<frxRelatorio."T' +
        'IP_FC">, '
      
        '                                                <frxRelatorio."C' +
        'ODCLI">, '
      
        '                                                <frxRelatorio."N' +
        'UMDOC">, '
      
        '                                                <frxRelatorio."E' +
        'SPDOC">, '
      
        '                                                <frxRelatorio."C' +
        'ODEMP">)'
      '  Else'
      
        '    rdbCodCli.Text := fImprimeClienteFornecedor(<frxRelatorio."T' +
        'IP_FC">, '
      
        '                                                <frxRelatorio."C' +
        'ODFOR">,'
      
        '                                                <frxRelatorio."N' +
        'UMDOC">, '
      
        '                                                <frxRelatorio."E' +
        'SPDOC">, '
      
        '                                                <frxRelatorio."C' +
        'ODEMP">);        '
      'end;'
      ''
      'procedure rdbCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbCodigo.Text := <frxRelatorio."NUMDOC"> + fVerificaDocumento' +
        'Alterado(<frxRelatorio."NUMDOC">, '
      
        '                                                                ' +
        '         <frxRelatorio."ESPDOC">, '
      
        '                                                                ' +
        '         <frxRelatorio."CODEMP">, '
      
        '                                                                ' +
        '         <frxRelatorio."CODFOR">, '
      
        '                                                                ' +
        '         <frxRelatorio."SERIE_">, '
      
        '                                                                ' +
        '         <frxRelatorio."TIP_FC">, '
      
        '                                                                ' +
        '         <frxRelatorio."CLAFIS">);  '
      'end;'
      ''
      
        'procedure lblQtdEntOnBeforePrint(Sender: TfrxComponent);        ' +
        '                                                            '
      'begin'
      
        '  lblQtdEnt.Text := fVerificaFatorQuantidadeItem(<frxRelatorio."' +
        'QTDITEENT">,'
      
        '                                                 <frxRelatorio."' +
        'ITE_CNV_ML">,'
      
        '                                                 <frxRelatorio."' +
        'ESPORI">, '
      
        '                                                 <frxRelatorio."' +
        'CANCEL">);'
      ''
      '  If (<frxRelatorio."ESPORI"> <> '#39'ML'#39') And'
      '     (<frxRelatorio."ITE_CNV_ML"> > 1)      Then'
      '  Begin'
      
        '    fltQtdEnt := fltQtdEnt + (<frxRelatorio."QTDITEENT"> * <frxR' +
        'elatorio."ITE_CNV_ML">)     '
      '  End'
      '  Else            '
      
        '    fltQtdEnt := fltQtdEnt + <frxRelatorio."QTDITEENT">;        ' +
        '                                                                ' +
        '                                                       '
      'end;'
      ''
      'procedure rdbTotCusEntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotCusEnt.Text := fVerificaCustoItem(<frxRelatorio."TOTCUSE' +
        'NT">, <frxRelatorio."ITE_CNV_ML">);                        '
      'end;'
      ' '
      'procedure rdbUnitarEntOnBeforePrint(Sender: TfrxComponent);'
      '  var'
      
        '    blnComIpi: Boolean;                                         ' +
        '                            '
      'begin'
      '  blnComIpi := <frxRelatorio."VALIPIENT"> <> 0;'
      '    '
      '  rdbUnitarEnt.Text := fVerificaFatorValorUnitario(blnComIpi, '
      
        '                                                   <frxRelatorio' +
        '."UNITARENT">, '
      
        '                                                   <frxRelatorio' +
        '."VALIPIENT">, '
      
        '                                                   <frxRelatorio' +
        '."ITE_CNV_ML">);  '
      '      '
      'end;'
      ''
      'procedure lblQtdSaiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  lblQtdSai.Text := fVerificaFatorQuantidadeItem(<frxRelatorio."' +
        'QTDITESAI">,'
      
        '                                                 <frxRelatorio."' +
        'ITE_CNV_ML">,'
      
        '                                                 <frxRelatorio."' +
        'ESPORI">, '
      
        '                                                 <frxRelatorio."' +
        'CANCEL">);'
      ''
      '  If (<frxRelatorio."ESPORI"> <> '#39'ML'#39') And'
      '     (<frxRelatorio."ITE_CNV_ML"> > 1)      Then'
      '  Begin'
      
        '    fltQtdSai := fltQtdSai + (<frxRelatorio."QTDITESAI"> * <frxR' +
        'elatorio."ITE_CNV_ML">)     '
      '  End'
      '  Else            '
      
        '    fltQtdSai := fltQtdSai + <frxRelatorio."QTDITESAI">;        ' +
        '                                                                ' +
        '                                                 '
      'end;'
      ''
      'procedure rdbTotCusSaiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotCusSai.Text := fVerificaCustoItem(<frxRelatorio."TOTCUSS' +
        'AI">, <frxRelatorio."ITE_CNV_ML">);  '
      'end;'
      ''
      'procedure rdbUnitarSaiOnBeforePrint(Sender: TfrxComponent);'
      '  var'
      
        '    blnComIpi: Boolean;                                         ' +
        '                            '
      'begin'
      '  blnComIpi := <frxRelatorio."VALIPISAI"> <> 0;'
      '    '
      '  rdbUnitarSai.Text := fVerificaFatorValorUnitario(blnComIpi, '
      
        '                                                   <frxRelatorio' +
        '."UNITARSAI">, '
      
        '                                                   <frxRelatorio' +
        '."VALIPISAI">, '
      
        '                                                   <frxRelatorio' +
        '."ITE_CNV_ML">);'
      'end;'
      ''
      'procedure rllProCanOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."CANCEL"> = '#39'N'#39') Then'
      '    rllProCan.Text := '#39#39
      '  Else'
      
        '    rllProCan.Text := '#39'*'#39';                                      ' +
        '                            '
      'end;'
      ''
      'procedure rdbDtaEntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbDtaEnt.Text := FormatDateTime('#39'dd/mm/yy'#39',<frxRelatorio."DTA' +
        'ENT">) + '#39' '#39' +'
      
        '                    FormatDateTime('#39'hh:mm'#39',   <frxRelatorio."HOR' +
        'ENT">);  '
      'end;'
      ''
      'procedure lblTotQtdEntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  lblTotQtdEnt.Text := fFormataQuantidadeTotal(fltQtdEnt);      ' +
        '        '
      'end;'
      ''
      'procedure lblTotQtdSaiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  lblTotQtdSai.Text := fFormataQuantidadeTotal(fltQtdSai);      ' +
        '                              '
      'end;'
      ''
      'begin'
      '  fltQtdEnt := 0;'
      '  fltQtdSai := 0;                                    '
      'end.')
    OnUserFunction = frxRelatorioMUserFunction
    Left = 113
    Top = 265
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
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
    object Page1: TfrxReportPage
      PaperWidth = 348.600000000000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 35.881880000000000000
        Top = 196.535560000000000000
        Width = 1241.953558000000000000
        object Shape2: TfrxShapeView
          Left = 2.000000000000000000
          Width = 1239.685840000000000000
          Height = 35.905511810000000000
          Fill.BackColor = 13421772
        end
        object Memo7: TfrxMemoView
          Left = 663.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'E N T R A D A S')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 962.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'S A '#205' D A S')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 17.000000000000000000
          Width = 93.959060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 112.800000000000000000
          Top = 17.000000000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TP')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 140.600000000000000000
          Top = 17.000000000000000000
          Width = 32.579530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 174.000000000000000000
          Top = 17.000000000000000000
          Width = 90.179530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 277.400000000000000000
          Top = 17.000000000000000000
          Width = 243.779530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO-CLIENTE/FORNECEDOR')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 526.600000000000000000
          Top = 17.000000000000000000
          Width = 36.359060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPE')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 565.000000000000000000
          Top = 17.000000000000000000
          Width = 45.959060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 653.600000000000000000
          Top = 17.000000000000000000
          Width = 45.959060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object lblValUniEnt: TfrxMemoView
          Left = 820.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR UNIT')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 952.600000000000000000
          Top = 17.000000000000000000
          Width = 49.738590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object lblValUniSai: TfrxMemoView
          Left = 1133.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR UNIT')
          ParentFont = False
        end
        object lblCustoEnt: TfrxMemoView
          Left = 731.000000000000000000
          Top = 17.000000000000000000
          Width = 59.338590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
        end
        object lblCustoSai: TfrxMemoView
          Left = 1046.600000000000000000
          Top = 17.000000000000000000
          Width = 55.559060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 152.984230000000000000
        Top = 18.897650000000000000
        Width = 1241.953558000000000000
        object Shape1: TfrxShapeView
          Left = 2.000000000000000000
          Top = 119.385900000000000000
          Width = 1239.685840000000000000
          Height = 34.015770000000000000
          Fill.BackColor = 13421772
        end
        object rllNomeEmpresa: TfrxMemoView
          Left = 395.376779000000000000
          Top = 17.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
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
          Left = 395.376779000000000000
          Top = 34.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELAT'#211'RIO DE FICHA KARDEX FISCAL DE PRODUTOS')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 1104.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            'P'#193'GINA: [Page]')
        end
        object Time: TfrxMemoView
          Left = 1152.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1025.390600000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date]')
        end
        object rllPeriodo: TfrxMemoView
          Left = 222.576779000000000000
          Top = 77.440940000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo1: TfrxMemoView
          Top = 119.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[ITEM]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 470.400000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 806.400000000000000000
          Top = 119.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 931.200000000000000000
          Top = 119.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[LOTE]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 4.118120000000000000
          Top = 96.488250000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 294.803340000000000000
        Width = 1241.953558000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Width = 1241.574734800000000000
          Height = 17.007874020000000000
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object rdbCodigo: TfrxMemoView
          Width = 113.007886220000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCodigoOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 112.800000000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."ESPDOC"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 140.600000000000000000
          Width = 32.579530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
        end
        object rdbDtaEnt: TfrxMemoView
          Left = 174.000000000000000000
          Width = 102.122820000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbDtaEntOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '')
          ParentFont = False
        end
        object rdbCodCli: TfrxMemoView
          Left = 277.400000000000000000
          Width = 245.820470000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCodCliOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 526.600000000000000000
          Width = 40.138590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODOPE"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 565.000000000000000000
          Width = 49.738590000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CFOP"]')
          ParentFont = False
        end
        object lblQtdEnt: TfrxMemoView
          Left = 614.897650000000000000
          Width = 84.661410000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblQtdEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rdbTotCusEnt: TfrxMemoView
          Left = 703.938590000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotCusEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rdbUnitarEnt: TfrxMemoView
          Left = 791.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbUnitarEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object lblQtdSai: TfrxMemoView
          Left = 917.677162910000000000
          Width = 84.661427090000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblQtdSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rdbTotCusSai: TfrxMemoView
          Left = 1006.159060000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotCusSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rdbUnitarSai: TfrxMemoView
          Left = 1104.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbUnitarSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object rllProCan: TfrxMemoView
          Left = 1230.174090000000000000
          Width = 11.338590000000000000
          Height = 17.007874020000000000
          OnBeforePrint = 'rllProCanOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '*')
          ParentFont = False
        end
      end
      object rlbResumo2: TfrxReportSummary
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 374.173470000000000000
        Width = 1241.953558000000000000
        Child = frxRelatorioJ.rlbResumo3
        object Memo32: TfrxMemoView
          Left = 461.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
        end
        object lblTotQtdEnt: TfrxMemoView
          Left = 558.204700000000000000
          Width = 141.354360000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblTotQtdEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
        end
        object lblTotQtdSai: TfrxMemoView
          Left = 860.984259290000000000
          Width = 141.354330710000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblTotQtdSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
        end
      end
      object rlbResumo3: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 415.748300000000000000
        Width = 1241.953558000000000000
        object Memo35: TfrxMemoView
          Left = 598.237170000000000000
          Width = 639.495980000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'FATOR TINTOM'#201'TRICO: [FATTIN]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Width = 1241.952755905512000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbResumo: TfrxPageFooter
        FillType = ftBrush
        Height = 20.779530000000000000
        Top = 457.323130000000000000
        Width = 1241.953558000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 488.878110000000000000
          Width = 751.823500000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETALHE)]')
        end
        object frxGenREL_NOMREL: TfrxMemoView
          Width = 488.088250000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
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
        object Memo6: TfrxMemoView
          Left = 234.330860000000000000
          Width = 487.559370000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Memo.UTF8W = (
            
              '(**) Transfer'#234'ncia de Mercadorias     (***) Docto Alterado pelo ' +
              'Usu'#225'rio')
          ParentFont = False
        end
      end
    end
  end
  object frxRelatorioM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42551.389319270800000000
    ReportOptions.LastChange = 42570.675474155090000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  fltQtdEnt: Double;'
      '  fltQtdSai: Double;'
      '    '
      'procedure rdbCodCliOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."TIP_FC"> = '#39'C'#39') Then                  '
      
        '    rdbCodCli.Text := fImprimeClienteFornecedor(<frxRelatorio."T' +
        'IP_FC">, '
      
        '                                                <frxRelatorio."C' +
        'ODCLI">, '
      
        '                                                <frxRelatorio."N' +
        'UMDOC">, '
      
        '                                                <frxRelatorio."E' +
        'SPDOC">, '
      
        '                                                <frxRelatorio."C' +
        'ODEMP">)'
      '  Else'
      
        '    rdbCodCli.Text := fImprimeClienteFornecedor(<frxRelatorio."T' +
        'IP_FC">, '
      
        '                                                <frxRelatorio."C' +
        'ODFOR">,'
      
        '                                                <frxRelatorio."N' +
        'UMDOC">, '
      
        '                                                <frxRelatorio."E' +
        'SPDOC">, '
      
        '                                                <frxRelatorio."C' +
        'ODEMP">);        '
      'end;'
      ''
      'procedure rdbCodigoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbCodigo.Text := <frxRelatorio."NUMDOC"> + fVerificaDocumento' +
        'Alterado(<frxRelatorio."NUMDOC">, '
      
        '                                                                ' +
        '         <frxRelatorio."ESPDOC">, '
      
        '                                                                ' +
        '         <frxRelatorio."CODEMP">, '
      
        '                                                                ' +
        '         <frxRelatorio."CODFOR">, '
      
        '                                                                ' +
        '         <frxRelatorio."SERIE_">, '
      
        '                                                                ' +
        '         <frxRelatorio."TIP_FC">, '
      
        '                                                                ' +
        '         <frxRelatorio."CLAFIS">);  '
      'end;'
      ''
      
        'procedure lblQtdEntOnBeforePrint(Sender: TfrxComponent);        ' +
        '                                                            '
      'begin'
      
        '  lblQtdEnt.Text := fVerificaFatorQuantidadeItem(<frxRelatorio."' +
        'QTDITEENT">,'
      
        '                                                 <frxRelatorio."' +
        'ITE_CNV_ML">,'
      
        '                                                 <frxRelatorio."' +
        'ESPORI">, '
      
        '                                                 <frxRelatorio."' +
        'CANCEL">);'
      ''
      '  If (<frxRelatorio."ESPORI"> <> '#39'ML'#39') And'
      '     (<frxRelatorio."ITE_CNV_ML"> > 1)      Then'
      '  Begin'
      
        '    fltQtdEnt := fltQtdEnt + (<frxRelatorio."QTDITEENT"> * <frxR' +
        'elatorio."ITE_CNV_ML">)     '
      '  End'
      '  Else            '
      
        '    fltQtdEnt := fltQtdEnt + <frxRelatorio."QTDITEENT">;        ' +
        '                                                                ' +
        '                                                       '
      'end;'
      ''
      'procedure rdbTotCusEntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotCusEnt.Text := fVerificaCustoItem(<frxRelatorio."TOTCUSE' +
        'NT">, <frxRelatorio."ITE_CNV_ML">);                        '
      'end;'
      ' '
      'procedure rdbUnitarEntOnBeforePrint(Sender: TfrxComponent);'
      '  var'
      
        '    blnComIpi: Boolean;                                         ' +
        '                            '
      'begin'
      '  blnComIpi := <frxRelatorio."VALIPIENT"> <> 0;'
      '    '
      '  rdbUnitarEnt.Text := fVerificaFatorValorUnitario(blnComIpi, '
      
        '                                                   <frxRelatorio' +
        '."UNITARENT">, '
      
        '                                                   <frxRelatorio' +
        '."VALIPIENT">, '
      
        '                                                   <frxRelatorio' +
        '."ITE_CNV_ML">);  '
      '      '
      'end;'
      ''
      'procedure lblQtdSaiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  lblQtdSai.Text := fVerificaFatorQuantidadeItem(<frxRelatorio."' +
        'QTDITESAI">,'
      
        '                                                 <frxRelatorio."' +
        'ITE_CNV_ML">,'
      
        '                                                 <frxRelatorio."' +
        'ESPORI">, '
      
        '                                                 <frxRelatorio."' +
        'CANCEL">);'
      ''
      '  If (<frxRelatorio."ESPORI"> <> '#39'ML'#39') And'
      '     (<frxRelatorio."ITE_CNV_ML"> > 1)      Then'
      '  Begin'
      
        '    fltQtdSai := fltQtdSai + (<frxRelatorio."QTDITESAI"> * <frxR' +
        'elatorio."ITE_CNV_ML">)     '
      '  End'
      '  Else            '
      
        '    fltQtdSai := fltQtdSai + <frxRelatorio."QTDITESAI">;        ' +
        '                                                                ' +
        '                                                 '
      'end;'
      ''
      'procedure rdbTotCusSaiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbTotCusSai.Text := fVerificaCustoItem(<frxRelatorio."TOTCUSS' +
        'AI">, <frxRelatorio."ITE_CNV_ML">);  '
      'end;'
      ''
      'procedure rdbUnitarSaiOnBeforePrint(Sender: TfrxComponent);'
      '  var'
      
        '    blnComIpi: Boolean;                                         ' +
        '                            '
      'begin'
      '  blnComIpi := <frxRelatorio."VALIPISAI"> <> 0;'
      '    '
      '  rdbUnitarSai.Text := fVerificaFatorValorUnitario(blnComIpi, '
      
        '                                                   <frxRelatorio' +
        '."UNITARSAI">, '
      
        '                                                   <frxRelatorio' +
        '."VALIPISAI">, '
      
        '                                                   <frxRelatorio' +
        '."ITE_CNV_ML">);'
      'end;'
      ''
      'procedure rllProCanOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<frxRelatorio."CANCEL"> = '#39'N'#39') Then'
      '    rllProCan.Text := '#39#39
      '  Else'
      
        '    rllProCan.Text := '#39'*'#39';                                      ' +
        '                            '
      'end;'
      ''
      'procedure rdbDtaEntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rdbDtaEnt.Text := FormatDateTime('#39'dd/mm/yy'#39',<frxRelatorio."DTA' +
        'ENT">) + '#39' '#39' +'
      
        '                    FormatDateTime('#39'hh:mm'#39',   <frxRelatorio."HOR' +
        'ENT">);  '
      'end;'
      ''
      'procedure lblTotQtdEntOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  lblTotQtdEnt.Text := fFormataQuantidadeTotal(fltQtdEnt);      ' +
        '        '
      'end;'
      ''
      'procedure lblTotQtdSaiOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  lblTotQtdSai.Text := fFormataQuantidadeTotal(fltQtdSai);      ' +
        '                              '
      'end;'
      ''
      'begin'
      '  fltQtdEnt := 0;'
      '  fltQtdSai := 0;                                    '
      'end.')
    OnUserFunction = frxRelatorioMUserFunction
    Left = 25
    Top = 273
    Datasets = <
      item
        DataSet = frxComandos
        DataSetName = 'frxComandos'
      end
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
    object Page1: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      TopMargin = 4.497916666666667000
      BottomMargin = 4.497916666666667000
      FontStyle = []
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 221.000000000000000000
        Width = 1526.400000000000000000
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 758.400000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'E N T R A D A S')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'S A I D A S')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'TP')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'EMP')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DATA/HORA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CODIGO-CLIENTE/FORNECEDOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'OPE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CFOP')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblValUniEnt: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VALOR UNIT')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 1209.600000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblValUniSai: TfrxDMPMemoView
          Left = 1420.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VALOR UNIT')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblCustoEnt: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblCustoSai: TfrxDMPMemoView
          Left = 1315.200000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CUSTO')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 17.000000000000000000
        Width = 1526.400000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          FontStyle = [fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 34.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxGen
          DataSetName = 'frxGen'
          HAlign = haCenter
          Memo.UTF8W = (
            'RELATORIO DE FICHA KARDEX FISCAL DE PRODUTOS')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 1449.600000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'EMITIDO EM [Date]')
          TruncOutboundText = False
        end
        object rllPeriodo: TfrxDMPMemoView
          Left = 288.000000000000000000
          Top = 85.000000000000000000
          Width = 796.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[PERIODO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#77'
        end
        object DMPMemo1: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[ITEM]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[REFERENCIA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 136.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[UNIDADE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 136.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[MARCA]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 178.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          Memo.UTF8W = (
            '[LOTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 681.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CUSTO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 306.000000000000000000
        Width = 1526.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rdbCodigo: TfrxDMPMemoView
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCodigoOnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 144.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."ESPDOC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbDtaEnt: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbDtaEntOnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbCodCli: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbCodCliOnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODCLI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CFOP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblQtdEnt: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblQtdEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbTotCusEnt: TfrxDMPMemoView
          Left = 844.800000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotCusEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbUnitarEnt: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbUnitarEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblQtdSai: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblQtdSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbTotCusSai: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbTotCusSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbUnitarSai: TfrxDMPMemoView
          Left = 1372.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rdbUnitarSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.3n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllProCan: TfrxDMPMemoView
          Left = 1516.800000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllProCanOnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            '*')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbResumo2: TfrxReportSummary
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1526.400000000000000000
        Child = frxRelatorioM.rlbResumo3
        object DMPMemo32: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Totais:')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblTotQtdEnt: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblTotQtdEntOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object lblTotQtdSai: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'lblTotQtdSaiOnBeforePrint'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbResumo3: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 1526.400000000000000000
        object DMPMemo35: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'FATOR TINTOMETRICO: [FATTIN]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1516.800000000000000000
          Color = clBlack
        end
      end
      object rlbResumo: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 442.000000000000000000
        Width = 1526.400000000000000000
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 1123.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'REGISTROS IMPRESSOS: [COUNT(RLBDETALHE)]')
          TruncOutboundText = False
        end
        object frxGenREL_NOMREL: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          FontStyle = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 700.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '(**) TRANSFERENCIA DE MERCADORIAS (***) DOCTO FOI ALTERADO PELO ' +
              'USUARIO')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
end
