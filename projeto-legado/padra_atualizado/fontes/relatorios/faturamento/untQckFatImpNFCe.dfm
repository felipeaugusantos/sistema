object frmQckFatImpNFCe: TfrmQckFatImpNFCe
  Left = 0
  Top = 0
  ClientHeight = 484
  ClientWidth = 310
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
  object frxDbNFce: TfrxDBDataset
    UserName = 'frxNFce'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 120
    Top = 40
  end
  object frxNFCeEntrega: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 41767.388587268500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 96
    Datasets = <
      item
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
      end>
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
      EndlessHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 283.464566930000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Child = frxNFCeEntrega.rlbCabecalhoItens
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
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
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.677180000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 98.692950000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DO CLIENTE')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 121.370130000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 136.488250000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 151.606370000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 166.724490000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CGCCLI]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 206.299320000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DE ENTREGA')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Top = 224.756030000000000000
          Width = 272.126160000000000000
          Height = 52.913420000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDENT]'
            '[CIDENT]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.574830000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TITULO] [NUMDOC] - S'#233'rie: [SERIE_]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 181.842610000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TELCLI]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.015770000000010000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TELEMP]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 4.779530000000000000
          Top = 75.370130000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Data de Emiss'#227'o: [DTAEMI]')
          ParentFont = False
        end
      end
      object rlbItens: TfrxMasterData
        FillType = ftBrush
        Height = 39.685039370000000000
        Top = 427.086890000000000000
        Width = 279.685220000000000000
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        RowCount = 0
        Stretched = True
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxNFce."PROMOC">='#39'S'#39','#39'*'#39'+<frxNFce."CODITE">,<frxNFce."COD' +
              'ITE">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 49.133890000000000000
          Top = 3.779530000000022000
          Width = 226.771800000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'DESITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESITE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 90.708720000000000000
          Top = 21.456709999999990000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 166.299320000000000000
          Top = 21.456709999999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'UNITAR'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNITAR"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 139.842610000000000000
          Top = 21.456709999999990000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          DataField = 'UNIDAD'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 222.992270000000000000
          Top = 21.456709999999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'TOTITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTITE"]')
          ParentFont = False
        end
      end
      object rlbTotais: TfrxFooter
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 491.338900000000000000
        Width = 279.685220000000000000
        Child = frxNFCeEntrega.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL DOS PRODUTOS:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 207.874150000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTPRO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118119999999980000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL DE DESCONTO:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 207.874150000000000000
          Top = 15.118119999999980000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'DESESP'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DESESP"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 31.015769999999920000
          Width = 196.535560000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL DO DOCUMENTO:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 207.874150000000000000
          Top = 31.015769999999920000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 52.913420000000000000
        Top = 563.149970000000100000
        Width = 279.685220000000000000
        Child = frxNFCeEntrega.rlbMensagem
        PrintChildIfInvisible = True
        Stretched = True
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.795300000000000000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VENCIMENTOS]')
          ParentFont = False
          WordBreak = True
        end
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 272.126160000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CONDI'#199#195'O DE PAGAMENTO'
            'VENCIMENTO VALOR DA PARCELA')
          ParentFont = False
        end
      end
      object rlbCabecalhoItens: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 325.039580000000000000
        Width = 279.685220000000000000
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.913419999999970000
          Width = 272.126160000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 19.236240000000010000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 49.133890000000000000
          Top = 19.236240000000010000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 109.606370000000000000
          Top = 19.236240000000010000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 147.401670000000000000
          Top = 19.236240000000010000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 173.858380000000000000
          Top = 19.236240000000010000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. Unit.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 222.992270000000000000
          Top = 19.236240000000010000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. Total')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITENS DO CUPOM')
          ParentFont = False
        end
      end
      object rlbMensagem: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 638.740570000000000000
        Width = 279.685220000000000000
        Child = frxNFCeEntrega.rlbMsg001
        PrintChildIfInvisible = True
        Stretched = True
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[MENSAGEM]')
          ParentFont = False
          WordBreak = True
        end
      end
      object rlbMsg001: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 684.094930000000000000
        Width = 279.685220000000000000
        Child = frxNFCeEntrega.rlbMsg002
        PrintChildIfInvisible = True
        Stretched = True
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSG001]')
          ParentFont = False
          WordBreak = True
        end
      end
      object rlbMsg002: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 729.449290000000000000
        Width = 279.685220000000000000
        Child = frxNFCeEntrega.Child6
        PrintChildIfInvisible = True
        Stretched = True
        object Memo35: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MSG002]')
          ParentFont = False
          WordBreak = True
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 774.803650000000000000
        Width = 279.685220000000000000
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 47.472480000000020000
          Width = 272.126160000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Assinatura')
          ParentFont = False
        end
      end
    end
  end
  object frxTEF: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 43678.685920462960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 120
    Top = 96
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 69.000000000000000000
      PaperHeight = 60.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 85.039370080000000000
        Top = 18.897650000000000000
        Width = 260.787570000000000000
        Child = frxTEF.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228346456692900000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.677180000000000000
          Width = 120.944881890000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ: [CNPJ]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 50.692949999999990000
          Width = 253.228346456692900000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[ENDEMP]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 129.259842520000000000
          Top = 18.897650000000000000
          Width = 127.748031500000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.E.: [IE]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 34.015770000000010000
          Width = 253.228346456692900000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.M.: [IM]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.031540000000010000
          Width = 253.228346456692900000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[TELEMP]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 128.504020000000000000
        Width = 260.787570000000000000
        Stretched = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999994000
          Width = 253.228346456692900000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TEXTO1]')
          ParentFont = False
        end
      end
    end
  end
  object frxNFCe: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 45582.734093344910000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 40
    Datasets = <
      item
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 660.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 1.889763780000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChdLogo
        PrintChildIfInvisible = True
        Stretched = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 63.496070310000000000
        Top = 442.205010000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.chdCompec1
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        RowCount = 0
        Stretched = True
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 52.535433070866140000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxNFce."PROMOC">='#39'S'#39','#39'*'#39'+<frxNFce."CODITE">,<frxNFce."COD' +
              'ITE">)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 59.456470640000000000
          Top = 0.779530000000022500
          Width = 197.551569360000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'DESITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESITE"]')
          ParentFont = False
        end
        object memQtdIte1: TfrxMemoView
          Left = 81.267716540000000000
          Top = 29.393700790000030000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object memUnitar1: TfrxMemoView
          Left = 159.519685040000000000
          Top = 29.393700790000030000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNITAR"]')
          ParentFont = False
        end
        object memUnidad1: TfrxMemoView
          Left = 127.905511810000000000
          Top = 29.393700790000030000
          Width = 30.236240000000000000
          Height = 13.228346460000000000
          DataField = 'UNIDAD'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"]')
          ParentFont = False
        end
        object memTotIte1: TfrxMemoView
          Left = 208.653543310000000000
          Top = 29.393700790000030000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTITE"]')
          ParentFont = False
        end
        object memLocFis1: TfrxMemoView
          Left = 3.779527560000000000
          Top = 15.118119999999980000
          Width = 252.944881890000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Loc.F'#237'sica: [frxNFce."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object memDesEspVal1: TfrxMemoView
          Left = 49.133890000000000000
          Top = 45.354359999999990000
          Width = 207.874150000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL R$: [frxNFce."DET_DESESP"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 702.992580000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 733.228820000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildTotFre
        PrintChildIfInvisible = True
        Stretched = True
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 22.677180000000020000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SUBTOTAL R$:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 192.756030000000000000
          Top = 22.677180000000020000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTPRO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.574830000000020000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCONTOS R$:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 192.756030000000000000
          Top = 41.574830000000020000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DESESP"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD. TOTAL DE ITENS:')
          ParentFont = False
        end
        object memQtdTot: TfrxMemoView
          Left = 192.756030000000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxNFce."QTDITE">,MasterData1,2)]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 49.133890000000000000
        ParentFont = False
        Top = 332.598640000000000000
        Width = 279.685220000000000000
        object rllMensagemAproveitaICMS: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.795299999999997000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#227'o permite aproveitamento de cr'#233'dito de ICMS')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.913419999999970000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 49.133890000000000000
          Top = 26.913419999999970000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 97.267780000000000000
          Top = 26.913419999999970000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 135.063080000000000000
          Top = 26.913419999999970000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 162.519790000000000000
          Top = 26.913419999999970000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. Unit.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 211.653680000000000000
          Top = 26.913419999999970000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. Total')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 43.590599999999990000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 20.692950000000000000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 1130.079470000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child7
        PrintChildIfInvisible = True
        Stretched = True
        object rllTotalPago: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL R$:')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 188.976500000000000000
          Top = 0.779530000000022500
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
        object rllTroco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897649999999880000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TROCO R$:')
          ParentFont = False
        end
        object rllValTroco: TfrxMemoView
          Left = 188.976500000000000000
          Top = 18.897649999999880000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TROCO_"]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 128.504020000000000000
        Top = 1882.205940000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child8
        PrintChildIfInvisible = True
        Stretched = True
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Consulta via leitor de QR Code')
          ParentFont = False
        end
        object imgQRCode: TfrxPictureView
          Align = baCenter
          Left = 92.598515511811000000
          Top = 26.456709999999930000
          Width = 94.488188976378000000
          Height = 94.488188976378000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 132.283550000000000000
        Top = 1727.245210000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child4
        PrintChildIfInvisible = True
        Stretched = True
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.677179999999910000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#250'mero: [NUMDOC] - S'#233'rie: [SERIE_]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 36.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Emiss'#227'o: [DTAEMI] - Via consumidor')
          ParentFont = False
        end
        object rllTituloChave: TfrxMemoView
          Left = 3.779530000000000000
          Top = 51.913420000000090000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Consulte pela Chave de Acesso em')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 79.590600000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACESSO]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 3.779530000000000000
          Top = 97.488250000000100000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONSUMIDOR')
          ParentFont = False
        end
        object rllConsumidor: TfrxMemoView
          Left = 3.779530000000000000
          Top = 113.385900000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DO CONSUMIDOR')
          ParentFont = False
        end
        object rllAreaMensagemFiscal: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.779530000000022000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #193'REA DE MENSAGEM FISCAL')
          ParentFont = False
        end
        object rllEnderecoConsulta: TfrxMemoView
          Left = 3.779530000000000000
          Top = 68.031539999999950000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          ParentFont = False
        end
      end
      object ChdContribuinte: TfrxChild
        FillType = ftBrush
        Height = 83.149660000000000000
        Top = 1394.646570000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChdNumGuiche
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 8.779530000000023000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #193'REA DE MENSAGEM DE INTERESSE DO CONTRIBUINTE')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 39.015769999999970000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[INF_COMPLEMENTAR]')
          ParentFont = False
        end
        object rllProfissional: TfrxMemoView
          Left = 3.779530000000000000
          Top = 61.472479999999910000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PROFIS] [CODDIV] - [NOMDIV]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Child7: TfrxChild
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 1190.551950000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChdNetpoints
        PrintChildIfInvisible = True
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.133889999999838000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tributos Totais Incidentes (Lei Federal 12.741/2012):')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.590599999999990000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$ [TOTAL_TRIBUTOS]')
          ParentFont = False
        end
      end
      object Child8: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 2033.387140000000000000
        Width = 279.685220000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object rllProtocolo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 19.913420000000090000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[PROTOC] - [DPROTO]')
          ParentFont = False
        end
        object rllLabelProtocolo: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.015769999999975000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Protocolo de Autoriza'#231#227'o')
          ParentFont = False
        end
      end
      object Child9: TfrxChild
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 1341.733150000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChdContribuinte
        PrintChildIfInvisible = True
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779527559999906000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'NFCE EMITIDA EM AMBIENTE DE HOMOLOGA'#199#195'O - SEM VALOR FISCAL')
          ParentFont = False
        end
      end
      object ChildTotFre: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 816.378480000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildDesAce
        PrintChildIfInvisible = True
        object Memo49: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FRETE R$:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 192.755907950000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTFRE"]')
          ParentFont = False
        end
      end
      object Child11: TfrxChild
        FillType = ftBrush
        Height = 109.606370000000000000
        Top = 997.795920000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child3
        PrintChildIfInvisible = True
        Stretched = True
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL R$:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 192.756030000000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 73.677180000000030000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FORMAS DE PAGAMENTO')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 89.574830000000030000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MODALIDADES]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 166.299320000000000000
          Top = 89.574830000000030000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORES_MOD]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.677180000000020000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONDI'#199#213'ES DE PAGAMENTO')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 3.779530000000000000
          Top = 53.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."CODCND"] - [frxNFce."DESCND"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 3.779530000000000000
          Top = 37.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CONDICAO_PAGAMENTO]')
          ParentFont = False
        end
      end
      object ChdNetpoints: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 1247.244900000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildFidelidade
        PrintChildIfInvisible = True
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parab'#233'ns! Voc'#234' ganhou [QTDNPS] NETPOINTS nesta compra.')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 74.456700240000000000
        Top = 566.929500000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.chdCompec2
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        RowCount = 0
        Stretched = True
        object Memo52: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 41.574830000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[IIF(<frxNFce."PROMOC">='#39'S'#39','#39'*'#39'+<frxNFce."CODITE">,<frxNFce."COD' +
              'ITE">)]'
            '')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 49.133890000000000000
          Top = 0.779530000000022500
          Width = 207.874150000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          DataField = 'DESITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESITE"]')
          ParentFont = False
        end
        object MemoMarca: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 3.401574800000000000
          Top = 15.574830000000020000
          Width = 128.503937010000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Marca: [frxNFce."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object MemoCodFab: TfrxMemoView
          Left = 135.685039370000000000
          Top = 15.574830000000020000
          Width = 120.944881890000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'd.F'#225'b.: [frxNFce."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object memQtdIte2: TfrxMemoView
          Left = 81.259842519685040000
          Top = 43.110236220000040000
          Width = 45.354360000000000000
          Height = 13.228346460000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object memUnitar2: TfrxMemoView
          Left = 159.496062992126000000
          Top = 43.110236220000040000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNITAR"]')
          ParentFont = False
        end
        object memUnidad2: TfrxMemoView
          Left = 127.748031500000000000
          Top = 43.110236220000040000
          Width = 30.236220472440940000
          Height = 13.228346460000000000
          DataField = 'UNIDAD'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"]')
          ParentFont = False
        end
        object memTotIte2: TfrxMemoView
          Left = 208.629921259842500000
          Top = 43.110236220000040000
          Width = 47.244094490000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTITE"]')
          ParentFont = False
        end
        object memLocFis2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 29.236239999999960000
          Width = 252.944881890000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Loc.F'#237'sica: [frxNFce."LOCFIS"]')
          ParentFont = False
          WordWrap = False
        end
        object memDesEspVal2: TfrxMemoView
          Left = 49.133890000000000000
          Top = 57.692950000000000000
          Width = 207.874150000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL R$: [frxNFce."DET_DESESP"]')
          ParentFont = False
        end
      end
      object ChildDesAce: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 861.732840000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildTotRet
        PrintChildIfInvisible = True
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESP. ACESSORIA R$:')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 192.755907950000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DESACE"]')
          ParentFont = False
        end
      end
      object ChildTotRet: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 907.087200000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildTotIpi
        PrintChildIfInvisible = True
        object Memo58: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ICMS ST R$:')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 192.755907950000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTRET"]')
          ParentFont = False
        end
      end
      object ChildTotIpi: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 952.441560000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child11
        PrintChildIfInvisible = True
        object Memo60: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IPI R$:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 192.755907950000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTIPI"]')
          ParentFont = False
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Height = 114.141754250000000000
        Top = 132.283550000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildContingencia1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 81.149660000000010000
          Width = 253.228510000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'DANFE NFC-e - Documento Auxiliar da Nota Fiscal Eletr'#244'nica para ' +
              'Consumidor Final')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.677179999999990000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ: [CNPJ]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 43.692949999999990000
          Width = 253.228510000000000000
          Height = 34.015770000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ENDEMP]'
            'CEP: [CEPEMP]   TELEFONE: [TELEMP]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 128.504020000000000000
          Top = 17.897650000000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'I.E.: [IE]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 29.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'I.M.: [IM]')
          ParentFont = False
        end
      end
      object ChdLogo: TfrxChild
        FillType = ftBrush
        Height = 64.251968500000000000
        Top = 45.354360000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child6
        PrintChildIfInvisible = True
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 71.811023620000000000
          Top = 3.779530000000001000
          Width = 120.944911180000000000
          Height = 52.913371180000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object ChdNumGuiche: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 1500.473410000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChdNomeSeparador
        PrintChildIfInvisible = True
        Stretched = True
        object Memo48: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.795299999999997000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'MERO DO GUICH'#202':')
          ParentFont = False
        end
        object rllNumGuiche: TfrxMemoView
          Left = 188.976500000000000000
          Top = 1.795299999999997000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."NUMGUI"]')
          ParentFont = False
        end
      end
      object ChildContingencia1: TfrxChild
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 268.346630000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child2
        PrintChildIfInvisible = True
        object rllContingencia1_1: TfrxMemoView
          Left = 4.440940000000000000
          Top = 9.440940000000012000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMITIDA EM CONTING'#202'NCIA')
          ParentFont = False
        end
        object rllContingencia1_2: TfrxMemoView
          Left = 4.440940000000000000
          Top = 20.338590000000010000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pendente de autoriza'#231#227'o')
          ParentFont = False
        end
      end
      object ChildContingencia2: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 1678.111320000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child5
        PrintChildIfInvisible = True
        object rllContingencia2_1: TfrxMemoView
          Left = 4.440940000000000000
          Top = 2.440939999999955000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMITIDA EM CONTING'#202'NCIA')
          ParentFont = False
        end
        object rllContingencia2_2: TfrxMemoView
          Left = 4.440940000000000000
          Top = 13.338590000000070000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pendente de autoriza'#231#227'o')
          ParentFont = False
        end
      end
      object ChdNomeConferente: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 1591.182130000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.chdNumCup
        PrintChildIfInvisible = True
        Stretched = True
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.795299999999997000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERENTE: [frxNFce."OPEEXP"] - [frxNFce."NOMEXP"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ChdNomeSeparador: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 1545.827770000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChdNomeConferente
        PrintChildIfInvisible = True
        Stretched = True
        object Memo14: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.795299999999997000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SEPARADOR: [frxNFce."OPESEP"] - [frxNFce."NOMSEP"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object chdNumCup: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1636.536490000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.ChildContingencia2
        PrintChildIfInvisible = True
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Cupom de Desconto n'#186' [frxNFce."NUMCUP"]')
          ParentFont = False
        end
      end
      object ChildFidelidade: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 1296.378790000000000000
        Width = 279.685220000000000000
        Child = frxNFCe.Child9
        PrintChildIfInvisible = True
        object Memo16: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total de Pontos Fidelidade: [PTOSLD]')
          ParentFont = False
        end
      end
      object chdCompec1: TfrxChild
        FillType = ftBrush
        Height = 13.228346460000000000
        Top = 529.134200000000000000
        Width = 279.685220000000000000
        object memQtd: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtd.: [frxNFce."QTDPEC"]')
          ParentFont = False
        end
        object memCompec: TfrxMemoView
          Left = 60.472480000000000000
          Width = 68.031540000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Comp.: [frxNFce."COMPEC"]')
          ParentFont = False
        end
        object memLarPec: TfrxMemoView
          Left = 132.283550000000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Larg.: [frxNFce."LARPEC"]')
          ParentFont = False
        end
        object memEspPec: TfrxMemoView
          Left = 192.756030000000000000
          Width = 64.252010000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Espe.: [frxNFce."ESPPEC"]')
          ParentFont = False
        end
      end
      object chdCompec2: TfrxChild
        FillType = ftBrush
        Height = 13.228346460000000000
        Top = 665.197280000000000000
        Width = 279.685220000000000000
        object memQtdPec2: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Qtd.: [frxNFce."QTDPEC"]')
          ParentFont = False
        end
        object memCompec2: TfrxMemoView
          Left = 60.472480000000000000
          Width = 68.031540000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Comp.: [frxNFce."COMPEC"]')
          ParentFont = False
        end
        object memLarPec2: TfrxMemoView
          Left = 132.283550000000000000
          Width = 52.913420000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Larg.: [frxNFce."LARPEC"]')
          ParentFont = False
        end
        object memEspPec2: TfrxMemoView
          Left = 192.756030000000000000
          Width = 64.252010000000000000
          Height = 13.228346460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Espe.: [frxNFce."ESPPEC"]')
          ParentFont = False
        end
      end
    end
  end
  object frxSATCFe: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 44952.492283842590000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbDescontoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rlbDesconto.Visible := <frxNFce."DET_DESESP"> > 0;'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxNFce."NUMLOT"> = '#39#39' Then'
      '  Begin'
      '    Memo52.Visible := False;'
      '    Memo14.Top := 15;                          '
      '    Memo15.Top := 15;  '
      '    Memo16.Top := 15;  '
      '    Memo17.Top := 15;  '
      
        '    Memo26.Top := 15;                                           ' +
        '                                                     '
      '  End'
      '  Else'
      '  Begin'
      '    Memo52.Visible := True;      '
      '    Memo14.Top := 29.5;                          '
      '    Memo15.Top := 29.5;  '
      '    Memo16.Top := 29.5;  '
      '    Memo17.Top := 29.5;  '
      '    Memo26.Top := 29.5;'
      '  End      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxSATCFeUserFunction
    Left = 40
    Top = 160
    Datasets = <
      item
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
      end>
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
      EndlessHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 80.149660000000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child1
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.677180000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ: [CNPJ]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 42.692950000000010000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[ENDEMP]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 128.504020000000000000
          Top = 17.897650000000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.E.: [IE]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 29.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.M.: [IM]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 3.779530000000000000
          Top = 58.692950000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP: [CEPEMP]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 109.606370000000000000
          Top = 58.826771650000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TELEFONE: [TELEMP]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 70.811070000000000000
        Top = 120.944960000000000000
        Width = 279.685220000000000000
        OnBeforePrint = 'Child1OnBeforePrint'
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Extrato [NUMCOO]'
            'CUPOM FISCAL ELETR'#212'NICO - SAT')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.677180000000010000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CPF/CNPJ do Consumidor: [CPF_CONSUMIDOR]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 18.897650000000000000
          Top = 44.015770000000020000
          Width = 34.015770000000010000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 71.811070000000000000
          Top = 44.015770000000020000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESC')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 49.133890000000000000
          Top = 55.354360000000000000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 75.590600000000000000
          Top = 55.354360000000000000
          Width = 18.897650000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 117.944960000000000000
          Top = 55.354360000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VL UN R$')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 207.874150000000000000
          Top = 55.354360000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VL ITEM R$')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 66.031539999999990000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.354360000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '#')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 158.740260000000000000
          Top = 55.692950000000010000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '(VL TR R$)*')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 253.228510000000000000
        Width = 279.685220000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        Child = frxSATCFe.rlbDesconto
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        RowCount = 0
        Stretched = True
        object Memo12: TfrxMemoView
          Left = 18.897650000000000000
          Top = 1.779529999999994000
          Width = 52.535433070000010000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."CODITE"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 70.795060640000000000
          Top = 1.779529999999994000
          Width = 174.874389360000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataField = 'DESITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESITE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 30.236240000000000000
          Top = 29.456710000000010000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 109.606370000000000000
          Top = 29.456710000000010000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fArredondaUnit('#39'UNITAR'#39')]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 75.590600000000000000
          Top = 29.456710000000010000
          Width = 34.015770000000010000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"] X ')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 211.653680000000000000
          Top = 29.456710000000070000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fArredondaUnit('#39'TOTITE'#39')]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 166.299320000000000000
          Top = 29.677179999999990000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '([frxNFce."DET_IMPPAG"])')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779529999999994000
          Width = 15.118120000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fNumeroDoItem]')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.118120000000010000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Lote: [frxNFce."NUMLOT"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 370.393940000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child2
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 71.811070000000000000
        Top = 400.630180000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child3
        Stretched = True
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SUBTOTAL R$:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 192.756030000000000000
          Top = 3.779529999999908000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTPRO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.677180000000020000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCONTOS R$:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 192.756030000000000000
          Top = 18.677180000000020000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'DESESP'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DESESP"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.354359999999990000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL R$:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 192.756030000000000000
          Top = 35.354359999999990000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 57.252009999999990000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MODALIDADES]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 166.299320000000000000
          Top = 57.252009999999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORES_MOD]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 578.268090000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child7
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES DO CONTRIBUINTE')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[INF_COMPLEMENTAR]')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 287.244280000000000000
        Top = 797.480830000000000000
        Width = 279.685220000000000000
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SAT No. [NUMSER]'
            '[DPROTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 31.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACESSO]')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 45.354360000000000000
          Top = 56.692949999999990000
          Width = 156.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128C
          DataField = 'ACESSO1'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '1234567890123456789012'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
        end
        object BarCode2: TfrxBarCodeView
          Left = 45.354360000000000000
          Top = 90.708719999999970000
          Width = 156.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128C
          DataField = 'ACESSO2'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '1234567890123456789012'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
        end
        object imgQRCode: TfrxPictureView
          Left = 47.354360000000000000
          Top = 132.283550000000000000
          Width = 154.960668980000000000
          Height = 147.401608980000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object rlbDesconto: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 321.260050000000000000
        Width = 279.685220000000000000
        OnBeforePrint = 'rlbDescontoOnBeforePrint'
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desconto')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 204.094620000000000000
          Top = 0.779530000000022500
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataField = 'DET_DESESP'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DET_DESESP"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 4.000000000000000000
          Top = 13.118119999999980000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor l'#237'quido')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 204.315090000000000000
          Top = 13.118119999999980000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataField = 'DET_TOTLIQ'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DET_TOTLIQ"]')
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 495.118430000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child6
        PrintChildIfInvisible = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TROCO R$:')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 192.756030000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TROCO_"]')
          ParentFont = False
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 536.693260000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child4
        Stretched = True
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INF_FISCO]')
          ParentFont = False
        end
      end
      object Child7: TfrxChild
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 638.740570000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.ChdSimNac
        PrintChildIfInvisible = True
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tributos Totais Incidentes (Lei Federal 12.741/2012) R$:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 188.976500000000000000
          Top = 9.559059999999931000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTAL_TRIBUTOS]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 28.456709999999930000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '*Valor aproximado dos tributos do item')
          ParentFont = False
        end
      end
      object ChdNetpoints: TfrxChild
        FillType = ftBrush
        Height = 26.456692910000000000
        Top = 748.346940000000000000
        Width = 279.685220000000000000
        Child = frxSATCFe.Child5
        PrintChildIfInvisible = True
        object Memo50: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parab'#233'ns! Voc'#234' ganhou [QTDNPS] NETPOINTS nesta compra.')
          ParentFont = False
        end
      end
      object ChdSimNac: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 706.772110000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxSATCFe.ChdNetpoints
        PrintChildIfInvisible = True
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC')
          ParentFont = False
        end
      end
    end
  end
  object frxCancSATCFe: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 41767.388587268500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 120
    Top = 160
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 71.000000000000000000
      PaperHeight = 115.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 385.512060000000000000
        Top = 18.897650000000000000
        Width = 268.346630000000000000
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000001000
          Width = 253.228510000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Extrato [NUMCOO]'
            'CUPOM FISCAL ELETR'#212'NICO - SAT'
            'CANCELAMENTO')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 41.574830000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DO CUPOM FISCAL ELETR'#212'NICO CANCELADO')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 64.252010000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CPF/CNPJ do Consumidor: [CPF_CONSUMIDOR]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 79.370130000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 45.354360000000000000
          Top = 79.370130000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VLRCON]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 102.047310000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SAT No. [NUMSER]'
            '[DPROTO]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 130.063080000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACESSO]')
          ParentFont = False
        end
        object codBarra1: TfrxBarCodeView
          Left = 45.354360000000000000
          Top = 154.960730000000000000
          Width = 156.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128C
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '1234567890123456789012'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
        end
        object codBarra2: TfrxBarCodeView
          Left = 45.354360000000000000
          Top = 188.976500000000000000
          Width = 156.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128C
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '1234567890123456789012'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
        end
        object imgQRCode: TfrxPictureView
          Left = 47.354360000000000000
          Top = 230.551330000000000000
          Width = 154.960668980000000000
          Height = 147.401608980000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
  object frxCanc: TfrxDBDataset
    UserName = 'frxCanc'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 184
    Top = 40
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 192
    Top = 97
  end
  object frxCarneRecibo: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42243.359141979200000000
    ReportOptions.LastChange = 43460.356279155080000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 216
    Datasets = <
      item
        DataSet = frxDataSetCarnePgto
        DataSetName = 'frxDataSetCarnePgto'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 306.000000000000000000
      PaperSize = 256
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 177.637910000000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Top = 3.779530000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'CARN'#202' DE PAGAMENTO')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 0.779530000000000000
          Top = 30.236240000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Contrato...:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Top = 52.913420000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Seu saldo em [DATA_SALDO]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 57.070866140000000000
          Top = 85.039370080000000000
          Width = 221.102362200000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CODCLI] - [NOMCLI]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo5: TfrxMemoView
          Top = 98.267716540000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Vendedor.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Top = 113.385826770000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Compra:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 136.063080000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCIMENTOS DO CARN'#202)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Top = 158.740260000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Par Vencimento    Parcela     Dt.Pagto   Vr.Pagto')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Top = 68.031540000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'para novas compras '#233' de [LIMITE_CREDITO].')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 68.031540000000000000
          Top = 30.236240000000000000
          Width = 211.653680000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[BARCON]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Top = 85.039370080000000000
          Width = 56.692913390000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente....:')
          ParentFont = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object Memo15: TfrxMemoView
          Left = 57.070866140000000000
          Top = 98.267716540000000000
          Width = 221.102362200000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMVEN]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 75.590600000000000000
          Top = 113.385826770000000000
          Width = 177.637910000000000000
          Height = 15.118120000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTACOM]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 257.008040000000000000
        Width = 279.685220000000000000
        DataSet = frxDataSetCarnePgto
        DataSetName = 'frxDataSetCarnePgto'
        RowCount = 0
        object Memo9: TfrxMemoView
          Width = 136.063080000000000000
          Height = 15.118110240000000000
          DataSet = frxDataSetCarnePgto
          DataSetName = 'frxDataSetCarnePgto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataSetCarnePgto."DUPLICATA1"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 139.740260000000000000
          Width = 120.944960000000000000
          Height = 15.118110240000000000
          DataSet = frxDataSetCarnePgto
          DataSetName = 'frxDataSetCarnePgto'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCarnePgto."DUPLICATA2"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 294.803340000000000000
        Width = 279.685220000000000000
        object BarCode1: TfrxBarCodeView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 129.000000000000000000
          Height = 37.795300000000000000
          BarType = bcCodeEAN13
          DataField = 'CODIGO_BARRAS'
          DataSet = frxDataSetCarnePgto
          DataSetName = 'frxDataSetCarnePgto'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '12345678'
          WideBarRatio = 3.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo10: TfrxMemoView
          Top = 60.472480000000010000
          Width = 279.685220000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 11.338590000000000000
          Top = 41.574830000000020000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[BARCON]')
          ParentFont = False
        end
      end
    end
  end
  object frxDataSetCarnePgto: TfrxUserDataSet
    UserName = 'frxDataSetCarnePgto'
    OnCheckEOF = frxDataSetCarnePgtoCheckEOF
    OnFirst = frxDataSetCarnePgtoFirst
    OnNext = frxDataSetCarnePgtoNext
    OnGetValue = frxDataSetCarnePgtoGetValue
    Left = 120
    Top = 216
  end
  object frxContrato: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42243.359141979200000000
    ReportOptions.LastChange = 43503.366074548610000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 272
    Datasets = <
      item
        DataSet = frxDataSetCarnePgto
        DataSetName = 'frxDataSetCarnePgto'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 200.000000000000000000
      PaperSize = 256
      LeftMargin = 4.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 117.165430000000000000
        Top = 18.897650000000000000
        Width = 264.567100000000000000
        Child = frxContrato.ChdParCar
        PrintChildIfInvisible = True
        Stretched = True
        object Memo1: TfrxMemoView
          Top = 3.779530000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DUPLICATA')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Top = 45.236240000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPDOC]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo7: TfrxMemoView
          Top = 83.811070000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'VENCIMENTOS DO CARN'#202)
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 102.047310000000000000
          Top = 45.236240000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DUPLIC]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Top = 64.133890000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Contrato....:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo15: TfrxMemoView
          Left = 102.047310000000000000
          Top = 64.133890000000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[BARCON]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Top = 26.435683330000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data da Venda:')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo31: TfrxMemoView
          Left = 102.047244094488200000
          Top = 26.435683330000000000
          Width = 177.637910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DTACOM]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 393.071120000000000000
        Width = 264.567100000000000000
        DataSet = frxDataSetCarnePgto
        DataSetName = 'frxDataSetCarnePgto'
        RowCount = 0
        object Memo9: TfrxMemoView
          Left = 3.023622047244094000
          Width = 119.433070866141700000
          Height = 15.118110240000000000
          DataSet = frxDataSetCarnePgto
          DataSetName = 'frxDataSetCarnePgto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDataSetCarnePgto."DUPLICATA1"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 122.834645669291300000
          Width = 139.842519685039400000
          Height = 15.118110240000000000
          DataSet = frxDataSetCarnePgto
          DataSetName = 'frxDataSetCarnePgto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetCarnePgto."DUPLICATA2"]')
          ParentFont = False
        end
      end
      object FooterMenPed: TfrxFooter
        FillType = ftBrush
        Height = 26.456692910000000000
        Top = 430.866420000000000000
        Width = 264.567100000000000000
        Child = frxContrato.Child2
        PrintChildIfInvisible = True
        Stretched = True
        object Memo3: TfrxMemoView
          Width = 279.685220000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = -0.220470000000000000
          Top = 7.559060000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MENPED]')
          ParentFont = False
        end
      end
      object rlbDupRep: TfrxChild
        FillType = ftBrush
        Height = 15.118120000000000000
        Top = 200.315090000000000000
        Width = 264.567100000000000000
        Child = frxContrato.rlbGerais
        PrintChildIfInvisible = True
        Stretched = True
        object Memo6: TfrxMemoView
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DataSetName = 'frxDataSetDupRep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[DUPREP]')
          ParentFont = False
        end
      end
      object rlbGerais: TfrxChild
        FillType = ftBrush
        Height = 94.488250000000000000
        Top = 238.110390000000000000
        Width = 264.567100000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo4: TfrxMemoView
          Width = 56.692901180000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente....:')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
        object Memo5: TfrxMemoView
          Top = 15.118120000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TIPOPE] [NOMVEN]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Top = 30.236240000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor Compra: [TOTDUP]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Top = 45.354360000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'Valor Pago..: [TOTREC]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Top = 60.472480000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[TIPO_REL]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Top = 75.590600000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emiss'#227'o  Par  Vencto.       Parcela Dt.Pagto Vr.Pagto')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 56.692950000000000000
          Width = 222.992147950000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CODCLI] - [NOMCLI]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ChdParCar: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 158.740260000000000000
        Width = 264.567100000000000000
        Child = frxContrato.rlbDupRep
        PrintChildIfInvisible = True
        object Memo8: TfrxMemoView
          Top = 0.220470000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Par Vencimento  Parcela Dt.Pagto  Vr.Pagto')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 139.842610000000000000
        Top = 480.000310000000000000
        Width = 264.567100000000000000
        PrintChildIfInvisible = True
        object Memo10: TfrxMemoView
          Left = 0.779530000000000000
          Top = 104.267780000000000000
          Width = 162.519790000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 0.779530000000000000
          Width = 279.685220000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 0.779530000000000000
          Top = 3.779530000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Reconhe'#231'o como l'#237'quida e certa a d'#237'vida objeto')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 0.779530000000000000
          Top = 18.897650000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[TEXTO_OBRIG]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 0.779530000000000000
          Top = 34.015770000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'valor, prazo e condi'#231#245'es acima. Ap'#243's o vencimento')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 0.779530000000000000
          Top = 110.826840000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Assinatura')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 128.842610000000000000
          Width = 279.685220000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Courier New'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Top = 49.133890000000000000
          Width = 279.685220000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ser'#225' cobrado acr'#233'scimos legais de mora.')
          ParentFont = False
        end
      end
    end
  end
  object frxSATCFeMod2: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 42250.363266076400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rlbDescontoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rlbDesconto.Visible := <frxNFce."DET_DESESP"> > 0;            ' +
        '             '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxSATCFeUserFunction
    Left = 208
    Top = 160
    Datasets = <
      item
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 270.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 80.149660000000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.677180000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ: [CNPJ]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 3.779530000000000000
          Top = 42.692950000000010000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[ENDEMP]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 128.504020000000000000
          Top = 17.897650000000000000
          Width = 128.504020000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.E.: [IE]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Top = 29.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'I.M.: [IM]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 3.779530000000000000
          Top = 58.692950000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CEP: [CEPEMP]')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 109.606370000000000000
          Top = 58.826771650000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TELEFONE: [TELEMP]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 120.944960000000000000
        Width = 279.685220000000000000
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Extrato [NUMCOO]'
            'CUPOM FISCAL ELETR'#212'NICO - SAT')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.677180000000010000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          Memo.UTF8W = (
            'CPF/CNPJ do Consumidor: [CPF_CONSUMIDOR]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 15.118120000000000000
          Top = 44.015769999999990000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'COD')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 41.574830000000000000
          Top = 44.015769999999990000
          Width = 30.236240000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESC')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 71.811070000000000000
          Top = 44.015769999999990000
          Width = 26.456710000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 98.267780000000000000
          Top = 44.015769999999990000
          Width = 18.897650000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 117.944960000000000000
          Top = 44.015769999999990000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VL UN R$')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 207.874150000000000000
          Top = 44.015769999999990000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VL ITEM R$')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 54.692950000000010000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.354360000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '#')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 158.740260000000000000
          Top = 44.354360000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '(VL TR R$)*')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 241.889920000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.rlbDesconto
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        PrintChildIfInvisible = True
        RowCount = 0
        Stretched = True
        object Memo12: TfrxMemoView
          Left = 18.897637800000000000
          Top = 1.779530000000000000
          Width = 71.811070000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."CODBAR"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 92.031540000000000000
          Top = 1.779530000000000000
          Width = 166.299320000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESORI"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Align = baBottom
          Left = 26.456710000000000000
          Top = 15.118120000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Align = baBottom
          Left = 113.385900000000000000
          Top = 15.118120000000000000
          Width = 49.133890000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fArredondaUnit('#39'UNITAR'#39')]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baBottom
          Left = 75.590600000000000000
          Top = 15.118120000000000000
          Width = 34.015770000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"] X ')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Align = baBottom
          Left = 211.653680000000000000
          Top = 15.118120000000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[fArredondaUnit('#39'TOTITE'#39')]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Align = baBottom
          Left = 166.299320000000000000
          Top = 15.118120000000000000
          Width = 41.574830000000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '([frxNFce."DET_IMPPAG"])'
            '')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 15.118110240000000000
          Height = 11.338590000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[fNumeroDoItem]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 340.157700000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child2
        PrintChildIfInvisible = True
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Height = 76.149660000000000000
        Top = 370.393940000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child3
        PrintChildIfInvisible = True
        Stretched = True
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'SUBTOTAL R$:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 192.756030000000000000
          Top = 3.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTPRO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.677180000000020000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DESCONTOS R$:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 192.756030000000000000
          Top = 18.677180000000020000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'DESESP'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DESESP"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.354359999999990000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL R$:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 192.756030000000000000
          Top = 35.354359999999990000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 57.252009999999990000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MODALIDADES]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 166.299320000000000000
          Top = 57.252009999999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORES_MOD]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 37.795300000000000000
        Top = 551.811380000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child7
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OBSERVA'#199#213'ES DO CONTRIBUINTE')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[INF_COMPLEMENTAR]')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 287.244280000000000000
        Top = 774.803650000000000000
        Width = 279.685220000000000000
        PrintChildIfInvisible = True
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'SAT No. [NUMSER]'
            '[DPROTO]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 31.795300000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACESSO]')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 45.354360000000000000
          Top = 56.692950000000000000
          Width = 156.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128C
          DataField = 'ACESSO1'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '1234567890123456789012'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
        end
        object BarCode2: TfrxBarCodeView
          Left = 45.354360000000000000
          Top = 90.708720000000000000
          Width = 156.000000000000000000
          Height = 30.236240000000000000
          BarType = bcCode128C
          DataField = 'ACESSO2'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Rotation = 0
          ShowText = False
          TestLine = False
          Text = '1234567890123456789012'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
        end
        object imgQRCode: TfrxPictureView
          Left = 47.354360000000000000
          Top = 132.283550000000000000
          Width = 154.960668980000000000
          Height = 147.401608980000000000
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object rlbDesconto: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 291.023810000000000000
        Width = 279.685220000000000000
        OnBeforePrint = 'rlbDescontoOnBeforePrint'
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Desconto')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 204.094620000000000000
          Top = 0.779530000000022500
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataField = 'DET_DESESP'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DET_DESESP"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 4.000000000000000000
          Top = 13.118119999999980000
          Width = 162.519790000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor l'#237'quido')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 204.315090000000000000
          Top = 13.118119999999980000
          Width = 52.913420000000000000
          Height = 11.338590000000000000
          DataField = 'DET_TOTLIQ'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DET_TOTLIQ"]')
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 468.661720000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child6
        PrintChildIfInvisible = True
        object Memo42: TfrxMemoView
          Left = 3.779530000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TROCO R$:')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 192.756030000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TROCO_"]')
          ParentFont = False
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 510.236550000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child4
        PrintChildIfInvisible = True
        Stretched = True
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779529999999966000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INF_FISCO]')
          ParentFont = False
        end
      end
      object Child7: TfrxChild
        FillType = ftBrush
        Height = 49.133890000000000000
        Top = 612.283860000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.ChdSimNac
        PrintChildIfInvisible = True
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779527560000000000
          Width = 181.417440000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tributos Totais Incidentes (Lei Federal 12.741/2012) R$:')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 188.976500000000000000
          Top = 8.779530000000023000
          Width = 68.031540000000010000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[TOTAL_TRIBUTOS]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 3.779530000000000000
          Top = 29.677180000000020000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '*Valor aproximado dos tributos do item')
          ParentFont = False
        end
      end
      object ChdNetpoints: TfrxChild
        FillType = ftBrush
        Height = 26.456692910000000000
        Top = 725.669760000000000000
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.Child5
        PrintChildIfInvisible = True
        object Memo50: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parab'#233'ns! Voc'#234' ganhou [QTDNPS] NETPOINTS nesta compra.')
          ParentFont = False
        end
      end
      object ChdSimNac: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 684.094930000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxSATCFeMod2.ChdNetpoints
        PrintChildIfInvisible = True
        object Memo51: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ICMS A SER REC. CONF. LC 123/2006 - SIMPLES NAC')
          ParentFont = False
        end
      end
    end
  end
  object frxCartaoVinculadoJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 43802.370168148100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 40
    Top = 344
    Datasets = <
      item
        DataSet = frxDBCartaoVinculado
        DataSetName = 'frxDBCartaoVinculado'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 200.000000000000000000
      PaperHeight = 100.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 54.803186220000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Child = frxCartaoVinculadoJ.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo9: TfrxMemoView
          Left = 188.976500000000000000
          Top = 7.559060000000000000
          Width = 374.173470000000000000
          Height = 22.677180000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DA MOVIMENTA'#199#195'O DO CART'#195'O')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 33.259830310000000000
        Top = 264.567100000000000000
        Width = 755.906000000000000000
        DataSet = frxDBCartaoVinculado
        DataSetName = 'frxDBCartaoVinculado'
        RowCount = 0
        Stretched = True
        object memLocFis1: TfrxMemoView
          Left = 3.779527560000000000
          Top = 3.779530000000000000
          Width = 71.527441890000000000
          Height = 20.787406460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartaoVinculado."PARCELA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 245.669450000000000000
          Top = 3.779530000000000000
          Width = 120.661331890000000000
          Height = 20.787406460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'R$ [frxDBCartaoVinculado."VALOR_VISTA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 375.393940000000000000
          Top = 3.779530000000000000
          Width = 124.440861890000000000
          Height = 20.787406460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartaoVinculado."PERC_DESCONTO"] %')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 503.897960000000000000
          Top = 3.779530000000000000
          Width = 113.102271890000000000
          Height = 20.787406460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'R$ [frxDBCartaoVinculado."VALOR_TAXA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 621.063390000000000000
          Top = 3.779530000000000000
          Width = 124.440861890000000000
          Height = 20.787406460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'R$ [frxDBCartaoVinculado."VALOR_PARCELA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo18: TfrxMemoView
          Left = 79.370130000000000000
          Top = 3.779530000000000000
          Width = 158.456631890000000000
          Height = 20.787406460000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartaoVinculado."DATA_VENCIMENTO"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Height = 106.582694250000000000
        ParentFont = False
        Top = 98.267780000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 351.496290000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CART'#195'O: [CARTAO]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 380.834880000000000000
          Top = 18.897650000000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DATA DE CADASTRO: [DATA_CADASTRO]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 40.574830000000000000
          Width = 351.496290000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#186' NSU: [NUMNSU]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 381.732530000000000000
          Top = 40.440957090000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' LIBERA'#199#195'O: [NUMCCD]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 3.779530000000000000
          Top = 83.149660000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PARCELA')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 245.669450000000000000
          Top = 83.149660000000000000
          Width = 120.944960000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR A VISTA')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 375.393940000000000000
          Top = 83.149660000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'PERC. DESCONTO')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 503.897960000000000000
          Top = 83.149660000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR DA TAXA')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 621.063390000000000000
          Top = 83.149660000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR PARCELA')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Width = 744.567410000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '---------')
        end
        object Memo16: TfrxMemoView
          Left = 3.779530000000000000
          Top = 56.692950000000000000
          Width = 744.567410000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '---------')
        end
        object Memo17: TfrxMemoView
          Left = 79.370130000000000000
          Top = 83.149660000000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA VENCIMENTO')
          ParentFont = False
        end
      end
    end
  end
  object frxDBCartaoVinculado: TfrxDBDataset
    UserName = 'frxDBCartaoVinculado'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 152
    Top = 344
  end
  object frxCartaoVinculadoM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40822.587279363400000000
    ReportOptions.LastChange = 40823.564782256900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 38
    Top = 396
    Datasets = <
      item
        DataSet = frxDBCartaoVinculado
        DataSetName = 'frxDBCartaoVinculado'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 253.999835958439300000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      LeftMargin = 4.497913761764029000
      RightMargin = 4.497913761764029000
      TopMargin = 2.539998359584393000
      BottomMargin = 2.539998359584393000
      EndlessHeight = True
      FontStyle = []
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 926.000000000000000000
        Child = frxCartaoVinculadoM.Child1
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo1: TfrxDMPMemoView
          Left = 278.400000000000000000
          Width = 326.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS DA MOVIMENTA'#199#195'O DO CART'#195'O')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 926.000000000000000000
        DataSet = frxDBCartaoVinculado
        DataSetName = 'frxDBCartaoVinculado'
        RowCount = 0
        Stretched = True
        object DMPMemo11: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartaoVinculado."PARCELA"]')
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            'R$ [frxDBCartaoVinculado."VALOR_VISTA"]')
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartaoVinculado."PERC_DESCONTO"] %')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            'R$ [frxDBCartaoVinculado."VALOR_TAXA"]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 729.600000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haCenter
          Memo.UTF8W = (
            'R$ [frxDBCartaoVinculado."VALOR_PARCELA"]')
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.Kind = fkDateTime
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBCartaoVinculado."DATA_VENCIMENTO"]')
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 85.000000000000000000
        Width = 926.000000000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'CART'#195'O: [CARTAO]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 34.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'DATA DE CADASTRO: [DATA_CADASTRO]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'N'#186' NSU: [NUMNSU]')
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'N'#176' LIBERA'#199#195'O: [NUMCCD]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'PARCELA')
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 85.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR A VISTA')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 85.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'PERC.DESCONTO')
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 576.000000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR DA TAXA')
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 729.600000000000000000
          Top = 85.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'VALOR PARCELA')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '---------')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 873.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '----------------------------------------------------------------' +
              '---------')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 124.800000000000000000
          Top = 85.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'DATA VENCIMENTO')
          TruncOutboundText = False
        end
      end
    end
  end
  object frxExpPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 152
    Top = 400
  end
  object frxNFCeReduzido: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 41767.388587268500000000
    ReportOptions.LastChange = 44930.611503854170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 148
    Top = 280
    Datasets = <
      item
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 74.000000000000000000
      PaperHeight = 660.000000000000000000
      PaperSize = 256
      EndlessHeight = True
      object rlbTitulo: TfrxReportTitle
        FillType = ftBrush
        Height = 1.889763780000000000
        Top = 18.897650000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChdLogo
        PrintChildIfInvisible = True
        Stretched = True
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 52.913371180000000000
        Top = 325.039580000000000000
        Width = 279.685220000000000000
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        RowCount = 0
        Stretched = True
        object Memo12: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000000000
          Width = 52.542571940000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."CODITE"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 58.166148060000000000
          Top = 0.779530000000000000
          Width = 198.841891940000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'DESITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESITE"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 98.267716540000000000
          Top = 17.456710000000000000
          Width = 34.015748030000000000
          Height = 15.118120000000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 162.519685040000000000
          Top = 17.456710000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNITAR"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 136.062992130000000000
          Top = 17.456710000000000000
          Width = 22.677165350000000000
          Height = 15.118120000000000000
          DataField = 'UNIDAD'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 211.653543310000000000
          Top = 17.456710000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTITE"]')
          ParentFont = False
        end
        object MemoDesEspVal1: TfrxMemoView
          Left = 49.133890000000000000
          Top = 35.015769999999970000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL R$: [frxNFce."DET_DESESP"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 7.559060000000000000
        Top = 491.338900000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child1
        Stretched = True
        object Memo18: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 48.472480000000000000
        Top = 521.575140000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChildTotFre
        PrintChildIfInvisible = True
        Stretched = True
        object Memo27: TfrxMemoView
          Left = 3.779530000000000000
          Top = 16.677179999999910000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'SUBTOTAL R$:')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 192.756030000000000000
          Top = 16.677180000000020000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTPRO"]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 3.779530000000000000
          Top = 32.574829999999800000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESCONTOS R$:')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 192.756030000000000000
          Top = 32.574830000000020000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            
              '[(SUM((<frxNFce."UNIORI"> - <frxNFce."UNITAR">) * <frxNFce."QTDI' +
              'TE">)+<frxNFce."DESESP">)]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000022000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'QTD. TOTAL DE ITENS:')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 192.756030000000000000
          Top = 1.779530000000022000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxNFce."QTDITE">,MasterData1,2)]')
          ParentFont = False
        end
      end
      object Child2: TfrxChild
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 29.133890000000000000
        ParentFont = False
        Top = 234.330860000000000000
        Width = 279.685220000000000000
        object Memo5: TfrxMemoView
          Left = 3.779530000000000000
          Top = 6.913420000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 49.133890000000000000
          Top = 6.913420000000003000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 98.267780000000000000
          Top = 6.913420000000000000
          Width = 34.015770000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde.')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 136.063080000000000000
          Top = 6.913420000000003000
          Width = 22.677180000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'UN')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 162.519790000000000000
          Top = 6.913420000000003000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. Unit.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 211.653680000000000000
          Top = 6.913420000000003000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vl. Total')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 3.779530000000000000
          Top = 23.590600000000020000
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.692949999999996200
          Width = 253.228510000000000000
          Height = 3.779530000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          ParentFont = False
        end
      end
      object Child3: TfrxChild
        FillType = ftBrush
        Height = 34.195300000000000000
        Top = 835.276130000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child7
        PrintChildIfInvisible = True
        Stretched = True
        object Memo41: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TOTAL R$:')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 188.976500000000000000
          Top = 0.779530000000022500
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
        object rllTroco: TfrxMemoView
          Left = 3.779530000000000000
          Top = 15.897650000000000000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'TROCO R$:')
          ParentFont = False
        end
        object rllValTroco: TfrxMemoView
          Left = 188.976500000000000000
          Top = 15.897650000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TROCO_"]')
          ParentFont = False
        end
      end
      object Child4: TfrxChild
        FillType = ftBrush
        Height = 112.504020000000000000
        Top = 1345.512680000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child8
        PrintChildIfInvisible = True
        Stretched = True
        object imgQRCode: TfrxPictureView
          Left = 3.842610000000000000
          Top = 5.456710000000000000
          Width = 100.000000000000000000
          Height = 100.000000000000000000
          Picture.Data = {
            07544269746D61703A3E0000424D3A3E00000000000036000000280000003F00
            00003F0000000100200000000000043E00000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
            00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000000000000000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
            000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object Memo20: TfrxMemoView
          Left = 151.181102362204700000
          Top = 17.677180000000000000
          Width = 105.826771653543300000
          Height = 11.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#250'mero: [NUMDOC] - S'#233'rie: [SERIE_]')
          ParentFont = False
        end
        object rllConsumidor: TfrxMemoView
          Left = 151.181102362204700000
          Top = 6.385900000000000000
          Width = 105.826771653543300000
          Height = 11.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CNPJ: 01.374.419/0001-76'
            'MAGALHAES DISTRIBUIDORA DE DIESEL E TRAN 00003242'
            'RUA NEWTON STILAC LEAL, 911, JARDIM BOT'#194'NICO, TUP'#195', SP'
            'TELEFONE: (19) 3682-8822')
          ParentFont = False
        end
        object rllProtocolo: TfrxMemoView
          Left = 151.181102362204700000
          Top = 40.913420000000000000
          Width = 105.826771653543300000
          Height = 11.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[PROTOC] - [DPROTO]')
          ParentFont = False
        end
        object rllLabelProtocolo: TfrxMemoView
          Left = 151.181102362204700000
          Top = 29.015770000000000000
          Width = 105.826771653543300000
          Height = 11.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Protocolo de Autoriza'#231#227'o')
          ParentFont = False
        end
      end
      object Child5: TfrxChild
        FillType = ftBrush
        Height = 52.283550000000000000
        Top = 1269.922080000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child4
        Stretched = True
        object rllTituloChave: TfrxMemoView
          Left = 3.779530000000000000
          Top = 5.913420000000087000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Consulte pela Chave de Acesso em')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 3.779530000000000000
          Top = 32.590599999999990000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ACESSO]')
          ParentFont = False
        end
        object rllEnderecoConsulta: TfrxMemoView
          Left = 3.779530000000000000
          Top = 21.031539999999950000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'http://homnfce.sefaz.am.gov.br/nfceweb/consultarNFCe.jsp?')
          ParentFont = False
          WordWrap = False
        end
        object rllAreaMensagemFiscal: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 253.228510000000000000
          Height = 3.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
        end
      end
      object ChdContribuinte: TfrxChild
        FillType = ftBrush
        Height = 20.540000000000000000
        Top = 1016.693570000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChdNumGuiche
        PrintChildIfInvisible = True
        Stretched = True
        object rllProfissional: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.267716535433071000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[PROFIS] [CODDIV] - [NOMDIV]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object Child7: TfrxChild
        FillType = ftBrush
        Height = 2.015770000000000000
        Top = 891.969080000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChdNetpoints
        PrintChildIfInvisible = True
      end
      object Child8: TfrxChild
        FillType = ftBrush
        Height = 58.204700000000000000
        Top = 1481.575760000000000000
        Width = 279.685220000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object Memo43: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.133890000000060000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tributos Totais Incidentes (Lei Federal 12.741/2012):')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 3.779530000000000000
          Top = 39.590599999999990000
          Width = 253.228510000000000000
          Height = 11.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$ [TOTAL_TRIBUTOS]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.795299999999997500
          Width = 253.228510000000000000
          Height = 11.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emiss'#227'o: [DTAEMI] - Via consumidor')
          ParentFont = False
        end
        object rllMensagemAproveitaICMS: TfrxMemoView
          Left = 3.779530000000000000
          Top = 13.795300000000000000
          Width = 253.228510000000000000
          Height = 11.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#227'o permite aproveitamento de cr'#233'dito de ICMS')
          ParentFont = False
        end
      end
      object Child9: TfrxChild
        FillType = ftBrush
        Height = 24.472480000000000000
        Top = 967.559680000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChdContribuinte
        PrintChildIfInvisible = True
        object Memo25: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779527560000019600
          Width = 253.228510000000000000
          Height = 23.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'NFCE EMITIDA EM AMBIENTE DE HOMOLOGA'#199#195'O'
            'SEM VALOR FISCAL')
          ParentFont = False
        end
      end
      object ChildTotFre: TfrxChild
        FillType = ftBrush
        Height = 18.677180000000000000
        Top = 593.386210000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChildDesAce
        PrintChildIfInvisible = True
        object Memo49: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'FRETE R$:')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 192.755907950000000000
          Top = 0.779530000000022500
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTFRE"]')
          ParentFont = False
        end
      end
      object Child11: TfrxChild
        FillType = ftBrush
        Height = 52.252010000000000000
        Top = 759.685530000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child3
        PrintChildIfInvisible = True
        Stretched = True
        object Memo31: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000136000
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VALOR TOTAL R$:')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 192.756030000000000000
          Top = 1.779530000000136000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'VLRCON'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."VLRCON"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 3.779530000000000000
          Top = 17.677180000000020000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'FORMAS DE PAGAMENTO')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 3.779530000000000000
          Top = 33.574830000000130000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[MODALIDADES]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 166.299320000000000000
          Top = 33.574830000000020000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALORES_MOD]')
          ParentFont = False
        end
      end
      object ChdNetpoints: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 918.425790000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child9
        PrintChildIfInvisible = True
        object Memo22: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Parab'#233'ns! Voc'#234' ganhou [QTDNPS] NETPOINTS nesta compra.')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 68.031491180000010000
        Top = 400.630180000000000000
        Visible = False
        Width = 279.685220000000000000
        DataSet = frxDbNFce
        DataSetName = 'frxNFce'
        RowCount = 0
        Stretched = True
        object Memo52: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."CODITE"]')
          ParentFont = False
        end
        object Memo53: TfrxMemoView
          Left = 49.133890000000000000
          Top = 0.779530000000000000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          DataField = 'DESITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxNFce."DESITE"]')
          ParentFont = False
        end
        object MemoMarca: TfrxMemoView
          ShiftMode = smWhenOverlapped
          Left = 3.401574800000000000
          Top = 17.574830000000000000
          Width = 128.503937010000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Marca: [frxNFce."DESMAR"]')
          ParentFont = False
          WordWrap = False
        end
        object MemoCodFab: TfrxMemoView
          Left = 135.685039370000000000
          Top = 17.574830000000000000
          Width = 120.944881890000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C'#243'd.F'#225'b.: [frxNFce."CODFAB"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo54: TfrxMemoView
          Left = 98.267716535433080000
          Top = 32.236240000000000000
          Width = 34.015748031496060000
          Height = 15.118120000000000000
          DataField = 'QTDITE'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."QTDITE"]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 162.519685039370100000
          Top = 32.236240000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNITAR"]')
          ParentFont = False
        end
        object Memo56: TfrxMemoView
          Left = 136.062992130000000000
          Top = 32.236240000000000000
          Width = 22.677165350000000000
          Height = 15.118120000000000000
          DataField = 'UNIDAD'
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."UNIDAD"]')
          ParentFont = False
        end
        object Memo57: TfrxMemoView
          Left = 211.653543307086600000
          Top = 32.236240000000000000
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTITE"]')
          ParentFont = False
        end
        object MemoDesEspVal2: TfrxMemoView
          Left = 49.133890000000000000
          Top = 49.133890000000010000
          Width = 207.874150000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL R$: [frxNFce."DET_DESESP"]')
          ParentFont = False
        end
      end
      object ChildDesAce: TfrxChild
        FillType = ftBrush
        Height = 18.677180000000000000
        Top = 634.961040000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChildTotRet
        PrintChildIfInvisible = True
        object Memo26: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DESP. ACESSORIA R$:')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 192.755907950000000000
          Top = 0.779530000000022500
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."DESACE"]')
          ParentFont = False
        end
      end
      object ChildTotRet: TfrxChild
        FillType = ftBrush
        Height = 18.677180000000000000
        Top = 676.535870000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChildTotIpi
        PrintChildIfInvisible = True
        object Memo58: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'ICMS ST R$:')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 192.755907950000000000
          Top = 0.779530000000022500
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTRET"]')
          ParentFont = False
        end
      end
      object ChildTotIpi: TfrxChild
        FillType = ftBrush
        Height = 18.677180000000000000
        Top = 718.110700000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child11
        PrintChildIfInvisible = True
        object Memo60: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.779530000000022500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'IPI R$:')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 192.755907950000000000
          Top = 0.779530000000022500
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."TOTIPI"]')
          ParentFont = False
        end
      end
      object Child6: TfrxChild
        FillType = ftBrush
        Height = 86.141754250000000000
        Top = 68.031540000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChildContingencia1
        PrintChildIfInvisible = True
        Stretched = True
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 60.149660000000000000
          Width = 269.228510000000000000
          Height = 22.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'DANFE NFC-e - Documento Auxiliar da Nota Fiscal Eletr'#244'nica para ' +
              'Consumidor Final')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 61.220470000000000000
          Top = 1.511811020000000000
          Width = 212.567100000000000000
          Height = 13.228346460000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 61.220470000000000000
          Top = 15.874015750000000000
          Width = 120.504020000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ: [CNPJ]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 61.220470000000000000
          Top = 28.346456690000000000
          Width = 212.409448820000000000
          Height = 29.858267720000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haBlock
          Memo.UTF8W = (
            '[ENDEMP] CEP: [CEPEMP]   TELEFONE: [TELEMP]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo37: TfrxMemoView
          Left = 181.944960000000000000
          Top = 15.874015750000000000
          Width = 92.063080000000000000
          Height = 13.228346460000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'IE: [IE]')
          ParentFont = False
        end
        object rllImagem: TfrxPictureView
          ShiftMode = smWhenOverlapped
          Left = 3.811023620000000000
          Top = 7.559055120000000000
          Width = 57.606321180000000000
          Height = 45.574781180000000000
          Center = True
          KeepAspectRatio = False
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
      end
      object ChdLogo: TfrxChild
        FillType = ftBrush
        Height = 0.251968500000000000
        Top = 45.354360000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child6
        PrintChildIfInvisible = True
      end
      object ChdNumGuiche: TfrxChild
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 1058.268400000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChdInfComplementar
        PrintChildIfInvisible = True
        Stretched = True
        object Memo48: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.795299999999997500
          Width = 181.417440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'MERO DO GUICH'#202':')
          ParentFont = False
        end
        object rllNumGuiche: TfrxMemoView
          Left = 188.976500000000000000
          Top = 0.795299999999997500
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          DataSet = frxDbNFce
          DataSetName = 'frxNFce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxNFce."NUMGUI"]')
          ParentFont = False
        end
      end
      object ChildContingencia1: TfrxChild
        FillType = ftBrush
        Height = 33.574830000000000000
        Top = 177.637910000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child2
        PrintChildIfInvisible = True
        object rllContingencia1_1: TfrxMemoView
          Left = 4.440940000000000000
          Top = 5.440940000000000000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMITIDA EM CONTING'#202'NCIA')
          ParentFont = False
        end
        object rllContingencia1_2: TfrxMemoView
          Left = 4.440940000000000000
          Top = 16.338590000000000000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pendente de autoriza'#231#227'o')
          ParentFont = False
        end
      end
      object ChildContingencia2: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 1220.788190000000000000
        Visible = False
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.Child5
        PrintChildIfInvisible = True
        object rllContingencia2_1: TfrxMemoView
          Left = 4.440940000000000000
          Top = 2.440939999999955000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'EMITIDA EM CONTING'#202'NCIA')
          ParentFont = False
        end
        object rllContingencia2_2: TfrxMemoView
          Left = 4.440940000000000000
          Top = 13.338590000000070000
          Width = 253.228510000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Pendente de autoriza'#231#227'o')
          ParentFont = False
        end
      end
      object ChdInfComplementar: TfrxChild
        FillType = ftBrush
        Height = 18.897635350000000000
        Top = 1099.843230000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChdNomeConferente
        PrintChildIfInvisible = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 3.779530000000000000
          Top = 2.338590000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[INF_COMPLEMENTAR]')
          ParentFont = False
        end
      end
      object chdNumCup: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 1179.213360000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.ChildContingencia2
        PrintChildIfInvisible = True
        object Memo24: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 15.118120000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Cupom de Desconto n'#186' [frxNFce."NUMCUP"]')
          ParentFont = False
        end
      end
      object ChdNomeConferente: TfrxChild
        FillType = ftBrush
        Height = 15.118110240000000000
        Top = 1141.418060000000000000
        Width = 279.685220000000000000
        Child = frxNFCeReduzido.chdNumCup
        PrintChildIfInvisible = True
        Stretched = True
        object Memo38: TfrxMemoView
          Left = 3.779530000000000000
          Width = 253.228510000000000000
          Height = 13.228346456692900000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'CONFERENTE: [frxNFce."OPEEXP"] - [frxNFce."NOMEXP"]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
    end
  end
end
