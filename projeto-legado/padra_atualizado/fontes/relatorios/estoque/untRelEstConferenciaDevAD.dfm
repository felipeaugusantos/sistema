inherited frmRelEstConferenciaDevAD: TfrmRelEstConferenciaDevAD
  Width = 335
  Height = 320
  Caption = 'Confer'#234'ncia de devolu'#231#245'es x ADs'
  ExplicitWidth = 335
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 249
    Width = 329
    ExplicitTop = 249
    ExplicitWidth = 329
    inherited FlwBotoes: TFlowPanel
      Width = 248
      ExplicitWidth = 248
    end
    inherited btnSair: TBitBtnLocked
      Left = 250
      ExplicitLeft = 250
    end
  end
  inherited pnlDados: TPanel
    Width = 329
    Height = 249
    ExplicitWidth = 329
    ExplicitHeight = 249
    object Label1: TLabel [0]
      Left = 9
      Top = 5
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label4: TLabel [1]
      Left = 95
      Top = 5
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object Label2: TLabel [2]
      Left = 9
      Top = 45
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
    end
    object Label3: TLabel [3]
      Left = 9
      Top = 86
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [4]
      Left = 9
      Top = 129
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel [5]
      Left = 97
      Top = 129
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 196
      TabOrder = 8
      ExplicitTop = 196
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 9
      Top = 19
      Width = 80
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnChange = edtNumDocChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 95
      Top = 19
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      OnChange = edtNumDocChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 9
      Top = 59
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnChange = edtNumDocChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 9
      Top = 100
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 68
      Top = 100
      Width = 251
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 144
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
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 96
      Top = 144
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
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object chkExiSomDiv: TCheckBox
      Left = 9
      Top = 173
      Width = 248
      Height = 17
      Caption = 'Exibir somente as diverg'#234'ncias?'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
  end
  inherited pnlStatus: TPanel
    Top = 275
    Width = 329
    ExplicitTop = 275
    ExplicitWidth = 329
    inherited pnlNomeForm: TPanel
      Left = 158
      ExplicitLeft = 158
    end
    inherited pnlInfo: TPanel
      Width = 158
      ExplicitWidth = 158
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 200
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 168
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 232
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 200
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 168
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 232
    Top = 104
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 200
    Top = 104
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = cdsRelatorio
    Left = 232
  end
  inherited frxGen: TfrxUserDataSet
    Left = 168
    Top = 104
  end
  inherited frxDesigner: TfrxDesigner
    Left = 200
    Top = 72
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 232
    Top = 72
  end
  object frxRelatorioM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41052.714219652780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 224
    Top = 184
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 323.000000000000000000
        Width = 1257.600000000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatoriofrxRelatorio: TfrxDMPMemoView
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_CODITE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_DESCRI'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_DESCRI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 345.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_CODUNI'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDDEV'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDDEV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDEV'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIDEV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_TOTDEV'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDEV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDADE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDADE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 777.600000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DataField = 'DET_UNIADE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIADE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_TOTADE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTADE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDDIF'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDDIF"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDIF'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIDIF"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_TOTDIF'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDIF"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 854.400000000000000000
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
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 221.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo10: TfrxDMPMemoView
          Left = 19.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#211'D. ITEM.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 345.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEVOLUCAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'UNITAR.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 691.200000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'AUTORIZACAO DE DEVOLUCAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 691.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'UNITAR.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 979.200000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIFERENCAS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 979.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000010000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'UNITAR.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 268.800000000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 384.000000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 1132.800000000000000000
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
          Left = 1180.800000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          TruncOutboundText = False
        end
        object Date: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[DIVERGENCIAS]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 289.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        object DMPMemo21: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DOCUMENTO: ')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DOCUMENTO'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DOCUMENTO"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 1257.600000000000000000
        object DMPMemo29: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'TOTAIS: ')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTDEV">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 873.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTADE">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTDIF">,rlbDetalhes)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object cdsRelatorio: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 144
    object cdsRelatorioDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Size = 12
    end
    object cdsRelatorioDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Size = 2
    end
    object cdsRelatorioDET_CODEMP: TStringField
      FieldName = 'DET_CODEMP'
      Size = 3
    end
    object cdsRelatorioDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Size = 15
    end
    object cdsRelatorioQUEBRA: TStringField
      FieldName = 'QUEBRA'
      Size = 15
    end
    object cdsRelatorioDET_CODITE: TStringField
      FieldName = 'DET_CODITE'
      Size = 5
    end
    object cdsRelatorioDET_DESCRI: TStringField
      FieldName = 'DET_DESCRI'
      Size = 50
    end
    object cdsRelatorioDET_CODUNI: TStringField
      FieldName = 'DET_CODUNI'
      Size = 10
    end
    object cdsRelatorioDET_QTDDEV: TFloatField
      FieldName = 'DET_QTDDEV'
    end
    object cdsRelatorioDET_UNIDEV: TFloatField
      FieldName = 'DET_UNIDEV'
    end
    object cdsRelatorioDET_TOTDEV: TFloatField
      FieldName = 'DET_TOTDEV'
    end
    object cdsRelatorioDET_QTDADE: TFloatField
      FieldName = 'DET_QTDADE'
    end
    object cdsRelatorioDET_UNIADE: TFloatField
      FieldName = 'DET_UNIADE'
    end
    object cdsRelatorioDET_TOTADE: TFloatField
      FieldName = 'DET_TOTADE'
    end
    object cdsRelatorioDET_QTDDIF: TFloatField
      FieldName = 'DET_QTDDIF'
    end
    object cdsRelatorioDET_UNIDIF: TFloatField
      FieldName = 'DET_UNIDIF'
    end
    object cdsRelatorioDET_TOTDIF: TFloatField
      FieldName = 'DET_TOTDIF'
    end
    object cdsRelatorioDET_DTAENT: TDateTimeField
      FieldName = 'DET_DTAENT'
    end
  end
  object frxRelatorioJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41052.714219652800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    Left = 256
    Top = 184
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxGen
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
    object qckPagina: TfrxReportPage
      PaperWidth = 332.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 321.260050000000000000
        Width = 1217.008660000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Left = 8.979530000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_CODITE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 105.902350000000000000
          Width = 214.979530000000000000
          Height = 17.000000000000000000
          DataField = 'DET_DESCRI'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_DESCRI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 326.702350000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_CODUNI'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODUNI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 384.302350000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDDEV'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDDEV"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 466.771653543307100000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDEV'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIDEV"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 558.614173230000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          DataField = 'DET_TOTDEV'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDEV"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 659.302350000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDADE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDADE"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 745.702350000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIADE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIADE"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 841.702350000000000000
          Width = 88.440944880000000000
          Height = 17.000000000000000000
          DataField = 'DET_TOTADE'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTADE"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 941.404700000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_QTDDIF'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDDIF"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 1027.804700000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DET_UNIDIF'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_UNIDIF"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 1120.804700000000000000
          Width = 88.440944881889750000
          Height = 17.000000000000000000
          DataField = 'DET_TOTDIF'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_TOTDIF"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 457.323130000000000000
        Width = 1217.008660000000000000
        object rllNomeForm: TfrxMemoView
          Left = 2.040940000000000000
          Top = 17.000000000000000000
          Width = 393.297650000000000000
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
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 820.384230000000000000
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
        Height = 39.661410000000000000
        Top = 215.433210000000000000
        Width = 1217.008660000000000000
        ReprintOnNewPage = True
        object Memo36: TfrxMemoView
          Align = baClient
          Width = 1217.008660000000000000
          Height = 39.661410000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 22.979530000000000000
          Width = 80.881880000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D. ITEM.')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 105.902350000000000000
          Width = 214.979530000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 326.702350000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 384.302350000000000000
          Width = 263.281880000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DEVOLUCAO')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 384.302350000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 466.702350000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNITAR.')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 558.702350000000000000
          Top = 17.000000000000000000
          Width = 88.440940000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 659.302350000000000000
          Width = 270.840940000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'AUTORIZACAO DE DEVOLUCAO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 659.302350000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 745.702350000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNITAR.')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 841.702350000000000000
          Top = 17.000000000000000000
          Width = 88.440944880000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 941.404700000000000000
          Width = 267.061410000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DIFERENCAS')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 941.404700000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 1027.804700000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'UNITAR.')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 1119.804700000000000000
          Top = 17.000000000000000000
          Width = 88.440944881889750000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 135.984230000000000000
        Top = 18.897650000000000000
        Width = 1217.008660000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 243.704330000000000000
          Top = 2.000000000000000000
          Width = 729.600000000000000000
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
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 363.704330000000000000
          Top = 19.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
        end
        object rllPagina: TfrxMemoView
          Left = 1095.004700000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Time: TfrxMemoView
          Left = 1143.004700000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
        end
        object Date: TfrxMemoView
          Left = 1018.204700000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 126.500000000000000000
          Width = 1217.008660000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo33: TfrxMemoView
          Left = 9.600000000000000000
          Top = 66.220470000000000000
          Width = 767.471120000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENTE]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 9.600000000000000000
          Top = 83.220470000000000000
          Width = 767.471120000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PERIODO]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 9.600000000000000000
          Top = 100.220470000000000000
          Width = 767.471120000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DIVERGENCIAS]')
          ParentFont = False
        end
      end
      object rlbGrupo: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 279.685220000000000000
        Width = 1217.008660000000000000
        Condition = 'frxRelatorio."QUEBRA"'
        object Memo21: TfrxMemoView
          Left = 6.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO: ')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 105.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DOCUMENTO'
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCUMENTO"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 362.834880000000000000
        Width = 1217.008660000000000000
        object Memo29: TfrxMemoView
          Left = 320.277180000000000000
          Width = 54.425170000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'TOTAIS: ')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 558.614173228346500000
          Width = 88.440944881889750000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTDEV">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 841.700787401574800000
          Width = 88.440944881889750000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTADE">,rlbDetalhes)]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 1119.653531100000000000
          Width = 88.440944881889750000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRelatorio."DET_TOTDIF">,rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 25.500000000000000000
          Width = 1217.008660000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
