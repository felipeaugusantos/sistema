object frmCadBoxEti: TfrmCadBoxEti
  Left = 0
  Top = 0
  Caption = 'Impressao de etiqueta'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxCadBoxEti: TfrxReport
    Version = '5.6.11'
    DataSet = frxdbCadBoxEti
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 45404.885980011580000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure CodBarOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  TfrxBarCodeView(Sender).visible := <frxDBImpEti."CODBAR"> <> '#39 +
        #39' ;'
      'end;'
      ''
      ''
      'begin'
      'end.')
    Left = 296
    Top = 88
    Datasets = <
      item
        DataSet = frxdbCadBoxEti
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 100.000000000000000000
      PaperHeight = 50.000000000000000000
      PaperSize = 256
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 25.877180000000000000
        Top = 381.732530000000000000
        Visible = False
        Width = 377.953000000000000000
      end
      object frxPageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 226.800000000000000000
        Top = 18.897650000000000000
        Width = 377.953000000000000000
        object memo0: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 109.000000000000000000
          Top = 8.000000000000000000
          Width = 171.000000000000000000
          Height = 53.000000000000000000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxdbCadBoxEti
          DataSetName = 'frxDBDataset1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial Black'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[<frxDBDataset1."CODBOX">]')
          ParentFont = False
        end
        object memo1: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 28.000000000000000000
          Top = 14.000000000000000000
          Width = 85.000000000000000000
          Height = 39.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '['#39'Box:'#39']')
          ParentFont = False
        end
        object memo2: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 9.000000000000000000
          Top = 80.000000000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '['#39'Cliente:'#39']')
        end
        object memo3: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 62.000000000000000000
          Top = 79.000000000000000000
          Width = 303.000000000000000000
          Height = 42.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxdbCadBoxEti
          DataSetName = 'frxDBDataset1'
          Memo.UTF8W = (
            '[<frxDBDataset1."NOMCLI">]')
        end
        object memo4: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 87.000000000000000000
          Top = 126.000000000000000000
          Width = 151.000000000000000000
          Height = 18.000000000000000000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxdbCadBoxEti
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxDBDataset1."NUMDOC">]')
          ParentFont = False
        end
        object memo5: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 50.000000000000000000
          Top = 152.000000000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '[<frxDBDataset1."SEQSEP">]')
        end
        object memo6: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 11.000000000000000000
          Top = 126.000000000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            '['#39'Documento:'#39']')
        end
        object memo7: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 11.000000000000000000
          Top = 153.000000000000000000
          Width = 50.000000000000000000
          Height = 19.000000000000000000
          Memo.UTF8W = (
            '['#39'Onda:'#39']')
        end
        object memo8: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 191.000000000000000000
          Top = 126.000000000000000000
          Width = 41.425170000000000000
          Height = 19.000000000000000000
          StretchMode = smMaxHeight
          AutoWidth = True
          DataSet = frxdbCadBoxEti
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxDBDataset1."ESPDOC">]')
          ParentFont = False
        end
        object TfrxBarCodeView
          Left = 245.000000000000000000
          Top = 6.000000000000000000
          Width = 97.294736842105180000
          Height = 59.000000000000000000
          BarType = bcCode128
          DataSet = frxdbCadBoxEti
          DataSetName = 'frxDBDataset1'
          Expression = '<frxDBDataset1."CODBOX">'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.231578947368420000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
      object HeaderData1: TfrxHeader
        FillType = ftBrush
        Height = 30.240000000000000000
        Top = 306.141930000000000000
        Width = 377.953000000000000000
        OnBeforePrint = 'HeaderOnBeforePrint'
        ReprintOnNewPage = True
        object mmoCorHeaderData: TfrxMemoView
          Align = baClient
          Width = 377.953000000000000000
          Height = 30.240000000000000000
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Top = 359.055350000000000000
        Width = 377.953000000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Columns = 1
        ColumnWidth = 378.000000000000000000
        DataSetName = 'frxDBImpEti'
        RowCount = 0
        Stretched = True
      end
    end
  end
  object frxdbCadBoxEti: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 384
    Top = 88
  end
end
