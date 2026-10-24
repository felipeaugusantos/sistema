object frmQckOrdProTintaMaquina: TfrmQckOrdProTintaMaquina
  Left = 487
  Top = 489
  ClientHeight = 174
  ClientWidth = 357
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
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39583.682226817100000000
    ReportOptions.LastChange = 45406.387143541670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 32
    Top = 16
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
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
      object Cabecalho: TfrxHeader
        FillType = ftBrush
        Height = 156.149660000000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        Child = frxReport.ChildAutomotivas
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 19.338590000000000000
          Top = 13.661410000000000000
          Width = 205.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ORDEM DE PRODU'#199#195'O N'#186':')
          ParentFont = False
        end
        object rllNumDoc: TfrxMemoView
          Left = 230.779530000000000000
          Top = 13.661410000000000000
          Width = 142.299320000000000000
          Height = 18.897650000000000000
          DataField = 'DOCUMENTO'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataset."DOCUMENTO"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 23.118120000000000000
          Top = 38.661409999999990000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'CLIENTE....:')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 23.118120000000000000
          Top = 57.881880000000000000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'FORMULA....:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 146.000000000000000000
          Top = 38.661409999999990000
          Width = 609.960730000000000000
          Height = 18.897650000000000000
          DataField = 'CLIENTE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."CLIENTE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 146.000000000000000000
          Top = 57.881880000000000000
          Width = 609.960730000000000000
          Height = 34.015770000000000000
          DataField = 'FORMULA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."FORMULA"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 380.811070000000000000
          Top = 13.661410000000000000
          Width = 30.488250000000000000
          Height = 18.897650000000000000
          DataField = 'ESPECIE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataset."ESPECIE"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 418.811070000000000000
          Top = 13.606299210000000000
          Width = 38.047310000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataset."EMPRESA"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 23.118120000000000000
          Top = 93.590600000000000000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'QUANTIDADE.:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 146.000000000000000000
          Top = 93.590600000000000000
          Width = 549.488250000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."QTDFORMUL"]')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 22.677180000000000000
          Top = 115.165430000000000000
          Width = 122.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DESTINO....:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 145.511825670000000000
          Top = 115.165430000000000000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DEST]')
          ParentFont = False
        end
        object memBase: TfrxMemoView
          Left = 22.677180000000000000
          Top = 136.063080000000000000
          Width = 122.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'BASE......:')
          ParentFont = False
        end
        object DbMemBase: TfrxMemoView
          Left = 145.511825670000000000
          Top = 136.063080000000000000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[BASE_IMOB]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 430.866420000000000000
        Width = 793.701300000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        object Memo9: TfrxMemoView
          Left = 23.118120000000000000
          Top = 0.905379999999979600
          Width = 428.850650000000000000
          Height = 18.897650000000000000
          DataField = 'COLORANTE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."COLORANTE"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 458.102660000000000000
          Top = 0.779530000000022500
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."QUANTIDADE"]')
          ParentFont = False
        end
        object DbMemEmbVinc: TfrxMemoView
          Left = 632.961157170000000000
          Top = 0.677180000000021200
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."TIPEMB"]')
          ParentFont = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 268.346630000000000000
        Top = 476.220780000000000000
        Width = 793.701300000000000000
        object Memo11: TfrxMemoView
          Left = 23.118120000000000000
          Top = 138.243970000000100000
          Width = 108.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VENDEDOR.:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 23.118120000000000000
          Top = 164.243970000000100000
          Width = 108.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DIGITADOR:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 502.118120000000000000
          Top = 138.070897870000100000
          Width = 107.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DATA/HORA:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 136.118120000000000000
          Top = 138.243970000000100000
          Width = 357.488250000000000000
          Height = 18.897650000000000000
          DataField = 'VENDEDOR'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."VENDEDOR"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 136.118120000000000000
          Top = 164.243970000000100000
          Width = 357.488250000000000000
          Height = 18.897650000000000000
          DataField = 'DIGITADOR'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."DIGITADOR"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 613.118120000000000000
          Top = 138.243970000000100000
          Width = 98.488250000000000000
          Height = 18.897650000000000000
          DataField = 'DATA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."DATA"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 716.118120000000000000
          Top = 138.243970000000100000
          Width = 68.252010000000000000
          Height = 18.897650000000000000
          DataField = 'HORA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."HORA"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 4.157480310000001000
          Top = 121.684910000000000000
          Width = 780.472448270000000000
          Height = 11.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 23.055118110000000000
          Top = 96.118119999999970000
          Width = 271.008040000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Valor Unit'#225'rio do Produto:')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 298.582782130000000000
          Top = 96.118119999999970000
          Width = 357.488250000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."UNITAR"]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 4.157480310000001000
          Top = 81.000000000000120000
          Width = 780.472448270000000000
          Height = 11.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 23.897635350000000000
          Top = 17.070722129999980000
          Width = 108.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'PRODU'#199#195'O')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 423.204700000000000000
          Top = 17.007871570000020000
          Width = 107.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EXPEDI'#199#195'O')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 23.897650000000000000
          Top = 36.677180000000020000
          Width = 342.819110000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Operador:_________________________')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 423.015745590000000000
          Top = 36.661414880000050000
          Width = 361.716760000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Respons'#225'vel:_________________________')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 23.897650000000000000
          Top = 59.354360000000150000
          Width = 342.819110000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Hora:___:___')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 423.189240000000000000
          Top = 59.338580240000170000
          Width = 361.716760000000000000
          Height = 22.677180000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Hora:___:___')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Width = 780.472448270000000000
          Height = 11.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object memObsCol: TfrxMemoView
          Left = 22.677180000000000000
          Top = 189.976500000000100000
          Width = 157.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'OBS.COLORISTA..:')
          ParentFont = False
        end
        object memDbObsCol: TfrxMemoView
          Left = 187.976500000000000000
          Top = 189.976500000000100000
          Width = 599.378170000000000000
          Height = 41.574830000000000000
          StretchMode = smActualHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."OBSCOL"]')
          ParentFont = False
        end
        object memTipFor: TfrxMemoView
          Left = 22.677180000000000000
          Top = 241.889920000000000000
          Width = 157.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'TIPO DA F'#211'RMULA:')
          ParentFont = False
        end
        object memDbTipFor: TfrxMemoView
          Left = 185.196970000000000000
          Top = 241.889920000000000000
          Width = 603.157700000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."TIPFOR"]')
          ParentFont = False
        end
      end
      object ChildAutomotivas: TfrxChild
        FillType = ftBrush
        Height = 143.622140000000000000
        Top = 196.535560000000000000
        Width = 793.701300000000000000
        Child = frxReport.ChildColorante
        PrintChildIfInvisible = True
        object Memo24: TfrxMemoView
          Left = 23.055120550000000000
          Top = 2.267779999999988000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'MONTADORA..:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 145.889763780000000000
          Top = 2.267779999999988000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[MONTAD]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 23.055120550000000000
          Top = 22.165429999999990000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'MARCA......:')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 145.889763780000000000
          Top = 22.165429999999990000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[MARTIN]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 23.055120550000000000
          Top = 41.842610000000010000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'LITROS.....:')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 145.889763780000000000
          Top = 41.842610000000010000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[LITROS]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 23.055120550000000000
          Top = 61.740259999999950000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EMBALAGEM..:')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 145.889763780000000000
          Top = 61.740259999999950000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[DESEMBALA]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 23.055118110000000000
          Top = 81.637910000000060000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DIL/CON....:')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 145.889763780000000000
          Top = 81.637910000000060000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."DILCON"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 23.055118110000000000
          Top = 101.535560000000300000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'ANO........:')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 145.889763780000000000
          Top = 101.535560000000300000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[frxDataset."ANOCOR"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 23.055118110000000000
          Top = 121.212740000000200000
          Width = 118.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'VARIACAO...:')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 145.889763780000000000
          Top = 121.212740000000000000
          Width = 628.858380000000000000
          Height = 18.897650000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[VARIAC]')
          ParentFont = False
        end
      end
      object ChildColorante: TfrxChild
        FillType = ftBrush
        Height = 45.897650000000000000
        Top = 362.834880000000000000
        Width = 793.701300000000000000
        object Memo5: TfrxMemoView
          Left = 4.000000000000000000
          Top = 3.779530000000022000
          Width = 780.472440944881900000
          Height = 4.338590000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 4.157480310000001000
          Top = 30.220469999999970000
          Width = 780.488250000000000000
          Height = 8.118119999999999000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 23.055118110000000000
          Top = 13.220469999999980000
          Width = 115.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'C'#211'DIGO')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 466.102542830000000000
          Top = 13.220469999999980000
          Width = 117.165347010000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 139.960730000000000000
          Top = 13.118119999999980000
          Width = 190.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'DESCRI'#199#195'O')
          ParentFont = False
        end
        object LbMemEmbVinc: TfrxMemoView
          Left = 593.386210000000000000
          Top = 13.118119999999980000
          Width = 190.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'EMBALAGEM VINCULADA')
          ParentFont = False
        end
      end
    end
  end
  object frxDataset: TfrxDBDataset
    UserName = 'frxDataset'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 32
    Top = 88
  end
  object frxOrdPro40Col: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 45016.389090266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 248
    Top = 16
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxSaltoPagina
        DataSetName = 'frxSaltoPagina'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549600000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      EndlessHeight = True
      FontStyle = []
      object Titulo: TfrxReportTitle
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 374.400000000000000000
        Child = frxOrdPro40Col.Child1
        Stretched = True
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Formula..:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 68.000000000000000000
          Width = 259.200000000000000000
          Height = 34.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'FORMULA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."FORMULA"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C'#243'digo...:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CODTIN]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMTIN]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 323.000000000000000000
        Width = 374.400000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'COLORANTE')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 408.000000000000000000
        Width = 374.400000000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object DMPMemo16: TfrxDMPMemoView
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataField = 'COLORANTE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."COLORANTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 182.400000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."QUANTIDADE"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 306.000000000000000000
        Top = 680.000000000000000000
        Width = 374.400000000000000000
        object DMPMemo26: TfrxDMPMemoView
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxSaltoPagina."SALTO"]')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baBottom
          Left = 4.800000000000000000
          Top = 314.500000000000000000
          Width = 364.800000000000000000
          Color = clBlack
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 442.000000000000000000
        Width = 374.400000000000000000
        object DMPMemo22: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Vendedor..:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Data/Hora:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 85.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataField = 'VENDEDOR'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."VENDEDOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 119.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'DATA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."DATA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 220.800000000000000000
          Top = 119.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DataField = 'HORA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."HORA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 119.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '/')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'DOCUMENTO'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."DOCUMENTO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 51.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          DataField = 'ESPECIE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."ESPECIE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Documento.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Cliente...:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 68.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataField = 'CLIENTE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 51.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '-')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'Valor Unit'#225'rio do Produto:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDataset."UNITAR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Destino...:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 102.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[DEST]')
          WordWrap = False
          TruncOutboundText = False
        end
        object memObsCol: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'Colorista.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object memDbObsCol: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 136.000000000000000000
          Width = 259.200000000000000000
          Height = 51.000000000000000000
          StretchMode = smActualHeight
          DataField = 'OBSCOL'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."OBSCOL"]')
          TruncOutboundText = False
        end
        object memTipFor: TfrxDMPMemoView
          Top = 187.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TP.Formula:')
          WordWrap = False
          TruncOutboundText = False
        end
        object memDbTipFor: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 187.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[TIPFOR]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 136.000000000000000000
        Width = 374.400000000000000000
        object rllQuant: TfrxDMPMemoView
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Quant....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDtQuant: TfrxDMPMemoView
          Left = 105.600000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[frxDataset."QTDFORMUL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllMarca: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Marca....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDtMarca: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 51.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MARTIN]')
          TruncOutboundText = False
        end
        object rllMontad: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Montadora:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllLitros: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Litros...:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDtLitros: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 68.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[LITROS]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllEmbala: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Embalagem:')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDtEmbala: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 85.000000000000000000
          Width = 259.200000000000000000
          Height = 34.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[DESEMBALA]')
          TruncOutboundText = False
        end
        object rllDtMontad: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 34.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[MONTAD]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Dil/Con:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'ANO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 119.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          Memo.UTF8W = (
            '[frxDataset."DILCON"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 136.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."ANOCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'Variacao.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 105.600000000000000000
          Top = 153.000000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VARIAC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
      end
    end
  end
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
    Left = 200
    Top = 88
  end
  object frxSaltoPagina: TfrxUserDataSet
    UserName = 'frxSaltoPagina'
    Fields.Strings = (
      'SALTO')
    OnGetValue = frxSaltoPaginaGetValue
    Left = 103
    Top = 88
  end
  object frxOrdPro40ColJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 45075.669343287000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 104
    Top = 16
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxSaltoPagina
        DataSetName = 'frxSaltoPagina'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 256.400000000000000000
      PaperSize = 256
      LeftMargin = 1.000000000000000000
      EndlessHeight = True
      object Titulo: TfrxReportTitle
        FillType = ftBrush
        Height = 116.256127370000000000
        Top = 18.897650000000000000
        Width = 298.582870000000000000
        Child = frxOrdPro40ColJ.Child1
        Stretched = True
        object DMPMemo1: TfrxMemoView
          Left = 15.263157890000000000
          Top = 17.000000000000000000
          Width = 254.372180150000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ORDEM DE PRODU'#199#195'O')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo14: TfrxMemoView
          Left = 15.118120000000000000
          Top = 100.000000000000000000
          Width = 52.362190080000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'F'#243'rmula:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo6: TfrxMemoView
          Left = 70.267780000000000000
          Top = 100.000000000000000000
          Width = 198.425196850000000000
          Height = 13.228346456692910000
          StretchMode = smActualHeight
          DataField = 'FORMULA'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."FORMULA"]')
          ParentFont = False
        end
        object DMPMemo12: TfrxMemoView
          Left = 15.118120000000000000
          Top = 51.000000000000000000
          Width = 52.362190080000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo23: TfrxMemoView
          Left = 70.267780000000000000
          Top = 51.000000000000000000
          Width = 198.425196850000000000
          Height = 43.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODTIN]')
          ParentFont = False
        end
        object DMPMemo25: TfrxMemoView
          Left = 70.267780000000000000
          Top = 34.000000000000000000
          Width = 198.425196850000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMTIN]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 15.118110240000000000
          Top = 33.795300000000000000
          Width = 52.362190080000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tinta:')
          ParentFont = False
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 430.866420000000000000
        Width = 298.582870000000000000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object DMPMemo16: TfrxMemoView
          Left = 13.118120000000000000
          Width = 167.281880000000000000
          Height = 13.228346456692910000
          StretchMode = smMaxHeight
          DataField = 'COLORANTE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."COLORANTE"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 186.015760240000000000
          Width = 81.089997890000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."QUANTIDADE"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Align = baWidth
          Top = 0.779530000000000000
          Width = 340.157700000000000000
          Visible = False
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 19.567994210000000000
        Top = 820.158010000000000000
        Width = 298.582870000000000000
        object DMPMemo26: TfrxMemoView
          Left = 10.951453330000000000
          Top = 3.000000000000000000
          Width = 247.936920000000000000
          Height = 13.228346456692910000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxSaltoPagina."SALTO"]')
          ParentFont = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 214.477736670000000000
        Top = 472.441250000000000000
        Width = 298.582870000000000000
        Child = frxOrdPro40ColJ.Child2
        object DMPMemo22: TfrxMemoView
          Left = 12.118120000000000000
          Top = 73.897650000000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo10: TfrxMemoView
          Left = 83.149606300000000000
          Top = 74.078740160000000000
          Width = 184.396912920000000000
          Height = 32.125979370000000000
          StretchMode = smActualHeight
          DataField = 'VENDEDOR'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."VENDEDOR"]')
          ParentFont = False
        end
        object DMPMemo2: TfrxMemoView
          Left = 83.149606300000000000
          Top = 23.055118110000000000
          Width = 184.396912920000000000
          Height = 13.220470000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DOCUMENTO"] - [frxDataset."ESPECIE"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo4: TfrxMemoView
          Left = 12.118120000000000000
          Top = 22.881880000000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Documento:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo13: TfrxMemoView
          Left = 12.118120000000000000
          Top = 37.220470000000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo5: TfrxMemoView
          Left = 83.149606300000000000
          Top = 37.039370080000000000
          Width = 184.396912920000000000
          Height = 35.897650000000000000
          StretchMode = smActualHeight
          DataField = 'CLIENTE'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CLIENTE"]')
          ParentFont = False
        end
        object DMPMemo11: TfrxMemoView
          Left = 13.228346460000000000
          Top = 2.661410000000000000
          Width = 146.776890690000000000
          Height = 13.228346456692910000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clWhite
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'Valor Unit'#225'rio do Produto:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo15: TfrxMemoView
          Left = 186.015760240000000000
          Top = 2.440940000000000000
          Width = 78.996408340000000000
          Height = 13.228346456692910000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clWhite
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."UNITAR"]')
          ParentFont = False
          WordWrap = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 1.338590000000010000
          Width = 298.582870000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 18.236240000000000000
          Width = 298.582870000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo6: TfrxMemoView
          Left = 12.118120000000000000
          Top = 106.401670000000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Destino:')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 83.149606300000000000
          Top = 106.582677170000000000
          Width = 184.396912920000000000
          Height = 13.228346460000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DEST]')
          ParentFont = False
          WordWrap = False
        end
        object memObsCol: TfrxMemoView
          Left = 12.118120000000000000
          Top = 134.535560000000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Obs.Colorista:')
          ParentFont = False
          WordWrap = False
        end
        object memTipFor: TfrxMemoView
          Left = 11.118120000000000000
          Top = 183.157555980000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Tp.Formula'#231#227'o:')
          ParentFont = False
          WordWrap = False
        end
        object memDbTipFor: TfrxMemoView
          Left = 83.149606300000000000
          Top = 183.307086610000000000
          Width = 184.396912920000000000
          Height = 28.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPFOR]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo9: TfrxMemoView
          Left = 12.118120000000000000
          Top = 120.346485980000000000
          Width = 68.176205700000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data/Hora:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo17: TfrxMemoView
          Left = 83.149606300000000000
          Top = 120.188976380000000000
          Width = 184.396912920000000000
          Height = 13.228346460000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DATA"] / [frxDataset."HORA"]')
          ParentFont = False
          WordWrap = False
        end
        object memDBObsCol: TfrxMemoView
          Left = 83.149606300000000000
          Top = 134.551181100000000000
          Width = 184.396912920000000000
          Height = 47.236240000000000000
          StretchMode = smActualHeight
          DataField = 'OBSCOL'
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."OBSCOL"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 170.623376670000000000
        Top = 158.740260000000000000
        Width = 298.582870000000000000
        object rllQuant: TfrxMemoView
          Left = 15.118110240000000000
          Width = 52.362190080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Quant:')
          ParentFont = False
          WordWrap = False
        end
        object rllDtQuant: TfrxMemoView
          Left = 70.267780000000000000
          Width = 198.259384160000000000
          Height = 13.228346460000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."QTDFORMUL"]')
          ParentFont = False
          WordWrap = False
        end
        object rllMarca: TfrxMemoView
          Left = 15.118120000000000000
          Top = 37.000000000000000000
          Width = 72.539370080000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Marca:')
          ParentFont = False
          WordWrap = False
        end
        object rllDtMarca: TfrxMemoView
          Left = 90.718120000000000000
          Top = 37.000000000000000000
          Width = 177.637795280000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MARTIN]')
          ParentFont = False
        end
        object rllMontad: TfrxMemoView
          Left = 15.118120000000000000
          Top = 20.000000000000000000
          Width = 72.539370080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Montadora:')
          ParentFont = False
          WordWrap = False
        end
        object rllLitros: TfrxMemoView
          Left = 15.118120000000000000
          Top = 52.000000000000000000
          Width = 72.539370080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Litros:')
          ParentFont = False
          WordWrap = False
        end
        object rllDtLitros: TfrxMemoView
          Left = 90.718120000000000000
          Top = 52.000000000000000000
          Width = 177.637795280000000000
          Height = 15.118110240000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[LITROS]')
          ParentFont = False
          WordWrap = False
        end
        object rllEmbala: TfrxMemoView
          Left = 15.118120000000000000
          Top = 67.000000000000000000
          Width = 72.539370080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Embalagem:')
          ParentFont = False
          WordWrap = False
        end
        object rllDtEmbala: TfrxMemoView
          Left = 90.718120000000000000
          Top = 67.000000000000000000
          Width = 177.637795280000000000
          Height = 52.897650000000000000
          StretchMode = smActualHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DESEMBALA]')
          ParentFont = False
        end
        object rllDtMontad: TfrxMemoView
          Left = 90.718120000000000000
          Top = 20.000000000000000000
          Width = 177.637795280000000000
          Height = 13.228346460000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MONTAD]')
          ParentFont = False
        end
        object DMPMemo24: TfrxMemoView
          Left = 15.118120000000000000
          Top = 121.456710000000000000
          Width = 72.539370080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dil/Con:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo28: TfrxMemoView
          Left = 15.118120000000000000
          Top = 136.456710000000000000
          Width = 72.539370080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ANO:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo27: TfrxMemoView
          Left = 90.718120000000000000
          Top = 121.456710000000000000
          Width = 177.637795280000000000
          Height = 13.228346460000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,###0.0000'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DILCON"]')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo29: TfrxMemoView
          Left = 90.718120000000000000
          Top = 136.456710000000000000
          Width = 177.637795280000000000
          Height = 13.228346460000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."ANOCOR"] ')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo30: TfrxMemoView
          Left = 15.118120000000000000
          Top = 153.236240000000000000
          Width = 72.539370080000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Varia'#231#227'o:')
          ParentFont = False
          WordWrap = False
        end
        object DMPMemo31: TfrxMemoView
          Left = 90.718120000000000000
          Top = 153.236240000000000000
          Width = 177.637795280000000000
          Height = 13.228346460000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[VARIAC]')
          ParentFont = False
          WordWrap = False
        end
        object DMPLine1: TfrxLineView
          Align = baWidth
          Top = 14.333333330000000000
          Width = 298.582870000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 17.677180000000000000
        Top = 389.291590000000000000
        Width = 298.582870000000000000
        object Memo3: TfrxMemoView
          Left = 13.118120000000000000
          Width = 45.354360000000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clWhite
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 58.811070000000000000
          Width = 120.944960000000000000
          Height = 13.228346456692910000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clWhite
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 186.015760240000000000
          Width = 81.089997890000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clWhite
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Align = baWidth
          Width = 340.157700000000000000
          Visible = False
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 710.551640000000000000
        Width = 298.582870000000000000
        object Memo8: TfrxMemoView
          Left = 10.960629920000000000
          Width = 68.527082880000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Mensagem '
            'Expedi'#231#227'o:')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 83.149606300000000000
          Width = 184.396912920000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MENEXP] [MENEX2] [MENEX3] [MENEX4]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end
            item
            end>
        end
        object Line5: TfrxLineView
          Align = baWidth
          Top = 44.913420000000000000
          Width = 298.582870000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
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
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 45406.483640856480000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 176
    Top = 16
    Datasets = <
      item
        DataSet = frxDataset
        DataSetName = 'frxDataset'
      end
      item
        DataSet = frxSaltoPagina
        DataSetName = 'frxSaltoPagina'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 261.619831037192500000
      PaperHeight = 179.916550470561200000
      PaperSize = 256
      RightMargin = 2.539998359584393000
      EndlessHeight = True
      FontStyle = []
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 17.000000000000000000
        Width = 979.200000010611200000
        Child = frxReportM.ChildAutomotivas
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ORDEM DE PRODUCAO N'#186':')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80'
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CLIENTE....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 528.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Command = '#27#87#49'
        end
        object DMPCommand3: TfrxDMPCommand
          Left = 441.600000000000000000
          Top = 17.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          Command = '#27#87#48'
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."DOCUMENTO"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 326.400000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."ESPECIE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."EMPRESA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."CLIENTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'FORMULA....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."FORMULA"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'QUANTIDADE.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."QTDFORMUL"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESTINO....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[DEST]')
          WordWrap = False
          TruncOutboundText = False
        end
        object memBase: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'BASE......:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DbMemBase: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[BASE_IMOB]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand4: TfrxDMPCommand
          Left = 86.400000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#18'
        end
        object DMPCommand5: TfrxDMPCommand
          Left = 172.800000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#80'
        end
        object DMPCommand6: TfrxDMPCommand
          Left = 259.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#48'
        end
        object DMPCommandPagina: TfrxDMPCommand
          Left = 355.200000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 391.000000000000000000
        Width = 979.200000010611200000
        DataSet = frxDataset
        DataSetName = 'frxDataset'
        RowCount = 0
        Stretched = True
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          Memo.UTF8W = (
            '[frxDataset."COLORANTE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."QUANTIDADE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DbMemEmbVinc: TfrxDMPMemoView
          Left = 566.400000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxDataset
          DataSetName = 'frxDataset'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."TIPEMB"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildAutomotivas: TfrxChild
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 170.000000000000000000
        Width = 979.200000010611200000
        Child = frxReportM.ChildColorante
        PrintChildIfInvisible = True
        object DMPMemo7: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MONTADORA..:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[MONTAD]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'MARCA......:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[MARTIN]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'LITROS.....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[LITROS]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMBALAGEM..:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 51.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[DESEMBALA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DIL/CON....:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 68.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."DILCON"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'ANO........:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 85.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."ANOCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VARIACAO...:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 102.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[VARIAC]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object ChildColorante: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 306.000000000000000000
        Width = 979.200000010611200000
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CODIGO')
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DESCRICAO')
          TruncOutboundText = False
        end
        object LbMemEmbVinc: TfrxDMPMemoView
          Left = 566.400000000000000000
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMBALAGEM VINCULADA')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'QUANTIDADE')
          TruncOutboundText = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 221.000000000000000000
        Top = 425.000000000000000000
        Width = 979.200000010611200000
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PRODUCAO')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 34.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPERADOR:_________________________')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EXPEDICAO')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 34.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'RESPONSAVEL:_________________________')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HORA:___:___')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 364.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HORA:___:___')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VALOR UNITARIO DO PRODUTO:')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 278.400000000000000000
          Top = 85.000000000000000000
          Width = 480.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."UNITAR"]')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 739.200000000000000000
          Color = clBlack
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'VENDEDOR.:')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DIGITADOR:')
          TruncOutboundText = False
        end
        object memObsCol: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 153.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OBS.COLORISTA..:')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 119.000000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."VENDEDOR"]')
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DATA/HORA:')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 119.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."DATA"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 662.400000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."HORA"]')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 136.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."DIGITADOR"]')
          TruncOutboundText = False
        end
        object memDbObsCol: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 153.000000000000000000
          Width = 556.800000000000000000
          Height = 34.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."OBSCOL"]')
          TruncOutboundText = False
        end
        object memTipFor: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 187.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'TIPO DA F'#211'RMULA:')
          TruncOutboundText = False
        end
        object memDbTipFor: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 187.000000000000000000
          Width = 556.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."TIPFOR"]')
          TruncOutboundText = False
        end
      end
    end
  end
end
