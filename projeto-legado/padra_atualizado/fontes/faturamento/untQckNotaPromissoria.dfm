object frmQckNotaPromissoria: TfrmQckNotaPromissoria
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 175
  Width = 334
  object frxPromissoria_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 43858.747105381950000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxPromissoria_MUserFunction
    Left = 40
    Top = 16
    Datasets = <
      item
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      HGuides.Strings = (
        '493')
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 510.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
        RowCount = 0
        object dmpComando: TfrxDMPCommand
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo12: TfrxDMPMemoView
          Align = baCenter
          Left = 249.600000000000000000
          Top = 17.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsxWide]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA PROMISSORIA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              'Pag'#225'vel em [frxDatasetDup."CID_NOMCID_EMP"] - [frxDatasetDup."CI' +
              'D_ESTADO_EMP"].')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 221.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsxWide]
          Memo.UTF8W = (
            'Nro:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 221.000000000000000000
          Width = 1200.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsxWide]
          Memo.UTF8W = (
            '[frxDatasetDup."CTR_NUMDUP"] - [frxDatasetDup."CTR_ESPDOC"].')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 255.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Emitente:')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 255.000000000000000000
          Width = 1152.000000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_NOMCLI"] - [frxDatasetDup."CLI_C_G_C_"].')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 272.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Endere'#231'o:')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 272.000000000000000000
          Width = 1152.000000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            
              '[frxDatasetDup."CLI_ENDERE"] - [frxDatasetDup."CLI_BAIRRO"] - [f' +
              'rxDatasetDup."CID_NOMCID"] - [frxDatasetDup."CID_ESTADO"] - [frx' +
              'DatasetDup."CLI_C_E_P_"]')
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
            end>
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 323.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Telefone:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 323.000000000000000000
          Width = 1152.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_FONE01"]')
          TruncOutboundText = False
        end
        object rllObs: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 357.000000000000000000
          Width = 1248.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."MemoObs"]')
          TruncOutboundText = False
        end
        object rllVencimento: TfrxDMPMemoView
          Left = 912.000000000000000000
          Top = 34.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."MemoVencimento"]')
          TruncOutboundText = False
        end
        object rllTexto: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 1248.000000000000000000
          Height = 85.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."MemoTexto"]')
          TruncOutboundText = False
        end
        object rllValor: TfrxDMPMemoView
          Align = baCenter
          Left = 249.600000000000000000
          Top = 68.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsxWide]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDatasetDup."MemoValor"]')
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
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 216
    Top = 22
  end
  object frxPromissoria_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43077.499538669000000000
    ReportOptions.LastChange = 43858.746385914360000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '  '
      'end.')
    OnUserFunction = frxPromissoria_MUserFunction
    Left = 144
    Top = 16
    Datasets = <
      item
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 523.464566930000100000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
        KeepChild = True
        KeepFooter = True
        KeepHeader = True
        KeepTogether = True
        RowCount = 0
        object Shape2: TfrxShapeView
          Width = 718.110700000000000000
          Height = 30.236240000000000000
          Shape = skRoundRectangle
        end
        object rllVencimento: TfrxMemoView
          Left = 277.795455000000000000
          Top = 64.252010000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDatasetDup."MemoVencimento"]')
        end
        object rllTexto: TfrxMemoView
          Left = 18.897650000000000000
          Top = 158.740260000000000000
          Width = 680.315400000000000000
          Height = 83.149660000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetDup."MemoTexto"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 90.708720000000000000
          Top = 262.551330000000000000
          Width = 608.504330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              '[frxDatasetDup."CID_NOMCID_EMP"] - [frxDatasetDup."CID_ESTADO_EM' +
              'P"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo2: TfrxMemoView
          Left = 90.708720000000000000
          Top = 284.008040000000000000
          Width = 608.504330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxDatasetDup."CTR_NUMDUP"] - [frxDatasetDup."CTR_ESPDOC"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo3: TfrxMemoView
          Left = 15.118120000000000000
          Top = 304.244280000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Emitente:')
        end
        object Memo4: TfrxMemoView
          Left = 15.118120000000000000
          Top = 284.008040000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Nro.:')
        end
        object Memo5: TfrxMemoView
          Left = 90.708720000000000000
          Top = 304.244280000000000000
          Width = 608.504330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_NOMCLI"] - [frxDatasetDup."CLI_C_G_C_"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo6: TfrxMemoView
          Left = 15.118120000000000000
          Top = 324.700990000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Endere'#231'o:')
        end
        object Memo7: TfrxMemoView
          Left = 90.708720000000000000
          Top = 324.700990000000000000
          Width = 608.504330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_ENDERE"] - [frxDatasetDup."CLI_BAIRRO"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo8: TfrxMemoView
          Left = 90.708720000000000000
          Top = 345.157700000000000000
          Width = 608.504330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            
              '[frxDatasetDup."CID_NOMCID"] - [frxDatasetDup."CID_ESTADO"] - [f' +
              'rxDatasetDup."CLI_C_E_P_"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo9: TfrxMemoView
          Left = 15.118120000000000000
          Top = 365.614410000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Telefone:')
        end
        object Memo10: TfrxMemoView
          Left = 90.708720000000000000
          Top = 365.614410000000000000
          Width = 608.504330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_FONE01"]')
          ParentFont = False
        end
        object rllObs: TfrxMemoView
          Align = baCenter
          Left = 109.606370000000000000
          Top = 397.630180000000000000
          Width = 498.897960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDatasetDup."MemoObs"]')
          ParentFont = False
        end
        object rllValor: TfrxMemoView
          Left = 582.047620000000000000
          Top = 124.724490000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDatasetDup."MemoValor"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 245.669450000000000000
          Top = 6.559059999999999000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA PROMISS'#211'RIA')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 15.118120000000000000
          Top = 262.551330000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Pag'#225'vel:')
        end
      end
    end
  end
  object frxDatasetDup: TfrxDBDataset
    UserName = 'frxDatasetDup'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 224
    Top = 120
  end
  object frxPromissoria40_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 43859.678678171300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnUserFunction = frxPromissoria_MUserFunction
    Left = 40
    Top = 72
    Datasets = <
      item
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 269.874825705841700000
      PaperSize = 256
      HGuides.Strings = (
        '697')
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 697.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
        RowCount = 0
        object dmpComando: TfrxDMPCommand
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo12: TfrxDMPMemoView
          Align = baCenter
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsxWide]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA PROMISSORIA')
          ParentFont = False
          TruncOutboundText = False
          VAlign = vaCenter
        end
        object DMPMemo1: TfrxDMPMemoView
          Top = 323.000000000000000000
          Width = 384.000000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            
              'Pag'#225'vel em [frxDatasetDup."CID_NOMCID_EMP"] - [frxDatasetDup."CI' +
              'D_ESTADO_EMP"].')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo2: TfrxDMPMemoView
          Top = 374.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsxWide]
          Memo.UTF8W = (
            'Nro:')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 374.000000000000000000
          Width = 336.000000000000000000
          Height = 34.000000000000000000
          FontStyle = [fsxBold, fsxWide]
          Memo.UTF8W = (
            '[frxDatasetDup."CTR_NUMDUP"] - [frxDatasetDup."CTR_ESPDOC"].')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 425.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Emitente:')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Top = 442.000000000000000000
          Width = 384.000000000000000000
          Height = 51.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_NOMCLI"] - [frxDatasetDup."CLI_C_G_C_"].')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 493.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Endere'#231'o:')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Top = 510.000000000000000000
          Width = 384.000000000000000000
          Height = 102.000000000000000000
          Memo.UTF8W = (
            
              '[frxDatasetDup."CLI_ENDERE"] - [frxDatasetDup."CLI_BAIRRO"] - [f' +
              'rxDatasetDup."CID_NOMCID"] - [frxDatasetDup."CID_ESTADO"] - [frx' +
              'DatasetDup."CLI_C_E_P_"]')
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
            end>
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 612.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Telefone:')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 612.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."CLI_FONE01"]')
          TruncOutboundText = False
        end
        object rllObs: TfrxDMPMemoView
          Top = 646.000000000000000000
          Width = 364.800000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."MemoObs"]')
          TruncOutboundText = False
        end
        object rllVencimento: TfrxDMPMemoView
          Align = baCenter
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDatasetDup."MemoVencimento"]')
          TruncOutboundText = False
        end
        object rllTexto: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 384.000000000000000000
          Height = 170.000000000000000000
          Memo.UTF8W = (
            '[frxDatasetDup."MemoTexto"]')
          TruncOutboundText = False
        end
        object rllValor: TfrxDMPMemoView
          Align = baCenter
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsxWide]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDatasetDup."MemoValor"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPromissoria40_J: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43077.499538669000000000
    ReportOptions.LastChange = 43858.746759803240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      '  '
      'end.')
    OnUserFunction = frxPromissoria_MUserFunction
    Left = 144
    Top = 72
    Datasets = <
      item
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 175.000000000000000000
      PaperSize = 256
      RightMargin = 8.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 701.874460000000000000
        Top = 18.897650000000000000
        Width = 272.126160000000000000
        DataSet = frxDatasetDup
        DataSetName = 'frxDatasetDup'
        RowCount = 0
        object rllTexto: TfrxMemoView
          Left = 5.897650000000000000
          Top = 105.283550000000100000
          Width = 260.787570000000000000
          Height = 170.078850000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDatasetDup."MemoTexto"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 381.260050000000400000
          Width = 260.787570000000000000
          Height = 71.811070000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitente: '
            '[frxDatasetDup."CLI_NOMCLI"] - [frxDatasetDup."CLI_C_G_C_"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 332.787570000000400000
          Width = 260.787570000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            
              'Nro.: [frxDatasetDup."CTR_NUMDUP"] - [frxDatasetDup."CTR_ESPDOC"' +
              '].')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 3.559060000000000000
          Top = 458.071120000000400000
          Width = 260.787570000000000000
          Height = 120.944960000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Endere'#231'o:'
            '[frxDatasetDup."CLI_ENDERE"] - [frxDatasetDup."CLI_BAIRRO"]'
            
              '[frxDatasetDup."CID_NOMCID"] - [frxDatasetDup."CID_ESTADO"] - [f' +
              'rxDatasetDup."CLI_C_E_P_"].')
          ParentFont = False
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
            end>
        end
        object Memo9: TfrxMemoView
          Left = 4.338590000000000000
          Top = 582.370439999999900000
          Width = 260.787570000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Telefone: [frxDatasetDup."CLI_FONE01"]')
          ParentFont = False
        end
        object rllObs: TfrxMemoView
          Align = baCenter
          Left = 5.669295000000013000
          Top = 604.724409450000000000
          Width = 260.787570000000000000
          Height = 34.015770000000010000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDatasetDup."MemoObs"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Align = baCenter
          Left = 22.677180000000010000
          Top = 6.559060000000003000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA PROMISS'#211'RIA')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 282.874150000000200000
          Width = 260.787570000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              'Pag'#225'vel em [frxDatasetDup."CID_NOMCID_EMP"] - [frxDatasetDup."CI' +
              'D_ESTADO_EMP"].')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object rllVencimento: TfrxMemoView
          Left = 56.692950000000010000
          Top = 37.795300000000010000
          Width = 211.653680000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDatasetDup."MemoVencimento"]')
          ParentFont = False
        end
        object rllValor: TfrxMemoView
          Left = 151.291435000000000000
          Top = 68.031540000000010000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.ShadowWidth = 1.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDatasetDup."MemoValor"]')
          ParentFont = False
        end
      end
    end
  end
end
