object frmRelFatEtiqProdAcabados: TfrmRelFatEtiqProdAcabados
  Left = 349
  Top = 381
  ClientHeight = 98
  ClientWidth = 152
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxReport: TfrxReport
    Version = '4.15'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39715.560623553240000000
    ReportOptions.LastChange = 39715.616671909720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 24
    Top = 16
    Datasets = <
      item
        DataSet = frxProdutos
        DataSetName = 'frxProdutos'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 55.000000000000000000
      PaperSize = 256
      object MasterData1: TfrxMasterData
        Height = 143.622047240000000000
        Top = 18.897650000000000000
        Width = 302.362400000000000000
        DataSet = frxProdutos
        DataSetName = 'frxProdutos'
        RowCount = 0
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 7.559059999999999000
          Width = 287.244280000000000000
          Height = 37.795275590000000000
          ShowHint = False
          DataField = 'DESCRI'
          DataSet = frxProdutos
          DataSetName = 'frxProdutos'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxProdutos."DESCRI"]')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Align = baCenter
          Left = 56.181199999999990000
          Top = 56.692949999999990000
          Width = 190.000000000000000000
          Height = 75.590600000000000000
          ShowHint = False
          BarType = bcCodeEAN13
          DataField = 'CODBAR'
          DataSet = frxProdutos
          DataSetName = 'frxProdutos'
          Rotation = 0
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 2.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
      object Footer1: TfrxFooter
        Height = 18.897650000000000000
        Top = 185.196970000000000000
        Width = 302.362400000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SALTO]')
          ParentFont = False
        end
      end
    end
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 24
    Top = 48
  end
  object frxProdutos: TfrxDBDataset
    UserName = 'frxProdutos'
    CloseDataSource = False
    DataSet = qryProdutos
    BCDToCurrency = False
    Left = 56
    Top = 16
  end
  object qryProdutos: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 88
    Top = 16
  end
end
