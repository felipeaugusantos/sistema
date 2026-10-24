object frmCtrReciboAdiantamento: TfrmCtrReciboAdiantamento
  Left = 0
  Top = 0
  ClientHeight = 355
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object frxRelReciboColunaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41410.589098483800000000
    ReportOptions.LastChange = 44291.372744884300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      ''
      'begin'
      ''
      'end.')
    Left = 48
    Top = 104
    Datasets = <>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'rllValCre'
        Value = #39'CR'#201'DITO UTILIZADO: 0,00'#39
      end
      item
        Name = 'VALEXT'
        Value = #39'DUZENTOS E CINQUENTA E SEIS REAIS '#39
      end
      item
        Name = 'CIDADE'
        Value = #39'RIBEIRAO PRETO'#39
      end
      item
        Name = 'NOMEMP'
        Value = #39'TESTE EMPRESA'#39
      end
      item
        Name = 'INSEST'
        Value = #39'INSCRICAO ESTADUAL: 1212121212'#39
      end
      item
        Name = 'fltTotalRecebidoExt'
        Value = #39'DUZENTOS E CINQUENTA E SEIS REAIS '#39
      end
      item
        Name = 'rllValOrd'
        Value = #39'ORDEM DE PGTO: 0,00'#39
      end
      item
        Name = 'SEQCON'
        Value = #39'SEQ. BAIXA: 00000001'#39
      end
      item
        Name = 'NOMCLI'
        Value = #39'MARIA APARECIDA'#39
      end
      item
        Name = 'strDescriUsuarioLogado'
        Value = #39'WAGNER NEVES'#39
      end
      item
        Name = 'rllBaiEmp'
        Value = #39#39
      end
      item
        Name = 'ENDCLI'
        Value = #39'RUA TAMOIOS - '#39
      end
      item
        Name = 'VALREC'
        Value = #39'256'#39
      end
      item
        Name = 'rllValChp'
        Value = #39'CHEQUE-PR'#201': 0,00'#39
      end
      item
        Name = 'VS_strCodEmp'
        Value = #39'789'#39
      end
      item
        Name = 'LOGOTIPO'
        Value = #39'E:\Users\matheus.alacrino\Documentos\AutPas\logo.jpg'#39
      end
      item
        Name = 'C_E_P_'
        Value = #39'14000000'#39
      end
      item
        Name = 'rllValChv'
        Value = #39'CHEQUE '#193' VISTA: 0,00'#39
      end
      item
        Name = 'VS_Date'
        Value = #39'05/04/2021'#39
      end
      item
        Name = 'strEmpAcessoUsuarioLogado'
        Value = 
          #39'787_000_001_002_003_005_006_007_008_009_010_012_013_014_015_016' +
          '_017_018_020_021_022_023_025_027_028_029_030_033_040_041_100_101' +
          '_106_111_112_123_127_153_154_155_159_171_222_234_237_268_290_300' +
          '_301_302_321_333_363_444_456_500_513_531_532_533_555_556_559_600' +
          '_601_602_603_666_712_713_741_777_789_799_800_888_889_900_901_907' +
          '_950_969_987_994_998_999_'#39
      end
      item
        Name = 'CODEMP'
        Value = #39'789'#39
      end
      item
        Name = 'rllValDin'
        Value = #39'DINHEIRO: 0,00'#39
      end
      item
        Name = 'CIDCLI'
        Value = #39'RIBEIRAO PRETO'#39
      end
      item
        Name = 'strLoginUsuarioLogado'
        Value = #39'789'#39
      end
      item
        Name = 'CNPJ'
        Value = #39'CNPJ: 52.0421.010/0001'#39
      end
      item
        Name = 'DTAREC'
        Value = #39'05/04/2021'#39
      end
      item
        Name = 'CODOPE'
        Value = #39'998'#39
      end
      item
        Name = 'CEPCLI'
        Value = #39'14000000 - '#39
      end
      item
        Name = 'fltTotalRecebido'
        Value = #39'256'#39
      end
      item
        Name = 'rllValCar'
        Value = #39'CART'#195'O: 0,00'#39
      end
      item
        Name = 'CAIXA'
        Value = #39'TESTE CAIXA'#39
      end
      item
        Name = 'rllBaiPor'
        Value = #39#39
      end
      item
        Name = 'rllBaiOp'
        Value = #39#39
      end
      item
        Name = 'ESTADO'
        Value = #39'SP'#39
      end
      item
        Name = 'rllBaiHis'
        Value = #39#39
      end
      item
        Name = 'ESTCLI'
        Value = #39'SP'#39
      end
      item
        Name = 'ENDERE'
        Value = #39'ENDERECO EMPRESA, 175'#39
      end>
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
      RightMargin = 3.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object rllCodVen: TfrxMemoView
          Left = 127.448816460000000000
          Width = 19.653533540000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio1."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaVen: TfrxMemoView
          Left = 151.600000000000000000
          Width = 45.354330710000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio1."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllDtaRec: TfrxMemoView
          Left = 197.000000000000000000
          Width = 45.354330710000000000
          Height = 17.000000000000000000
          DataField = 'DTAREC'
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio1."DTAREC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDoc: TfrxMemoView
          Left = 244.329128980000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio1."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 318.618883000000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio1."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Line5: TfrxLineView
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllNumDoc: TfrxMemoView
          Left = 18.600000000000000000
          Width = 105.826776540000000000
          Height = 17.007874020000000000
          DataField = 'NUMDOC'
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio1."NUMDOC"]')
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
        Width = 761.575295000000000000
        Child = frxRelReciboColunaJ.rlbEmpresa
        PrintChildIfInvisible = True
        object mmoCheques: TfrxMemoView
          Left = 17.763779530000000000
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
          Left = 18.600000000000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboColunaJ.pagCheques
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 761.575295000000000000
        object Memo1: TfrxMemoView
          Left = 339.271120000000000000
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
          Left = 575.563760000000000000
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
          Left = 547.118120000000000000
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
          Left = 18.918120000000000000
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
          Left = 18.918120000000000000
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
          Left = 18.918120000000000000
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
          Left = 17.763779530000000000
          Top = 136.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 18.600000000000000000
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
          Left = 17.763779530000000000
          Top = 155.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 118.448816460000000000
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
          Left = 153.600000000000000000
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
          Left = 199.000000000000000000
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
          Left = 248.864564490000000000
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
          Left = 321.264564490000000000
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
          Left = 472.318120000000000000
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
          Left = 17.763779530000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 17.763779530000000000
          Top = 19.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Left = 761.196850390000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Left = 202.074150000000000000
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
          Left = 135.822140000000000000
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
          Left = 135.822140000000000000
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
          Left = 589.373780000000000000
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
          Left = 390.826771650000000000
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
          Left = 486.842519690000000000
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
          Left = 518.992125980000000000
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
          Left = 567.370078740000000000
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
          Left = 620.818897640000000000
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
          Left = 696.165354330000000000
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
          Left = 387.401574800000000000
          Top = 137.283550000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo283: TfrxMemoView
          Left = 551.811380000000000000
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
        Width = 761.575295000000000000
        Child = frxRelReciboColunaJ.rlbBaixa
        object Memo34: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 56.170130000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 119.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo41: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 140.976412130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 761.233070870000000000
          Height = 140.976377950000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 17.800000000000000000
          Top = 142.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua: TfrxMemoView
          Left = 19.697650000000000000
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
          Left = 19.677180000000000000
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
          Left = 46.472480000000000000
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
          Left = 18.519685040000000000
          Top = 24.456709999999990000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line122: TfrxLineView
          Left = 18.661410000000000000
          Top = 49.692949999999990000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllValDin: TfrxMemoView
          Left = 21.543307090000000000
          Top = 5.669291339999972000
          Width = 207.874015750000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllValDin]')
          ParentFont = False
          WordWrap = False
        end
        object rllValChv: TfrxMemoView
          Left = 301.897637800000000000
          Top = 5.669291339999972000
          Width = 207.874015750000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllValChv]')
          ParentFont = False
          WordWrap = False
        end
        object rllValChp: TfrxMemoView
          Left = 547.393700790000000000
          Top = 5.669291339999972000
          Width = 207.873998660000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllValChp]')
          ParentFont = False
          WordWrap = False
        end
        object rllValCar: TfrxMemoView
          Left = 21.543307090000000000
          Top = 29.858267720000010000
          Width = 207.874015750000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllValCar]')
          ParentFont = False
          WordWrap = False
        end
        object rllValOrd: TfrxMemoView
          Left = 301.897637800000000000
          Top = 29.858267720000010000
          Width = 207.874015750000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllValOrd]')
          ParentFont = False
          WordWrap = False
        end
        object rllValCre: TfrxMemoView
          Left = 547.393700790000000000
          Top = 29.858267720000010000
          Width = 207.874015750000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rllValCre]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbEmpresa2: TfrxChild
        FillType = ftBrush
        Height = 120.944960000000000000
        Top = 578.268090000000000000
        Width = 761.575295000000000000
        object Memo250: TfrxMemoView
          Left = 439.820504170000000000
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
          Left = 661.420504170000000000
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
          Left = 19.653543310000000000
          Top = 4.240260000000035000
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
          Left = 19.795300000000000000
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
          Left = 19.795300000000000000
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
          Left = 19.795300000000000000
          Top = 55.681199999999990000
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
          Left = 19.795300000000000000
          Top = 74.681200000000100000
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
          Left = 468.620504170000000000
          Top = 72.681200000000100000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo280: TfrxMemoView
          Left = 466.018834170000000000
          Top = 74.681200000000100000
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
          Left = 231.220504170000000000
          Top = 74.681200000000100000
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
          Left = 17.897650000000000000
          Top = 0.779530000000022500
          Height = 99.401582130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line125: TfrxLineView
          Left = 761.330720870000000000
          Top = 0.779530000000022500
          Height = 99.401577240000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line126: TfrxLineView
          Left = 17.897650000000000000
          Top = 101.244280000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line127: TfrxLineView
          Left = 17.897650000000000000
          Top = 0.779530000000022500
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo282: TfrxMemoView
          Left = 19.795300000000000000
          Top = 99.488250000000000000
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
      object rlbBaixa: TfrxChild
        FillType = ftBrush
        Height = 86.929190000000000000
        Top = 468.661720000000000000
        Width = 761.575295000000000000
        object Memo269: TfrxMemoView
          Left = 26.456710000000000000
          Top = 0.220469999999977500
          Width = 731.263390000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS BAIXA')
          ParentFont = False
        end
        object Memo270: TfrxMemoView
          Left = 25.000000000000000000
          Top = 18.897650000000000000
          Width = 449.763825910000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'EMPRESA...: [rllBaiEmp]')
          ParentFont = False
        end
        object Memo271: TfrxMemoView
          Left = 25.000000000000000000
          Top = 34.015769999999970000
          Width = 449.763825910000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'PORTADOR..: [rllBaiPor]')
          ParentFont = False
        end
        object Memo272: TfrxMemoView
          Left = 25.000000000000000000
          Top = 49.913420000000030000
          Width = 449.763825910000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'OPERADOR..: [rllBaiOp]')
          ParentFont = False
        end
        object Memo273: TfrxMemoView
          Left = 26.000000000000000000
          Top = 66.031540000000010000
          Width = 449.763825910000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'HIST'#211'RICO.: [rllBaiHis]')
          ParentFont = False
        end
        object Line130: TfrxLineView
          Left = 19.677180000000000000
          Top = 86.929190000000000000
          Width = 739.653540870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line128: TfrxLineView
          Left = 18.677180000000000000
          Top = 0.118119999999976200
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line129: TfrxLineView
          Left = 18.677180000000000000
          Top = 1.118119999999976000
          Height = 84.283462130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line131: TfrxLineView
          Left = 760.008350000000000000
          Height = 88.062957950000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
    end
    object pagRel2Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 3.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe2Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo64: TfrxMemoView
          Left = 18.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
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
          Left = 126.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 146.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 195.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAREC'
          DataSetName = 'frxRelatorio'
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
          Left = 244.157470560000000000
          Width = 71.811023620000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSetName = 'frxRelatorio'
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
          Left = 318.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSetName = 'frxRelatorio'
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques2Via: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 761.575295000000000000
        Child = frxRelReciboColunaJ.rlbEmpresa2Via
        PrintChildIfInvisible = True
        object mmoCheques2Via: TfrxMemoView
          Left = 17.763779530000000000
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
          Left = 18.897650000000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboColunaJ.pagCheques2Via
        end
      end
      object rlbEmpresa2Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 761.575295000000000000
        object Memo70: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo77: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line35: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line36: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua2Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo33: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line26: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo53: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line29: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo54: TfrxMemoView
          Left = 201.853680000000000000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 121.746466460000000000
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
          Left = 157.897650000000000000
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
          Left = 204.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo284: TfrxMemoView
          Left = 555.590910000000000000
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
      RightMargin = 3.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhe3Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo103: TfrxMemoView
          Left = 18.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
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
          Left = 124.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 146.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 195.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAREC'
          DataSetName = 'frxRelatorio'
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
          Left = 244.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSetName = 'frxRelatorio'
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
          Left = 318.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSetName = 'frxRelatorio'
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques3Via: TfrxFooter
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 241.889920000000000000
        Width = 761.575295000000000000
        Child = frxRelReciboColunaJ.rlbEmpresa3Via
        PrintChildIfInvisible = True
        object mmoCheques3Via: TfrxMemoView
          Left = 17.763779530000000000
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
          Left = 18.897637800000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboColunaJ.pagCheques3Via
        end
      end
      object rlbEmpresa3Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 761.575295000000000000
        object Memo109: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo116: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line55: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua3Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo119: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line58: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo131: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line60: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line61: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo132: TfrxMemoView
          Left = 201.853680000000000000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 118.746466460000000000
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
          Left = 154.897650000000000000
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
          Left = 200.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo285: TfrxMemoView
          Left = 555.590910000000000000
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
      RightMargin = 3.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe4Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo158: TfrxMemoView
          Left = 18.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
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
          Left = 126.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 146.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 195.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAREC'
          DataSetName = 'frxRelatorio'
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
          Left = 244.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSetName = 'frxRelatorio'
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
          Left = 318.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSetName = 'frxRelatorio'
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line74: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa4Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 761.575295000000000000
        object Memo164: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo171: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line77: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line78: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line79: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua4Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo174: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line82: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo186: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line84: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line85: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo187: TfrxMemoView
          Left = 201.853680000000000000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 119.746466460000000000
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
          Left = 151.897650000000000000
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
          Left = 200.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo286: TfrxMemoView
          Left = 555.590910000000000000
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
        Width = 761.575295000000000000
        Child = frxRelReciboColunaJ.rlbEmpresa4Via
        PrintChildIfInvisible = True
        object mmoCheques4Via: TfrxMemoView
          Left = 17.763779530000000000
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
          Left = 18.897637800000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboColunaJ.pagCheques4Via
        end
      end
    end
    object pagRel5Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 3.500000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        Columns = 2
        ColumnGap = 371.149606299213000000
        DataSetName = 'frxRelatorio'
        RowCount = 22
        object Memo213: TfrxMemoView
          Left = 18.600000000000000000
          Width = 105.826771650000000000
          Height = 17.000000000000000000
          DataField = 'NUMDOC'
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."NUMDOC"]')
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
          Left = 125.519685040000000000
          Width = 19.653543310000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSetName = 'frxRelatorio'
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
          Left = 146.645669290000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAVENC'
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DTAVENC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo216: TfrxMemoView
          Left = 195.023622050000000000
          Width = 47.244094490000000000
          Height = 17.000000000000000000
          DataField = 'DTAREC'
          DataSetName = 'frxRelatorio'
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
          Left = 244.157480310000000000
          Width = 71.811016300000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DataSetName = 'frxRelatorio'
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
          Left = 318.614173230000000000
          Width = 66.141732280000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DataSetName = 'frxRelatorio'
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line98: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa5Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 279.685220000000000000
        Width = 761.575295000000000000
        object Memo219: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
        object Line99: TfrxLineView
          Left = 468.522854170000000000
          Top = 67.901670000000000000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo226: TfrxMemoView
          Left = 465.921184170000000000
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
        object Memo227: TfrxMemoView
          Left = 231.122854170000000000
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
        object Line100: TfrxLineView
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line101: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line102: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line103: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua5Via: TfrxMemoView
          Left = 18.897650000000000000
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
      object rlbTitulo5Via: TfrxHeader
        FillType = ftBrush
        Height = 156.850393700000000000
        Top = 18.897650000000000000
        Width = 761.575295000000000000
        object Memo229: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line106: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo241: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line108: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line109: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo242: TfrxMemoView
          Left = 201.853680000000000000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 119.746466460000000000
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
          Left = 151.897650000000000000
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
          Left = 200.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo287: TfrxMemoView
          Left = 555.590910000000000000
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
        Width = 761.575295000000000000
        Child = frxRelReciboColunaJ.rlbEmpresa5Via
        PrintChildIfInvisible = True
        object mmoCheques5Via: TfrxMemoView
          Left = 17.763779530000000000
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
          Left = 18.897637800000000000
          Width = 94.488250000000000000
          Height = 13.606299210000000000
          Page = frxRelReciboColunaJ.pagCheques5Via
        end
      end
    end
    object pagCheques: TfrxReportPage
      Visible = False
      PaperWidth = 1290.000000000000000000
      PaperHeight = 310.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 10.000000000000000000
      ColumnPositions.Strings = (
        '0')
      object rlbChq: TfrxMasterData
        FillType = ftBrush
        Height = 13.606299210000000000
        Top = 75.590600000000000000
        Width = 4800.003100000000000000
        DataSetName = 'frxDataSetContasCheque'
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
          DataField = 'CHQ_NUMAGE'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_CONCOR'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_VALCHQ'
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NOMEMI'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_C_G_C_'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_C_G_C_"]')
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
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbHdChq: TfrxHeader
        FillType = ftBrush
        Height = 34.771653540000000000
        Top = 18.897650000000000000
        Width = 4800.003100000000000000
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
        Width = 4800.003100000000000000
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
      PaperHeight = 35.000000000000000000
      PaperSize = 256
      object rlbFtChq2Via: TfrxFooter
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 113.385900000000000000
        Width = 793.701300000000000000
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
        Width = 793.701300000000000000
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
        Width = 793.701300000000000000
        DataSetName = 'frxDataSetContasCheque'
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
          DataField = 'CHQ_NUMAGE'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo80: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_CONCOR'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo81: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo82: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_VALCHQ'
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo83: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NOMEMI'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo84: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_C_G_C_'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_C_G_C_"]')
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
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagCheques3Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 35.000000000000000000
      PaperSize = 256
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
        DataSetName = 'frxDataSetContasCheque'
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
          DataField = 'CHQ_NUMAGE'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo152: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_CONCOR'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo153: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo154: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_VALCHQ'
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo155: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NOMEMI'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo156: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_C_G_C_'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_C_G_C_"]')
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
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagCheques4Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 35.000000000000000000
      PaperSize = 256
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
        DataSetName = 'frxDataSetContasCheque'
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
          DataField = 'CHQ_NUMAGE'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo207: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_CONCOR'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo208: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo209: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_VALCHQ'
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo210: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NOMEMI'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo211: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_C_G_C_'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_C_G_C_"]')
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
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
    object pagCheques5Via: TfrxReportPage
      Visible = False
      PaperWidth = 210.000000000000000000
      PaperHeight = 35.000000000000000000
      PaperSize = 256
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
        DataSetName = 'frxDataSetContasCheque'
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
          DataField = 'CHQ_NUMAGE'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo262: TfrxMemoView
          Left = 60.440942440000000000
          Width = 84.661410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_CONCOR'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo263: TfrxMemoView
          Left = 147.930715980000000000
          Width = 94.261410000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo264: TfrxMemoView
          Left = 332.807895980000000000
          Top = 0.000000010000000002
          Width = 102.122820000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_VALCHQ'
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo265: TfrxMemoView
          Left = 439.530715980000000000
          Width = 180.359060000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_NOMEMI'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo266: TfrxMemoView
          Left = 622.330715980000000000
          Width = 116.107050000000000000
          Height = 13.220470000000000000
          DataField = 'CHQ_C_G_C_'
          DataSetName = 'frxDataSetContasCheque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CGCCPF"]')
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
          DataSetName = 'frxDataSetContasCheque'
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
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
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = True
    Left = 258
    Top = 17
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Transparency = False
    Author = 'Citel Software'
    Subject = 'FastReport PDF export'
    Creator = 'Citel Software'
    ProtectionFlags = [eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = True
    Left = 344
    Top = 16
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
    ReportOptions.LastChange = 44291.432950706020000000
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
    Left = 48
    Top = 160
    Datasets = <
      item
      end
      item
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
      RightMargin = 3.500000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'rlbDetalheOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        RowCount = 22
        object rllCodVen: TfrxMemoView
          Left = 117.448816460000000000
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
          Left = 150.600000000000000000
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
          Left = 197.000000000000000000
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
          Left = 244.329128980000000000
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
          Left = 318.618883000000000000
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object rllNumDoc: TfrxMemoView
          Left = 17.763779530000000000
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
        Width = 761.575295000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa
        PrintChildIfInvisible = True
        object mmoCheques: TfrxMemoView
          Left = 17.763779530000000000
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
        Width = 761.575295000000000000
        object Memo34: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo41: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.763779530000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line21: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua: TfrxMemoView
          Left = 19.697650000000000000
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
        Width = 761.575295000000000000
        object Memo1: TfrxMemoView
          Left = 339.271120000000000000
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
          Left = 575.563760000000000000
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
          Left = 547.118120000000000000
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
          Left = 18.918120000000000000
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
          Left = 18.918120000000000000
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
          Left = 18.918120000000000000
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
          Left = 17.763779530000000000
          Top = 136.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo8: TfrxMemoView
          Left = 18.600000000000000000
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
          Left = 17.763779530000000000
          Top = 155.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo9: TfrxMemoView
          Left = 115.448816460000000000
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
          Left = 150.600000000000000000
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
          Left = 197.000000000000000000
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
          Left = 248.864564490000000000
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
          Left = 321.264564490000000000
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
          Left = 472.318120000000000000
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
          Left = 17.763779530000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 17.763779530000000000
          Top = 19.897650000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line9: TfrxLineView
          Left = 761.196850390000000000
          Top = 20.897650000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo6: TfrxMemoView
          Left = 202.074150000000000000
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
          Left = 135.822140000000000000
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
          Left = 135.822140000000000000
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
          Left = 589.373780000000000000
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
          Left = 390.826771650000000000
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
          Left = 486.842519690000000000
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
          Left = 518.992125980000000000
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
          Left = 567.370078740000000000
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
          Left = 620.818897640000000000
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
          Left = 696.165354330000000000
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
          Left = 387.401574800000000000
          Top = 137.283550000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo283: TfrxMemoView
          Left = 555.590910000000000000
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
      RightMargin = 3.500000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe2Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'rlbDetalhe2ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        RowCount = 22
        object Memo64: TfrxMemoView
          Left = 18.600000000000000000
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
          Left = 114.519685040000000000
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
          Left = 146.645669290000000000
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
          Left = 195.023622050000000000
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
          Left = 244.157470560000000000
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
          Left = 318.614173230000000000
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line31: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques2Via: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 761.575295000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa2Via
        PrintChildIfInvisible = True
        object mmoCheques2Via: TfrxMemoView
          Left = 17.763779530000000000
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
        Width = 761.575295000000000000
        object Memo70: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo77: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.763779530000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line34: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line35: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line36: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua2Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo33: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
          Top = 96.177180000000010000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line26: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo53: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line28: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line29: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo54: TfrxMemoView
          Left = 201.853680000000000000
          Top = 96.177180000000010000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
          Top = 61.531540000000010000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 113.746466460000000000
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
          Left = 194.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo25: TfrxMemoView
          Left = 555.590910000000000000
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
      RightMargin = 3.500000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhe3Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'rlbDetalhe3ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        RowCount = 22
        object Memo103: TfrxMemoView
          Left = 18.600000000000000000
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
          Left = 114.519685040000000000
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
          Left = 146.645669290000000000
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
          Left = 195.023622050000000000
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
          Left = 244.157480310000000000
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
          Left = 318.614173230000000000
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line50: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbCheques3Via: TfrxFooter
        FillType = ftBrush
        Height = 226.771653540000000000
        Top = 241.889920000000000000
        Width = 761.575295000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa3Via
        PrintChildIfInvisible = True
        object mmoCheques3Via: TfrxMemoView
          Left = 17.763779530000000000
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
        Width = 761.575295000000000000
        object Memo109: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo116: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line53: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line54: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line55: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua3Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo119: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
          Top = 96.177180000000010000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line58: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo131: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line60: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line61: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo132: TfrxMemoView
          Left = 201.853680000000000000
          Top = 96.177180000000010000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
          Top = 61.531540000000010000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 113.746466460000000000
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
        object Memo127: TfrxMemoView
          Left = 194.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo26: TfrxMemoView
          Left = 555.590910000000000000
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
      RightMargin = 3.500000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      PrintOnPreviousPage = True
      object rlbDetalhe4Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'rlbDetalhe4ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        RowCount = 22
        object Memo158: TfrxMemoView
          Left = 18.600000000000000000
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
          Left = 114.519685040000000000
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
          Left = 146.645669290000000000
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
          Left = 195.023622050000000000
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
          Left = 244.157480310000000000
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
          Left = 318.614173230000000000
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line74: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa4Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 491.338900000000000000
        Width = 761.575295000000000000
        object Memo164: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo171: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line77: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line78: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line79: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua4Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo174: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
          Top = 96.177180000000010000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line82: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo186: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line84: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line85: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo187: TfrxMemoView
          Left = 201.853680000000000000
          Top = 96.177180000000010000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
          Top = 61.531540000000010000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 113.746466460000000000
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
        object Memo181: TfrxMemoView
          Left = 194.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 555.590910000000000000
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
        Width = 761.575295000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa4Via
        PrintChildIfInvisible = True
        object mmoCheques4Via: TfrxMemoView
          Left = 17.763779530000000000
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
      RightMargin = 3.500000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 10.000000000000000000
      object rlbDetalhe5Via: TfrxMasterData
        FillType = ftBrush
        Height = 17.385826770000000000
        Top = 200.315090000000000000
        Width = 761.575295000000000000
        OnBeforePrint = 'rlbDetalhe5ViaOnBeforePrint'
        Columns = 2
        ColumnGap = 371.149606299213000000
        RowCount = 22
        object Memo213: TfrxMemoView
          Left = 17.820470000000000000
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
          Left = 114.519685040000000000
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
          Left = 146.645669290000000000
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
          Left = 195.023622050000000000
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
          Left = 244.157480310000000000
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
          Left = 318.614173230000000000
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
          Left = 761.233070870000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line98: TfrxLineView
          Left = 17.800000000000000000
          Height = 17.385826770000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
      object rlbEmpresa5Via: TfrxChild
        FillType = ftBrush
        Height = 102.047244090000000000
        Top = 491.338900000000000000
        Width = 761.575295000000000000
        object Memo219: TfrxMemoView
          Left = 439.722854170000000000
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
          Left = 661.322854170000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 19.697650000000000000
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
          Left = 468.522854170000000000
          Top = 67.901670000000030000
          Width = 276.132220000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo226: TfrxMemoView
          Left = 465.921184170000000000
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
          Left = 231.122854170000000000
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
          Left = 17.800000000000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line101: TfrxLineView
          Left = 761.233070870000000000
          Height = 88.062992130000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line102: TfrxLineView
          Left = 17.800000000000000000
          Top = 88.464750000000040000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line103: TfrxLineView
          Left = 17.800000000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object rllContinua5Via: TfrxMemoView
          Left = 18.897650000000000000
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
        Width = 761.575295000000000000
        object Memo229: TfrxMemoView
          Left = 339.050650000000000000
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
          Left = 575.343290000000000000
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
          Left = 546.897650000000000000
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
          Left = 18.697650000000000000
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
          Left = 18.697650000000000000
          Top = 96.177180000000010000
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
          Left = 18.697650000000000000
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
          Left = 17.897650000000000000
          Top = 136.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line106: TfrxLineView
          Left = 17.897650000000000000
          Top = 155.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo241: TfrxMemoView
          Left = 472.097650000000000000
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
          Left = 17.897650000000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line108: TfrxLineView
          Left = 17.897650000000000000
          Top = 19.677180000000000000
          Width = 743.433070870000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line109: TfrxLineView
          Left = 761.330720870000000000
          Top = 20.677180000000000000
          Height = 134.173228350000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo242: TfrxMemoView
          Left = 201.853680000000000000
          Top = 96.177180000000010000
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
          Left = 135.601670000000000000
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
          Left = 135.601670000000000000
          Top = 61.531540000000010000
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
          Left = 589.153310000000000000
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
          Left = 17.897650000000000000
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
          Left = 113.746466460000000000
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
        object Memo235: TfrxMemoView
          Left = 194.297650000000000000
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
          Left = 248.162214490000000000
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
          Left = 320.562214490000000000
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
          Left = 390.124421650000000000
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
          Left = 486.140169690000000000
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
          Left = 518.289775980000000000
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
          Left = 566.667728740000000000
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
          Left = 620.116547640000000000
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
          Left = 695.463004330000000000
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
          Left = 386.699224800000000000
          Top = 137.063080000000000000
          Height = 18.881880000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Memo28: TfrxMemoView
          Left = 555.590910000000000000
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
        Width = 761.575295000000000000
        Child = frxRelReciboSemChqJ.rlbEmpresa5Via
        PrintChildIfInvisible = True
        object mmoCheques5Via: TfrxMemoView
          Left = 17.763779530000000000
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
  object frxReciboLinhaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 44291.686660011580000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure fooChePreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  chiCabec.Visible := False;                                    ' +
        '  '
      'end;'
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    Left = 152
    Top = 104
    Datasets = <
      item
      end
      item
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 75.543290000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        Child = frxReciboLinhaJ.chiCabec
        object rllNomEmp: TfrxMemoView
          Align = baCenter
          Left = 113.575140000000000000
          Top = 17.000000000000000000
          Width = 528.755720000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
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
        object rllNumPag: TfrxMemoView
          Left = 664.771490000000000000
          Top = 17.000000000000000000
          Width = 36.434570000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'PAG.')
          ParentFont = False
        end
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 262.904330000000000000
          Top = 34.000000000000000000
          Width = 230.097340000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          ParentFont = False
        end
        object rllDtaEmi: TfrxMemoView
          Left = 623.130550000000000000
          Top = 34.000000000000000000
          Width = 76.875510000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [frxDataset."DTAREC"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 702.944650000000000000
          Top = 34.000000000000000000
          Width = 48.302350000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            ' [frxDataset."HORREC"]')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          Left = 732.047000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 724.447000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '/')
          ParentFont = False
        end
        object Page: TfrxMemoView
          Left = 703.247000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          ParentFont = False
        end
        object Memo44: TfrxMemoView
          Left = 522.795610000000000000
          Top = 34.000000000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[RECEBIDO]')
          ParentFont = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 253.228510000000000000
        Width = 755.906000000000000000
        RowCount = 0
        object rllDtaVen: TfrxMemoView
          Left = 438.963760000000000000
          Top = 1.000000000000000000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DisplayFormat.FormatStr = 'dd/mm/yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DTAVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDup: TfrxMemoView
          Left = 502.070810000000000000
          Top = 1.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DataField = 'VALDOC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValDes: TfrxMemoView
          Left = 568.916450000000000000
          Top = 1.000000000000000000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DataField = 'VALDES'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDES"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValJur: TfrxMemoView
          Left = 626.762090000000000000
          Top = 1.000000000000000000
          Width = 60.472443390000000000
          Height = 13.220470000000000000
          DataField = 'VALJUR'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALJUR"]')
          ParentFont = False
          WordWrap = False
        end
        object rllValRec: TfrxMemoView
          Left = 690.780890000000000000
          Top = 1.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DataField = 'VALREC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALREC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo6: TfrxMemoView
          Left = 338.159060000000000000
          Top = 1.000000000000000000
          Width = 97.889785750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."NUMDOC"][frxDataset."PARCEL"]-[frxDataset."ESPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo41: TfrxMemoView
          Left = 273.905690000000000000
          Top = 1.000000000000000000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODVEN"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo42: TfrxMemoView
          Left = 306.141930000000000000
          Top = 1.000000000000000000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo43: TfrxMemoView
          Left = 77.472480000000000000
          Top = 1.000000000000000000
          Width = 116.787435750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."CODCTA"] - [frxDataset."DESCTA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo45: TfrxMemoView
          Left = 3.600000000000000000
          Top = 1.000000000000000000
          Width = 71.433075750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[PLANO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo49: TfrxMemoView
          Left = 196.299320000000000000
          Top = 1.000000000000000000
          Width = 75.212598430000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."NOSNUM"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Height = 18.881880000000000000
        Top = 211.653680000000000000
        Width = 755.906000000000000000
        Condition = 'frxDataset."DESCRI"'
        Stretched = True
        object rllHist01: TfrxMemoView
          Left = 3.600000000000000000
          Top = 3.000000000000000000
          Width = 710.022140000000000000
          Height = 13.220470000000000000
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDataset."DESCRI"][NOMECLI]')
          ParentFont = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Height = 69.866110000000000000
        Top = 377.953000000000000000
        Width = 755.906000000000000000
        Child = frxReciboLinhaJ.chiAssinatura
        PrintChildIfInvisible = True
        object rllTotValRec: TfrxMemoView
          Left = 688.780890000000000000
          Top = 7.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[SUM(<frxDataset."VALREC">,rlbMaster,2)]')
          ParentFont = False
          WordWrap = False
        end
        object Memo2: TfrxMemoView
          Left = 78.999631420000000000
          Top = 22.220469999999980000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[FLTDINHEI]')
          ParentFont = False
          WordWrap = False
        end
        object Memo5: TfrxMemoView
          Left = 619.472465350000000000
          Top = 7.000000000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 10.968135350000000000
          Top = 22.220469999999980000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[DINHEIRO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          Left = 79.377672050000000000
          Top = 41.897650000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[FLTCARTAO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          Left = 11.346175980000000000
          Top = 41.897650000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[CARTAO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo10: TfrxMemoView
          Left = 375.181099920000000000
          Top = 22.220469999999980000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[FLTCHQVIS]')
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 305.149603860000000000
          Top = 22.220469999999980000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            'CHQ.VISTA:')
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 688.203340000000000000
          Top = 22.220469999999980000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[FLTCHQPRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo19: TfrxMemoView
          Left = 617.137230000000000000
          Top = 22.220469999999980000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[CHQPRE]')
          ParentFont = False
          WordWrap = False
        end
        object Memo20: TfrxMemoView
          Left = 376.669450000000000000
          Top = 41.897650000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[FLTORDPAG]')
          ParentFont = False
          WordWrap = False
        end
        object Memo21: TfrxMemoView
          Left = 280.300990000000000000
          Top = 41.897650000000000000
          Width = 90.330725750000000000
          Height = 13.220470000000000000
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
            '[ORDEM]')
          ParentFont = False
          WordWrap = False
        end
        object Line1: TfrxLineView
          Align = baLeft
          Top = 3.779530000000022000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          Align = baLeft
          Top = 37.795300000000000000
          Width = 755.906000000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo46: TfrxMemoView
          Left = 558.811380000000000000
          Top = 37.795300000000000000
          Width = 124.346495750000000000
          Height = 13.220470000000000000
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
            '[CREDITO]')
          ParentFont = False
          WordWrap = False
        end
        object Memo47: TfrxMemoView
          Left = 688.094930000000000000
          Top = 37.795300000000000000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
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
            '[FLTCREDITO]')
          ParentFont = False
          WordWrap = False
        end
      end
      object chiAssinatura: TfrxChild
        FillType = ftBrush
        Height = 68.031540000000000000
        Top = 472.441250000000000000
        Width = 755.906000000000000000
        PrintChildIfInvisible = True
        object Memo22: TfrxMemoView
          Left = 7.559060000000000000
          Top = 22.692928030000020000
          Width = 320.654730000000000000
          Height = 17.000000000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[STROPERAD]:_____________________________________')
          ParentFont = False
        end
        object rllSeqBaixa: TfrxMemoView
          Left = 585.428200000000000000
          Top = 22.692928030000020000
          Width = 163.880210000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 333.132530000000000000
          Top = 22.677180000000020000
          Width = 247.029870000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPERADOR1]')
          ParentFont = False
        end
        object Memo50: TfrxMemoView
          Left = 7.559060000000000000
          Top = 42.354359999999990000
          Width = 318.840940000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[CAIXA]')
          ParentFont = False
        end
      end
      object fooChePre: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 294.803340000000000000
        Width = 755.906000000000000000
        OnBeforePrint = 'fooChePreOnBeforePrint'
        object subChePre: TfrxSubreport
          Left = 1.000000000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Page = frxReciboLinhaJ.pagChePre
        end
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 34.015770000000000000
        Top = 117.165430000000000000
        Width = 755.906000000000000000
        object Shape1: TfrxShapeView
          Left = 2.000000000000000000
          Top = 1.031540000000007000
          Width = 752.126470000000000000
          Height = 26.456710000000000000
          Fill.BackColor = clSilver
        end
        object Memo12: TfrxMemoView
          Left = 3.426840000000000000
          Top = 1.000000000000000000
          Width = 146.872170000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[DESCRICAO]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 438.963760000000000000
          Top = 14.000000000000020000
          Width = 60.094485750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VENC]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 502.070810000000000000
          Top = 14.000000000000020000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOC.')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 568.916450000000100000
          Top = 14.000000000000020000
          Width = 56.692913390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DESC.')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 626.762090000000000000
          Top = 14.000000000000020000
          Width = 60.472443390000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[JUROS]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 689.607730000000000000
          Top = 14.000000000000020000
          Width = 63.874015750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. REC.')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 338.159060000000000000
          Top = 14.000000000000020000
          Width = 97.889785750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'DOCUMEN.')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 306.141930000000000000
          Top = 13.999999999999980000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[EMP]')
          ParentFont = False
        end
        object Memo40: TfrxMemoView
          Left = 273.937032280000000000
          Top = 13.999999999999980000
          Width = 29.858245750000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'VEN')
          ParentFont = False
        end
        object Memo48: TfrxMemoView
          Left = 196.299320000000000000
          Top = 14.000000000000020000
          Width = 75.212605750000000000
          Height = 13.220470000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'NOSSO NUM.')
          ParentFont = False
        end
      end
    end
    object pagChePre: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 20.787404020000000000
        ParentFont = False
        Top = 64.252010000000000000
        Width = 755.906000000000000000
        RowCount = 0
        object frxChePrefrxChePre: TfrxMemoView
          Left = 3.000000000000000000
          Top = 1.000000000000000000
          Width = 42.330701340000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          WordWrap = False
        end
        object Memo34: TfrxMemoView
          Left = 47.622047240000000000
          Top = 1.000000000000000000
          Width = 83.905494720000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          WordWrap = False
        end
        object Memo35: TfrxMemoView
          Left = 135.685039370000000000
          Top = 1.000000000000000000
          Width = 99.023578110000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          WordWrap = False
        end
        object Memo36: TfrxMemoView
          Left = 393.448818900000000000
          Top = 1.000000000000000000
          Width = 170.834601730000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          WordWrap = False
        end
        object Memo37: TfrxMemoView
          Left = 567.307086610000000000
          Top = 1.000000000000000000
          Width = 144.378011340000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_C_G_C_"]')
          WordWrap = False
        end
        object Memo38: TfrxMemoView
          Left = 238.488188980000000000
          Top = 1.000000000000000000
          Width = 72.566919370000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          WordWrap = False
        end
        object Memo39: TfrxMemoView
          Left = 314.078740160000000000
          Top = 1.000000000000000000
          Width = 76.346427400000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxChePre."CHQ_VALCHQ"]')
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 109.606370000000000000
        Width = 755.906000000000000000
        object Line4: TfrxLineView
          Left = 2.000000000000000000
          Top = 3.779530000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo26: TfrxMemoView
          Left = 2.000000000000000000
          Top = 7.559060000000000000
          Width = 570.709030000000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[COMPENSACAO]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          Left = 2.000000000000000000
          Top = 27.236240000000000000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        ReprintOnNewPage = True
        object Memo25: TfrxMemoView
          Left = 2.000000000000000000
          Width = 714.331170000000000000
          Height = 17.007849610000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop, ftBottom]
          Fill.BackColor = clSilver
        end
        object Memo27: TfrxMemoView
          Left = 3.000000000000000000
          Top = 1.779530000000000000
          Width = 42.330708660000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'AG'#202'N.')
          ParentFont = False
          WordWrap = False
        end
        object Memo28: TfrxMemoView
          Left = 135.866144170000000000
          Top = 1.779529999999994000
          Width = 99.023622050000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#218'M. CHEQUE')
          ParentFont = False
          WordWrap = False
        end
        object Memo29: TfrxMemoView
          Left = 393.630180000000000000
          Top = 1.779529999999994000
          Width = 170.985900000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
          WordWrap = False
        end
        object Memo30: TfrxMemoView
          Left = 567.488560000000000000
          Top = 1.779530000000000000
          Width = 148.308720000000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[CNPJ]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 238.669450000000000000
          Top = 1.779530000000000000
          Width = 72.566929130000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[VENC]')
          ParentFont = False
          WordWrap = False
        end
        object Memo32: TfrxMemoView
          Left = 314.259844960000000000
          Top = 1.779529999999994000
          Width = 76.346456690000000000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          WordWrap = False
        end
        object Memo33: TfrxMemoView
          Left = 47.803152050000000000
          Top = 1.779529999999994000
          Width = 83.905511809999990000
          Height = 13.220470000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxReciboLinhaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Compressed = True
    ReportOptions.CreateDate = 39910.392387326400000000
    ReportOptions.LastChange = 42331.390527905100000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure fooChePreOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  chiCabec.Visible := False;  '
      'end;'
      ''
      ''
      'begin'
      'end.')
    OnStartReport = 'frxReciboMOnStartReport'
    Left = 150
    Top = 31
    Datasets = <
      item
      end
      item
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Pagina: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object rlbHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        Child = frxReciboLinhaM.chiCabec
        object rllNomEmp: TfrxDMPMemoView
          Align = baCenter
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 816.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          TruncOutboundText = False
        end
        object rllNumPag: TfrxDMPMemoView
          Left = 1056.000000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'PAGINA')
          TruncOutboundText = False
        end
        object rllNomRel: TfrxDMPMemoView
          Align = baCenter
          Left = 297.600000000000000000
          Top = 34.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[RELACAO]')
          TruncOutboundText = False
        end
        object rllDtaEmi: TfrxDMPMemoView
          Left = 1017.600000000000000000
          Top = 34.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."DTAREC"]')
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 1180.800000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."HORREC"]')
          TruncOutboundText = False
        end
        object TotalPages: TfrxDMPMemoView
          Left = 1248.000000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[TotalPages#]')
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 1238.400000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '/')
          TruncOutboundText = False
        end
        object Page: TfrxDMPMemoView
          Left = 1219.200000000000000000
          Top = 17.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 844.800000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[RECEBIDO]')
          TruncOutboundText = False
        end
      end
      object rlbMaster: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 221.000000000000000000
        Width = 1276.800000000000000000
        RowCount = 0
        object rllDtaVen: TfrxDMPMemoView
          Left = 768.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = 'dd/MM/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxDataset."DTAVEN"]')
          TruncOutboundText = False
        end
        object rllValDup: TfrxDMPMemoView
          Left = 854.400000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDOC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDOC"]')
          TruncOutboundText = False
        end
        object rllValDes: TfrxDMPMemoView
          Left = 969.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'VALDES'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALDES"]')
          TruncOutboundText = False
        end
        object rllValJur: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DataField = 'VALJUR'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALJUR"]')
          TruncOutboundText = False
        end
        object rllValRec: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataField = 'VALREC'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataset."VALREC"]')
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 585.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."NUMDOC"][frxDataset."PARCEL"]-[frxDataset."ESPDOC"]')
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODVEN"]')
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODEMP"]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxDataset."CODCTA"] - [frxDataset."DESCTA"]')
          TruncOutboundText = False
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[PLANO]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDataset."NOSNUM"]')
          TruncOutboundText = False
        end
      end
      object GroupHeaderDocs: TfrxGroupHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 187.000000000000000000
        Width = 1276.800000000000000000
        Condition = 'frxDataset."DESCRI"'
        Stretched = True
        object rllHist01: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 1257.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          Memo.UTF8W = (
            '[frxDataset."DESCRI"][NOMECLI]')
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
      end
      object ReportSummaryDocs: TfrxReportSummary
        FillType = ftBrush
        Height = 119.000000000000000000
        Top = 306.000000000000000000
        Width = 1276.800000000000000000
        Child = frxReciboLinhaM.chiAssinatura
        PrintChildIfInvisible = True
        object rllTotValRec: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 17.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDataset."VALREC">,rlbMaster,2)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = -9.600000000000000000
          Top = 17.000000000000000000
          Width = 1142.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = -4.800000000000000000
          Top = 93.500000000000000000
          Width = 979.200000000000000000
          Color = clBlack
        end
        object rllValDin: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[rllValDin]')
          TruncOutboundText = False
        end
        object rllValChv: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 34.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[rllValChv]')
          TruncOutboundText = False
        end
        object rllValChp: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 34.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[rllValChp]')
          TruncOutboundText = False
        end
        object rllValCar: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[rllValCar]')
          TruncOutboundText = False
        end
        object rllValOrd: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 68.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[rllValOrd]')
          TruncOutboundText = False
        end
        object rllValCre: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 68.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[rllValCre]')
          TruncOutboundText = False
        end
      end
      object chiAssinatura: TfrxChild
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 442.000000000000000000
        Width = 1276.800000000000000000
        PrintChildIfInvisible = True
        object rllRiscoAssinatura: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[STROPERAD]')
          TruncOutboundText = False
        end
        object rllSeqBaixa: TfrxDMPMemoView
          Left = 1084.800000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          TruncOutboundText = False
        end
        object rllOperador: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[OPERADOR1]')
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 34.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[CAIXA]')
          TruncOutboundText = False
        end
      end
      object fooChePre: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 255.000000000000000000
        Width = 1276.800000000000000000
        OnBeforePrint = 'fooChePreOnBeforePrint'
        AllowSplit = True
        Stretched = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxReciboLinhaM.pagChePre
        end
      end
      object chiCabec: TfrxChild
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 85.000000000000000000
        Width = 1276.800000000000000000
        object DMPMemo12: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 1257.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[DESCRICAO]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 854.400000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DOCUM.')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. DESC.')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1065.600000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[JUROS]')
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 1161.600000000000000000
          Top = 34.000000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VL. REC.')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 585.600000000000000000
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'DOCUMENTO')
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[EMP]')
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 489.600000000000000000
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'VEN')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            'NOSSO NUMER.')
          TruncOutboundText = False
        end
      end
    end
    object pagChePre: TfrxDMPPage
      PaperWidth = 337.819781824724200000
      PaperHeight = 134.937412852920900000
      PaperSize = 256
      FontStyle = []
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 119.000000000000000000
        Width = 1248.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 556.799999999999900000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[COMPENSACAO]')
          TruncOutboundText = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 1276.800000000000000000
        RowCount = 0
        object frxChePreCHQ_NUMAGE: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMAGE'
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_CONCOR: TfrxDMPMemoView
          Left = 67.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_NUMCHQ: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMCHQ'
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_DTAVEN: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_DTAVEN'
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_VALCHQ: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxChePre."CHQ_VALCHQ"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_NOMEMI: TfrxDMPMemoView
          Left = 528.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NOMEMI'
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          TruncOutboundText = False
        end
        object frxChePreCHQ_C_G_C_: TfrxDMPMemoView
          Left = 921.600000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_C_G_C_'
          Memo.UTF8W = (
            '[frxChePre."CHQ_C_G_C_"]')
          TruncOutboundText = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 1276.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo36: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGEN.')
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
        object DMPMemo37: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C. CORRENTE')
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          Left = 528.000000000000000000
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMITENTE')
          TruncOutboundText = False
        end
        object DMPMemo40: TfrxDMPMemoView
          Left = 921.600000000000000000
          Top = 17.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CNPJ]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 1248.000000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxRelReciboBobina: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 39708.728873877300000000
    ReportOptions.LastChange = 44292.344855729160000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 155
    Top = 161
    Datasets = <
      item
        DataSet = frxAuxiliar
        DataSetName = 'frxAuxiliar'
      end
      item
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
      end
      item
        DataSet = frxChePre
        DataSetName = 'frxChePre'
      end
      item
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pagRelatorio: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549700000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object Titulo: TfrxReportTitle
        FillType = ftBrush
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 153.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."NOMCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Top = 153.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CLIENTE:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 136.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CODCLI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo6: TfrxDMPMemoView
          Top = 136.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CODIGO.:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[TELEFONE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[ENDERECO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[CIDADE]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#80'
        end
      end
      object Cabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 204.000000000000000000
        Width = 384.000000000000000000
        object DMPMemo7: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'DOCUMENTO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.DOCUM')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.RECEB')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[DESCRICAO]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[EMP]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo47: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'VENDEDOR')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo49: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'CADASTRO')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo51: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 34.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VR.JUR')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Detalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 340.000000000000000000
        Width = 384.000000000000000000
        Child = frxRelReciboBobina.Child1
        RowCount = 0
        Stretched = True
        object DMPMemo16: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            
              '[Trim(<frxRecibo."NUMDOC">)][Trim(<frxRecibo."PARCEL">)]-[Trim(<' +
              'frxRecibo."ESPDOC">)]-[Trim(<frxRecibo."SEQBAI">)]')
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
        object DMPMemo17: TfrxDMPMemoView
          Left = 153.600000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo18: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."VALDOC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 307.200000000000000000
          Top = 17.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."VALREC"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CODEMP"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Top = 51.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smActualHeight
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo48: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."CODVEN"]-[fRetNomVendRep(<frxRecibo."CODVEN">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo50: TfrxDMPMemoView
          Left = 48.000000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."DTACAD"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo52: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRecibo."VALJUR"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Rodape: TfrxFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 476.000000000000000000
        Width = 384.000000000000000000
        Child = frxRelReciboBobina.chiAvisoCheque
        PrintChildIfInvisible = True
        object DMPMemo22: TfrxDMPMemoView
          Left = 86.400000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL RECEBIDO:')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 259.200000000000000000
          Top = 17.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxRecibo."VALREC">,Detalhes)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
      end
      object chiAvisoCheque: TfrxChild
        FillType = ftBrush
        Height = 136.000000000000000000
        Top = 527.000000000000000000
        Width = 384.000000000000000000
        Child = frxRelReciboBobina.chiChePre
        PrintChildIfInvisible = True
        object DMPMemo24: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 34.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[COMPENSACAO]')
          TruncOutboundText = False
        end
        object DMPMemo26: TfrxDMPMemoView
          Top = 68.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'AGEN.')
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object DMPMemo28: TfrxDMPMemoView
          Left = 57.600000000000000000
          Top = 68.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'C. CORRENTE')
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 68.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NUM.CHEQUE')
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Top = 85.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'EMITENTE')
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Top = 102.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[CNPJ]')
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 182.400000000000000000
          Top = 102.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[VENC]')
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 268.800000000000000000
          Top = 102.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          TruncOutboundText = False
        end
        object DMPLine8: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
      end
      object chiChePre: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 680.000000000000000000
        Width = 384.000000000000000000
        Child = frxRelReciboBobina.chiCheAvi
        PrintChildIfInvisible = True
        object subChePre: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelReciboBobina.pagChePre
        end
      end
      object chiCheAvi: TfrxChild
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 714.000000000000000000
        Width = 384.000000000000000000
        Child = frxRelReciboBobina.ChildRodape
        PrintChildIfInvisible = True
        object subCheAvi: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelReciboBobina.pagCheAvi
        end
      end
      object ChildRodape: TfrxChild
        FillType = ftBrush
        Height = 153.000000000000000000
        Top = 748.000000000000000000
        Width = 384.000000000000000000
        PrintChildIfInvisible = True
        Stretched = True
        object DMPMemo23: TfrxDMPMemoView
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haRight
          Memo.UTF8W = (
            '[DATA]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo27: TfrxDMPMemoView
          Left = 19.200000000000000000
          Top = 85.000000000000000000
          Width = 345.600000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxAuxiliar."OPERADOR"]')
          TruncOutboundText = False
        end
        object rllSalto: TfrxDMPMemoView
          Top = 119.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          StretchMode = smMaxHeight
          DisplayFormat.DecimalSeparator = ','
          TruncOutboundText = False
        end
        object DMPLine2: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 110.500000000000000000
          Width = 374.400000000000000000
          Color = clBlack
        end
        object DMPLine3: TfrxDMPLineView
          Align = baCenter
          Left = 62.400000000000000000
          Top = 76.500000000000000000
          Width = 259.200000000000000000
          Color = clBlack
        end
        object DMPMemo53: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'SEQ. BAIXA: [Trim(<frxRecibo."SEQCON">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo54: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[CAIXA]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 425.000000000000000000
        Width = 384.000000000000000000
        object rllNosNum: TfrxDMPMemoView
          Left = 124.800000000000000000
          Width = 259.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllNosNumOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxRecibo."NOSNUM"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllCabNosNum: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            'NOSSO NUMERO:')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
    object pagChePre: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549700000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxChePre
        DataSetName = 'frxChePre'
        RowCount = 0
        object frxChePrefrxChePre: TfrxDMPMemoView
          ShiftMode = smDontShift
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMAGE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 57.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_CONCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NUMCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          ShiftMode = smDontShift
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxChePre."CHQ_NOMEMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo37: TfrxDMPMemoView
          ShiftMode = smDontShift
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxChePre."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39')  ,<frxChePre."CHQ_C_G_C_">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo38: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxChePre."CHQ_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo39: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxChePre."CHQ_VALCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 384.000000000000000000
        object DMPLine6: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
      end
    end
    object pagCheAvi: TfrxDMPPage
      PaperWidth = 101.599934383375700000
      PaperHeight = 256.381084420549700000
      PaperSize = 256
      EndlessHeight = True
      FontStyle = []
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 17.000000000000000000
        Width = 384.000000000000000000
        DataSet = frxCheAvi
        DataSetName = 'frxCheAvi'
        RowCount = 0
        object DMPMemo40: TfrxDMPMemoView
          ShiftMode = smDontShift
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMAGE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 57.600000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_CONCOR"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NUMCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Top = 17.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_NOMEMI"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo44: TfrxDMPMemoView
          Top = 34.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxCheAvi."CHQ_CGCCPF"> = '#39'1'#39', '#39'99.999.999/' +
              '9999-99;0;'#39', '#39'999.999.999-99;0;'#39'), <frxCheAvi."CHQ_C_G_C_">)]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo45: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 182.400000000000000000
          Top = 34.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd/mm/yy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_DTAVEN"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo46: TfrxDMPMemoView
          ShiftMode = smDontShift
          Left = 268.800000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataSet = frxChePre
          DataSetName = 'frxChePre'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxCheAvi."CHQ_VALCHQ"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object Footer2: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 85.000000000000000000
        Width = 384.000000000000000000
        object DMPLine7: TfrxDMPLineView
          Align = baWidth
          Left = 4.800000000000000000
          Top = 8.500000000000000000
          Width = 355.200000000000000000
          Color = clBlack
        end
      end
    end
  end
  object frxAuxiliar: TfrxUserDataSet
    UserName = 'frxAuxiliar'
    Fields.Strings = (
      'SALTO'
      'OPERADOR')
    Left = 126
    Top = 213
  end
  object frxChePre: TfrxDBDataset
    UserName = 'frxChePre'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 163
    Top = 213
  end
  object frxCheAvi: TfrxDBDataset
    UserName = 'frxCheAvi'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 195
    Top = 213
  end
  object frxRelReciboColunaM: TfrxReport
    Version = '5.6.11'
    DataSetName = 'frxRelatorio'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44284.628206794000000000
    ReportOptions.LastChange = 44284.628206794000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure strCaixaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If (<strSIGPAI> = '#39'PAR'#39') Or'
      '     (<frxDataSetContasReceber."RCX_CAIXA"> = '#39#39') Then'
      '    strCaixa.Text := '#39#39
      '  Else'
      
        '    strCaixa.Text := '#39'CAIXA: '#39' + <frxDataSetContasReceber."RCX_C' +
        'AIXA">;                      '
      'end;'
      ''
      'procedure DMPMemo18OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo18.Text := '#39'CHEQUES RELACION'#39
      '  Else'
      '    DMPMemo18.Text := '#39'RELACAO DE CHEQUES'#39';  '
      'end;'
      ''
      'procedure DMPMemo5OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo5.Text := '#39'RESPECT AL PAGO DE LA(S) QUOTA(S): '#39
      '  Else'
      
        '    DMPMemo5.Text := '#39'REFERENTE AO PAGAMENTO DA(S) PARCELA(S): '#39 +
        ';  '
      'end;'
      ''
      'procedure DMPMemo3OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo3.Text := '#39'HEMOS RECEBIDO'#39
      '  Else'
      '    DMPMemo3.Text := '#39'RECEBEMOS DE'#39';  '
      'end;'
      ''
      'procedure DMPMemo4OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo4.Text := '#39'POR ENCIMA DE LA IMPORTANCIA DE: '#39
      '  Else'
      '    DMPMemo4.Text := '#39'A IMPORTANCIA ACIMA DE:'#39';  '
      'end;'
      ''
      'procedure DMPMemo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo1.Text := #27 + '#39'W1'#39' + '#39'RECIBO'#39' + #27 + '#39'W0'#39';'
      'end;'
      ''
      'procedure DMPMemo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If  <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo2.Text := '#39'G$'#39
      '  Else'
      '    DMPMemo2.Text := '#39'R$'#39';'
      'end;'
      ''
      'procedure DMPMemo33OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    DMPMemo33.Text := '#39'RUC: '#39' + <strCGCEMP>  '
      '  Else'
      '    DMPMemo33.Text := '#39'CNPJ: '#39' + <strCGCEMP>;  '
      'end;'
      ''
      
        'procedure frxDataSetEmpresaEMP_C_G_C_OnBeforePrint(Sender: TfrxC' +
        'omponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      '    frxDataSetEmpresaEMP_C_G_C_.Text := '#39'RUC: '#39' + <strCGCEMP>  '
      '  Else'
      
        '    frxDataSetEmpresaEMP_C_G_C_.Text := '#39'CNPJ: '#39' + <strCGCEMP>; ' +
        ' '
      'end;'
      ''
      'procedure DMPMemo46OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      
        '    DMPMemo46.Text := '#39'LA IMPRESION CONTINUA EN LA PAGINA SIGUIE' +
        'NTE'#39
      '  Else'
      
        '    DMPMemo46.Text := '#39'IMPRESSAO CONTINUA NA PROXIMA PAGINA'#39';   ' +
        '     '
      ' end;'
      ''
      'procedure DMPMemo34OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI>  = '#39'PAR'#39' Then'
      
        '    DMPMemo34.Text := '#39'SEQ.BAJA: '#39' + FloatToStr(<frxDataSetConta' +
        'sReceber."SEQCON">)    '
      '  Else'
      
        '    DMPMemo34.Text := '#39'INSCRICAO ESTADUAL: '#39' + <frxDataSetEmpres' +
        'a."EMP_I_E_S_"> + '#39'                    SEQ.BAIXA: '#39' + FloatToStr' +
        '(<frxDataSetContasReceber."SEQCON">);'
      '  '
      'end;'
      ''
      
        'procedure frxDataSetEmpresaEMP_I_E_S_OnBeforePrint(Sender: TfrxC' +
        'omponent);'
      'begin'
      '  If <strSIGPAI> = '#39'PAR'#39' Then'
      
        '    frxDataSetEmpresaEMP_I_E_S_.Text := '#39'SEQ.BAJA: '#39' + FloatToSt' +
        'r(<frxDataSetContasReceber."SEQCON">)    '
      '  Else'
      
        '    frxDataSetEmpresaEMP_I_E_S_.Text := '#39'INSCRICAO ESTADUAL: '#39' +' +
        ' <frxDataSetEmpresa."EMP_I_E_S_"> + '#39'                    SEQ.BAI' +
        'XA: '#39' + FloatToStr(<frxDataSetContasReceber."SEQCON">);'
      '  '
      'end;'
      ''
      'procedure DMPMemo8OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI>  = '#39'PAR'#39' Then'
      '    DMPMemo8.Text := '#39'MADUR.'#39
      '  Else'
      '    DMPMemo8.Text := '#39'VENC.'#39';  '
      'end;'
      ''
      'procedure DMPMemo14OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <strSIGPAI>  = '#39'PAR'#39' Then'
      '    DMPMemo14.Text := '#39'MADUR.'#39
      '  Else'
      '    DMPMemo14.Text := '#39'VENC.'#39';  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 52
    Top = 32
    Datasets = <>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'rllValChv'
        Value = #39'CHEQUE '#193' VISTA: 0,00'#39
      end
      item
        Name = 'VS_Date'
        Value = #39'31/03/2021'#39
      end
      item
        Name = 'strEmpAcessoUsuarioLogado'
        Value = 
          #39'000_001_300_800_106_778_400_401_278_799_011_026_032_002_003_531' +
          '_100_017_127_999_018_532_533_007_012_456_020_666_013_029_009_014' +
          '_321_333_004_555_556_559_601_602_603_600_112_950_888_889_171_025' +
          '_998_900_777_901_033_008_015_123_016_005_987_030_050_323_110_109' +
          '_990_997_031_038_125_700_787_022_006_290_021_907_994_154_010_222' +
          '_234_500_301_302_268_155_040_023_741_237_712_713_789_041_028_513' +
          '_111_153_101_159_363_027_969_444_'#39
      end
      item
        Name = 'rllValCre'
        Value = #39'CR'#201'DITO UTILIZADO: 0,00'#39
      end
      item
        Name = 'strSIGPAI'
        Value = #39'BRA'#39
      end
      item
        Name = 'rllValDin'
        Value = #39'DINHEIRO: 0,00'#39
      end
      item
        Name = 'strLoginUsuarioLogado'
        Value = #39'998'#39
      end
      item
        Name = 'fltTotalRecebidoExt'
        Value = #39'DUZENTOS E CINQUENTA E SEIS REAIS '#39
      end
      item
        Name = 'strLocalData'
        Value = #39'GUARULHOS, 31 de Mar'#231'o de 2021'#39
      end
      item
        Name = 'rllValOrd'
        Value = #39'ORDEM DE PGTO: 0,00'#39
      end
      item
        Name = 'strCGCEMP'
        Value = #39'52.688.892/0001-69'#39
      end
      item
        Name = 'strDescriUsuarioLogado'
        Value = #39'PROGRAMA'#199#195'O'#39
      end
      item
        Name = 'rllBaiEmp'
        Value = #39#39
      end
      item
        Name = 'fltTotalRecebido'
        Value = #39'256'#39
      end
      item
        Name = 'rllValCar'
        Value = #39'CART'#195'O: 0,00'#39
      end
      item
        Name = 'rllBaiPor'
        Value = #39#39
      end
      item
        Name = 'rllValChp'
        Value = #39'CHEQUE-PR'#201': 0,00'#39
      end
      item
        Name = 'rllBaiOp'
        Value = #39#39
      end
      item
        Name = 'VS_strCodEmp'
        Value = #39'001'#39
      end
      item
        Name = 'LOGOTIPO'
        Value = 
          #39'E:\Users\matheus.alacrino\Documentos\AutPas\Homologar\padra_atu' +
          'alizado\CITEL.BMP'#39
      end
      item
        Name = 'rllBaiHis'
        Value = #39#39
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object pagRelatorio: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 202.406119279381300000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      ColumnPositions.Strings = (
        '0')
      FontStyle = []
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Frame.ShadowWidth = 2.000000000000000000
        Frame.Typ = [ftTop]
        Frame.LeftLine.Width = 2.000000000000000000
        Frame.TopLine.Width = 2.000000000000000000
        Height = 170.000000000000000000
        Top = 17.000000000000000000
        Width = 1219.200000000000000000
        object DMPMemo1: TfrxDMPMemoView
          Left = 489.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo1OnBeforePrint'
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            #9'RECIBO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 940.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo2OnBeforePrint'
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'R$')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberVALREC: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasReceber."VALREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 182.400000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo3OnBeforePrint'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'RECEBEMOS DE ')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberNOMCLI: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 17.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = [fsxBold, fsx12cpi]
          Memo.UTF8W = (
            
              '[frxDataSetContasReceber."CODCLI"]-[frxDataSetContasReceber."NOM' +
              'CLI"]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object frxDataSetContasReceberENDERE: TfrxDMPMemoView
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 1008.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = []
          Memo.UTF8W = (
            
              '[frxDataSetContasReceber."ENDERE"] - [frxDataSetContasReceber."E' +
              'NDCMP"], [frxDataSetContasReceber."ENDNUM"] - [frxDataSetContasR' +
              'eceber."BAIRRO"]'
            ' ')
          ParentFont = False
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
        object frxDataSetContasReceberC_E_P_: TfrxDMPMemoView
          Left = 633.600000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'C_E_P_'
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasReceber1."C_E_P_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberCIDADE: TfrxDMPMemoView
          Left = 768.000000000000000000
          Top = 51.000000000000000000
          Width = 441.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            
              '[frxDataSetContasReceber."CIDADE"]-[frxDataSetContasReceber."EST' +
              'ADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo4OnBeforePrint'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'A IMPORTANCIA ACIMA DE')
          ParentFont = False
          TruncOutboundText = False
        end
        object fltTotalRecebidoExt: TfrxDMPMemoView
          Left = 240.000000000000000000
          Top = 68.000000000000000000
          Width = 969.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[fltTotalRecebidoExt]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo5OnBeforePrint'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REFERENTE AO PAGAMENTO DA(S) PARCELA(S)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 127.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 161.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 192.000000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo8OnBeforePrint'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VENC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 297.600000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 403.200000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOC')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 508.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 609.599999999999900000
          Top = 127.500000000000000000
          Height = 34.000000000000000000
          Color = clBlack
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 136.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'DOCUMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 739.200000000000000000
          Top = 136.000000000000000000
          Width = 48.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VEND')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 796.800000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo14OnBeforePrint'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VENC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo15: TfrxDMPMemoView
          Left = 902.400000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'REC.')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 1008.000000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. DOC')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 1113.600000000000000000
          Top = 136.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VR. RECEB')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object strCaixa: TfrxDMPMemoView
          Left = 988.800000000000000000
          Top = 102.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'strCaixaOnBeforePrint'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[strCaixa]')
          ParentFont = False
          TruncOutboundText = False
        end
        object dmpComando: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#15#27#67#33#27#80'
        end
      end
      object rlbDetalhe: TfrxMasterData
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 204.000000000000000000
        Width = 1219.200000000000000000
        Columns = 2
        ColumnGap = 610.560000000000000000
        DataSetName = 'frxDataSetContasReceber'
        RowCount = 24
        object frxDataSetContasReceberNUMDOC: TfrxDMPMemoView
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            '[frxDataSetContasReceber."NUMDOC"]'
            '[frxDataSetContasReceber."PARCEL"]-'
            '[frxDataSetContasReceber."ESPDOC"]-'
            '[frxDataSetContasReceber."CODEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberCODVEN: TfrxDMPMemoView
          Left = 134.400000000000000000
          Width = 38.400000000000000000
          Height = 17.000000000000000000
          DataField = 'CODVEN'
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = [fsxCondensed, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[frxDataSetContasReceber1."CODVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberDTAVEN: TfrxDMPMemoView
          Left = 192.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAVEN'
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = [fsxCondensed, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[frxDataSetContasReceber1."DTAVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberDTAREC: TfrxDMPMemoView
          Left = 297.600000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'DTAREC'
          DataSetName = 'frxDataSetContasReceber'
          FontStyle = [fsxCondensed, fsx12cpi, fsx15cpi]
          Memo.UTF8W = (
            '[frxDataSetContasReceber1."DTAREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberVALDOC: TfrxDMPMemoView
          Left = 403.200000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxCondensed, fsx12cpi, fsx15cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasReceber."VALDOC"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasReceberVALREC1: TfrxDMPMemoView
          Left = 499.200000000000000000
          Width = 105.600000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetContasReceber'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsxCondensed, fsx12cpi, fsx15cpi]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasReceber."VALREC"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCheques: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 238.000000000000000000
        Width = 1219.200000000000000000
        Child = frxRelReciboColunaM.rlbEmpresa2
        PrintChildIfInvisible = True
        object subCheques: TfrxSubreport
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          Page = frxRelReciboColunaM.pagCheques
        end
      end
      object rlbEmpresa2: TfrxChild
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 204.000000000000000000
        Top = 272.000000000000000000
        Width = 1219.200000000000000000
        Child = frxRelReciboColunaM.rlbBaixa
        object rllValDin: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 17.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[rllValDin]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllValChv: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 17.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[rllValChv]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllValChp: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 17.000000000000000000
          Width = 230.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[rllValChp]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllValCar: TfrxDMPMemoView
          Left = 67.200000000000000000
          Top = 51.000000000000000000
          Width = 220.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[rllValCar]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllValOrd: TfrxDMPMemoView
          Left = 460.800000000000000000
          Top = 51.000000000000000000
          Width = 268.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[rllValOrd]')
          ParentFont = False
          TruncOutboundText = False
        end
        object rllValCre: TfrxDMPMemoView
          Left = 864.000000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[rllValCre]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object DMPLine5: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 42.500000000000000000
          Width = 1209.600000000000000000
          Color = clBlack
        end
        object frxDataSetEmpresaEMP_NOMEMP: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            
              '[frxDataSetEmpresa."EMP_CODEMP"]-[frxDataSetEmpresa."EMP_NOMEMP"' +
              ']')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetEmpresaEMP_C_E_P_: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_C_E_P_'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_C_E_P_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetEmpresaEMP_NOMCID: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 119.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMCID'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_NOMCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetEmpresaEMP_ESTADO: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 119.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_ESTADO'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_ESTADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetEmpresaEMP_ENDERECO: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 102.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_ENDERECO'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_ENDERECO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetEmpresaEMP_C_G_C_: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 136.000000000000000000
          Width = 499.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'frxDataSetEmpresaEMP_C_G_C_OnBeforePrint'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            'CNPJ: [frxDataSetEmpresa."EMP_C_G_C_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetEmpresaEMP_I_E_S_: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 153.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'frxDataSetEmpresaEMP_I_E_S_OnBeforePrint'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            
              'INSCRICAO ESTADUAL: [frxDataSetEmpresa."EMP_I_E_S_"] SEQ.BAIXA: ' +
              '[frxDataSetContasReceber."SEQCON"]')
          ParentFont = False
          TruncOutboundText = False
          Formats = <
            item
            end
            item
            end>
        end
        object DMPLine6: TfrxDMPLineView
          Left = 811.199999999999900000
          Top = 161.500000000000000000
          Width = 384.000000000000000000
          Color = clBlack
        end
        object DMPMemo44: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 187.000000000000000000
          Width = 470.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'IMPRESS'#195'O CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
          TruncOutboundText = False
        end
        object strLocalData: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 85.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[strLocalData]')
          ParentFont = False
          TruncOutboundText = False
        end
        object strDescriUsuarioLogado: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 170.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[strLoginUsuarioLogado]-[strDescriUsuarioLogado]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbEmpresa: TfrxChild
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 136.000000000000000000
        Top = 612.000000000000000000
        Width = 1219.200000000000000000
        object DMPMemo28: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_NOMEMP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo29: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_C_E_P_'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_C_E_P_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo30: TfrxDMPMemoView
          Left = 115.200000000000000000
          Top = 51.000000000000000000
          Width = 316.800000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMCID'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_NOMCID"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo31: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 51.000000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_ESTADO'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_ESTADO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo32: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 403.200000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_ENDERECO'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetEmpresa1."EMP_ENDERECO"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo33: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo33OnBeforePrint'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            'CNPJ: [frxDataSetEmpresa."EMP_C_G_C_"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo34: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 85.000000000000000000
          Width = 768.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo34OnBeforePrint'
          DataSetName = 'frxDataSetEmpresa'
          FontStyle = []
          Memo.UTF8W = (
            
              'INSCRICAO ESTADUAL: [frxDataSetEmpresa."EMP_I_E_S_"] SEQ.BAIXA: ' +
              '[frxDataSetContasReceber."SEQCON"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine7: TfrxDMPLineView
          Left = 811.199999999999900000
          Top = 93.500000000000000000
          Width = 384.000000000000000000
          Color = clBlack
        end
        object DMPMemo46: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 119.000000000000000000
          Width = 624.000000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo46OnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            'IMPRESS'#195'O CONTINUA NA PR'#211'XIMA P'#193'GINA')
          ParentFont = False
          TruncOutboundText = False
        end
        object strLocalData1: TfrxDMPMemoView
          Left = 748.800000000000000000
          Top = 17.000000000000000000
          Width = 451.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[strLocalData]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo36: TfrxDMPMemoView
          Left = 806.400000000000000000
          Top = 102.000000000000000000
          Width = 384.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[strLoginUsuarioLogado]-[strDescriUsuarioLogado]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbBaixa: TfrxChild
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Courier New'
        Font.Style = []
        Height = 102.000000000000000000
        ParentFont = False
        Top = 493.000000000000000000
        Width = 1219.200000000000000000
        Child = frxRelReciboColunaM.rlbEmpresa
        object DMPMemo40: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'EMPRESA...: [rllBaiEmp]')
          TruncOutboundText = False
        end
        object DMPMemo41: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'PORTADOR..: [rllBaiPor]')
          TruncOutboundText = False
        end
        object DMPMemo42: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'OPERADOR..: [rllBaiOp]')
          TruncOutboundText = False
        end
        object DMPMemo43: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 68.000000000000000000
          Width = 643.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            'HIST'#211'RICO.: [rllBaiHis]')
          TruncOutboundText = False
        end
        object DMPMemo35: TfrxDMPMemoView
          Left = 441.600000000000000000
          Width = 278.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'DADOS BAIXA')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
    object pagCheques: TfrxDMPPage
      PaperWidth = 327.659788386386700000
      PaperHeight = 44.979137617640290000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      ColumnPositions.Strings = (
        '0')
      FontStyle = []
      object rlbHdChq: TfrxHeader
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 1219.200000000000000000
        object DMPMemo18: TfrxDMPMemoView
          Left = 470.400000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'DMPMemo18OnBeforePrint'
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            'RELA'#199#195'O DE CHEQUES')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo19: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 51.000000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'AGEN')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo20: TfrxDMPMemoView
          Left = 96.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'C. CORRENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo21: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'NUM. CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo22: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 51.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'VENCIMENTO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo23: TfrxDMPMemoView
          Left = 480.000000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'VALOR')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo24: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 51.000000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'EMITENTE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo25: TfrxDMPMemoView
          Left = 960.000000000000000000
          Top = 51.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsx12cpi]
          Memo.UTF8W = (
            'CNPJ/CGC')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbChq: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight]
        Height = 17.000000000000000000
        Top = 102.000000000000000000
        Width = 1219.200000000000000000
        RowCount = 0
        object frxDataSetContasChequePreCHQ_NUMAGE: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 76.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMAGE'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMAGE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasChequePreCHQ_CONCOR: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_CONCOR'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_CONCOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasChequePreCHQ_NUMCHQ: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NUMCHQ'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NUMCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasChequePreCHQ_DTAVEN: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_DTAVEN'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_DTAVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasChequePreCHQ_VALCHQ: TfrxDMPMemoView
          Left = 480.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_VALCHQ'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_VALCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasChequePreCHQ_NOMEMI: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 336.000000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_NOMEMI'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_NOMEMI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object frxDataSetContasChequePreCHQ_C_G_C_: TfrxDMPMemoView
          Left = 960.000000000000000000
          Width = 249.600000000000000000
          Height = 17.000000000000000000
          DataField = 'CHQ_C_G_C_'
          DataSetName = 'frxDataSetContasCheque'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDataSetContasCheque."CHQ_C_G_C_"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbFtChq: TfrxFooter
        FillType = ftBrush
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 17.000000000000000000
        Top = 136.000000000000000000
        Width = 1219.200000000000000000
        object DMPMemo26: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 576.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'ESTE RECIBO SOMENTE SER'#193' V'#193'LIDO NA COMPENSA'#199#195'O DO CHEQUE')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
end
