object frmQckDAV: TfrmQckDAV
  Left = 196
  Top = 103
  Caption = 'DAV'
  ClientHeight = 87
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxDAV: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 40133.407199074100000000
    ReportOptions.LastChange = 40718.461485451400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDocumento."FGO_DESESP"> <= 0 Then'
      '  Begin'
      '    CDesEsp.Visible := False;'
      '    CDesEsp.Height  := 0;        '
      '  End;'
      ''
      '  If <frxDocumento."FGO_TOTRET"> <= 0 Then'
      '  Begin'
      '    CTotRet.Visible := False;'
      '    CTotRet.Height  := 0;        '
      '  End;'
      ''
      '  If <frxDocumento."FGO_TOTSER"> <= 0 Then'
      '  Begin'
      '    CTotSer.Visible := False;'
      '    CTotSer.Height  := 0;        '
      '  End;'
      ''
      '  If <frxDocumento."FGO_TOTFRE"> <= 0 Then'
      '  Begin'
      '    CTotFre.Visible := False;'
      '    CTotFre.Height  := 0;        '
      '  End;'
      ''
      '  If <frxDocumento."FGO_TOTIPI"> <= 0 Then'
      '  Begin'
      '    CTotIpi.Visible := False;'
      '    CTotIpi.Height  := 0;        '
      '  End;'
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 56
    Top = 32
    Datasets = <
      item
        DataSet = frxDocumento
        DataSetName = 'frxDocumento'
      end
      item
        DataSet = frxItens
        DataSetName = 'frxItens'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 148.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 11
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 253.228510000000000000
        Top = 18.897650000000000000
        Width = 521.575140000000100000
        object rllTitulo: TfrxMemoView
          Align = baCenter
          Left = 0.000000000000016542
          Width = 521.575140000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'DOCUMENTO AUXILIAR DE VENDA - [ESPECIE]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Top = 26.456710000000000000
          Width = 521.575140000000000000
          Height = 34.015770000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            
              'N'#195'O '#201' DOCUMENTO FISCAL - N'#195'O '#201' V'#193'LIDO COMO RECIBO E COMO GARANTI' +
              'A DE MERCADORIA - N'#195'O COMPROVA PAGAMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          Top = 60.472480000000000000
          Width = 521.575140000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Identifica'#231#227'o do Estabelecimento Emitente')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 343.937230000000000000
          Top = 86.929190000000000000
          Width = 52.913420000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            '  CNPJ:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 86.929190000000000000
          Width = 90.708720000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'Denomina'#231#227'o:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 132.283550000000000000
          Width = 521.575140000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Identifica'#231#227'o do Destinat'#225'rio')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 317.480520000000000000
          Top = 158.740260000000000000
          Width = 79.370130000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            '  CNPJ/CPF:')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Top = 158.740260000000000000
          Width = 45.354360000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'Nome:')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Top = 204.094620000000000000
          Width = 113.385900000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8W = (
            'N'#186' do Documento:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 257.008040000000000000
          Top = 204.094620000000000000
          Width = 264.567100000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '  N'#186' do Documento Fiscal: _____________')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 90.708720000000000000
          Top = 86.929190000000000000
          Width = 253.228510000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[RAZSOC]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 396.850650000000000000
          Top = 86.929190000000000000
          Width = 124.724490000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[CGCEMP]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 45.354360000000000000
          Top = 158.740260000000000000
          Width = 272.126160000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 396.850650000000000000
          Top = 158.740260000000000000
          Width = 124.724490000000000000
          Height = 45.354330710000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[CGCCLI]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 113.385900000000000000
          Top = 204.094620000000000000
          Width = 143.622140000000000000
          Height = 22.677180000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[NUMDOC]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Top = 226.771800000000000000
          Width = 257.008040000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'PRODUTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 336.378170000000000000
          Top = 226.771800000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'UNIT'#193'RIO')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 257.008040000000000000
          Top = 226.771800000000000000
          Width = 79.370130000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTDE.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 415.748300000000000000
          Top = 226.771800000000000000
          Width = 105.826840000000000000
          Height = 26.456710000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 23.677180000000000000
        Top = 332.598640000000000000
        Width = 521.575140000000100000
        DataSet = frxItens
        DataSetName = 'frxItens'
        RowCount = 0
        object Memo20: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.000000000000000000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          DataField = 'FDO_DESCRI'
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxItens."FDO_DESCRI"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 260.787570000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'FDO_QTDITE'
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."FDO_QTDITE"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 340.157700000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'FDO_UNITAR'
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."FDO_UNITAR"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 419.527830000000000000
          Top = 1.000000000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FDO_TOTITE'
          DataSet = frxItens
          DataSetName = 'frxItens'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxItens."FDO_TOTITE"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 34.015748030000000000
        Top = 733.228820000000000000
        Width = 521.575140000000100000
        object rllRodaPeMsg: TfrxMemoView
          Width = 521.575140000000100000
          Height = 34.015748030000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #201' VEDADA A AUTENTICA'#199#195'O DESTE DOCUMENTO')
          ParentFont = False
          VAlign = vaCenter
        end
        object rllValidadeOR: TfrxMemoView
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Validade do Or'#231'amento:')
          ParentFont = False
        end
        object rllDtaValOR: TfrxMemoView
          Left = 162.181200000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Visible = False
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDocumento."FGO_VALORC"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 415.748300000000000000
        Width = 521.575140000000100000
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        Child = frxDAV.CDesEsp
        object Memo10: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DOS PRODUTOS:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 415.748300000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_TOTPRO'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_TOTPRO"]')
          ParentFont = False
        end
      end
      object CDesEsp: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 461.102660000000000000
        Width = 521.575140000000100000
        Child = frxDAV.CTotRet
        PrintChildIfInvisible = True
        object Memo25: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'DESCONTO ESPECIAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_DESESP'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_DESESP"]')
          ParentFont = False
        end
      end
      object CTotRet: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 506.457020000000000000
        Width = 521.575140000000100000
        Child = frxDAV.CTotSer
        PrintChildIfInvisible = True
        object Memo30: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'SUB. TRIBUTARIA:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo31: TfrxMemoView
          Left = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_TOTRET'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_TOTRET"]')
          ParentFont = False
        end
      end
      object CTotSer: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 551.811380000000000000
        Width = 521.575140000000100000
        Child = frxDAV.CTotFre
        PrintChildIfInvisible = True
        object Memo32: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL SERVI'#199'O(S):')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          Left = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_TOTSER'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_TOTSER"]')
          ParentFont = False
        end
      end
      object CTotFre: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 597.165740000000000000
        Width = 521.575140000000100000
        Child = frxDAV.CTotIpi
        PrintChildIfInvisible = True
        object Memo34: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR DO FRETE:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          Left = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_TOTFRE'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_TOTFRE"]')
          ParentFont = False
        end
      end
      object CVlrCon: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 687.874460000000000000
        Width = 521.575140000000100000
        PrintChildIfInvisible = True
        object Memo26: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR TOTAL:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_VLRCON'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_VLRCON"]')
          ParentFont = False
        end
      end
      object CTotIpi: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 642.520100000000000000
        Width = 521.575140000000100000
        Child = frxDAV.CVlrCon
        PrintChildIfInvisible = True
        object Memo36: TfrxMemoView
          Width = 415.748300000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DO IPI:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 419.527830000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'FGO_TOTIPI'
          DataSet = frxDocumento
          DataSetName = 'frxDocumento'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDocumento."FGO_TOTIPI"]')
          ParentFont = False
        end
      end
    end
  end
  object frxItens: TfrxDBDataset
    UserName = 'frxItens'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 88
    Top = 32
  end
  object frxDocumento: TfrxDBDataset
    UserName = 'frxDocumento'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 120
    Top = 32
  end
end
