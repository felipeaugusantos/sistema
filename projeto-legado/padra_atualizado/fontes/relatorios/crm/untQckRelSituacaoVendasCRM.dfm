object frmQckRelSituacaoVendasCRM: TfrmQckRelSituacaoVendasCRM
  OldCreateOrder = False
  Height = 150
  Width = 215
  object frxAnaliticoJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42333.440664918980000000
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
      ''
      'begin'
      ''
      'end.')
    Left = 44
    Top = 22
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Height = 9.440940000000000000
        ParentFont = False
        Top = 332.598640000000000000
        Width = 1046.929810000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 9.440940000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 45.354360000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."OCO_DTAINC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 45.354360000000000000
          Width = 37.795300000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'hhh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."OCO_HORINC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 86.929190000000000000
          Width = 105.826840000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OCO_PROTOC"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoGrupoOcorrencia: TfrxMemoView
          Left = 193.756030000000000000
          Width = 158.740260000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OCO_CODCLI"] - [frxRelatorio."CLI_NOMCLI"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo13: TfrxMemoView
          Left = 357.834880000000000000
          Width = 45.354360000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."OCO_DTACON"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 403.189240000000000000
          Width = 37.795300000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'hhh:mm:ss'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HideZeros = True
          Memo.UTF8W = (
            '[frxRelatorio."OCO_HORCON"]')
          ParentFont = False
          WordWrap = False
        end
        object mmoOpeOrigem: TfrxMemoView
          Left = 444.543600000000000000
          Width = 98.267780000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OCO_OPEOCO"] - [frxRelatorio."OPE_NOMORI"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object mmoOpeDestino: TfrxMemoView
          Left = 546.031850000000000000
          Width = 98.267780000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OCO_CODOPE"] - [frxRelatorio."OPE_NOMDES"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo9: TfrxMemoView
          Left = 647.079160000000000000
          Width = 94.488250000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."ORCAMENTO"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo11: TfrxMemoView
          Left = 743.567410000000000000
          Width = 94.488250000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."PEDIDO"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo16: TfrxMemoView
          Left = 840.835190000000000000
          Width = 94.488250000000000000
          Height = 9.440940000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DOCVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 937.323440000000000000
          Width = 105.826840000000000000
          Height = 9.440940000000000000
          StretchMode = smMaxHeight
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."BAIXAD"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.661410000000000000
        ParentFont = False
        Top = 404.409710000000000000
        Width = 1046.929810000000000000
        object rllNomeForm: TfrxMemoView
          Align = baLeft
          Top = 5.661409999999989000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 691.729810000000000000
          Top = 5.661409999999989000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 215.433210000000000000
        Width = 1046.929810000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1046.929810000000000000
          Height = 17.000000000000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA/HORA INC.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 86.929190000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PROTOCOLO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllGrupoOcorrencia: TfrxMemoView
          Left = 193.756030000000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CLITIT]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 357.834880000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA/HORA CON.')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllOpeOrigem: TfrxMemoView
          Left = 444.543600000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPERADOR ORIGEM')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllOpeDestino: TfrxMemoView
          Left = 546.031850000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPERADOR DESTINO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 647.079160000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OR'#199'AMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 743.567410000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 840.835190000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOC. VENDA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 937.323440000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'BAIXADO N'#195'O ENTREGUE')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 134.118120000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 265.436550000000000000
          Top = 21.102350000000000000
          Width = 516.056710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 932.182870000000000000
          Top = 15.102350000000000000
          Width = 115.200000000000000000
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
        object Time: TfrxMemoView
          Left = 980.182870000000000000
          Top = 32.102350000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 874.280520000000000000
          Top = 32.102350000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 68.590600000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODCLI]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baRight
          Left = 706.772329690000000000
          Top = 52.913420000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OPEOCO]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 128.842610000000000000
          Width = 1046.929810000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Top = 98.826840000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODTOC]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baLeft
          Left = 340.157480310000000000
          Top = 68.590600000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODGOC]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 83.929190000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODCID]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baLeft
          Left = 340.157480310000000000
          Top = 83.929190000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PROTOC]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Align = baRight
          Left = 706.772329690000000000
          Top = 68.590600000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITUAC]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Top = 52.913420000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAINC]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Align = baLeft
          Left = 340.157480310000000000
          Top = 52.913420000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTACON]')
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 158.664905000000000000
          Top = 0.102350000000001300
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
        object Memo1: TfrxMemoView
          Align = baRight
          Left = 706.772329690000000000
          Top = 98.826840000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODSIT]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Align = baRight
          Left = 706.772329690000000000
          Top = 83.149660000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITVEN]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baLeft
          Left = 340.157480310000000000
          Top = 98.826840000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Align = baLeft
          Top = 114.165430000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODATI]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Align = baLeft
          Left = 340.157480310000000000
          Top = 114.165430000000000000
          Width = 340.157480310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODGAT]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 294.803340000000000000
        Width = 1046.929810000000000000
        Condition = 'frxRelatorio."SIT_DESSIT"'
        object Memo4: TfrxMemoView
          Left = 18.897650000000000000
          Width = 1016.693570000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'SITUA'#199#195'O DA OCORR'#202'NCIA: [frxRelatorio."OCO_CODSIT"] - [frxRelato' +
              'rio."SIT_DESSIT"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 257.008040000000000000
        Width = 1046.929810000000000000
        Condition = 'frxRelatorio."TOC_DESTOC"'
        object Memo18: TfrxMemoView
          Width = 1035.591220000000000000
          Height = 11.338590000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'TIPO DE OCORR'#202'NCIA: [frxRelatorio."OCO_CODTOC"] - [frxRelatorio.' +
              '"TOC_DESTOC"]')
          ParentFont = False
        end
      end
    end
  end
  object frxSinteticoJ: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42333.440664919000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 128
    Top = 24
    Datasets = <
      item
        DataSet = frmPaiRelatorio.frxComandos
        DataSetName = 'frxComandos'
      end
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
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 5.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 13.220470000000000000
        ParentFont = False
        Top = 291.023810000000000000
        Width = 718.110700000000000000
        DataSet = frmPaiRelatorio.frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 718.110700000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          WordWrap = False
        end
        object mmoTipoOcorrencia: TfrxMemoView
          Left = 0.999997560000000000
          Width = 192.756030000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OCO_CODTOC"] - [frxRelatorio."TOC_DESTOC"]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo11: TfrxMemoView
          Left = 500.677490000000000000
          Width = 79.370130000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."ORCAMENTO"> ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo12: TfrxMemoView
          Left = 581.047620000000000000
          Width = 68.031540000000010000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."PEDIDO"> ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 650.079160000000000000
          Width = 68.031540000000010000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxRelatorio."DOCVEN"> ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 196.535560000000000000
          Width = 185.196970000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."OCO_CODSIT"] - [frxRelatorio."SIT_DESSIT"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 383.732530000000000000
          Width = 113.385900000000000000
          Height = 13.220470000000000000
          DataSet = frmPaiRelatorio.frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxRelatorio."OCO_OPEOCO">] - [<frxRelatorio."OPE_NOMDES">]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 22.661410000000000000
        ParentFont = False
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        object rllNomeForm: TfrxMemoView
          Align = baLeft
          Top = 5.661409999999989000
          Width = 351.722820000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Align = baRight
          Left = 362.910700000000000000
          Top = 5.661409999999989000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000022000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 249.448980000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 718.110700000000000000
          Height = 17.000000000000000000
          Fill.BackColor = clSilver
        end
        object rllTipoOcorrencia: TfrxMemoView
          Left = 0.999997560000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TIPO DE OCORR'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 196.535560000000000000
          Width = 185.196970000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SITUA'#199#195'O DE OCORR'#202'NCIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 500.677490000000000000
          Width = 79.370129999999990000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. OR'#199'AMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 581.047620000000000000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. PEDIDO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 650.079160000000000000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD. VENDAS')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 383.732529999999900000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'OPERADOR DESTINO')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 168.133890000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 101.026995000000000000
          Top = 21.102350000000000000
          Width = 516.056710000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Align = baRight
          Left = 602.910700000000000000
          Top = 15.102350000000000000
          Width = 115.200000000000000000
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
        object Time: TfrxMemoView
          Align = baRight
          Left = 650.910700000000000000
          Top = 32.102350000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Align = baRight
          Left = 560.126470000000000000
          Top = 32.102350000000000000
          Width = 90.784230000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Align = baLeft
          Top = 83.149660000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODCID]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Align = baLeft
          Top = 128.504020000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[OPEOCO]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 160.299320000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo25: TfrxMemoView
          Align = baLeft
          Top = 113.385900000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baRight
          Left = 362.835099690000000000
          Top = 83.149660000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODGOC]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Align = baLeft
          Top = 98.267780000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODTOC]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Align = baRight
          Left = 362.835099690000000000
          Top = 128.504020000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PROTOC]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Align = baRight
          Left = 362.835099689999000000
          Top = 68.031540000000040000
          Width = 355.275600310001000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITUAC]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Align = baLeft
          Top = 52.913420000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAINC]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Align = baRight
          Left = 362.835099690000000000
          Top = 52.913420000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTACON]')
          ParentFont = False
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 0.102350000000001300
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
        object Memo22: TfrxMemoView
          Align = baRight
          Left = 362.835099690000000000
          Top = 98.267780000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODSIT]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baRight
          Left = 362.835099690000000000
          Top = 113.385900000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SITVEN]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baLeft
          Top = 68.031540000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODCLI]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Align = baLeft
          Top = 142.622140000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODATI]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baRight
          Left = 362.835099690000000000
          Top = 142.622140000000000000
          Width = 355.275600310000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODGAT]')
          ParentFont = False
        end
      end
    end
  end
end
