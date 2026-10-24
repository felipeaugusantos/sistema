inherited frmVerificaEstoqueOrdPro: TfrmVerificaEstoqueOrdPro
  Caption = 'Verifica Estoque Ordem Produ'#231#227'o'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    inherited btnSair: TBitBtnLocked
      ExplicitLeft = 419
    end
  end
  inherited pnlDados: TPanel
    ExplicitHeight = 212
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42091.475643032400000000
    ReportOptions.LastChange = 42091.475643032400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 264
    Top = 88
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
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 45.354360000000000000
        ParentFont = False
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 45.354360000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PRODUTOS QUE N'#195'O PERMITEM  BAIXAR A ORDEM DE PRODU'#199#195'O'
            'DOCUMENTO: [CODPRO]-OP')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 124.724490000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Top = 0.755905510000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 354.834880000000000000
          Top = 0.755905510000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'LOTE')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 434.425480000000000000
          Top = 0.755905510000005100
          Width = 86.929138740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NECESS'#193'RIO')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 526.134199999999900000
          Top = 0.755905510000005100
          Width = 86.929138740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DISPON'#205'VEL')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 617.842920000000000000
          Top = 0.755905510000005100
          Width = 139.842558740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'MOTIVO')
          ParentFont = False
        end
        object memCodFabLabel: TfrxMemoView
          Left = 267.440940000000000000
          Top = 0.275510000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'COD. FABRICA')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 245.669450000000000000
        Width = 755.906000000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Top = 11.338589999999980000
          Width = 755.906000000000000000
          Color = clBlack
          Diagonal = True
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        object Memo6: TfrxMemoView
          Top = 1.511811020000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxRelatorio."CODITE">)] - [(<frxRelatorio."DESITE">)]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo7: TfrxMemoView
          Left = 354.834880000000000000
          Top = 1.511811020000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxRelatorio."NUMLOT">)]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 434.425480000000000000
          Top = 1.511811023622044000
          Width = 86.929138740000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxRelatorio."QTDPRO">)]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 526.134199999999900000
          Top = 1.511811023622044000
          Width = 86.929138740000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxRelatorio."SALDIS">)]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 617.842920000000000000
          Top = 1.511811020000010000
          Width = 139.842558740000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxRelatorio."ERRO">)]')
          ParentFont = False
        end
        object memCodFab: TfrxMemoView
          Left = 270.220470000000000000
          Top = 2.031415510000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[(<frxRelatorio."CODFAB">)]')
          ParentFont = False
        end
      end
    end
  end
end
