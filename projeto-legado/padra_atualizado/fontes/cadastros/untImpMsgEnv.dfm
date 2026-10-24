object frmImpMsgEnv: TfrmImpMsgEnv
  Left = 0
  Top = 0
  Caption = 'frmImpMsgEnv'
  ClientHeight = 237
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxReportM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40182.522628217590000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      'end.')
    Left = 96
    Top = 88
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelMsg'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 200.659870407167000000
      PaperHeight = 148.431154138213000000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 739.200000000000000000
        Stretched = True
        object frxUserRelstrTitRel: TfrxDMPMemoView
          Align = baCenter
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'COMUNICACAO INTERNA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 93.500000000000000000
          Width = 720.000000000000000000
          Color = clBlack
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPEENV]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPEREC]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DTAEMI]')
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MSGTIT]')
          TruncOutboundText = False
        end
        object frxRelatorioHORENV: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 720.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frmCadEstruturas.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MENSAG]')
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 720.000000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[NUMERO]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 739.200000000000000000
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 720.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = False
    Left = 95
    Top = 40
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelMsg'
    CloseDataSource = False
    DataSet = frmModuloSPR.qryRelatorio
    BCDToCurrency = False
    Left = 151
    Top = 40
  end
  object frxReportJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40182.522628217600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      'end.')
    Left = 151
    Top = 88
    Datasets = <
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelMsg'
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
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 924.024120000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Stretched = True
        object frxUserRelstrTitRel: TfrxMemoView
          Align = baCenter
          Left = 176.655350000000000000
          Top = 52.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'COMUNICACAO INTERNA')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 127.500000000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object memo5: TfrxMemoView
          Left = 9.600000000000000000
          Top = 69.000000000000000000
          Width = 700.119790000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPEENV]')
        end
        object Memo3: TfrxMemoView
          Left = 9.600000000000000000
          Top = 86.000000000000000000
          Width = 700.119790000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[OPEREC]')
        end
        object Memo4: TfrxMemoView
          Left = 9.600000000000000000
          Top = 103.000000000000000000
          Width = 700.119790000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DTAEMI]')
        end
        object Memo2: TfrxMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 700.119790000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MSGTIT]')
        end
        object frxRelatorioHORENV: TfrxMemoView
          Left = 9.600000000000000000
          Top = 170.000000000000000000
          Width = 697.322820000000000000
          Height = 761.567410000000000000
          StretchMode = smMaxHeight
          DataSet = frmCadEstruturas.frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MENSAG]')
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 161.500000000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo1: TfrxMemoView
          Left = 546.722820000000000000
          Top = 52.000000000000000000
          Width = 165.240940000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[NUMERO]')
          ParentFont = False
        end
        object barCodBar: TfrxBarCodeView
          Left = 453.047620000000000000
          Top = 0.559060000000000000
          Width = 259.000000000000000000
          Height = 52.913420000000000000
          BarType = bcCode39
          Rotation = 0
          TestLine = False
          Text = '112345678901225001'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 1005.354980000000000000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          Align = baWidth
          Top = 8.500000000000114000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
