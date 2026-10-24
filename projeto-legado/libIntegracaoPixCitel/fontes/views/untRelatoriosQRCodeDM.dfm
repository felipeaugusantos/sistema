object frmRelatoriosQRCodeDM: TfrmRelatoriosQRCodeDM
  OldCreateOrder = False
  Height = 150
  Width = 296
  object frxQRCodePix40C: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44434.370589328700000000
    ReportOptions.LastChange = 44434.370589328700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure barQRCodePixOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 40
    Top = 16
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
      PaperWidth = 80.000000000000000000
      PaperHeight = 80.000000000000000000
      PaperSize = 256
      object rlbQRCode: TfrxReportTitle
        FillType = ftBrush
        Height = 272.126160000000000000
        Top = 18.897650000000000000
        Width = 302.362400000000000000
        object barQRCodePix: TfrxBarcode2DView
          Left = 54.031540000000000000
          Top = 39.897650000000000000
          Width = 196.000000000000000000
          Height = 196.000000000000000000
          OnBeforePrint = 'barQRCodePixOnBeforePrint'
          StretchMode = smActualHeight
          BarType = bcCodeQR
          BarProperties.Encoding = qrAuto
          BarProperties.QuietZone = 0
          BarProperties.ErrorLevels = ecL
          BarProperties.PixelSize = 4
          BarProperties.CodePage = 0
          DataField = 'TEXTOQRCODE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Rotation = 0
          ShowText = False
          Text = 
            '00020101021226850014br.gov.bcb.pix2563qrcodepix.bb.com.br/pix/v2' +
            '/00070d34-123a-4d04-822b-335e683d70c35204000053039865802BR5925RE' +
            'ZENDE MATERIAIS PARA CO6013NOVA FRIBURGO62070503***6304CF52'
          Zoom = 1.000000000000000000
          FontScaled = True
          QuietZone = 0
        end
        object rllValor: TfrxMemoView
          Left = 5.677180000000000000
          Top = 248.771800000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."VALOR"]')
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 291.023810000000000000
          Height = 22.677180000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pagamento')
          ParentFont = False
        end
      end
    end
  end
  object frxObjetoQRCode: TfrxBarCodeObject
    Left = 40
    Top = 72
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSource = dtsRelatorio
    BCDToCurrency = False
    Left = 136
    Top = 24
  end
  object dtsRelatorio: TDataSource
    AutoEdit = False
    Left = 208
    Top = 24
  end
end
