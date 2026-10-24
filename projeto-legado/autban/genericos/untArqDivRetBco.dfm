inherited frmArqDivRetBco: TfrmArqDivRetBco
  Width = 750
  Height = 550
  BorderStyle = bsNone
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 750
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 506
    Width = 750
    ExplicitTop = 506
    ExplicitWidth = 750
    inherited btnSair: TBitBtnLocked
      Left = 667
      ExplicitLeft = 667
    end
  end
  object memArqDiv: TMemo [2]
    Left = 0
    Top = 0
    Width = 750
    Height = 506
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
  end
  inherited pnlStatus: TPanel
    Top = 534
    Width = 750
    ExplicitTop = 534
    ExplicitWidth = 750
    inherited pnlNomeForm: TPanel
      Left = 579
      ExplicitLeft = 579
    end
    inherited pnlInfo: TPanel
      Width = 579
      ExplicitWidth = 579
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 43202.482394143500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 512
    Top = 64
    Datasets = <
      item
        DataSet = frxDBNaoGra
        DataSetName = 'frxDBNaoGra'
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
      LeftMargin = 4.497913761764030000
      RightMargin = 4.497913761764030000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 230.551330000000000000
        Width = 1088.520410000000000000
        DataSet = frxDBNaoGra
        DataSetName = 'frxDBNaoGra'
        RowCount = 0
        object rllZebra: TfrxMemoView
          Width = 1085.102589210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxDBNaoGraNUMDUP: TfrxMemoView
          Width = 103.936998110000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_NUMDUP"][frxDBNaoGra."CTR_PARCEL"]')
        end
        object Memo10: TfrxMemoView
          Left = 105.724490000000000000
          Width = 26.456710000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_ESPDOC"]')
        end
        object Memo11: TfrxMemoView
          Left = 137.960730000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_CODEMP"]')
        end
        object Memo12: TfrxMemoView
          Left = 170.976500000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Memo.UTF8W = (
            '[frxDBNaoGra."CLI_NOMCLI"]')
        end
        object Memo13: TfrxMemoView
          Left = 474.220780000000000000
          Width = 68.031510710000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_DTAVEN"]')
        end
        object Memo14: TfrxMemoView
          Left = 543.811380000000000000
          Width = 64.251980710000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_DTAREC"]')
        end
        object Memo16: TfrxMemoView
          Left = 609.520100000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_VALDUP"]')
        end
        object Memo17: TfrxMemoView
          Left = 841.685530000000000000
          Width = 83.149606300000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_VALREC"]')
        end
        object Memo24: TfrxMemoView
          Left = 403.527830000000000000
          Width = 68.031510710000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_DTACAD"]')
        end
        object Memo25: TfrxMemoView
          Left = 697.772110000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_VALJUR"]')
        end
        object Memo26: TfrxMemoView
          Left = 768.362710000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_VALDES"]')
        end
        object Memo15: TfrxMemoView
          Left = 972.000620000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
        object rllTarifaDuplicataValor: TfrxMemoView
          Left = 926.984850000000000000
          Width = 37.795246300000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBNaoGra."CTR_TARIFA"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 355.275820000000000000
        Width = 1088.520410000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 730.757700000000000000
          Top = 12.220470000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Registros Impressos: [COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 7.559059999999990000
          Width = 1088.520410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 84.984230000000000000
        Top = 18.897650000000000000
        Width = 1088.520410000000000000
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 176.625480000000000000
          Top = 33.000000000000000000
          Width = 735.269450000000000000
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
          Left = 918.403340000000000000
          Top = 34.000000000000000000
          Width = 164.333890000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina [Page] de [TotalPages#]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 988.741930000000000000
          Top = 53.779530000000000000
          Width = 93.656710000000000000
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
          Left = 856.382870000000000000
          Top = 53.779530000000000000
          Width = 124.800000000000000000
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
        object Line1: TfrxLineView
          Align = baWidth
          Top = 79.370130000000000000
          Width = 1088.520410000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 128.436550000000000000
          Top = 3.779530000000000000
          Width = 831.647310000000000000
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
      end
      object rlbHeaderGrupoDescri: TfrxGroupHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 166.299320000000000000
        Width = 1088.520410000000000000
        Condition = 'frxDBNaoGra."DESCRI"'
        object Memo18: TfrxMemoView
          Top = 24.779530000000000000
          Width = 1084.725110000000000000
          Height = 15.874015750000000000
          DataSet = frmProcArqSPC.frxDBDatasetDetalhes
          DataSetName = 'frxDBDatasetDetalhes'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Fill.BackColor = clSilver
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Top = 24.779530000000000000
          Width = 103.936998110000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Duplicata')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 105.724490000000000000
          Top = 24.779530000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Esp')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 137.960730000000000000
          Top = 24.779530000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Emp')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 169.976500000000000000
          Top = 24.779530000000000000
          Width = 230.551330000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 473.118430000000000000
          Top = 24.779530000000000000
          Width = 68.031510710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Vencimento')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 542.811380000000000000
          Top = 24.779530000000000000
          Width = 64.251980710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Pagamento')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 608.716760000000000000
          Top = 24.779530000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Duplicata')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 841.882190000000000000
          Top = 24.779530000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Pago')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 971.047620000000000000
          Top = 24.779530000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Nosso N'#250'mero')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 402.764070000000000000
          Top = 24.677180000000000000
          Width = 68.031510710000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Cadastro')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 698.331170000000000000
          Top = 24.456710000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Juros')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 768.142240000000000000
          Top = 24.897650000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Valor Desc')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 11.338590000000000000
          Top = 3.779530000000000000
          Width = 77.480288110000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Diverg'#234'ncia:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 91.708720000000000000
          Top = 3.779530000000000000
          Width = 595.275898110000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBNaoGra."DESCRI"]')
          ParentFont = False
        end
        object rllTarifaCarteira: TfrxMemoView
          Left = 857.953310000000000000
          Top = 3.779530000000000000
          Width = 103.936998110000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tarifa da Carteira:')
          ParentFont = False
        end
        object rllTarifaCarteiraValor: TfrxMemoView
          Left = 964.559680000000000000
          Top = 3.779530000000000000
          Width = 115.275588110000000000
          Height = 15.118120000000000000
          DataSet = frxDBNaoGra
          DataSetName = 'frxDBNaoGra'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBNaoGra."TARIFA_CARTEIRA"]')
          ParentFont = False
        end
        object rllTarifaDuplicata: TfrxMemoView
          Left = 926.764380000000000000
          Top = 24.677180000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Tarifa')
          ParentFont = False
        end
      end
      object rlbFooterrGrupoDescri: TfrxGroupFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 272.126160000000000000
        Width = 1088.520410000000000000
      end
    end
  end
  object frxDBNaoGra: TfrxDBDataset
    UserName = 'frxDBNaoGra'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 448
    Top = 64
  end
end
