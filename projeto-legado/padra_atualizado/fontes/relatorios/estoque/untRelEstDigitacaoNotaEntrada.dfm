inherited frmRelEstDigitacaoNotaEntrada: TfrmRelEstDigitacaoNotaEntrada
  Left = 386
  Top = 431
  Width = 434
  Height = 247
  Caption = 'Confer'#234'ncia da digita'#231#227'o da Nota de Entrada'
  OnClose = FormClose
  ExplicitWidth = 434
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 175
    Width = 428
    ExplicitTop = 175
    ExplicitWidth = 428
    inherited btnSair: TBitBtnLocked
      Left = 345
      ExplicitLeft = 345
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      ExplicitLeft = 81
    end
  end
  inherited pnlDados: TPanel
    Width = 428
    Height = 175
    ExplicitWidth = 428
    ExplicitHeight = 175
    object Label1: TLabel [0]
      Left = 8
      Top = 8
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label2: TLabel [1]
      Left = 100
      Top = 8
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
    end
    object lblCliFor: TLabel [2]
      Left = 11
      Top = 50
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label12: TLabel [3]
      Left = 9
      Top = 93
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
    object lblDesDtaIni: TLabel [4]
      Left = 76
      Top = 112
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel [5]
      Left = 9
      Top = 130
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
    object lblDesDtaFin: TLabel [6]
      Left = 76
      Top = 148
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 271
      Top = 112
      TabOrder = 6
      ExplicitLeft = 271
      ExplicitTop = 112
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 24
      Width = 91
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 100
      Top = 24
      Width = 47
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 9
      Top = 65
      Width = 90
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 2
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 100
      Top = 65
      Width = 309
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 106
      Width = 63
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
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 142
      Width = 64
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
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 203
    Width = 428
    ExplicitTop = 203
    ExplicitWidth = 428
    inherited pnlNomeForm: TPanel
      Left = 257
      ExplicitLeft = 257
    end
    inherited pnlInfo: TPanel
      Width = 257
      ExplicitWidth = 257
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 16
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 160
    Top = 16
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 320
    Top = 16
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 256
    Top = 48
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 224
    Top = 48
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 288
    Top = 48
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 256
    Top = 16
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 192
    Top = 16
  end
  inherited frxGen: TfrxUserDataSet
    Left = 288
    Top = 16
  end
  inherited frxDesigner: TfrxDesigner
    Left = 320
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 48
  end
  object frxPagina_J: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39734.668697546300000000
    ReportOptions.LastChange = 40870.615325879640000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '  Var'
      '    strNumDoc, '
      '    strEspDoc, '
      '    strCodEmp,'
      '    strSerie_,'
      '    strCodFor,'
      '    strIteHis: String;'
      ''
      'procedure GroupHeaderNotaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strNumDoc := <frxRelatorio."NUMDOC">;              '
      '  strEspDoc := <frxRelatorio."ESPDOC">;     '
      '  strCodEmp := <frxRelatorio."CODEMP">;    '
      
        '  strSerie_ := <frxRelatorio."SERIE_">;                         ' +
        '                      '
      '  strCodFor := <frxRelatorio."CODFOR">;'
      '  strIteHis := '#39#39';                          '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  strIteHis := strIteHis + '#39#39#39#39' + <frxRelatorio."CODITE"> + '#39#39#39',' +
        #39';'
      '  '
      'end;'
      ''
      'procedure GroupFooterNotaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  strIteHis := Copy( strIteHis, 1, Length( strIteHis ) - 1 );   ' +
        ' '
      
        '  fAbreItensNaoRelacionados(strNumDoc, strEspDoc, strCodEmp, str' +
        'Serie_, strCodFor, strIteHis);                                  ' +
        '                          '
      'end;'
      ''
      'procedure mmoTitNaoRelOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoTitNaoRel.Text := '#39'ITENS N'#195'O RELACIONADOS NOS PEDIDOS - DOC' +
        'UMENTO: '#39' + strNumDoc + '#39'-'#39' + strEspDoc + '#39'-'#39' + strCodEmp;      ' +
        '                                                           '
      'end;'
      ''
      ''
      'procedure mmoNumDocOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Not GroupFooterNota.Visible Then'
      
        '    mmoNumDoc.Text := '#39'PR'#201'-VISUALIZA'#199#195'O'#39';                       ' +
        '                    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPagina_JUserFunction
    Left = 160
    Top = 48
    Datasets = <
      item
        DataSet = frxIteNao
        DataSetName = 'frxIteNao'
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
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 328.819110000000000000
        Width = 740.409927000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllNumPed: TfrxMemoView
          Left = 1.889763780000000000
          Width = 80.277180000000000000
          Height = 17.000000000000000000
          DataField = 'NUMPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMPED"]')
        end
        object rllQtdPed: TfrxMemoView
          Left = 86.929133858267720000
          Width = 69.921259842519690000
          Height = 17.000000000000000000
          DataField = 'QTDITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
        end
        object rllQtdDig: TfrxMemoView
          Left = 328.818897637795300000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDBAI"]')
        end
        object Memo9: TfrxMemoView
          Left = 162.519685039370100000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataField = 'UNITAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
        end
        object Memo21: TfrxMemoView
          Left = 240.000000000000000000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
        end
        object Memo26: TfrxMemoView
          Left = 408.188976377952700000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataField = 'UNIBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIBAI"]')
        end
        object Memo30: TfrxMemoView
          Left = 486.779527560000000000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DataField = 'TOTBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTBAI"]')
        end
        object Memo35: TfrxMemoView
          Left = 577.488188980000000000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DataField = 'DIFQTD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DIFQTD"]')
        end
        object Memo36: TfrxMemoView
          Left = 653.858267716535600000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DataField = 'DIFUNI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DIFUNI"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 555.590910000000000000
        Width = 740.409927000000000000
        object rllNomeForm: TfrxMemoView
          Left = 1.889763779527559000
          Top = 4.000000000000000000
          Width = 415.974830000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 343.245640000000000000
          Top = 4.000000000000000000
          Width = 391.256710000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 75.543290000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 28.082143500000000000
          Top = 17.000000000000000000
          Width = 684.245640000000000000
          Height = 17.000000000000000000
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
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 98.948253500000000000
          Top = 34.000000000000000000
          Width = 542.513420000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 615.907050000000000000
          Top = 34.000000000000000000
          Width = 118.979530000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 667.686580000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 539.107050000000000000
          Top = 51.000000000000000000
          Width = 128.579530000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 28.322820000000000000
        Top = 275.905690000000000000
        Width = 740.409927000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODITE"'
        object Memo4: TfrxMemoView
          Left = 1.889763780000000000
          Top = 5.440940000000000000
          Width = 44.220470000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITEM:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 48.200000000000000000
          Top = 5.440940000000000000
          Width = 76.497650000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 125.400000000000000000
          Top = 5.440940000000000000
          Width = 493.455040000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 623.606680000000000000
          Top = 5.440940000000000000
          Width = 74.456710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNIDADE:')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 700.932688660000000000
          Top = 5.440940000000000000
          Width = 87.836240000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 47.236240000000000000
        Top = 154.960730000000000000
        Width = 740.409927000000000000
        ReprintOnNewPage = True
        object Memo22: TfrxMemoView
          Top = 22.000000000000000000
          Width = 740.107577000000000000
          Height = 20.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 1.889763779527559000
          Top = 24.000000000000000000
          Width = 80.125998900000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PEDIDO')
        end
        object Memo8: TfrxMemoView
          Left = 86.929133858267720000
          Top = 24.000000000000000000
          Width = 69.921259842519690000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PED.')
        end
        object Memo10: TfrxMemoView
          Left = 328.818897637795300000
          Top = 24.000000000000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. BAI.')
        end
        object Memo1: TfrxMemoView
          Left = 162.519685039370100000
          Top = 23.889763780000010000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. UNIT')
        end
        object Memo19: TfrxMemoView
          Left = 240.000000000000000000
          Top = 23.889763780000010000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
        end
        object Memo25: TfrxMemoView
          Left = 408.188976377952700000
          Top = 23.889763780000010000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. UNIT.')
        end
        object Memo29: TfrxMemoView
          Left = 486.779527560000000000
          Top = 23.889763780000010000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
        end
        object Memo33: TfrxMemoView
          Left = 577.488188980000000000
          Top = 23.889763780000010000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIF. QTD.')
        end
        object Memo34: TfrxMemoView
          Left = 653.858267720000000000
          Top = 23.889763780000010000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIF. TOTAL')
        end
        object Memo43: TfrxMemoView
          Left = 1.889763780000000000
          Top = 4.779530000000000000
          Width = 733.228820000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITENS RELACIONADOS NOS PEDIDOS')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 26.440940000000000000
        Top = 370.393940000000000000
        Width = 740.409927000000000000
        object Memo11: TfrxMemoView
          Left = 86.929133858267720000
          Top = 1.661409999999989000
          Width = 69.921259842519690000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
        end
        object Memo12: TfrxMemoView
          Left = 328.818897637795300000
          Top = 1.661409999999989000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDBAI">,rlbDetalhes)]')
        end
        object Memo14: TfrxMemoView
          Left = 1.889763779527559000
          Top = 1.661409999999989000
          Width = 83.527520000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOT. ITEM:')
        end
        object Memo20: TfrxMemoView
          Top = 18.677180000000020000
          Width = 740.031496060000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 162.519685039370100000
          Top = 1.661409999999989000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNITAR">,rlbDetalhes)]')
        end
        object Memo23: TfrxMemoView
          Left = 240.000000000000000000
          Top = 1.661409999999989000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
        end
        object Memo27: TfrxMemoView
          Left = 408.188976377952700000
          Top = 1.661409999999989000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNIBAI">,rlbDetalhes)]')
        end
        object Memo31: TfrxMemoView
          Left = 486.779527560000000000
          Top = 1.661409999999989000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTBAI">,rlbDetalhes)]')
        end
        object Memo37: TfrxMemoView
          Left = 577.488188980000000000
          Top = 1.661409999999989000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFQTD">,rlbDetalhes)]')
        end
        object Memo38: TfrxMemoView
          Left = 653.858267716535600000
          Top = 1.661409999999989000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFUNI">,rlbDetalhes)]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 30.236215590000000000
        Top = 464.882190000000000000
        Width = 740.409927000000000000
        object Memo15: TfrxMemoView
          Left = 86.929133860000000000
          Top = 7.661410000000000000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
        end
        object Memo16: TfrxMemoView
          Left = 328.818897640000000000
          Top = 7.661410000000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDBAI">,rlbDetalhes)]')
        end
        object Memo18: TfrxMemoView
          Left = 1.889763780000000000
          Top = 7.661410000000000000
          Width = 83.527520000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOT.GERAL:')
        end
        object Memo17: TfrxMemoView
          Left = 162.519685040000000000
          Top = 7.661410000000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNITAR">,rlbDetalhes)]')
        end
        object Memo24: TfrxMemoView
          Left = 240.000000000000000000
          Top = 7.661410000000000000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
        end
        object Memo28: TfrxMemoView
          Left = 408.188976380000000000
          Top = 7.661410000000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNIBAI">,rlbDetalhes)]')
        end
        object Memo32: TfrxMemoView
          Left = 486.779527560000000000
          Top = 7.661410000000000000
          Width = 83.149606300000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTBAI">,rlbDetalhes)]')
        end
        object Memo39: TfrxMemoView
          Left = 577.488188980000000000
          Top = 7.661410000000000000
          Width = 69.921259840000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFQTD">,rlbDetalhes)]')
        end
        object Memo40: TfrxMemoView
          Left = 653.858267720000000000
          Top = 7.661410000000000000
          Width = 79.370078740000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFUNI">,rlbDetalhes)]')
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 740.409927000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeaderNota: TfrxGroupHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 226.771800000000000000
        Width = 740.409927000000000000
        OnBeforePrint = 'GroupHeaderNotaOnBeforePrint'
        Condition = 'frxRelatorio."KEYDOC"'
        object Line1: TfrxLineView
          Align = baWidth
          Width = 740.409927000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 26.456710000000000000
          Width = 740.409927000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object mmoNumDoc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 575.395610000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoNumDocOnBeforePrint'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'DOCUMENTO: [frxRelatorio."NUMDOC"] - [frxRelatorio."ESPDOC"] - [' +
              'frxRelatorio."CODEMP"]')
          ParentFont = False
        end
      end
      object GroupFooterNota: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 419.527830000000000000
        Width = 740.409927000000000000
        OnBeforePrint = 'GroupFooterNotaOnBeforePrint'
        object subRepIteNao: TfrxSubreport
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          Page = frxPagina_J.Page2
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 64.252010000000000000
        Top = 18.897650000000000000
        Width = 740.409927000000000000
        object mmoTitNaoRel: TfrxMemoView
          Left = 1.889763780000000000
          Top = 21.779530000000000000
          Width = 733.228820000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmoTitNaoRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ITENS N'#195'O RELACIONADOS NOS PEDIDOS')
          ParentFont = False
        end
        object Shape1: TfrxShapeView
          Top = 40.236240000000000000
          Width = 740.031496060000000000
          Height = 20.787401570000000000
          Fill.BackColor = clSilver
        end
        object Memo45: TfrxMemoView
          Left = 1.889763779527559000
          Top = 42.456710000000000000
          Width = 56.692913390000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 66.251968500000000000
          Top = 42.456710000000000000
          Width = 94.488249999999990000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 405.110390000000000000
          Top = 42.456710000000000000
          Width = 45.354325830000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 454.953000000000000000
          Top = 42.456710000000000000
          Width = 68.031486300000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 528.118430000000000000
          Top = 42.456710000000000000
          Width = 102.047239210000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. UNIT.')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 637.709030000000000000
          Top = 42.456710000000000000
          Width = 98.267709210000010000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. TOTAL')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 15.118120000000000000
          Width = 740.409927000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 105.826840000000000000
        Width = 740.409927000000000000
        DataSet = frxIteNao
        DataSetName = 'frxIteNao'
        PrintIfDetailEmpty = True
        RowCount = 0
        object Memo51: TfrxMemoView
          Left = 1.889763780000000000
          Top = 0.779530000000000000
          Width = 60.472443390000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxIteNao."CODITE"]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 66.251968500000000000
          Top = 0.779529999999994100
          Width = 336.378133390000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxIteNao."DESITE"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 405.110390000000000000
          Top = 0.779530000000000000
          Width = 45.354325830000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxIteNao."SIGUNI"]')
          ParentFont = False
        end
        object Memo54: TfrxMemoView
          Left = 454.953000000000000000
          Top = 0.779530000000000000
          Width = 68.031486300000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxIteNao."QTDITE"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 528.118430000000000000
          Top = 0.779530000000000000
          Width = 102.047239210000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxIteNao."UNITAR"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 637.709030000000000000
          Top = 0.779530000000000000
          Width = 98.267709210000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxIteNao."TOTITE"]')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 151.181200000000000000
        Width = 740.409927000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Top = 11.338590000000000000
          Width = 740.409927000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxPagina_M: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39734.668697546300000000
    ReportOptions.LastChange = 40773.393780532410000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      '  Var'
      '    strNumDoc, '
      '    strEspDoc, '
      '    strCodEmp,'
      '    strSerie_,'
      '    strCodFor,'
      '    strIteHis: String;'
      ''
      'procedure GroupFooterNotaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  strIteHis := Copy( strIteHis, 1, Length( strIteHis ) - 1 );   ' +
        ' '
      
        '  fAbreItensNaoRelacionados(strNumDoc, strEspDoc, strCodEmp, str' +
        'Serie_, strCodFor, strIteHis);                                  ' +
        '                          '
      'end;'
      ''
      'procedure mmoTitNaoRelOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  mmoTitNaoRel.Text := '#39'ITENS N'#195'O RELACIONADOS NOS PEDIDOS - DOC' +
        'UMENTO: '#39' + strNumDoc + '#39'-'#39' + strEspDoc + '#39'-'#39' + strCodEmp;      ' +
        '                                                           '
      'end;'
      ''
      'procedure GroupHeaderNotaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  strNumDoc := <frxRelatorio."NUMDOC">;              '
      '  strEspDoc := <frxRelatorio."ESPDOC">;     '
      '  strCodEmp := <frxRelatorio."CODEMP">;    '
      
        '  strSerie_ := <frxRelatorio."SERIE_">;                         ' +
        '                      '
      '  strCodFor := <frxRelatorio."CODFOR">;'
      '  strIteHis := '#39#39';                          '
      'end;'
      ''
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  strIteHis := strIteHis + '#39#39#39#39' + <frxRelatorio."CODITE"> + '#39#39#39',' +
        #39';'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPagina_JUserFunction
    Left = 192
    Top = 48
    Datasets = <
      item
        DataSet = frxIteNao
        DataSetName = 'frxIteNao'
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
      PaperWidth = 243.839842520101700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object rllNumPed: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataField = 'NUMPED'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRelatorio."NUMPED"]')
          TruncOutboundText = False
        end
        object rllQtdPed: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDITE"]')
          TruncOutboundText = False
        end
        object rllQtdDig: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'QTDBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."QTDBAI"]')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'UNITAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNITAR"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'TOTITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."TOTITE"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIBAI"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'UNIBAI'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."UNIBAI"]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DIFQTD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DIFQTD"]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DIFQTD'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DIFQTD"]')
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 544.000000000000000000
        Width = 902.400000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object Time: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#77'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 902.400000000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."CODITE"'
        object DMPMemo4: TfrxDMPMemoView
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'ITEM:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 556.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DESITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            '[frxRelatorio."DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'UNIDADE:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            '[frxRelatorio."SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 136.000000000000000000
        Width = 902.400000000000000000
        ReprintOnNewPage = True
        object DMPMemo7: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 51.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PEDIDO')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.PED.')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.BAI.')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.UNIT.')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIF.QTD.')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'DIF.TOTAL')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'ITENS RELACIONADOS NOS PEDIDOS')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 391.000000000000000000
        Width = 902.400000000000000000
        object DMPMemo11: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 422.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDBAI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOT ITEM:')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNITAR">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 307.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 508.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNIBAI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 595.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTBAI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 710.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFQTD">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 806.400000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFUNI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 902.400000000000000000
        object DMPMemo15: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 422.400000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."QTDBAI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOT.GERAL:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNITAR">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTITE">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."UNIBAI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."TOTBAI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 710.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFQTD">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DIFUNI">,rlbDetalhes)]')
          TruncOutboundText = False
        end
        object DMPLine11: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
      end
      object GroupHeaderNota: TfrxGroupHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 255.000000000000000000
        Width = 902.400000000000000000
        OnBeforePrint = 'GroupHeaderNotaOnBeforePrint'
        Condition = 'frxRelatorio."KEYDOC"'
        object mmoNumDoc: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            
              'DOCUMENTO: [frxRelatorio."NUMDOC"] - [frxRelatorio."ESPDOC"] - [' +
              'frxRelatorio."CODEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPLine9: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
      end
      object GroupFooterNota: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 442.000000000000000000
        Width = 902.400000000000000000
        OnBeforePrint = 'GroupFooterNotaOnBeforePrint'
        object Subreport1: TfrxSubreport
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Page = frxPagina_M.Page2
        end
      end
    end
    object Page2: TfrxDMPPage
      PaperWidth = 243.839842520101700000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 902.400000000000000000
        object DMPLine6: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#77'
        end
        object DMPLine7: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object DMPLine8: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 892.800000000000000000
          Color = clBlack
        end
        object mmoTitNaoRel: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'mmoTitNaoRelOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold]
          Memo.UTF8W = (
            'ITENS NAO RELACIONADOS NOS PEDIDOS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 68.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 68.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'UNID')
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 652.800000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. UNIT.')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR. TOTAL')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 902.400000000000000000
        DataSet = frxIteNao
        DataSetName = 'frxIteNao'
        PrintIfDetailEmpty = True
        RowCount = 0
        object DMPMemo49: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxIteNao."CODITE"]')
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxIteNao."DESITE"]')
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxIteNao."SIGUNI"]')
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxIteNao."QTDITE"]')
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 652.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxIteNao."UNITAR"]')
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxIteNao."TOTITE"]')
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 170.000000000000000000
        Width = 902.400000000000000000
        object DMPLine10: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 883.200000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxIteNao: TfrxDBDataset
    UserName = 'frxIteNao'
    CloseDataSource = True
    BCDToCurrency = False
    Left = 160
    Top = 80
  end
end
