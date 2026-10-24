object frmQckCopiaCheque: TfrmQckCopiaCheque
  Left = 0
  Top = 0
  ClientHeight = 139
  ClientWidth = 262
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
  object frxCopiaCheque_M: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39585.352479375000000000
    ReportOptions.LastChange = 39602.585068599500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 48
    Top = 16
    Datasets = <
      item
        DataSet = FrxCheque
        DataSetName = 'FrxCheque'
      end
      item
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 304.799803150127100000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object HCheque: TfrxHeader
        FillType = ftBrush
        Height = 272.000000000000000000
        Top = 17.000000000000000000
        Width = 1152.000000000000000000
        object FrxChequeVALOR_CHEQUE: TfrxDMPMemoView
          Left = 912.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '( [FrxCheque."VALOR_CHEQUE"] )')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxChequeEXTENSO_CHEQUE: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 34.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EXTENSO_CHEQUE'
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          Memo.UTF8W = (
            '[FrxCheque."EXTENSO_CHEQUE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxChequeFAVORECIDO_CHEQUE: TfrxDMPMemoView
          Left = 144.000000000000000000
          Top = 102.000000000000000000
          Width = 883.200000000000000000
          Height = 17.000000000000000000
          DataField = 'FAVORECIDO_CHEQUE'
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          Memo.UTF8W = (
            '[FrxCheque."FAVORECIDO_CHEQUE"]')
          TruncOutboundText = False
        end
        object FrxChequeCIDADE_CHEQUE: TfrxDMPMemoView
          Left = 393.600000000000000000
          Top = 136.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CIDADE_CHEQUE'
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxCheque."CIDADE_CHEQUE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxChequeDATA_CHEQUE: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 136.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          DataField = 'DATA_CHEQUE'
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          Memo.UTF8W = (
            '[FrxCheque."DATA_CHEQUE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object FrxChequeBOMPARA_CHEQUE: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 238.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataField = 'BOMPARA_CHEQUE'
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxCheque."BOMPARA_CHEQUE"]')
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#27#67#33#15#27#80'
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 68.000000000000000000
          Width = 931.200000000000000000
          Height = 17.000000000000000000
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[FrxCheque."EXTENSO2_CHEQUE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 255.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          HAlign = haRight
          Memo.UTF8W = (
            '[FrxCheque."EMISSAO_CHEQUE"]')
          TruncOutboundText = False
        end
      end
      object GHDuplicatas: TfrxGroupHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 306.000000000000000000
        Width = 1152.000000000000000000
        Condition = 'frxDuplicatas."EMI_NUMCHQ"'
        object DMPMemo1: TfrxDMPMemoView
          Left = 220.800000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."EMI_NUMCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUMERO DO CHEQUE : ')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'PORTADOR         : ')
          TruncOutboundText = False
        end
        object FrxChequePORTADOR_CHEQUE: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'PORTADOR_CHEQUE'
          DataSet = FrxCheque
          DataSetName = 'FrxCheque'
          Memo.UTF8W = (
            '[FrxCheque."PORTADOR_CHEQUE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 38.400000000000000000
          Top = 34.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'BANCO            : ')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."EMI_CODBCO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGENCIA        : ')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CONTA CORRENTE : ')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 17.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."EMI_NUMAGE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 34.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."EMI_CONCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object MDDuplicatas: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 1152.000000000000000000
        DataSet = frxDuplicatas
        DataSetName = 'frxDuplicatas'
        RowCount = 0
        object DMPMemo4: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'DP: ')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDuplicatas."EMI_NUMDUP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 336.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VR: ')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 374.400000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDuplicatas."EMI_VALBAI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 556.799999999999900000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'FORN: ')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 528.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxDuplicatas."FOR_NOMFOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 168
    Top = 16
  end
  object frxDuplicatas: TfrxDBDataset
    UserName = 'frxDuplicatas'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 48
    Top = 79
  end
  object FrxCheque: TfrxUserDataSet
    UserName = 'FrxCheque'
    Fields.Strings = (
      'VALOR_CHEQUE'
      'EXTENSO_CHEQUE'
      'EXTENSO2_CHEQUE'
      'FAVORECIDO_CHEQUE'
      'CIDADE_CHEQUE'
      'DATA_CHEQUE'
      'BOMPARA_CHEQUE'
      'PORTADOR_CHEQUE'
      'EMISSAO_CHEQUE')
    OnGetValue = FrxChequeGetValue
    Left = 168
    Top = 80
  end
end
