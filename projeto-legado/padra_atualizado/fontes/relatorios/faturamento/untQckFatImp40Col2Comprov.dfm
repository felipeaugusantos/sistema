object frmQckFatImp40Col2Comprov: TfrmQckFatImp40Col2Comprov
  Left = 422
  Top = 348
  Caption = 'Impress'#227'o de Faturamento 40 Colunas 2'
  ClientHeight = 148
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object frxDotMatrixExport1: TfrxDotMatrixExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = True
    Left = 151
    Top = 21
  end
  object frxComprovM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39540.732132268500000000
    ReportOptions.LastChange = 42810.617800405100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure ColumnFooter1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  pAcionaGuilhotina;      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxComprovMUserFunction
    Left = 40
    Top = 24
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 269.874825705841700000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        Child = frxComprovM.CComprovante
        PrintChildIfInvisible = True
        object Command2: TfrxDMPCommand
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
      end
      object CComprovante: TfrxChild
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 51.000000000000000000
        Width = 384.000000000000000000
        Child = frxComprovM.CComprovanteSimplificado
        PrintChildIfInvisible = True
        object DMPLine1: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 42.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Left = -14.400000000000000000
          Top = 297.500000000000000000
          Width = 393.600000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baWidth
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCadEmp'
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cliente..:')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vendedor.:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Align = baCenter
          Left = 57.600000000000000000
          Top = 85.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxTitulo'
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITULO]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 136.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxVendedor'
          Memo.UTF8W = (
            '[VENDED]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 204.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Forma Pag:')
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Top = 170.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Cnd. Pgto:')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 204.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFormaPgto'
          Memo.UTF8W = (
            '[FPGPGO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 170.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCondPgto'
          Memo.UTF8W = (
            '[CONDI1]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 187.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCondPagto2'
          Memo.UTF8W = (
            '[CONDI2]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Top = 238.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Dt.Emis:')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 238.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Hora:')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 238.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFatGor'
          Memo.UTF8W = (
            '[DTAENT]')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 238.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFatGor'
          Memo.UTF8W = (
            '[HORENT]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 272.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFatGor'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[VLRCON]')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Top = 272.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'TOTAL:')
          TruncOutboundText = False
        end
        object frxCadCliCLI_CODCLI: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 119.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxCadCli'
          Memo.UTF8W = (
            '[CLIENT]')
          TruncOutboundText = False
        end
        object rllVende2_2: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Vendedor2:')
          TruncOutboundText = False
        end
        object dbVende2_2: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 153.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxVendedor'
          Memo.UTF8W = (
            '[VENDE2]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 459.000000000000000000
        Width = 384.000000000000000000
        OnAfterPrint = 'ColumnFooter1OnAfterPrint'
        object frxSaltoPaginaSALTO: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxSaltoPagina'
          Memo.UTF8W = (
            '[SALTO]')
          TruncOutboundText = False
        end
      end
      object CComprovanteSimplificado: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 374.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFatGor'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '###,#0.00'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[VLRCON]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFatGor'
          Memo.UTF8W = (
            '[CODVEN]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxFatGor'
          Memo.UTF8W = (
            '[NUMDOC]')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxComprovJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42874.492788750000000000
    ReportOptions.LastChange = 42874.492788750000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 80
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 245.000000000000000000
      PaperSize = 256
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Child = frxComprovJ.CComprovante
      end
      object CComprovante: TfrxChild
        FillType = ftBrush
        Height = 264.567100000000000000
        Top = 64.252010000000000000
        Width = 279.685220000000000000
        Child = frxComprovJ.CComprovanteSimplificado
        PrintChildIfInvisible = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 30.236240000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 106.252010000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 121.370130000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 136.488250000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor2:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 151.606370000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cnd. Pagto:')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 11.338590000000000000
          Width = 279.685220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 75.590600000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITULO]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 113.385900000000000000
          Top = 106.252010000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CLIENT]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 113.385900000000000000
          Top = 121.370130000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDED]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 113.385900000000000000
          Top = 136.488250000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENDE2]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 113.385900000000000000
          Top = 151.606370000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONDI1]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 113.385900000000000000
          Top = 166.724490000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONDI2]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 3.779530000000000000
          Top = 185.196970000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Forma Pagto:')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 113.385900000000000000
          Top = 185.196970000000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[FPGPGO]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 211.653680000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Emiss'#227'o:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 113.385900000000000000
          Top = 211.653680000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAENT]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 177.637910000000000000
          Top = 211.653680000000000000
          Width = 30.236240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Hora:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 215.433210000000000000
          Top = 211.653680000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[HORENT]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Top = 238.110390000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Total:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 113.385900000000000000
          Top = 238.110390000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VLRCON]')
          ParentFont = False
        end
      end
      object CComprovanteSimplificado: TfrxChild
        FillType = ftBrush
        Height = 56.692950000000000000
        Top = 351.496290000000000000
        Width = 279.685220000000000000
        PrintChildIfInvisible = True
        object Memo17: TfrxMemoView
          Left = 3.779530000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VLRCON]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.015770000000000000
          Width = 192.756030000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODVEN]')
          ParentFont = False
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 143.622140000000000000
        Top = 468.661720000000000000
        Width = 279.685220000000000000
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[SALTO]')
          ParentFont = False
        end
      end
    end
  end
  object frxCompro: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45118.417959976850000000
    ReportOptions.LastChange = 45118.417959976850000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 152
    Top = 96
    Datasets = <>
    Variables = <>
    Style = <>
  end
end
