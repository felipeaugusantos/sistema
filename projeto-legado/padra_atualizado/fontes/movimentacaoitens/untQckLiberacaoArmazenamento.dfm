object frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento
  Left = 0
  Top = 0
  ClientHeight = 563
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 45
    Top = 8
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42411.439745023150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 56
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo26: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeFalta: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeAguarda: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoEntSai: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ENTSAI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MLTVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 425.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 393.600000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]'
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          TruncOutboundText = False
        end
        object mmNumRequisicao: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1046.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '')
          TruncOutboundText = False
        end
        object mmNomeCliente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1046.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          Memo.UTF8W = (
            '')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]'
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cidade..: [frxRelatorio."EMPCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro.: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep....: [fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80#27#67#33'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 170.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        StartNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'LIBERACAO ARMAZENA. ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Fornecedor:[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Codigo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco..:[frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Municipio.:[frxRelatorio."FORCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep...: [fFormataCEP(<frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CGC/CPF...:[fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'IE....: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FONE......:[fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 136.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 136.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 136.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO/REFERE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 136.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPFalta: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPAguard: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD.')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoTitEntSai: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 136.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MLT. VEN.')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 1
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = False
    Left = 152
    Top = 8
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45919.467387268520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 56
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.500000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 45.354330708661400000
        ParentFont = False
        Top = 272.126160000000000000
        Width = 718.110700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 45.354330708661400000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 33.779530000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 114.504020000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 170.551330000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
        end
        object mmoEntSai: TfrxMemoView
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Visible = False
          Memo.UTF8W = (
            '[frxRelatorio."ENTSAI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 526.338900000000000000
          Width = 60.472480000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllQtdeFalta: TfrxMemoView
          Left = 591.929500000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          WordWrap = False
        end
        object rllQtdeAguarda: TfrxMemoView
          Left = 650.299630000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 429.968770000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          WordWrap = False
        end
        object mmoAplica: TfrxMemoView
          Left = 1.779530000000000000
          Top = 29.118120000000000000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 500.692913390000000000
          Width = 22.677165350000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object MemoSerieDados: TfrxMemoView
          Left = 310.141930000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."SER_NUMSER"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 370.393940000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MLTVEN"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 73.692950000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 366.614410000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 366.614410000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 71.488250000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 559.370440000000000000
          Top = 20.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 117.165430000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.880591670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.002123340000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 78.366718330000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 92.488250000000000000
          Width = 646.299630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 366.614410000000000000
          Top = 21.880591670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 366.614410000000000000
          Top = 36.002123340000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 366.614410000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 110.047310000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 33.779530000000000000
          Top = 110.826840000000000000
          Width = 79.370130000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 114.504020000000000000
          Top = 110.826840000000000000
          Width = 49.133890000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 170.551330000000000000
          Top = 110.826840000000000000
          Width = 136.063080000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFERE')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 500.866420000000000000
          Top = 110.826840000000000000
          Width = 22.677180000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 541.457020000000000000
          Top = 110.826840000000000000
          Width = 45.354360000000000000
          Height = 15.118110236220500000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object rllPFalta: TfrxMemoView
          Left = 591.929500000000000000
          Top = 110.826840000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
        end
        object rllPAguard: TfrxMemoView
          Left = 650.299630000000000000
          Top = 110.826840000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 429.968770000000000000
          Top = 111.267780000000000000
          Width = 68.031540000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 366.614410000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 127.842610000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoTitEntSai: TfrxMemoView
          Top = 110.606370000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
        end
        object MemoSerie: TfrxMemoView
          Left = 310.196850390000000000
          Top = 110.606370000000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#186' S'#201'RIE')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 370.393940000000000000
          Top = 110.740157480000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MLT. VEN.')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 366.614410000000000000
          Top = 78.236220470000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data de Emiss'#227'o: [frxRelatorio."DTADOC"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 96.692950000000000000
        Top = 340.157700000000000000
        Width = 718.110700000000000000
        object Memo34: TfrxMemoView
          Left = 7.559060000000000000
          Top = 20.377963330000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 563.149970000000000000
          Top = 20.377963330000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 3.220469999999980000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo33: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.220469999999980000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 563.149970000000000000
          Top = 3.220469999999980000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object mmNumRequisicao: TfrxMemoView
          Left = 7.559060000000000000
          Top = 39.842300000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 7.559060000000000000
          Top = 60.062770000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object frxReportM_Mod2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41171.334652488440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 104
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 357.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo27: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 787.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeFalta: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeAguarda: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 1171.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC.FISICA: [frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '______')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '______')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 34.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 442.000000000000000000
        Width = 1305.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 393.600000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]'
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          TruncOutboundText = False
        end
        object mmNumRequisicao: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 1046.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          TruncOutboundText = False
        end
        object mmNomeCliente: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 1046.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1305.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo18: TfrxDMPMemoView
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]'
            '')
          ParentFont = False
          TruncOutboundText = True
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cidade..: [frxRelatorio."EMPCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro.: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep....: [fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = -4.800000000000000000
          Top = 76.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 1248.000000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80'
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#87#48#15#27#80'
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1094.400000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80#27#67#33'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 1248.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80#27#87#49'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 170.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        StartNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'LIB. ARMAZENA ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          TruncOutboundText = True
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Codigo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco..: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Municipio.: [frxRelatorio."FORCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep...: [fFormataCEP(<frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CGC/CPF...: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 873.600000000000000000
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'IE....: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FONE......: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 127.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 161.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 136.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO/REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 136.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPFalta: TfrxDMPMemoView
          Left = 1027.200000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPAguard: TfrxDMPMemoView
          Left = 1152.000000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'SEP')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 136.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CONF')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPCommand5: TfrxDMPCommand
          Left = 777.600000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#87#48#15#27#80'
        end
      end
    end
  end
  object frxReportJ_Mod2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45329.692120000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 104
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897637800000000000
        ParentFont = False
        Top = 272.126160000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        Child = frxReportJ_Mod2.Child1
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 18.897637800000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 49.133890000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 102.858380000000000000
          Width = 336.378170000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
        end
        object Memo27: TfrxMemoView
          Left = 504.764070000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 444.968770000000000000
          Width = 56.692950000000010000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllQtdeFalta: TfrxMemoView
          Left = 581.811380000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          WordWrap = False
        end
        object rllQtdeAguarda: TfrxMemoView
          Left = 650.299630000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          WordWrap = False
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.440940000000011900
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '______')
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 539.134200000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '_____')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 73.692950000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]'
            '')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 366.614410000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 366.614410000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 71.488250000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 559.370440000000000000
          Top = 20.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 117.165430000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.880591669999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.002123340000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 78.366718330000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 92.488250000000010000
          Width = 646.299630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 366.614410000000000000
          Top = 21.880591669999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 366.614410000000000000
          Top = 36.002123340000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 366.614410000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 110.047310000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo18: TfrxMemoView
          Left = 49.133890000000000000
          Top = 110.826840000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 102.858380000000000000
          Top = 110.826840000000000000
          Width = 336.378170000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 504.764070000000000000
          Top = 110.826840000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 444.968770000000000000
          Top = 110.826840000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object rllPFalta: TfrxMemoView
          Left = 581.811380000000000000
          Top = 110.826840000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
        end
        object rllPAguard: TfrxMemoView
          Left = 650.299630000000000000
          Top = 110.826840000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 126.267780000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo28: TfrxMemoView
          Left = 366.614410000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 110.826840000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SEP')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 539.134200000000000000
          Top = 111.267780000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONF')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 96.811070000000000000
        Top = 374.173470000000000000
        Width = 718.110700000000000000
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 11.338590000000010000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 28.496083329999980000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 559.370440000000000000
          Top = 11.338590000000010000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 559.370440000000000000
          Top = 28.496083329999980000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmNumRequisicao: TfrxMemoView
          Left = 3.779530000000000000
          Top = 49.133890000000010000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmNomeCliente: TfrxMemoView
          Left = 3.779530000000000000
          Top = 70.354359999999990000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 37.795275590000000000
        ParentFont = False
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        object mmoZebra2: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 37.795275590000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 49.133890000000000000
          Top = 1.779530000000022000
          Width = 665.197280000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'LOC. FISICA: [frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object mmoAplica: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportM_Mod3: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41171.334652488400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 152
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 357.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeFalta: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeAguarda: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#243'digos de Fabrica : [frxRelatorio."ITE_CDFABS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 34.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#243'digos de Barras : [frxRelatorio."ITE_CDBARS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 51.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 459.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1142.400000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]'
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1507.200000000000000000
        ReprintOnNewPage = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cidade..: [frxRelatorio."EMPCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro.: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep....: [fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object rllCommand1: TfrxDMPCommand
          Left = 1104.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65'
        end
        object rllCommand2: TfrxDMPCommand
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 170.000000000000000000
        Width = 1507.200000000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        StartNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'LIBERACAO ARMAZENA. ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Fornecedor:[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Codigo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco..:[frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Municipio.:[frxRelatorio."FORCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep...: [fFormataCEP(<frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CGC/CPF...:[fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 950.400000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'IE....: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FONE......:[fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 136.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 136.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPFalta: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPAguard: TfrxDMPMemoView
          Left = 1411.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD. DE FABRICA')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ_Mod3: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41165.707501782410000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 152
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
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 60.094488190000000000
        ParentFont = False
        Top = 283.464750000000000000
        Width = 1046.929810000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 60.094488190000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 80.826840000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 136.874150000000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 828.244590000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 862.717070000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllQtdeFalta: TfrxMemoView
          Left = 913.189550000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          WordWrap = False
        end
        object rllQtdeAguarda: TfrxMemoView
          Left = 971.559680000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 408.189240000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 544.252320000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 687.874460000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 14.574820240000010000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digos de Fabrica : [frxRelatorio."ITE_CDFABS"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 28.574830000000020000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digos de Barras : [frxRelatorio."ITE_CDBARS"]')
          ParentFont = False
        end
        object mmoAplica: TfrxMemoView
          Left = 3.779530000000000000
          Top = 42.354359999999990000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 77.472480000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]'
            '')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 699.213050000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 699.213050000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 71.488250000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 895.969080000000000000
          Top = 20.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 139.842610000000000000
        Top = 120.944960000000000000
        Width = 1046.929810000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000003000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 29.439651670000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 43.561183340000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 57.682714999999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 71.804246670000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 85.925778330000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 100.047310000000000000
          Width = 978.898270000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 495.118430000000000000
          Top = 29.439651670000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 495.118430000000000000
          Top = 43.561183340000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 495.118430000000000000
          Top = 57.682714999999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 117.606370000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 118.385900000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 80.826840000000000000
          Top = 118.385900000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 136.874150000000000000
          Top = 118.385900000000000000
          Width = 260.787570000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 828.244590000000000000
          Top = 118.385900000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 862.717070000000000000
          Top = 118.385900000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object rllPFalta: TfrxMemoView
          Left = 913.189550000000000000
          Top = 118.385900000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
        end
        object rllPAguard: TfrxMemoView
          Left = 971.559680000000000000
          Top = 118.385900000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 408.189240000000000000
          Top = 118.826840000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 133.826840000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo28: TfrxMemoView
          Left = 495.118430000000000000
          Top = 71.804246670000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 544.252320000000000000
          Top = 118.826840000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 687.874460000000000000
          Top = 118.826840000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO DE FABRICA')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 3.779529999999994000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 366.614410000000000000
        Width = 1046.929810000000000000
        object Line5: TfrxLineView
          Align = baWidth
          Top = 7.559059999999988000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo33: TfrxMemoView
          Left = 5.559060000000000000
          Top = 15.118119999999980000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 5.559060000000000000
          Top = 32.275613330000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 889.969080000000000000
          Top = 15.118119999999980000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 889.969080000000000000
          Top = 32.275613330000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReportJ_Mod5: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45183.531462939800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 248
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.236230240000000000
        ParentFont = False
        Top = 272.126160000000000000
        Width = 718.110700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 30.236230240000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Width = 86.929133858267720000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 93.732283460000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 147.779527559055100000
          Width = 222.992270000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 488.866420000000000000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 515.000310000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllQtdeFalta: TfrxMemoView
          Left = 591.929500000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          WordWrap = False
        end
        object rllQtdeAguarda: TfrxMemoView
          Left = 650.299630000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 375.685039370078700000
          Width = 109.606299210000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          WordWrap = False
        end
        object mmoAplica: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000000000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 73.692950000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 366.614410000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 366.614410000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 71.488250000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 559.370440000000000000
          Top = 20.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 117.165430000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.880591670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.002123340000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 78.366718330000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 92.488250000000000000
          Width = 646.299630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 366.614410000000000000
          Top = 21.880591670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 366.614410000000000000
          Top = 36.002123340000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 366.614410000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 110.047310000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Top = 110.826840000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 93.826840000000000000
          Top = 110.826840000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 147.874150000000000000
          Top = 110.826840000000000000
          Width = 222.992270000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 488.866420000000000000
          Top = 110.826840000000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 541.457020000000000000
          Top = 110.826840000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object rllPFalta: TfrxMemoView
          Left = 591.929500000000000000
          Top = 110.826840000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
        end
        object rllPAguard: TfrxMemoView
          Left = 650.299630000000000000
          Top = 110.826840000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 375.614410000000000000
          Top = 111.267780000000000000
          Width = 109.606299210000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 366.614410000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 127.842610000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 49.614203330000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        object Memo34: TfrxMemoView
          Left = 7.559060000000000000
          Top = 19.377963330000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 563.149970000000000000
          Top = 19.377963330000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 4.220469999999980000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo33: TfrxMemoView
          Left = 7.559060000000000000
          Top = 4.220469999999980000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 563.149970000000000000
          Top = 4.220469999999980000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReportJ_Mod4: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42411.390546793980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 200
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
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 60.094488190000000000
        ParentFont = False
        Top = 325.039580000000000000
        Width = 1046.929810000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 60.094488190000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 80.826840000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 136.874150000000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 805.039370078740200000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 839.055118110000000000
          Width = 68.031505830000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllQtdeFalta: TfrxMemoView
          Left = 913.189550000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          WordWrap = False
        end
        object rllQtdeAguarda: TfrxMemoView
          Left = 971.559680000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 408.189240000000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 544.252320000000000000
          Width = 113.385826771653500000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 665.196850393700700000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 14.574820240000010000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digos de Fabrica : [frxRelatorio."ITE_CDFABS"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 28.574830000000020000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digos de Barras : [frxRelatorio."ITE_CDBARS"]')
          ParentFont = False
        end
        object mmoAplica: TfrxMemoView
          Left = 3.779530000000000000
          Top = 42.354359999999990000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ_Mod4.Child1
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 38.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 699.213050000000000000
          Top = 38.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 53.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 699.213050000000000000
          Top = 53.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 895.969080000000000000
          Top = 21.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 100.606370000000000000
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 80.488250000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 4.338590000000000000
          Top = 81.267780000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 81.385900000000000000
          Top = 81.267780000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 137.433210000000000000
          Top = 81.267780000000000000
          Width = 260.787570000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 805.039370080000000000
          Top = 81.267780000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 863.276130000000000000
          Top = 81.267780000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object rllPFalta: TfrxMemoView
          Left = 913.748610000000000000
          Top = 81.267780000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
        end
        object rllPAguard: TfrxMemoView
          Left = 972.118740000000000000
          Top = 81.267780000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 408.748300000000000000
          Top = 81.708720000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 96.708720000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo30: TfrxMemoView
          Left = 544.811380000000000000
          Top = 81.708720000000000000
          Width = 113.385826771653500000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 665.196850390000000000
          Top = 81.708720000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO DE FABRICA')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.338590000000000000
          Top = 5.660121670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.338590000000000000
          Top = 19.781653339999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.338590000000000000
          Top = 33.903185000000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.338590000000000000
          Top = 48.024716670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.338590000000000000
          Top = 62.146248329999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 494.677490000000000000
          Top = 5.660121670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 494.677490000000000000
          Top = 19.781653339999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 494.677490000000000000
          Top = 33.903185000000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 494.677490000000000000
          Top = 48.024716670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 4.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 408.189240000000000000
        Width = 1046.929810000000000000
        object Memo13: TfrxMemoView
          Left = 7.559060000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 7.559060000000000000
          Top = 17.157493330000020000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 891.969080000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 891.969080000000000000
          Top = 17.157493330000020000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 41.574830000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 117.165430000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object mmoNotas: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."NOTAS"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportM_Mod4: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41171.334652488400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 198
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 172.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 288.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 662.400000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeFalta: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeAguarda: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#243'digos de Fabrica : [frxRelatorio."ITE_CDFABS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 34.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#243'digos de Barras : [frxRelatorio."ITE_CDBARS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 51.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cidade..: [frxRelatorio."EMPCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro.: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 68.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep....: [fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCommand1: TfrxDMPCommand
          Left = 1104.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65'
        end
        object rllCommand2: TfrxDMPCommand
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 153.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 136.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPFalta: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPAguard: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD. DE FABRICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoNotas: TfrxDMPMemoView
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'LIBERACAO ARMAZENA. ESTOQUE - [frxRelatorio."NOTAS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Fornecedor:[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Codigo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco..:[frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Municipio.:[frxRelatorio."FORCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep...: [fFormataCEP(<frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CGC/CPF...:[fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'IE....: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FONE......:[fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 425.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]'
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReportM_Mod6: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42656.491816585650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 295
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 350.519773622646200000
      PaperHeight = 292.364394514661900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 272.000000000000000000
        Width = 1305.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo28: TfrxDMPMemoView
          Left = 211.200000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1305.600000000000000000
        object DMPMemo14: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 187.000000000000000000
        Top = 68.000000000000000000
        Width = 1305.600000000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        ReprintOnNewPage = True
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80#27#67#33'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 1248.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#18#27#80#27#87#49'
        end
        object DMPLine3: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 144.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Left = 14.400000000000000000
          Top = 178.500000000000000000
          Width = 1267.200000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 451.200000000000000000
          Top = 153.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 153.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 153.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD BARRAS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 153.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOCALIZAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 153.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baWidth
          Top = 17.000000000000000000
          Width = 1305.600000000000000000
          Height = 34.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'LIBERACAO DE ARMAZENAGEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 119.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 119.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'NOTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 119.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoDocGerado: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'DOCUMENTO GERADO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoLblFornOri: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR:')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoForOri: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 68.000000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."FORORI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmolblNotOri: TfrxDMPMemoView
          Left = 777.600000000000000000
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'NOTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoNotOri: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 68.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DOCORI_TA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoDocSelec: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'DOCUMENTO SELECIONADO:')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 391.000000000000000000
        Width = 1305.600000000000000000
        object DMPLine2: TfrxDMPLineView
          Left = 244.800000000000000000
          Top = 42.500000000000000000
          Width = 700.800000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 240.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'ASSINATURA DO ESTOQUISTA:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DATA:____/_____/_______')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 68.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'HORA:____:_____')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 340.000000000000000000
        Width = 1305.600000000000000000
      end
    end
  end
  object frxReportJ_Mod6: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42661.442647928200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 295
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 46.866141730000000000
        ParentFont = False
        Top = 268.346630000000000000
        Width = 718.110700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 46.866141730000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 666.197280000000000000
          Top = 15.496062992125980000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 364.346456690000000000
          Top = 15.377952760000030000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 257.008040000000000000
          Top = 15.377952760000030000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 426.086890000000000000
          Top = 15.496062992125980000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 545.472790000000000000
          Top = 15.496062992125980000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoAplica: TfrxMemoView
          Left = 2.779530000000000000
          Top = 29.118119999999970000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 2.889763780000000000
          Top = 1.377952760000028000
          Width = 117.165430000000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 121.944881890000000000
          Top = 1.377952760000028000
          Width = 593.386210000000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 139.842610000000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo7: TfrxMemoView
          Align = baCenter
          Left = 149.291435000000000000
          Top = 5.677180000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'LIBERA'#199#195'O DE ARMAZENAGEM')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 99.234951669999990000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR: ')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 121.385900000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 137.606370000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo29: TfrxMemoView
          Left = 1.889763780000000000
          Top = 121.700836220000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCALIZA'#199#195'O')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 438.425480000000000000
          Top = 99.252010000000040000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOTA: ')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 120.944881890000000000
          Top = 121.700836220000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 257.567100000000000000
          Top = 121.700836220000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 364.173470000000000000
          Top = 121.700836220000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 423.645950000000000000
          Top = 121.700836220000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 544.252320000000000000
          Top = 121.944960000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D. BARRAS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 665.197280000000000000
          Top = 121.724490000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 162.519790000000000000
          Top = 99.401574799999990000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 487.338900000000000000
          Top = 99.401574803149630000
          Width = 226.771800000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
        end
        object mmoDocGerado: TfrxMemoView
          Left = 3.779530000000000000
          Top = 82.133890000000000000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO GERADO:')
          ParentFont = False
        end
        object mmoNotOri: TfrxMemoView
          Left = 528.134200000000000000
          Top = 55.251968500000000000
          Width = 185.196970000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCORI_TA"]')
          ParentFont = False
        end
        object mmoLblFornOri: TfrxMemoView
          Left = 3.779530000000000000
          Top = 55.251968500000030000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR: ')
          ParentFont = False
        end
        object mmoDocSelec: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.574830000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO SELECIONADO:'
            ':')
          ParentFont = False
        end
        object mmolblNotOri: TfrxMemoView
          Left = 476.220780000000000000
          Top = 55.251968500000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'NOTA:')
          ParentFont = False
        end
        object mmoForOri: TfrxMemoView
          Left = 162.519790000000000000
          Top = 55.251968500000000000
          Width = 309.921460000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FORORI"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 578.268090000000000000
          Top = 4.338590000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 578.268090000000000000
          Top = 19.456710000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HORA:')
          ParentFont = False
        end
        object mmoData: TfrxMemoView
          Left = 627.401980000000000000
          Top = 4.338590000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmoHora: TfrxMemoView
          Left = 627.401980000000000000
          Top = 19.456710000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmoDtaEmiss: TfrxMemoView
          Left = 528.000000000000000000
          Top = 37.795300000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
          ParentFont = False
        end
        object mmoLabelDtaEmiss: TfrxMemoView
          Left = 401.173470000000000000
          Top = 37.795300000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DATA DE EMISS'#195'O:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 528.000000000000000000
          Top = 82.015748030000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GER_DTAENT"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 396.850650000000000000
          Top = 82.015748030000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DATA DE ENTRADA:')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 336.378170000000000000
        Width = 718.110700000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 400.630180000000000000
        Width = 718.110700000000000000
        object Memo13: TfrxMemoView
          Left = 22.677180000000000000
          Top = 22.677180000000080000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ASSINATURA DO ESTOQUISTA: ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 188.535560000000000000
          Top = 38.015769999999970000
          Width = 396.850650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo14: TfrxMemoView
          Left = 23.456710000000000000
          Top = 65.031540000000010000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA:  ____/____/________')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 215.433210000000000000
          Top = 64.252009999999990000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'HORA:  ____:____')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo39: TfrxMemoView
          Left = 566.929500000000000000
          Top = 10.338590000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReportM_Mod7: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42411.439745023150000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 344
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 357.000000000000000000
        Width = 1257.600000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo26: TfrxDMPMemoView
          Left = 48.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 316.800000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 700.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 864.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoEntSai: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ENTSAI"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdTotAmz: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LOT_SALDOS"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 425.000000000000000000
        Width = 1257.600000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 17.000000000000000000
          Width = 393.600000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]'
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 68.000000000000000000
        Width = 1257.600000000000000000
        ReprintOnNewPage = True
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]'
            '')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cidade..: [frxRelatorio."EMPCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 34.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro.: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep....: [fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 1257.600000000000000000
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80#27#67#33'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 170.000000000000000000
        Width = 1257.600000000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        StartNewPage = True
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1238.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'LIBERACAO ARMAZENA. ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Fornecedor:[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Codigo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco..:[frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Municipio.:[frxRelatorio."FORCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep...: [fFormataCEP(<frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CGC/CPF...:[fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'IE....: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FONE......:[fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 136.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 136.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 136.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO/REFERENCIA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 700.800000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UNID')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoTitEntSai: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoQtdTotAmz: TfrxDMPMemoView
          Left = 1123.200000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.TOT.AMZ')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ_Mod7: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41165.707501782410000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 344
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.500000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 45.354330708661410000
        ParentFont = False
        Top = 272.126160000000000000
        Width = 718.110700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 45.354330708661410000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 33.779530000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 110.826840000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 166.874150000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
        end
        object mmoEntSai: TfrxMemoView
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Visible = False
          Memo.UTF8W = (
            '[frxRelatorio."ENTSAI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 515.000310000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 366.614410000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          WordWrap = False
        end
        object mmoAplica: TfrxMemoView
          Left = 1.779530000000000000
          Top = 29.118120000000000000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 623.622450000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."LOT_SALDOS"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 488.692913390000000000
          Width = 22.677165350000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 73.692950000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]'
            '')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 366.614410000000000000
          Top = 37.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 366.614410000000000000
          Top = 52.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 71.488250000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo39: TfrxMemoView
          Left = 559.370440000000000000
          Top = 20.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 117.165430000000000000
        Width = 718.110700000000000000
        Condition = 'frxRelatorio."GER_DOCNUM"'
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.880591669999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.002123340000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 78.366718330000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 3.779530000000000000
          Top = 92.488250000000010000
          Width = 646.299630000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;' +
              '0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 366.614410000000000000
          Top = 21.880591669999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 366.614410000000000000
          Top = 36.002123340000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 366.614410000000000000
          Top = 50.123655000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 110.047310000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 33.779530000000000000
          Top = 110.826840000000000000
          Width = 68.031540000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 110.826840000000000000
          Top = 110.826840000000000000
          Width = 49.133890000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 166.874150000000000000
          Top = 110.826840000000000000
          Width = 196.535560000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O/REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 488.866420000000000000
          Top = 110.826840000000000000
          Width = 22.677180000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 541.457020000000000000
          Top = 110.826840000000000000
          Width = 45.354360000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 366.614410000000000000
          Top = 111.267780000000000000
          Width = 117.165430000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 366.614410000000000000
          Top = 64.245186670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 127.842610000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line5: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object mmoTitEntSai: TfrxMemoView
          Top = 110.606370000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'E/S')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 624.401980000000000000
          Top = 110.606370000000000000
          Width = 90.708720000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTD.TOT.AMZ')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 340.157700000000000000
        Width = 718.110700000000000000
        object Memo34: TfrxMemoView
          Left = 7.559060000000000000
          Top = 20.377963330000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 563.149970000000000000
          Top = 20.377963330000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 3.220469999999978000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo33: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.220469999999978000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 563.149970000000000000
          Top = 3.220469999999978000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReportJ_Mod8: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42411.390546793980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 154
    Top = 400
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
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 60.094488190000000000
        ParentFont = False
        Top = 321.260050000000000000
        Width = 1046.929810000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 60.094488190000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 2.267716535433071000
          Width = 98.267716540000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          WordWrap = False
        end
        object Memo25: TfrxMemoView
          Left = 104.330708660000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 156.377952760000000000
          Width = 260.787570000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          WordWrap = False
        end
        object Memo27: TfrxMemoView
          Left = 835.653543310000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 870.425196850393700000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          WordWrap = False
        end
        object rllQtdeFalta: TfrxMemoView
          Left = 920.692913390000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          WordWrap = False
        end
        object rllQtdeAguarda: TfrxMemoView
          Left = 979.275590550000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 421.748031500000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 557.811023620000000000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 695.433070866141700000
          Width = 132.283550000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 14.574820240000010000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digos de Fabrica : [frxRelatorio."ITE_CDFABS"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 28.574830000000020000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digos de Barras : [frxRelatorio."ITE_CDBARS"]')
          ParentFont = False
        end
        object mmoAplica: TfrxMemoView
          Left = 3.779530000000000000
          Top = 42.354359999999990000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 75.590600000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Child = frxReportJ_Mod8.Child1
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.417336670000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 38.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade: [frxRelatorio."EMPCID"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 699.213050000000000000
          Top = 38.834673330000000000
          Width = 343.937230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 53.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 699.213050000000000000
          Top = 53.252010000000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP: [ fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 895.969080000000000000
          Top = 21.417336670000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 98.826830240000000000
        Top = 200.315090000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          Align = baWidth
          Top = 82.488250000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo17: TfrxMemoView
          Left = 2.338590000000000000
          Top = 83.267780000000000000
          Width = 98.267780000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. FISICA')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 104.385900000000000000
          Top = 83.267780000000000000
          Width = 49.133890000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 156.433210000000000000
          Top = 83.267780000000000000
          Width = 260.787570000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 835.803650000000000000
          Top = 83.267780000000000000
          Width = 30.236240000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 870.276130000000000000
          Top = 83.267780000000000000
          Width = 45.354360000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
        end
        object rllPFalta: TfrxMemoView
          Left = 920.748610000000000000
          Top = 83.267780000000000000
          Width = 52.913420000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
        end
        object rllPAguard: TfrxMemoView
          Left = 979.118740000000000000
          Top = 83.267780000000000000
          Width = 64.252010000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 421.748300000000000000
          Top = 83.708720000000000000
          Width = 132.283550000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 98.708720000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo30: TfrxMemoView
          Left = 557.811380000000000000
          Top = 83.708720000000000000
          Width = 132.283550000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOC. SUP ESTOQ.')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 695.433520000000000000
          Top = 83.708720000000000000
          Width = 132.283550000000000000
          Height = 15.118110236220470000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO DE FABRICA')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 1.338590000000000000
          Top = 5.660121670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fornecedor: [frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 1.338590000000000000
          Top = 19.781653339999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o: [frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 1.338590000000000000
          Top = 33.903185000000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Municipio: [frxRelatorio."FORCID"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 1.338590000000000000
          Top = 48.024716670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CGC: [fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 1.338590000000000000
          Top = 62.146248329999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Fone: [fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 502.677490000000000000
          Top = 5.660121670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 502.677490000000000000
          Top = 19.781653339999990000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 502.677490000000000000
          Top = 33.903185000000010000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cep...: [fFormataCEP( <frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 502.677490000000000000
          Top = 48.024716670000000000
          Width = 343.937230000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'IE: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 4.000000000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 404.409710000000000000
        Width = 1046.929810000000000000
        object Memo13: TfrxMemoView
          Left = 3.559060000000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 3.559060000000000000
          Top = 17.157493330000000000
          Width = 540.472790000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 891.969080000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo44: TfrxMemoView
          Left = 891.969080000000000000
          Top = 17.157493330000020000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 41.574830000000020000
          Width = 1046.929810000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 117.165430000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object mmoNotas: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LIBERA'#199#195'O ARMAZENA ESTOQUE - [frxRelatorio."NOTAS"]')
          ParentFont = False
        end
      end
    end
  end
  object frxReportM_Mod8: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 41171.334652488400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure mmoCusRea1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 45
    Top = 398
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
    object qckPagina: TfrxDMPPage
      PaperWidth = 403.859739173918500000
      PaperHeight = 278.870653229369800000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 340.000000000000000000
        Width = 1507.200000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 153.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 259.200000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 643.200000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."UNI_SIGUNI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtde: TfrxDMPMemoView
          Left = 1190.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeFalta: TfrxDMPMemoView
          Left = 1296.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdFal]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllQtdeAguarda: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[fQtdAgu]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 796.800000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCSUP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODFAB"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#243'digos de Fabrica : [frxRelatorio."ITE_CDFABS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 34.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C'#243'digos de Barras : [frxRelatorio."ITE_CDBARS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoAplica: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 51.000000000000000000
          Width = 1459.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo18: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1180.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            '[frxRelatorio."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 1065.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[fFormataTelefone(<frxRelatorio."EMP_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cidade..: [frxRelatorio."EMPCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 51.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro.: [frxRelatorio."EMP_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco: [frxRelatorio."EMP_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 892.800000000000000000
          Top = 68.000000000000000000
          Width = 604.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep....: [fFormataCEP(<frxRelatorio."EMP_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 1334.400000000000000000
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllCommand1: TfrxDMPCommand
          Left = 1104.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#65'
        end
        object rllCommand2: TfrxDMPCommand
          Left = 1180.800000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Command = '#15#27#77'
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 153.000000000000000000
        Width = 1507.200000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC.FISICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CODIGO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 136.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DESCRICAO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 643.200000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPFalta: TfrxDMPMemoView
          Left = 1286.400000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. FALTA')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllPAguard: TfrxDMPMemoView
          Left = 1401.600000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'P. AGUARD.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 787.200000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'LOC. SUP. EST.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 136.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'COD. DE FABRICA')
          ParentFont = False
          TruncOutboundText = False
        end
        object mmoNotas: TfrxDMPMemoView
          Width = 1324.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            'LIBERACAO ARMAZENA. ESTOQUE - [frxRelatorio."NOTAS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Fornecedor:[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 17.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Codigo: [frxRelatorio."FOR_CODFOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Endereco..:[frxRelatorio."FOR_ENDERE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 34.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Bairro: [frxRelatorio."FOR_BAIRRO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Municipio.:[frxRelatorio."FORCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 51.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Cep...: [fFormataCEP(<frxRelatorio."FOR_C_E_P_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CGC/CPF...:[fFormataCpfCgc(<frxRelatorio."FOR_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 940.800000000000000000
          Top = 68.000000000000000000
          Width = 537.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'IE....: [frxRelatorio."FOR_I_E_S_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'FONE......:[fFormataTelefone(<frxRelatorio."FOR_FONE01">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 835.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            
              'Form.Pagto: [FormatMaskText('#39'99.999.999.999.999.999.999.999.999.' +
              '999.999.999.999;0;_'#39', <frxRelatorio."GER_CONPAG">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1488.000000000000000000
          Color = clBlack
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 425.000000000000000000
        Width = 1507.200000000000000000
        object rllNomeForm: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Operador : [frxRelatorio."OPE_NOMOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllTotalImpresso: TfrxDMPMemoView
          Left = 1132.800000000000000000
          Top = 17.000000000000000000
          Width = 336.000000000000000000
          Height = 34.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'Data: [frxRelatorio."GER_DTAENT"]'
            'Hora: [frxRelatorio."GER_HORENT"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Digitador: [frxRelatorio."NOMDIG"]')
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1497.600000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxReportJ_Mod10: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmSplit
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45345.792705185190000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;              ' +
        '                                                  '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure GroupHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxReportMUserFunction
    Left = 155
    Top = 473
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
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 46.866141730000000000
        ParentFont = False
        Top = 268.346630000000000000
        Width = 718.110700000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 46.866141730000000000
          DataSetName = 'frxdbCriticas'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clSilver
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 666.197280000000000000
          Top = 15.496062992126000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DET_CODITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rllQtde: TfrxMemoView
          Left = 364.346456690000000000
          Top = 15.377952760000000000
          Width = 56.692950000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DET_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 257.008040000000000000
          Top = 15.377952760000000000
          Width = 105.826840000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_REFERE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 426.086890000000000000
          Top = 15.496062992126000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."MAR_DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 545.472790000000000000
          Top = 15.496062992126000000
          Width = 113.385900000000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_CODBAR"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoAplica: TfrxMemoView
          Left = 2.779530000000000000
          Top = 29.118120000000000000
          Width = 1046.929810000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            'Aplica'#231#227'o : [frxRelatorio."ITE_APLICA"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 2.889763780000000000
          Top = 1.377952760000030000
          Width = 117.165430000000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo26: TfrxMemoView
          Left = 121.944881890000000000
          Top = 1.377952760000030000
          Width = 593.386210000000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial Narrow'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DESITE"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 4.779530000000000000
          Top = 28.456710000000000000
          Width = 230.551330000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 139.842610000000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'GroupHeader1OnBeforePrint'
        Condition = 'frxRelatorio."GER_DOCNUM"'
        ReprintOnNewPage = True
        StartNewPage = True
        object Memo7: TfrxMemoView
          Align = baCenter
          Left = 149.291435000000000000
          Top = 5.669291338582680000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'LIBERA'#199#195'O DE ARMAZENAGEM')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 3.779530000000000000
          Top = 99.234951670000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR: ')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 121.385900000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Line3: TfrxLineView
          Align = baWidth
          Top = 137.606370000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
        object Memo29: TfrxMemoView
          Left = 1.889763780000000000
          Top = 121.700836220000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'LOCALIZA'#199#195'O')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 438.425480000000000000
          Top = 99.252010000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOTA: ')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 120.944881890000000000
          Top = 121.700836220000000000
          Width = 109.606370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 257.567100000000000000
          Top = 121.700836220000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'REFER'#202'NCIA')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 364.173470000000000000
          Top = 121.700836220000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 423.645950000000000000
          Top = 121.700836220000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'MARCA')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 544.252320000000000000
          Top = 121.944960000000000000
          Width = 117.165430000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'D. BARRAS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 665.197280000000000000
          Top = 121.724490000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 162.519790000000000000
          Top = 99.401574800000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FOR_NOMFOR"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 487.338900000000000000
          Top = 99.401574803149600000
          Width = 226.771800000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GER_DOCNUM"]')
          ParentFont = False
        end
        object mmoDocGerado: TfrxMemoView
          Left = 3.779530000000000000
          Top = 82.133890000000000000
          Width = 211.653680000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO GERADO:')
          ParentFont = False
        end
        object mmoNotOri: TfrxMemoView
          Left = 528.134200000000000000
          Top = 55.251968500000000000
          Width = 185.196970000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCORI_TA"]')
          ParentFont = False
        end
        object mmoLblFornOri: TfrxMemoView
          Left = 3.779530000000000000
          Top = 55.251968500000000000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOME DO FORNECEDOR: ')
          ParentFont = False
        end
        object mmoDocSelec: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.574830000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMENTO SELECIONADO:'
            ':')
          ParentFont = False
        end
        object mmolblNotOri: TfrxMemoView
          Left = 476.220780000000000000
          Top = 55.251968500000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'NOTA:')
          ParentFont = False
        end
        object mmoForOri: TfrxMemoView
          Left = 162.519790000000000000
          Top = 55.251968500000000000
          Width = 309.921460000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."FORORI"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 578.268090000000000000
          Top = 4.338590000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 578.268090000000000000
          Top = 19.456710000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'HORA:')
          ParentFont = False
        end
        object mmoData: TfrxMemoView
          Left = 627.401980000000000000
          Top = 4.338590000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmoHora: TfrxMemoView
          Left = 627.401980000000000000
          Top = 19.456710000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mmoDtaEmiss: TfrxMemoView
          Left = 528.000000000000000000
          Top = 37.795300000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTADOC"]')
          ParentFont = False
        end
        object mmoLabelDtaEmiss: TfrxMemoView
          Left = 401.173470000000000000
          Top = 37.795300000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DATA DE EMISS'#195'O:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 528.000000000000000000
          Top = 82.015748030000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."GER_DTAENT"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 396.850650000000000000
          Top = 82.015748030000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DATA DE ENTRADA:')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Height = 3.779530000000000000
        Top = 336.378170000000000000
        Width = 718.110700000000000000
        object Line4: TfrxLineView
          Align = baWidth
          Width = 718.110700000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 400.630180000000000000
        Width = 718.110700000000000000
        object Memo13: TfrxMemoView
          Left = 22.677180000000000000
          Top = 22.677180000000100000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ASSINATURA DO ESTOQUISTA: ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 188.535560000000000000
          Top = 38.015770000000000000
          Width = 396.850650000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo14: TfrxMemoView
          Left = 23.456710000000000000
          Top = 65.031540000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DATA:  ____/____/________')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 215.433210000000000000
          Top = 64.252010000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'HORA:  ____:____')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo39: TfrxMemoView
          Left = 566.929500000000000000
          Top = 10.338590000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA: [Page#]/[TotalPages#]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
end
