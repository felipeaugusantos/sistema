object frmQckRelFatReciboAvulso: TfrmQckRelFatReciboAvulso
  Left = 0
  Top = 0
  Caption = 'frmQckRelFatReciboAvulso'
  ClientHeight = 268
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxDotMatrixExport: TfrxDotMatrixExport
    UseFileCache = False
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = False
    Left = 104
    Top = 56
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'NOMEMP'
      'FONE01'
      'CIDEMP'
      'OPERAD'
      'RESULT')
    OnGetValue = frxGenGetValue
    Left = 24
    Top = 56
  end
  object frxDBDatasetCTPDET: TfrxUserDataSet
    UserName = 'frxUser'
    OnCheckEOF = frxDBDatasetCTPDETCheckEOF
    OnFirst = frxDBDatasetCTPDETFirst
    OnNext = frxDBDatasetCTPDETNext
    OnPrior = frxDBDatasetCTPDETPrior
    Fields.Strings = (
      'DTAREC'
      'VALREC'
      'NOMREC'
      'NOMASS'
      'HISREC'
      'CIDREC'
      'NROVIA'
      'VLREXT'
      'CGCCPF'
      'NOMEMP'
      'NUMTEL'
      'NOMCID'
      'NOMEND'
      'NOMBAI'
      'NUMCEP'
      'CLIEND'
      'CLINRO'
      'CLICID'
      'NUMCNPJ')
    OnGetValue = frxDBDatasetCTPDETGetValue
    Left = 168
    Top = 112
  end
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 44089.637581400500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      '                              '
      'end.')
    Left = 72
    Top = 112
    Datasets = <
      item
        DataSet = frxDBDatasetCTPDET
        DataSetName = 'frxUser'
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
        DataSet = frxDBDatasetCTPDET
        DataSetName = 'frxUser'
        RowCount = 0
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 278.400000000000000000
          Top = 102.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'R E C I B O')
          TruncOutboundText = False
        end
        object frxUserVALREC: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 136.000000000000000000
          Width = 595.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)]')
          TruncOutboundText = False
        end
        object frxUserNOMASS: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 442.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          DataField = 'NOMASS'
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxUserNROVIA: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 476.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '- ([frxUser."NROVIA"]a. Via ) -')
          TruncOutboundText = False
        end
        object frxUserCIDREC: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 374.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          TruncOutboundText = False
        end
        object frxUserNOMREC: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 187.000000000000000000
          Width = 720.000000000000000000
          Height = 153.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          Memo.UTF8W = (
            
              '    Declaramos ter recebido de [frxUser."NOMREC"], [frxUser."CLI' +
              'END"][frxUser."CLINRO"][frxUser."CLICID"] a importancia supra me' +
              'ncionada de R$ [FormatFloat('#39'#,##0.00'#39',<frxUser."VALREC">)] ( [f' +
              'rxUser."VLREXT"] ), referente [frxUser."HISREC"].')
          TruncOutboundText = False
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
          Top = 93.500000000000000000
          Width = 758.400000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#69'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 9.600000000000000000
          Top = 153.000000000000000000
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
        object memNomEmp: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 508.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Tel.....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Cidade..:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Endereco:')
          ParentFont = False
          TruncOutboundText = False
        end
        object memNomEnd: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 68.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMEND"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object memNomCid: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 51.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object memNumTel: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 34.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object memNomBai: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 51.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NOMBAI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object memNumCep: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 68.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          FontStyle = []
          Memo.UTF8W = (
            '[frxUser."NUMCEP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'BAIRRO:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 68.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CEP...:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 360.000000000000000000
          Top = 433.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object memNumCnpj: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          FontStyle = []
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 518.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CNPJ..:')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 40343.563931203700000000
    ReportOptions.LastChange = 44099.451046932860000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 28
    Top = 112
    Datasets = <
      item
        DataSet = frmRelFatReciboAvulso.frxUser
        DataSetName = 'frxUser'
      end>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'VS_Date'
        Value = #39'15/09/2020'#39
      end
      item
        Name = 'VS_strCodEmp'
        Value = #39'001'#39
      end
      item
        Name = 'LOGOTIPO'
        Value = #39#39
      end
      item
        Name = 'strEmpAcessoUsuarioLogado'
        Value = 
          #39'001_255_256_257_258_259_300_800_778_400_401_026_002_003_531_100' +
          '_017_127_999_018_532_533_007_012_456_020_666_013_029_009_014_321' +
          '_333_004_555_556_557_558_559_601_602_603_604_600_112_950_888_889' +
          '_171_025_998_900_777_776_901_852_033_008_015_123_016_005_987_030' +
          '_022_006_290_019_021_907_994_154_010_222_234_500_700_301_302_268' +
          '_155_040_023_741_237_712_713_789_238_239_240_241_242_243_041_790' +
          '_028_513_111_153_101_159_160_363_027_969_000_444_'#39
      end
      item
        Name = 'strLoginUsuarioLogado'
        Value = #39'998'#39
      end>
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
        Height = 525.354670000000100000
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        DataSet = frmRelFatReciboAvulso.frxUser
        DataSetName = 'frxUser'
        RowCount = 0
        object Shape1: TfrxShapeView
          Top = 81.267780000000000000
          Width = 755.906000000000000000
          Height = 374.173470000000000000
        end
        object frxUserNOMASS: TfrxMemoView
          Left = 279.685220000000000000
          Top = 376.071120000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          DataField = 'NOMASS'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxUser."NOMASS"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 26.456710000000000000
          Top = 421.425480000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DataField = 'NROVIA'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NROVIA"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 15.118120000000000000
          Top = 297.551330000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DataField = 'DTAREC'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUser."DTAREC"]')
          ParentFont = False
        end
        object frxUserVALREC: TfrxMemoView
          Left = 30.236240000000000000
          Top = 119.401670000000000000
          Width = 699.213050000000000000
          Height = 26.456710000000000000
          DataField = 'VALREC'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
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
            '[frxUser."VALREC"]')
          ParentFont = False
        end
        object memDizeres: TfrxMemoView
          Left = 26.456710000000000000
          Top = 156.094620000000000000
          Width = 702.992580000000000000
          Height = 120.944872130000000000
          DataField = 'HISREC'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."HISREC"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 82.267780000000000000
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
        end
        object Memo1: TfrxMemoView
          Left = 154.000000000000000000
          Top = 58.031539999999990000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 81.488249999999970000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Top = 111.724490000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 154.000000000000000000
          Top = 40.133890000000010000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cidade....:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 154.118120000000000000
          Top = 22.236239999999990000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tel..........:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 153.960730000000000000
          Top = 2.338589999999996000
          Width = 411.968389210000000000
          Height = 18.897650000000000000
          DataField = 'NOMEMP'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMEMP"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 218.472480000000000000
          Top = 22.236239999999990000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo5OnBeforePrint'
          AutoWidth = True
          DataField = 'NUMTEL'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NUMTEL"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 218.252010000000000000
          Top = 40.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataField = 'NOMCID'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMCID"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 218.252010000000000000
          Top = 58.141732280000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DataField = 'NOMEND'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMEND"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 618.709030000000000000
          Top = 40.000000000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'NOMBAI'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NOMBAI"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 573.354670000000100000
          Top = 40.000000000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 619.181483150000000000
          Top = 60.252010000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'NUMCEP'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NUMCEP"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 573.606680000000000000
          Top = 59.472480000000000000
          Width = 45.354333150000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CEP..:')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Height = 113.385900000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line6: TfrxLineView
          Left = 755.906000000000000000
          Height = 113.385900000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 277.905690000000000000
          Top = 370.055350000000100000
          Width = 457.323130000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object imgImagem: TfrxPictureView
          Left = 4.000000000000000000
          Top = 4.559060000000017000
          Width = 143.622047240000000000
          Height = 71.811070000000000000
          Center = True
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object MemoNumCnpj: TfrxMemoView
          Left = 618.708661417322800000
          Top = 3.000000000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataField = 'NUMCNPJ'
          DataSet = frmRelFatReciboAvulso.frxUser
          DataSetName = 'frxUser'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxUser."NUMCNPJ"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 573.354330708661300000
          Top = 2.779529999999994000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ:')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
      end
    end
  end
end
