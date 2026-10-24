object frmQckReciboBai2Fast: TfrmQckReciboBai2Fast
  Left = 0
  Top = 0
  ClientHeight = 364
  ClientWidth = 646
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
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 16
    Top = 62
  end
  object frxCheques: TfrxDBDataset
    UserName = 'frxCheques'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 84
    Top = 62
  end
  object frxRelReciboJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41410.589098483800000000
    ReportOptions.LastChange = 45216.439645659720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'procedure rlbTituloOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  rllOrdRec.Text := '#39'ORDEM DE PGTO.: [ORDEM]'#39';'
      '    If <frxRelatorio."RECPIX"> = '#39'S'#39' Then'
      '      rllOrdRec.Text := '#39'PIX: [ORDEM]'#39';  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 160
    Top = 8
    Datasets = <
      item
        DataSet = frxCheques
        DataSetName = 'frxCheques'
      end
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
    object pagRelatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object rllCodVen: TfrxMemoView
          Left = 115.448816460000000000
          Width = 19.653533540000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaVen: TfrxMemoView
          Left = 139.600000000000000000
          Width = 45.354330710000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaRec: TfrxMemoView
          Left = 185.000000000000000000
          Width = 45.354330710000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDoc: TfrxMemoView
          Left = 232.329128980000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 306.618883000000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllNumDoc: TfrxMemoView
          Left = 6.600000000000000000
          Width = 105.826776540000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
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
      end
      object rlbCheques: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object mmoCheques: TfrxMemoView
          Left = 5.763779527559060000
          Width = 743.433070870000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object subCheques: TfrxSubreport
          Left = 6.600000000000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboJ.pagCheques
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        OnAfterPrint = 'rlbTituloOnAfterPrint'
        object Memo1: TfrxMemoView
          Left = 327.271120000000000000
          Top = 21.618120000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 563.563760000000000000
          Top = 25.397650000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 535.118120000000000000
          Top = 25.397650000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 6.918120000000000000
          Top = 42.397650000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 6.918120000000000000
          Top = 97.397650000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 6.918120000000000000
          Top = 117.397650000000000000
          Width = 366.840940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 5.763779530000000000
          Top = 136.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 6.600000000000000000
          Top = 138.397650000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 5.763779530000000000
          Top = 155.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 106.448816460000000000
          Top = 138.397650000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 141.600000000000000000
          Top = 138.397650000000000000
          Width = 39.685034490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 187.000000000000000000
          Top = 138.397650000000000000
          Width = 39.685034490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 236.864564490000000000
          Top = 138.397650000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 309.264564490000000000
          Top = 138.397650000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 460.318120000000000000
          Top = 80.870130000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line7: TfrxLineView
          Left = 5.763779530000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 5.763779530000000000
          Top = 19.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Left = 749.196850390000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Left = 190.074150000000000000
          Top = 97.397650000000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 123.822140000000000000
          Top = 42.397650000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 123.822140000000000000
          Top = 61.752010000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 577.373780000000000000
          Top = 80.870130000000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 378.826771650000000000
          Top = 138.397650000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 474.842519690000000000
          Top = 138.397650000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 506.992125980000000000
          Top = 138.397650000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 555.370078740000000000
          Top = 138.397650000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 608.818897640000000000
          Top = 138.397650000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 684.165354330000000000
          Top = 138.397650000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 375.401574800000000000
          Top = 137.283550000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo283: TfrxMemoView
          Left = 539.811380000000000000
          Top = 117.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbEmpresa: TfrxChild
        FillType = ftBrush
        Height = 166.299320000000000000
        Top = 279.685220000000000000
        Width = 755.906000000000000000
        object Memo34: TfrxMemoView
          Left = 427.722854170000000000
          Top = 51.901670000000030000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 649.322854170000000000
          Top = 51.901670000000030000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 44.170130000000000000
          Top = 52.460730000000010000
          Width = 384.528880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 7.697650000000000000
          Top = 68.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 7.697650000000000000
          Top = 85.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 7.697650000000000000
          Top = 102.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 7.697650000000000000
          Top = 121.901670000000000000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Left = 456.522854170000000000
          Top = 119.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo41: TfrxMemoView
          Left = 453.921184170000000000
          Top = 121.901670000000000000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 219.122854170000000000
          Top = 121.901670000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line23: TfrxLineView
          Left = 5.800000000000000000
          Height = 140.976412130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 749.233070870000000000
          Height = 140.976377950000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 5.800000000000000000
          Top = 142.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua: TfrxMemoView
          Left = 7.697650000000000000
          Top = 146.708720000000000000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
        object Memo249: TfrxMemoView
          Left = 7.677180000000000000
          Top = 52.000000000000000000
          Width = 25.473530000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo251: TfrxMemoView
          Left = 34.472480000000000000
          Top = 52.118119999999970000
          Width = 6.575880000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '-')
          ParentFont = False
          WordWrap = False
        end
        object Line121: TfrxLineView
          Left = 6.519685040000000000
          Top = 24.456709999999990000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line122: TfrxLineView
          Left = 6.661410000000000000
          Top = 49.692949999999990000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo269: TfrxMemoView
          Left = 9.440940000000000000
          Top = 5.559060000000000000
          Width = 107.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO: [DINHEIRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo270: TfrxMemoView
          Left = 550.338900000000000000
          Top = 5.559059999999988000
          Width = 156.472480000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHEQUE-PR'#201': [CHEPRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo271: TfrxMemoView
          Left = 294.992270000000000000
          Top = 5.559059999999988000
          Width = 148.913420000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHEQUE A VISTA: [CHEVIS]')
          ParentFont = False
          WordWrap = False
        end
        object Memo272: TfrxMemoView
          Left = 9.440940000000000000
          Top = 30.015769999999970000
          Width = 107.338590000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CART'#195'O: [CARTAO]')
          ParentFont = False
          WordWrap = False
        end
        object rllOrdRec: TfrxMemoView
          Left = 294.992270000000000000
          Top = 30.015769999999970000
          Width = 148.913420000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORDEM DE PGTO.: [ORDEM]')
          ParentFont = False
          WordWrap = False
        end
        object Memo274: TfrxMemoView
          Left = 550.338900000000000000
          Top = 30.015769999999970000
          Width = 156.472480000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'CR'#201'DITO UTILIZADO: [CREDITO]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbEmpresa2: TfrxChild
        FillType = ftBrush
        Height = 120.944960000000000000
        Top = 468.661720000000000000
        Width = 755.906000000000000000
        object Memo250: TfrxMemoView
          Left = 427.820504170000000000
          Top = 4.681199999999990000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo268: TfrxMemoView
          Left = 649.420504170000000000
          Top = 4.681199999999990000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo275: TfrxMemoView
          Left = 7.653543310000000000
          Top = 4.240259999999978000
          Width = 418.544650000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo276: TfrxMemoView
          Left = 7.795300000000000000
          Top = 21.681199999999990000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo277: TfrxMemoView
          Left = 7.795300000000000000
          Top = 38.681199999999990000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
          Formats = <
            item
            end
            item
            end
            item
            end>
        end
        object Memo278: TfrxMemoView
          Left = 7.795300000000000000
          Top = 55.681200000000040000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo279: TfrxMemoView
          Left = 7.795300000000000000
          Top = 74.681200000000050000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line123: TfrxLineView
          Left = 456.620504170000000000
          Top = 72.681200000000050000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo280: TfrxMemoView
          Left = 454.018834170000000000
          Top = 74.681200000000050000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo281: TfrxMemoView
          Left = 219.220504170000000000
          Top = 74.681200000000050000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line124: TfrxLineView
          Left = 5.897650000000000000
          Top = 0.779530000000022500
          Height = 99.401582130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line125: TfrxLineView
          Left = 749.330720870000000000
          Top = 0.779530000000022500
          Height = 99.401577240000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line126: TfrxLineView
          Left = 5.897650000000000000
          Top = 101.244280000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line127: TfrxLineView
          Left = 5.897650000000000000
          Top = 0.779530000000022500
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo282: TfrxMemoView
          Left = 7.795300000000000000
          Top = 99.488249999999940000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
    end
    object pagRel2Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe2Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo64: TfrxMemoView
          Left = 6.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
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
        object Memo65: TfrxMemoView
          Left = 114.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo66: TfrxMemoView
          Left = 134.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo67: TfrxMemoView
          Left = 183.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 232.157470560000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Left = 306.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line30: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques2Via: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboJ.rlbEmpresa2Via
        PrintChildIfInvisible = True
        object mmoCheques2Via: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.433070870000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object subCheques2Via: TfrxSubreport
          Left = 6.897650000000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboJ.pagCheques2Via
        end
      end
      object rlbEmpresa2Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 755.906000000000000000
        object Memo70: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000000000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo71: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo72: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo75: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000000000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line32: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo77: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000000000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo78: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line33: TfrxLineView
          Left = 5.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line35: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line36: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua2Via: TfrxMemoView
          Left = 6.897650000000000000
          Top = 90.708720000000000000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTiulo2Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo33: TfrxMemoView
          Left = 327.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 563.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 534.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 6.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 6.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 6.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Left = 5.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line26: TfrxLineView
          Left = 5.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo53: TfrxMemoView
          Left = 460.097650000000000000
          Top = 80.429190000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line27: TfrxLineView
          Left = 5.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 5.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line29: TfrxLineView
          Left = 749.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo54: TfrxMemoView
          Left = 189.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 123.601670000000000000
          Top = 42.177180000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 123.601670000000000000
          Top = 61.531540000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 577.153310000000000000
          Top = 80.429190000000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 5.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 109.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 145.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 192.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 236.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 308.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 378.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 474.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 506.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 554.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 608.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 683.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line25: TfrxLineView
          Left = 374.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo284: TfrxMemoView
          Left = 543.590910000000000000
          Top = 116.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagRel3Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhe3Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo103: TfrxMemoView
          Left = 7.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
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
        object Memo104: TfrxMemoView
          Left = 113.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 135.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo106: TfrxMemoView
          Left = 184.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 233.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo108: TfrxMemoView
          Left = 307.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line49: TfrxLineView
          Left = 750.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 6.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques3Via: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboJ.rlbEmpresa3Via
        PrintChildIfInvisible = True
        object mmoCheques3Via: TfrxMemoView
          Left = 6.763779530000000000
          Width = 743.433070870000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object subCheques3Via: TfrxSubreport
          Left = 7.897637800000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboJ.pagCheques3Via
        end
      end
      object rlbEmpresa3Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 755.906000000000000000
        object Memo109: TfrxMemoView
          Left = 428.722854170000000000
          Top = 1.901670000000000000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 650.322854170000000000
          Top = 1.901670000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo111: TfrxMemoView
          Left = 8.697650000000000000
          Top = 1.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo112: TfrxMemoView
          Left = 8.697650000000000000
          Top = 18.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo113: TfrxMemoView
          Left = 8.697650000000000000
          Top = 35.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo114: TfrxMemoView
          Left = 8.697650000000000000
          Top = 52.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo115: TfrxMemoView
          Left = 8.697650000000000000
          Top = 69.901670000000000000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line51: TfrxLineView
          Left = 457.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo116: TfrxMemoView
          Left = 454.921184170000000000
          Top = 69.901670000000000000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo117: TfrxMemoView
          Left = 220.122854170000000000
          Top = 69.901670000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line52: TfrxLineView
          Left = 6.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 750.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 6.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line55: TfrxLineView
          Left = 6.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua3Via: TfrxMemoView
          Left = 7.897650000000000000
          Top = 90.708720000000000000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo3Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo119: TfrxMemoView
          Left = 328.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 564.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo121: TfrxMemoView
          Left = 535.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 7.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 7.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 7.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line56: TfrxLineView
          Left = 6.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line58: TfrxLineView
          Left = 6.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo131: TfrxMemoView
          Left = 461.097650000000000000
          Top = 77.649660000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line59: TfrxLineView
          Left = 6.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line60: TfrxLineView
          Left = 6.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line61: TfrxLineView
          Left = 750.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo132: TfrxMemoView
          Left = 190.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo133: TfrxMemoView
          Left = 124.601670000000000000
          Top = 42.177180000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo134: TfrxMemoView
          Left = 124.601670000000000000
          Top = 61.531540000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo135: TfrxMemoView
          Left = 578.153310000000000000
          Top = 77.649660000000000000
          Width = 166.299320000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo118: TfrxMemoView
          Left = 6.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 107.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 143.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 189.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 237.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 309.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 379.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 475.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 507.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          Left = 555.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          Left = 609.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 684.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line57: TfrxLineView
          Left = 375.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo285: TfrxMemoView
          Left = 544.590910000000000000
          Top = 116.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagRel4Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe4Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo158: TfrxMemoView
          Left = 6.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
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
        object Memo159: TfrxMemoView
          Left = 114.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo160: TfrxMemoView
          Left = 134.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo161: TfrxMemoView
          Left = 183.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo162: TfrxMemoView
          Left = 232.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo163: TfrxMemoView
          Left = 306.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line73: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line74: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa4Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 755.906000000000000000
        object Memo164: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000000000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo165: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo166: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo167: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo169: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo170: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000000000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line75: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo171: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000000000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo172: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line76: TfrxLineView
          Left = 5.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line77: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line78: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line79: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua4Via: TfrxMemoView
          Left = 6.897650000000000000
          Top = 90.708720000000000000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo4Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo174: TfrxMemoView
          Left = 327.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          Left = 563.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo176: TfrxMemoView
          Left = 534.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo177: TfrxMemoView
          Left = 6.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 6.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo179: TfrxMemoView
          Left = 6.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line80: TfrxLineView
          Left = 5.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line82: TfrxLineView
          Left = 5.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo186: TfrxMemoView
          Left = 460.097650000000000000
          Top = 78.649660000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line83: TfrxLineView
          Left = 5.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line84: TfrxLineView
          Left = 5.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line85: TfrxLineView
          Left = 749.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo187: TfrxMemoView
          Left = 189.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo188: TfrxMemoView
          Left = 123.601670000000000000
          Top = 42.177180000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo189: TfrxMemoView
          Left = 123.601670000000000000
          Top = 61.531540000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo190: TfrxMemoView
          Left = 577.153310000000000000
          Top = 78.649660000000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo141: TfrxMemoView
          Left = 5.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 107.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 139.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          Left = 188.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 236.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo183: TfrxMemoView
          Left = 308.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 378.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo185: TfrxMemoView
          Left = 474.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo191: TfrxMemoView
          Left = 506.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 554.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 608.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo194: TfrxMemoView
          Left = 683.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line81: TfrxLineView
          Left = 374.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo286: TfrxMemoView
          Left = 543.590910000000000000
          Top = 116.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCheques4Via: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboJ.rlbEmpresa4Via
        PrintChildIfInvisible = True
        object mmoCheques4Via: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.433070870000000000
          Height = 13.606299210000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object subCheques4Via: TfrxSubreport
          Left = 6.897637800000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboJ.pagCheques4Via
        end
      end
    end
    object pagRel5Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo213: TfrxMemoView
          Left = 6.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
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
        object Memo214: TfrxMemoView
          Left = 113.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo215: TfrxMemoView
          Left = 134.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo216: TfrxMemoView
          Left = 183.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo217: TfrxMemoView
          Left = 232.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo218: TfrxMemoView
          Left = 306.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line97: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line98: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa5Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 755.906000000000000000
        object Memo219: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000000000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo220: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo221: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo222: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo223: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo224: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000000000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo225: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000030000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line99: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo226: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000030000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo227: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000030000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line100: TfrxLineView
          Left = 5.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line101: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line102: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464749999999990000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line103: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua5Via: TfrxMemoView
          Left = 6.897650000000000000
          Top = 90.708720000000030000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo5Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo229: TfrxMemoView
          Left = 327.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo230: TfrxMemoView
          Left = 563.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo231: TfrxMemoView
          Left = 534.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Left = 6.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Left = 6.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo234: TfrxMemoView
          Left = 6.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line104: TfrxLineView
          Left = 5.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line106: TfrxLineView
          Left = 5.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo241: TfrxMemoView
          Left = 460.097650000000000000
          Top = 78.649660000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line107: TfrxLineView
          Left = 5.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line108: TfrxLineView
          Left = 5.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line109: TfrxLineView
          Left = 749.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo242: TfrxMemoView
          Left = 189.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo243: TfrxMemoView
          Left = 123.601670000000000000
          Top = 42.177180000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo244: TfrxMemoView
          Left = 123.601670000000000000
          Top = 61.531540000000000000
          Width = 616.063390000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo245: TfrxMemoView
          Left = 577.153310000000000000
          Top = 78.649660000000000000
          Width = 162.519790000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo195: TfrxMemoView
          Left = 5.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo196: TfrxMemoView
          Left = 107.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Left = 139.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo235: TfrxMemoView
          Left = 188.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo236: TfrxMemoView
          Left = 236.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Left = 308.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo238: TfrxMemoView
          Left = 378.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Left = 474.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo240: TfrxMemoView
          Left = 506.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo246: TfrxMemoView
          Left = 554.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo247: TfrxMemoView
          Left = 608.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo248: TfrxMemoView
          Left = 683.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line105: TfrxLineView
          Left = 374.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo287: TfrxMemoView
          Left = 543.590910000000000000
          Top = 116.385900000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCheques5Via: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboJ.rlbEmpresa5Via
        PrintChildIfInvisible = True
        object mmoCheques5Via: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.433070870000000000
          Height = 13.606299210000000000
          AllowHTMLTags = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object subCheques5Via: TfrxSubreport
          Left = 6.897637800000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboJ.pagCheques5Via
        end
      end
    end
    object pagCheques: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbChq: TfrxMasterData
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 75.590600000000000000
        Width = 755.906000000000000000
        DataSet = frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object Line19: TfrxLineView
          Height = 17.007874015748000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 742.464610870000000000
          Height = 13.228346460000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 1.592125980000000000
          Width = 55.861410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_C_G_C_"]')
          ParentFont = False
          WordWrap = False
        end
        object Line14: TfrxLineView
          Left = 1.000000000000000000
          Top = 13.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line11: TfrxLineView
          Left = 0.220470000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo94: TfrxMemoView
          Left = 244.889920000000000000
          Width = 82.922820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbHdChq: TfrxHeader
        FillType = ftBrush
        Height = 34.771653540000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo25: TfrxMemoView
          Left = 317.480520000000000000
          Width = 128.504020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE CHEQUES')
          ParentFont = False
          WordWrap = False
        end
        object Line10: TfrxLineView
          Left = 742.464610870000000000
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 0.811070000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line47: TfrxLineView
          Top = 16.629921259842500000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo87: TfrxMemoView
          Left = 1.592125980000000000
          Top = 16.897650000000000000
          Width = 52.913420000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'AGEN')
          ParentFont = False
        end
        object Memo88: TfrxMemoView
          Left = 60.440942440000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
        end
        object Memo89: TfrxMemoView
          Left = 147.930715980000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NUM. CHEQUE')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Left = 340.442465980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo91: TfrxMemoView
          Left = 439.530715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
        end
        object Memo92: TfrxMemoView
          Left = 622.330715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo93: TfrxMemoView
          Left = 244.889920000000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
      end
      object rlbFtChq: TfrxFooter
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 113.385900000000000000
        Width = 755.906000000000000000
        object Memo26: TfrxMemoView
          Left = 1.592125980000000000
          Width = 627.401980000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESTE RECIBO SOMENTE SER'#193' V'#193'LIDO NA COMPENSA'#199#195'O DO CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Line15: TfrxLineView
          Left = 742.464610870000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 1.000000000000000000
          Top = 17.118120000000000000
          Width = 741.543307086614000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
    object pagCheques2Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbFtChq2Via: TfrxFooter
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 113.385900000000000000
        Width = 755.906000000000000000
        object Memo86: TfrxMemoView
          Left = 1.592125980000000000
          Width = 627.401980000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESTE RECIBO SOMENTE SER'#193' VALIDO NA COMPENSA'#199#195'O DO CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Line44: TfrxLineView
          Left = 742.464610870000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line45: TfrxLineView
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line46: TfrxLineView
          Left = 1.000000000000000000
          Top = 17.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbHdChq2Via: TfrxHeader
        FillType = ftBrush
        Height = 34.771653540000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo85: TfrxMemoView
          Left = 317.480520000000000000
          Width = 128.504020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE CHEQUES')
          ParentFont = False
          WordWrap = False
        end
        object Line41: TfrxLineView
          Left = 742.464610870000000000
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line42: TfrxLineView
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line43: TfrxLineView
          Left = 0.811070000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line48: TfrxLineView
          Top = 16.629921259842500000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo95: TfrxMemoView
          Left = 1.592125980000000000
          Top = 16.897650000000000000
          Width = 52.913420000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'AGEN')
          ParentFont = False
        end
        object Memo96: TfrxMemoView
          Left = 60.440942440000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
        end
        object Memo97: TfrxMemoView
          Left = 147.930715980000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NUM. CHEQUE')
          ParentFont = False
        end
        object Memo98: TfrxMemoView
          Left = 340.442465980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo99: TfrxMemoView
          Left = 439.530715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
        end
        object Memo100: TfrxMemoView
          Left = 622.330715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Left = 244.889920000000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
      end
      object rlbChq2Via: TfrxMasterData
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 75.590600000000000000
        Width = 755.906000000000000000
        DataSet = frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object Line37: TfrxLineView
          Height = 17.007874015748000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line38: TfrxLineView
          Left = 742.464610870000000000
          Height = 13.228346460000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo79: TfrxMemoView
          Left = 1.592125980000000000
          Width = 55.861410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo82: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000009999993722
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo83: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo84: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_C_G_C_"]')
          ParentFont = False
          WordWrap = False
        end
        object Line39: TfrxLineView
          Left = 1.000000000000000000
          Top = 13.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line40: TfrxLineView
          Left = 0.220470000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo102: TfrxMemoView
          Left = 244.889920000000000000
          Width = 82.922820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagCheques3Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbFtChq3Via: TfrxFooter
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 113.385900000000000000
        Width = 793.701300000000000000
        object Memo142: TfrxMemoView
          Left = 1.592125980000000000
          Width = 627.401980000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESTE RECIBO SOMENTE SER'#193' VALIDO NA COMPENSA'#199#195'O DO CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Line62: TfrxLineView
          Left = 742.464610870000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line63: TfrxLineView
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line64: TfrxLineView
          Left = 1.000000000000000000
          Top = 17.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbHdChq3Via: TfrxHeader
        FillType = ftBrush
        Height = 34.771653540000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object Memo143: TfrxMemoView
          Left = 317.480520000000000000
          Width = 128.504020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE CHEQUES')
          ParentFont = False
          WordWrap = False
        end
        object Line65: TfrxLineView
          Left = 742.464610870000000000
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line66: TfrxLineView
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line67: TfrxLineView
          Left = 0.811070000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line68: TfrxLineView
          Top = 16.629921259842500000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo144: TfrxMemoView
          Left = 1.592125980000000000
          Top = 16.897650000000000000
          Width = 52.913420000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'AGEN')
          ParentFont = False
        end
        object Memo145: TfrxMemoView
          Left = 60.440942440000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
        end
        object Memo146: TfrxMemoView
          Left = 147.930715980000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NUM. CHEQUE')
          ParentFont = False
        end
        object Memo147: TfrxMemoView
          Left = 340.442465980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo148: TfrxMemoView
          Left = 439.530715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
        end
        object Memo149: TfrxMemoView
          Left = 622.330715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo150: TfrxMemoView
          Left = 244.889920000000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
      end
      object rlbChq3Via: TfrxMasterData
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 75.590600000000000000
        Width = 793.701300000000000000
        DataSet = frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object Line69: TfrxLineView
          Height = 17.007874015748000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line70: TfrxLineView
          Left = 742.464610870000000000
          Height = 13.228346460000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo151: TfrxMemoView
          Left = 1.592125980000000000
          Width = 55.861410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo152: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo153: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo154: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000009999993722
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo155: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo156: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_C_G_C_"]')
          ParentFont = False
          WordWrap = False
        end
        object Line71: TfrxLineView
          Left = 1.000000000000000000
          Top = 13.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line72: TfrxLineView
          Left = 0.220470000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo157: TfrxMemoView
          Left = 244.889920000000000000
          Width = 82.922820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagCheques4Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbFtChq4Via: TfrxFooter
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 113.385900000000000000
        Width = 793.701300000000000000
        object Memo197: TfrxMemoView
          Left = 1.592125980000000000
          Width = 627.401980000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESTE RECIBO SOMENTE SER'#193' VALIDO NA COMPENSA'#199#195'O DO CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Line86: TfrxLineView
          Left = 742.464610870000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line87: TfrxLineView
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line88: TfrxLineView
          Left = 1.000000000000000000
          Top = 17.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbHdChq4Via: TfrxHeader
        FillType = ftBrush
        Height = 34.771653540000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object Memo198: TfrxMemoView
          Left = 317.480520000000000000
          Width = 128.504020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE CHEQUES')
          ParentFont = False
          WordWrap = False
        end
        object Line89: TfrxLineView
          Left = 742.464610870000000000
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line90: TfrxLineView
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line91: TfrxLineView
          Left = 0.811070000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line92: TfrxLineView
          Top = 16.629921259842500000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo199: TfrxMemoView
          Left = 1.592125980000000000
          Top = 16.897650000000000000
          Width = 52.913420000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'AGEN')
          ParentFont = False
        end
        object Memo200: TfrxMemoView
          Left = 60.440942440000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
        end
        object Memo201: TfrxMemoView
          Left = 147.930715980000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NUM. CHEQUE')
          ParentFont = False
        end
        object Memo202: TfrxMemoView
          Left = 340.442465980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo203: TfrxMemoView
          Left = 439.530715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
        end
        object Memo204: TfrxMemoView
          Left = 622.330715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo205: TfrxMemoView
          Left = 244.889920000000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
      end
      object rlbChq4Via: TfrxMasterData
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 75.590600000000000000
        Width = 793.701300000000000000
        DataSet = frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object Line93: TfrxLineView
          Height = 17.007874015748000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line94: TfrxLineView
          Left = 742.464610870000000000
          Height = 13.228346460000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo206: TfrxMemoView
          Left = 1.592125980000000000
          Width = 55.861410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo207: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo208: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo209: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo210: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo211: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_C_G_C_"]')
          ParentFont = False
          WordWrap = False
        end
        object Line95: TfrxLineView
          Left = 1.000000000000000000
          Top = 13.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line96: TfrxLineView
          Left = 0.220470000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo212: TfrxMemoView
          Left = 244.889920000000000000
          Width = 82.922820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagCheques5Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbFtChq5Via: TfrxFooter
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 113.385900000000000000
        Width = 793.701300000000000000
        object Memo252: TfrxMemoView
          Left = 1.592125980000000000
          Width = 627.401980000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'ESTE RECIBO SOMENTE SER'#193' VALIDO NA COMPENSA'#199#195'O DO CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Line110: TfrxLineView
          Left = 742.464610870000000000
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line111: TfrxLineView
          Height = 17.007874020000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line112: TfrxLineView
          Left = 1.000000000000000000
          Top = 17.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbHdChq5Via: TfrxHeader
        FillType = ftBrush
        Height = 34.771653540000000000
        Top = 18.897650000000000000
        Width = 793.701300000000000000
        object Memo253: TfrxMemoView
          Left = 317.480520000000000000
          Width = 128.504020000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE CHEQUES')
          ParentFont = False
          WordWrap = False
        end
        object Line113: TfrxLineView
          Left = 742.464610870000000000
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line114: TfrxLineView
          Height = 34.015748031496100000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line115: TfrxLineView
          Left = 0.811070000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line116: TfrxLineView
          Top = 16.629921259842500000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo254: TfrxMemoView
          Left = 1.592125980000000000
          Top = 16.897650000000000000
          Width = 52.913420000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'AGEN')
          ParentFont = False
        end
        object Memo255: TfrxMemoView
          Left = 60.440942440000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
        end
        object Memo256: TfrxMemoView
          Left = 147.930715980000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'NUM. CHEQUE')
          ParentFont = False
        end
        object Memo257: TfrxMemoView
          Left = 340.442465980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
        end
        object Memo258: TfrxMemoView
          Left = 439.530715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
        end
        object Memo259: TfrxMemoView
          Left = 622.330715980000000000
          Top = 16.897650000000000000
          Width = 94.488250000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CNPJ/CPF')
          ParentFont = False
        end
        object Memo260: TfrxMemoView
          Left = 244.889920000000000000
          Top = 16.897650000000000000
          Width = 83.149660000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
        end
      end
      object rlbChq5Via: TfrxMasterData
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 75.590600000000000000
        Width = 793.701300000000000000
        DataSet = frxCheques
        DataSetName = 'frxCheques'
        RowCount = 0
        object Line117: TfrxLineView
          Height = 17.007874015748000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line118: TfrxLineView
          Left = 742.464610870000000000
          Height = 13.228346460000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo261: TfrxMemoView
          Left = 1.592125980000000000
          Width = 55.861410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo262: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo263: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo264: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheques."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo265: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo266: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_C_G_C_"]')
          ParentFont = False
          WordWrap = False
        end
        object Line119: TfrxLineView
          Left = 1.000000000000000000
          Top = 13.118120000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line120: TfrxLineView
          Left = 0.220470000000000000
          Width = 741.543307090000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo267: TfrxMemoView
          Left = 244.889920000000000000
          Width = 82.922820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxCheques
          DataSetName = 'frxCheques'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxCheques."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxRelReciboSemChqJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41410.589098483800000000
    ReportOptions.LastChange = 41970.709255486100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'Var'
      
        '  intLinha: Integer;                                            ' +
        '  '
      ''
      'procedure rlbDetalheOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intLinha Mod 2 = 0 Then'
      '  Begin              '
      '    rlbCheques.Height := rlbCheques.Height - rlbDetalhe.Height;'
      '    mmoCheques.Height := rlbCheques.Height;            '
      '  End;'
      '    '
      '  intLinha := intLinha + 1;      '
      'end;'
      ''
      'procedure rlbDetalhe2ViaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intLinha Mod 2 = 0 Then    '
      '  Begin          '
      
        '    rlbCheques2Via.Height := rlbCheques2Via.Height - rlbDetalhe2' +
        'Via.Height;'
      '    mmoCheques2Via.Height := rlbCheques2Via.Height;    '
      '  End;'
      '    '
      '  intLinha := intLinha + 1;     '
      'end;'
      ''
      'procedure rlbDetalhe3ViaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intLinha Mod 2 = 0 Then    '
      '  Begin          '
      
        '    rlbCheques3Via.Height := rlbCheques3Via.Height - rlbDetalhe3' +
        'Via.Height;'
      '    mmoCheques3Via.Height := rlbCheques3Via.Height;    '
      '  End;'
      '    '
      '  intLinha := intLinha + 1;  '
      'end;'
      ''
      'procedure rlbDetalhe4ViaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intLinha Mod 2 = 0 Then    '
      '  Begin          '
      
        '    rlbCheques4Via.Height := rlbCheques4Via.Height - rlbDetalhe4' +
        'Via.Height;'
      '    mmoCheques4Via.Height := rlbCheques4Via.Height;    '
      '  End;'
      '    '
      '  intLinha := intLinha + 1;  '
      '  '
      'end;'
      ''
      'procedure rlbDetalhe5ViaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If intLinha Mod 2 = 0 Then    '
      '  Begin          '
      
        '    rlbCheques5Via.Height := rlbCheques5Via.Height - rlbDetalhe5' +
        'Via.Height;'
      '    mmoCheques5Via.Height := rlbCheques5Via.Height;    '
      '  End;'
      '    '
      '  intLinha := intLinha + 1;  '
      '  '
      'end;'
      ''
      'begin'
      '  intLinha := 1;                              '
      'end.')
    Left = 264
    Top = 48
    Datasets = <
      item
        DataSet = frxCheques
        DataSetName = 'frxCheques'
      end
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
    object pagRelatorio: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalheOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object rllCodVen: TfrxMemoView
          Left = 105.448816460000000000
          Width = 30.992123540000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaVen: TfrxMemoView
          Left = 138.600000000000000000
          Width = 45.354330710000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaRec: TfrxMemoView
          Left = 185.000000000000000000
          Width = 45.354330710000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDoc: TfrxMemoView
          Left = 232.329128980000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 306.618883000000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllNumDoc: TfrxMemoView
          Left = 5.763779530000000000
          Width = 98.267716540000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
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
      end
      object rlbCheques: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa
        PrintChildIfInvisible = True
        object mmoCheques: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.433070870000000000
          Height = 226.771653540000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
      end
      object rlbEmpresa: TfrxChild
        FillType = ftBrush
        Height = 105.826840000000000000
        Top = 491.338900000000000000
        Width = 755.906000000000000000
        object Memo34: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000024000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000024000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000024000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo40: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000030000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line4: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo41: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000030000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo24: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000030000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line23: TfrxLineView
          Left = 5.763779530000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua: TfrxMemoView
          Left = 7.697650000000000000
          Top = 90.708720000000030000
          Width = 215.433210000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo1: TfrxMemoView
          Left = 327.271120000000000000
          Top = 21.618120000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 563.563760000000000000
          Top = 25.397650000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo3: TfrxMemoView
          Left = 535.118120000000000000
          Top = 25.397650000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 6.918120000000000000
          Top = 42.397650000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 6.918120000000000000
          Top = 96.397650000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 6.918120000000000000
          Top = 116.397650000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 5.763779530000000000
          Top = 136.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 6.600000000000000000
          Top = 138.397650000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 5.763779530000000000
          Top = 155.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 103.448816460000000000
          Top = 138.397650000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 138.600000000000000000
          Top = 138.397650000000000000
          Width = 39.685034490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 185.000000000000000000
          Top = 138.397650000000000000
          Width = 39.685034490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 236.864564490000000000
          Top = 138.397650000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 309.264564490000000000
          Top = 138.397650000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 460.318120000000000000
          Top = 78.870130000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line7: TfrxLineView
          Left = 5.763779530000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 5.763779530000000000
          Top = 19.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Left = 749.196850390000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Left = 190.074150000000000000
          Top = 96.397650000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 123.822140000000000000
          Top = 42.397650000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 123.822140000000000000
          Top = 61.752010000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo23: TfrxMemoView
          Left = 577.373780000000000000
          Top = 78.870130000000000000
          Width = 166.299320000000000000
          Height = 17.007874020000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo14: TfrxMemoView
          Left = 378.826771650000000000
          Top = 138.397650000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 474.842519690000000000
          Top = 138.397650000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 506.992125980000000000
          Top = 138.397650000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 555.370078740000000000
          Top = 138.397650000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 608.818897640000000000
          Top = 138.397650000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 684.165354330000000000
          Top = 138.397650000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 375.401574800000000000
          Top = 137.283550000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo283: TfrxMemoView
          Left = 543.590910000000000000
          Top = 117.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagRel2Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe2Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalhe2ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo64: TfrxMemoView
          Left = 6.600000000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."PARCEL"]-[frxRelatorio."E' +
              'SPDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo65: TfrxMemoView
          Left = 102.519685040000000000
          Width = 30.992125980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo66: TfrxMemoView
          Left = 134.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo67: TfrxMemoView
          Left = 183.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 232.157470560000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo69: TfrxMemoView
          Left = 306.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line30: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques2Via: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa2Via
        PrintChildIfInvisible = True
        object mmoCheques2Via: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.433070870000000000
          Height = 226.771653540000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
      end
      object rlbEmpresa2Via: TfrxChild
        FillType = ftBrush
        Height = 105.826774090000000000
        Top = 491.338900000000000000
        Width = 755.906000000000000000
        object Memo70: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000024000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo71: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000024000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo72: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000024000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo73: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo74: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo75: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo76: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000030000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line32: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo77: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000030000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo78: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000030000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line33: TfrxLineView
          Left = 5.763779530000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line35: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line36: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua2Via: TfrxMemoView
          Left = 6.897650000000000000
          Top = 90.708720000000030000
          Width = 215.433210000000000000
          Height = 15.118120000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTiulo2Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo33: TfrxMemoView
          Left = 327.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 563.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 534.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 6.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 6.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 6.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line18: TfrxLineView
          Left = 5.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line26: TfrxLineView
          Left = 5.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo53: TfrxMemoView
          Left = 460.097650000000000000
          Top = 78.649660000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line27: TfrxLineView
          Left = 5.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 5.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line29: TfrxLineView
          Left = 749.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo54: TfrxMemoView
          Left = 189.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo55: TfrxMemoView
          Left = 123.601670000000000000
          Top = 42.177180000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo56: TfrxMemoView
          Left = 123.601670000000000000
          Top = 61.531540000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo57: TfrxMemoView
          Left = 577.153310000000000000
          Top = 78.649660000000000000
          Width = 166.299320000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 5.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 101.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo49: TfrxMemoView
          Left = 133.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 182.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo51: TfrxMemoView
          Left = 236.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000010000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo52: TfrxMemoView
          Left = 308.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo58: TfrxMemoView
          Left = 378.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo59: TfrxMemoView
          Left = 474.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 506.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 554.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 608.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 683.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line25: TfrxLineView
          Left = 374.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo25: TfrxMemoView
          Left = 543.590910000000000000
          Top = 117.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagRel3Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhe3Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalhe3ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo103: TfrxMemoView
          Left = 7.600000000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."PARCEL"]-[frxRelatorio."E' +
              'SPDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo104: TfrxMemoView
          Left = 103.519685040000000000
          Width = 30.992125980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo105: TfrxMemoView
          Left = 135.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo106: TfrxMemoView
          Left = 184.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo107: TfrxMemoView
          Left = 233.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo108: TfrxMemoView
          Left = 307.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line49: TfrxLineView
          Left = 750.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 6.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques3Via: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa3Via
        PrintChildIfInvisible = True
        object mmoCheques3Via: TfrxMemoView
          Left = 6.763779530000000000
          Width = 743.433070870000000000
          Height = 226.771653540000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
      end
      object rlbEmpresa3Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 491.338900000000000000
        Width = 755.906000000000000000
        object Memo109: TfrxMemoView
          Left = 428.722854170000000000
          Top = 1.901670000000024000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo110: TfrxMemoView
          Left = 650.322854170000000000
          Top = 1.901670000000024000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo111: TfrxMemoView
          Left = 8.697650000000000000
          Top = 1.901670000000024000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo112: TfrxMemoView
          Left = 8.697650000000000000
          Top = 18.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo113: TfrxMemoView
          Left = 8.697650000000000000
          Top = 35.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo114: TfrxMemoView
          Left = 8.697650000000000000
          Top = 52.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo115: TfrxMemoView
          Left = 8.697650000000000000
          Top = 69.901670000000030000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line51: TfrxLineView
          Left = 457.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo116: TfrxMemoView
          Left = 454.921184170000000000
          Top = 69.901670000000030000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo117: TfrxMemoView
          Left = 220.122854170000000000
          Top = 69.901670000000030000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line52: TfrxLineView
          Left = 6.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 750.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 6.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line55: TfrxLineView
          Left = 6.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua3Via: TfrxMemoView
          Left = 7.897650000000000000
          Top = 90.708720000000030000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo3Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo119: TfrxMemoView
          Left = 328.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 564.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo121: TfrxMemoView
          Left = 535.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo122: TfrxMemoView
          Left = 7.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo123: TfrxMemoView
          Left = 7.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo124: TfrxMemoView
          Left = 7.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line56: TfrxLineView
          Left = 6.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line58: TfrxLineView
          Left = 6.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo131: TfrxMemoView
          Left = 461.097650000000000000
          Top = 78.649660000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line59: TfrxLineView
          Left = 6.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line60: TfrxLineView
          Left = 6.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line61: TfrxLineView
          Left = 750.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo132: TfrxMemoView
          Left = 190.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo133: TfrxMemoView
          Left = 124.601670000000000000
          Top = 42.177180000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo134: TfrxMemoView
          Left = 124.601670000000000000
          Top = 61.531540000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo135: TfrxMemoView
          Left = 578.153310000000000000
          Top = 78.649660000000000000
          Width = 166.299320000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo118: TfrxMemoView
          Left = 6.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo125: TfrxMemoView
          Left = 102.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo126: TfrxMemoView
          Left = 134.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo127: TfrxMemoView
          Left = 183.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo128: TfrxMemoView
          Left = 237.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000010000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo129: TfrxMemoView
          Left = 309.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo130: TfrxMemoView
          Left = 379.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo136: TfrxMemoView
          Left = 475.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo137: TfrxMemoView
          Left = 507.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo138: TfrxMemoView
          Left = 555.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo139: TfrxMemoView
          Left = 609.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo140: TfrxMemoView
          Left = 684.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line57: TfrxLineView
          Left = 375.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo26: TfrxMemoView
          Left = 544.590910000000000000
          Top = 117.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagRel4Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe4Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalhe4ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo158: TfrxMemoView
          Left = 6.600000000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."PARCEL"]-[frxRelatorio."E' +
              'SPDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo159: TfrxMemoView
          Left = 102.519685040000000000
          Width = 30.992125980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo160: TfrxMemoView
          Left = 134.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo161: TfrxMemoView
          Left = 183.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo162: TfrxMemoView
          Left = 232.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo163: TfrxMemoView
          Left = 306.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line73: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line74: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa4Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 491.338900000000000000
        Width = 755.906000000000000000
        object Memo164: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000024000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo165: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000024000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo166: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000024000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo167: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo168: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo169: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo170: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000030000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line75: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo171: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000030000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo172: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000030000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line76: TfrxLineView
          Left = 5.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line77: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line78: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line79: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua4Via: TfrxMemoView
          Left = 6.897650000000000000
          Top = 90.708720000000030000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo4Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo174: TfrxMemoView
          Left = 327.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo175: TfrxMemoView
          Left = 563.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo176: TfrxMemoView
          Left = 534.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo177: TfrxMemoView
          Left = 6.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo178: TfrxMemoView
          Left = 6.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo179: TfrxMemoView
          Left = 6.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line80: TfrxLineView
          Left = 5.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line82: TfrxLineView
          Left = 5.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo186: TfrxMemoView
          Left = 460.097650000000000000
          Top = 80.429190000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line83: TfrxLineView
          Left = 5.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line84: TfrxLineView
          Left = 5.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line85: TfrxLineView
          Left = 749.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo187: TfrxMemoView
          Left = 189.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo188: TfrxMemoView
          Left = 123.601670000000000000
          Top = 42.177180000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo189: TfrxMemoView
          Left = 123.601670000000000000
          Top = 61.531540000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo190: TfrxMemoView
          Left = 577.153310000000000000
          Top = 80.429190000000000000
          Width = 166.299320000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo141: TfrxMemoView
          Left = 5.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo173: TfrxMemoView
          Left = 101.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo180: TfrxMemoView
          Left = 133.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo181: TfrxMemoView
          Left = 182.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo182: TfrxMemoView
          Left = 236.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000010000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo183: TfrxMemoView
          Left = 308.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo184: TfrxMemoView
          Left = 378.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo185: TfrxMemoView
          Left = 474.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo191: TfrxMemoView
          Left = 506.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo192: TfrxMemoView
          Left = 554.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo193: TfrxMemoView
          Left = 608.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo194: TfrxMemoView
          Left = 683.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line81: TfrxLineView
          Left = 374.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 543.590910000000000000
          Top = 117.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCheques4Via: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa4Via
        PrintChildIfInvisible = True
        object mmoCheques4Via: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.055118110000000000
          Height = 226.771653540000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
      end
    end
    object pagRel5Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhe5Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'rlbDetalhe5ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo213: TfrxMemoView
          Left = 5.820470000000000000
          Width = 94.488188980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"]-[frxRelatorio."PARCEL"]-[frxRelatorio."E' +
              'SPDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo214: TfrxMemoView
          Left = 102.519685040000000000
          Width = 30.992125980000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo215: TfrxMemoView
          Left = 134.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo216: TfrxMemoView
          Left = 183.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo217: TfrxMemoView
          Left = 232.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo218: TfrxMemoView
          Left = 306.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line97: TfrxLineView
          Left = 749.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line98: TfrxLineView
          Left = 5.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa5Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 491.338900000000000000
        Width = 755.906000000000000000
        object Memo219: TfrxMemoView
          Left = 427.722854170000000000
          Top = 1.901670000000024000
          Width = 217.927520000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo220: TfrxMemoView
          Left = 649.322854170000000000
          Top = 1.901670000000024000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo221: TfrxMemoView
          Left = 7.697650000000000000
          Top = 1.901670000000024000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
        end
        object Memo222: TfrxMemoView
          Left = 7.697650000000000000
          Top = 18.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo223: TfrxMemoView
          Left = 7.697650000000000000
          Top = 35.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo224: TfrxMemoView
          Left = 7.697650000000000000
          Top = 52.901670000000030000
          Width = 414.765120000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo225: TfrxMemoView
          Left = 7.697650000000000000
          Top = 69.901670000000030000
          Width = 202.582560000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
        end
        object Line99: TfrxLineView
          Left = 456.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo226: TfrxMemoView
          Left = 453.921184170000000000
          Top = 69.901670000000030000
          Width = 281.499320000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo227: TfrxMemoView
          Left = 219.122854170000000000
          Top = 69.901670000000030000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
        end
        object Line100: TfrxLineView
          Left = 5.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line101: TfrxLineView
          Left = 749.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line102: TfrxLineView
          Left = 5.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line103: TfrxLineView
          Left = 5.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua5Via: TfrxMemoView
          Left = 6.897650000000000000
          Top = 90.708720000000030000
          Width = 215.433210000000000000
          Height = 11.338590000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
        end
      end
      object rlbTitulo5Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo229: TfrxMemoView
          Left = 327.050650000000000000
          Top = 21.397650000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
        end
        object Memo230: TfrxMemoView
          Left = 563.343290000000000000
          Top = 25.177180000000000000
          Width = 177.713420000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo231: TfrxMemoView
          Left = 534.897650000000000000
          Top = 25.177180000000000000
          Width = 26.759060000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'R$')
          ParentFont = False
        end
        object Memo232: TfrxMemoView
          Left = 6.697650000000000000
          Top = 42.177180000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
        end
        object Memo233: TfrxMemoView
          Left = 6.697650000000000000
          Top = 96.177180000000000000
          Width = 180.963760000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'A IMPORT'#194'NCIA ACIMA DE')
          ParentFont = False
        end
        object Memo234: TfrxMemoView
          Left = 6.697650000000000000
          Top = 116.177180000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
        end
        object Line104: TfrxLineView
          Left = 5.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line106: TfrxLineView
          Left = 5.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo241: TfrxMemoView
          Left = 460.097650000000000000
          Top = 78.870130000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CEPCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Line107: TfrxLineView
          Left = 5.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line108: TfrxLineView
          Left = 5.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line109: TfrxLineView
          Left = 749.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo242: TfrxMemoView
          Left = 189.853680000000000000
          Top = 96.177180000000000000
          Width = 551.811380000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
        end
        object Memo243: TfrxMemoView
          Left = 123.601670000000000000
          Top = 42.177180000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo244: TfrxMemoView
          Left = 123.601670000000000000
          Top = 61.531540000000000000
          Width = 619.842920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo245: TfrxMemoView
          Left = 577.153310000000000000
          Top = 78.870130000000000000
          Width = 166.299320000000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo195: TfrxMemoView
          Left = 5.897650000000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo196: TfrxMemoView
          Left = 101.746466460000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo228: TfrxMemoView
          Left = 133.897650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo235: TfrxMemoView
          Left = 182.297650000000000000
          Top = 138.177180000000000000
          Width = 43.464564490000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo236: TfrxMemoView
          Left = 236.162214490000000000
          Top = 138.177180000000000000
          Width = 67.275580790000010000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo237: TfrxMemoView
          Left = 308.562214490000000000
          Top = 138.177180000000000000
          Width = 63.496050790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Memo238: TfrxMemoView
          Left = 378.124421650000000000
          Top = 138.177180000000000000
          Width = 75.061410000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
        end
        object Memo239: TfrxMemoView
          Left = 474.140169690000000000
          Top = 138.177180000000000000
          Width = 34.620470000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
        end
        object Memo240: TfrxMemoView
          Left = 506.289775980000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
        end
        object Memo246: TfrxMemoView
          Left = 554.667728740000000000
          Top = 138.177180000000000000
          Width = 43.464566930000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
        end
        object Memo247: TfrxMemoView
          Left = 608.116547640000000000
          Top = 138.177180000000000000
          Width = 67.275580790000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
        end
        object Memo248: TfrxMemoView
          Left = 683.463004330000000000
          Top = 138.177180000000000000
          Width = 63.496062990000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
        end
        object Line105: TfrxLineView
          Left = 374.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo28: TfrxMemoView
          Left = 543.590910000000000000
          Top = 117.165430000000000000
          Width = 198.803030000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbCheques5Via: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 755.906000000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa5Via
        PrintChildIfInvisible = True
        object mmoCheques5Via: TfrxMemoView
          Left = 5.763779530000000000
          Width = 743.055118110000000000
          Height = 226.771653540000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
      end
    end
  end
  object cdsCadChq: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 72
    object cdsCadChqCHQ_CONCOR: TStringField
      FieldName = 'CHQ_CONCOR'
      Size = 12
    end
    object cdsCadChqCHQ_NUMCHQ: TStringField
      FieldName = 'CHQ_NUMCHQ'
      Size = 10
    end
    object cdsCadChqCHQ_NOMEMI: TStringField
      FieldName = 'CHQ_NOMEMI'
      Size = 40
    end
    object cdsCadChqCHQ_C_G_C_: TStringField
      FieldName = 'CHQ_C_G_C_'
      Size = 18
    end
    object cdsCadChqCHQ_DTAVEN: TDateField
      FieldName = 'CHQ_DTAVEN'
    end
    object cdsCadChqCHQ_VALCHQ: TFloatField
      FieldName = 'CHQ_VALCHQ'
    end
    object cdsCadChqCHQ_NUMAGE: TStringField
      FieldName = 'CHQ_NUMAGE'
      Size = 5
    end
  end
  object frxReciboColunaCtaReceber: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 45127.441827534700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    Left = 216
    Top = 264
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
    object Page1: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'rlbDetalheOnBeforePrint'
        Columns = 2
        ColumnWidth = 628.800000000000000000
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object rllCodVen: TfrxDMPMemoView
          Align = baLeft
          Left = 163.200000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."CODVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Align = baLeft
          Left = 220.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVEN"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllDtaRec: TfrxDMPMemoView
          Align = baLeft
          Left = 316.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          FontStyle = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAREC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllValDoc: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALDOC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Align = baLeft
          Left = 508.800000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."VALREC"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNumDoc: TfrxDMPMemoView
          Align = baLeft
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[frxRelatorio."NUMDOC"][frxRelatorio."PARCEL"]-[frxRelatorio."ES' +
              'PDOC"]-[frxRelatorio."CODEMP"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
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
      end
      object rlbCheques: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 221.000000000000000000
        Width = 1276.800000000000000000
        Child = frxReciboColunaCtaReceber.rlbEmpresa
        PrintChildIfInvisible = True
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        OnAfterPrint = 'rlbTituloOnAfterPrint'
        OnBeforePrint = 'rlbTituloOnBeforePrint'
        object Memo1: TfrxDMPMemoView
          Align = baCenter
          Left = 595.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo2: TfrxDMPMemoView
          Align = baRight
          Left = 1094.400000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[VALREC]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo3: TfrxDMPMemoView
          Align = baRight
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 28.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo4: TfrxDMPMemoView
          Align = baLeft
          Top = 34.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo5: TfrxDMPMemoView
          Align = baLeft
          Top = 85.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'A IMPORTANCIA ACIMA DE')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo7: TfrxDMPMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo8: TfrxDMPMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo9: TfrxDMPMemoView
          Align = baLeft
          Left = 163.200000000000000000
          Top = 136.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo10: TfrxDMPMemoView
          Align = baLeft
          Left = 220.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo11: TfrxDMPMemoView
          Align = baLeft
          Left = 316.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo12: TfrxDMPMemoView
          Align = baLeft
          Left = 412.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo13: TfrxDMPMemoView
          Align = baLeft
          Left = 508.800000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo22: TfrxDMPMemoView
          Align = baRight
          Left = 816.000000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[CEPCLI]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo6: TfrxDMPMemoView
          Align = baWidth
          Left = 230.400000000000000000
          Top = 85.000000000000000000
          Width = 1046.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[VALEXT]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo20: TfrxDMPMemoView
          Align = baWidth
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NOMCLI]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo21: TfrxDMPMemoView
          Align = baWidth
          Top = 51.000000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[ENDCLI]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo23: TfrxDMPMemoView
          Align = baRight
          Left = 912.000000000000000000
          Top = 51.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CIDCLI] - [ESTCLI]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo283: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 119.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baRight
          Left = 672.000000000000000000
          Top = 136.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Align = baRight
          Left = 825.600000000000000000
          Top = 136.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Align = baRight
          Left = 883.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'VENC')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Align = baRight
          Left = 979.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'REC')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Align = baRight
          Left = 1075.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOCUM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Align = baRight
          Left = 1171.200000000000000000
          Top = 136.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbEmpresa: TfrxChild
        FillType = ftBrush
        Height = 204.000000000000000000
        Top = 272.000000000000000000
        Width = 1276.800000000000000000
        object Memo34: TfrxDMPMemoView
          Align = baLeft
          Left = 585.600000000000000000
          Top = 68.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CIDADE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo35: TfrxDMPMemoView
          Align = baLeft
          Left = 806.400000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[DTAREC]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo36: TfrxDMPMemoView
          Align = baLeft
          Left = 86.400000000000000000
          Top = 68.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo37: TfrxDMPMemoView
          Align = baWidth
          Top = 85.000000000000000000
          Width = 1276.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[ENDERE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo38: TfrxDMPMemoView
          Align = baWidth
          Top = 102.000000000000000000
          Width = 1276.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[C_E_P_] - [CIDADE] - [ESTADO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo39: TfrxDMPMemoView
          Align = baLeft
          Top = 119.000000000000000000
          Width = 412.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo40: TfrxDMPMemoView
          Align = baLeft
          Top = 136.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[INSEST]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo41: TfrxDMPMemoView
          Left = 835.200000000000000000
          Top = 153.000000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[CODOPE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo24: TfrxDMPMemoView
          Align = baLeft
          Left = 201.600000000000000000
          Top = 136.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SEQCON]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllContinua: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 170.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          Visible = False
          FontStyle = []
          Memo.UTF8W = (
            'CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo249: TfrxDMPMemoView
          Align = baLeft
          Top = 68.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[CODEMP]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo251: TfrxDMPMemoView
          Align = baLeft
          Left = 76.800000000000000000
          Top = 68.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '-')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo269: TfrxDMPMemoView
          Align = baLeft
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'DINHEIRO: [DINHEIRO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo270: TfrxDMPMemoView
          Align = baLeft
          Left = 508.800000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHEQUE-PRE: [CHEPRE]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo271: TfrxDMPMemoView
          Align = baLeft
          Left = 211.200000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CHEQUE A VISTA: [CHEVIS]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo272: TfrxDMPMemoView
          Align = baLeft
          Top = 17.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CARTAO: [CARTAO]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllOrdRec: TfrxDMPMemoView
          Align = baLeft
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 307.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'ORDEM DE PGTO.: [ORDEM]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo274: TfrxDMPMemoView
          Align = baLeft
          Left = 499.200000000000000000
          Top = 17.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            'CREDITO UTILIZADO: [CREDITO]')
          ParentFont = False
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
    Left = 416
    Top = 272
  end
end
