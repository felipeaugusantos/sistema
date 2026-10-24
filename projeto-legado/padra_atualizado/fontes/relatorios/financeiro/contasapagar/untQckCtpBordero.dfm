object frmQckCtpBordero: TfrmQckCtpBordero
  Left = 145
  Top = 145
  Caption = 'frmQckCtpBordero'
  ClientHeight = 309
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dtsGenPag: TDataSource
    DataSet = cdsChqsEmi
    Left = 280
    Top = 94
  end
  object dtsChqsEmi: TDataSource
    DataSet = cdsChqsEmi
    Left = 280
    Top = 149
  end
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42999.621008865700000000
    ReportOptions.LastChange = 44176.663939097200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure MasterDataOnBeforePrint(Sender: TfrxComponent);'
      'var'
      '  strMemoCNPJ : String;'
      'begin                            '
      
        '    strMemoCNPJ := fFormataCpfCgcLOCAL(<frxDBDatasetGenPag."FOR_' +
        'C_G_C_">);'
      
        '    fVerificaComponenteRelExiste('#39'memoCNPJ'#39',strMemoCNPJ);       ' +
        '                                   '
      'end;'
      ''
      'procedure CChequesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Page#> > 1) then'
      '  begin'
      '    CCheques.Visible          := False;'
      '    CCabecalhoCheques.Visible := False;'
      '    CDDebitoConta.Visible     := False;'
      '    CDepBancario.Visible      := False;'
      '    CChequesTerceiros.Visible := False;'
      '    CDinheiro.Visible         := False;'
      '  end;                  '
      'end;'
      ''
      'begin'
      '  '
      'end.')
    OnUserFunction = frxReportUserFunction
    Left = 58
    Top = 95
    Datasets = <
      item
        DataSet = frxDBDatasetCTPDET
        DataSetName = 'frxDBDatasetCTPDET'
      end
      item
        DataSet = frxDBDatasetChqsEmi
        DataSetName = 'frxDBDatasetChqsEmi'
      end
      item
        DataSet = frxDBDatasetChqsTerceiros
        DataSetName = 'frxDBDatasetChqsTerceiros'
      end
      item
        DataSet = frxDBDatasetMOVBAN
        DataSetName = 'frxDBDatasetMOVBAN'
      end
      item
        DataSet = frxDBDatasetCADPAG
        DataSetName = 'frxDBDatasetCADPAG'
      end
      item
        DataSet = frxDBDatasetGenPag
        DataSetName = 'frxDBDatasetGenPag'
      end>
    Variables = <
      item
        Name = ' Autcom Variables'
        Value = Null
      end
      item
        Name = 'VS_Date'
        Value = #39'02/08/2019'#39
      end
      item
        Name = 'VS_strCodEmp'
        Value = #39'001'#39
      end
      item
        Name = 'LOGOTIPO'
        Value = #39'C:\NFE\CITEL.BMP'#39
      end
      item
        Name = 'strEmpAcessoUsuarioLogado'
        Value = 
          #39'001_002_003_531_100_017_127_999_018_532_533_007_012_456_020_666' +
          '_013_029_009_014_321_333_004_555_556_557_558_559_601_602_603_604' +
          '_600_112_950_888_889_171_025_998_900_777_776_901_033_008_015_123' +
          '_016_987_030_022_290_907_994_154_010_222_234_500_027_000_444_'#39
      end
      item
        Name = 'strLoginUsuarioLogado'
        Value = #39'998'#39
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageFooter: TfrxPageFooter
        FillType = ftBrush
        Height = 158.960730000000000000
        Top = 706.772110000000000000
        Width = 718.110700000000000000
        object Line3: TfrxLineView
          Top = 129.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 133.559060000000000000
          Width = 419.527830000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(*) Tipo Doc.: 1 - T'#237'tulos 2 - Tributos 3 - Concession'#225'rias')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Top = 3.779529999999800000
          Width = 597.165740000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            
              'Usar transa'#231#227'o FE-228 - C'#243'digo 8912                             ' +
              '                                                                ' +
              '           Total:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Top = 30.236239999999700000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 162.519790000000000000
          Top = 30.236239999999700000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Assinatura')
          ParentFont = False
        end
        object Line5: TfrxLineView
          Top = 90.708720000001000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object SysMemo1: TfrxSysMemoView
          Left = 4.000000000000000000
          Top = 60.472479999999900000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DATE]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Top = 94.488250000000810000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Autentica'#231#227'o')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 597.842920000000000000
          Top = 3.779529999999800000
          Width = 117.165354330000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDatasetGenPag."CTP_VALPAG">,MasterData)]')
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData: TfrxMasterData
        FillType = ftBrush
        Height = 18.897637800000000000
        Top = 498.897960000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterDataOnBeforePrint'
        Child = frxReport.CHistorico
        DataSet = frxDBDatasetGenPag
        DataSetName = 'frxDBDatasetGenPag'
        RowCount = 0
        object memoTipoDocumento: TfrxMemoView
          Top = 4.047246540000000000
          Width = 71.055118110000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_TIPDOC"]')
          ParentFont = False
          WordWrap = False
        end
        object memoNumDoc: TfrxMemoView
          Left = 71.433070870000000000
          Top = 4.118120000000000000
          Width = 94.866141730000000000
          Height = 18.897650000000000000
          DataField = 'CTP_NUMDUP'
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_NUMDUP"]')
          ParentFont = False
          WordWrap = False
        end
        object memoCedente: TfrxMemoView
          Left = 282.708661420000000000
          Top = 4.118120000000000000
          Width = 230.551181100000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."FOR_NOMFOR"]')
          ParentFont = False
          WordWrap = False
        end
        object memoDataBaixa: TfrxMemoView
          Left = 513.259842520000000000
          Top = 4.118120000000000000
          Width = 88.818900080000000000
          Height = 18.897650000000000000
          DataField = 'CTP_DTAPAG'
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_DTAPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object memoValor: TfrxMemoView
          Left = 601.842920000000000000
          Top = 4.118120000000000000
          Width = 114.519685040000000000
          Height = 18.897650000000000000
          DataField = 'CTP_VALPAG'
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_VALPAG"]')
          ParentFont = False
          WordWrap = False
        end
        object memoCNPJ: TfrxMemoView
          Left = 166.299212600000000000
          Top = 4.118120000000000000
          Width = 116.787401570000000000
          Height = 18.897650000000000000
          OnAfterData = 'memoCNPJOnAfterData'
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '25.630.302/0001-74')
          ParentFont = False
          WordWrap = False
        end
      end
      object CCheques: TfrxChild
        FillType = ftBrush
        Height = 24.566931570000000000
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'CChequesOnBeforePrint'
        Child = frxReport.CCabecalhoCheques
        PrintChildIfInvisible = True
        Stretched = True
        object Subreport: TfrxSubreport
          Top = 0.779529999999966000
          Width = 714.331170000000000000
          Height = 15.118107800000000000
          Page = frxReport.ChequesEmitidos
          PrintOnParent = True
        end
      end
      object CDepBancario: TfrxChild
        FillType = ftBrush
        Height = 22.677165350000000000
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        Child = frxReport.CChequesTerceiros
        PrintChildIfInvisible = True
        object shpValorCabDebConta: TfrxShapeView
          Left = 436.535433070000000000
          Top = 2.133858270000020000
          Width = 113.763779527559000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape2: TfrxShapeView
          Top = 2.133858270000020000
          Width = 136.062992125984000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape1: TfrxShapeView
          Left = 4.677180000000000000
          Top = 5.133858270000020000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object Memo17: TfrxMemoView
          Left = 20.574830000000000000
          Top = 5.133858270000020000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dep'#243'sito Banc'#225'rio:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape3: TfrxShapeView
          Left = 136.062992125984000000
          Top = 2.133858270000020000
          Width = 102.803149606299000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo24: TfrxMemoView
          Left = 137.952755905512000000
          Top = 5.133858270000020000
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape4: TfrxShapeView
          Left = 238.866141732283000000
          Top = 2.133858270000020000
          Width = 75.968503937007900000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo25: TfrxMemoView
          Left = 241.889763779528000000
          Top = 5.133858270000020000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape5: TfrxShapeView
          Left = 315.212598425197000000
          Top = 2.133858270000020000
          Width = 121.322834645669000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo26: TfrxMemoView
          Left = 321.259842519685000000
          Top = 5.133858270000020000
          Width = 22.677165350000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C/C:')
          ParentFont = False
          VAlign = vaCenter
        end
        object memValorCabDebConta: TfrxMemoView
          Left = 438.425196850394000000
          Top = 5.133858270000020000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object shpPortCabDebConta: TfrxShapeView
          Left = 550.299212600000000000
          Top = 2.133858270000020000
          Width = 166.299212600000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object memPortCabDebConta: TfrxMemoView
          Left = 555.590551181102000000
          Top = 5.133858270000020000
          Width = 30.236220472440900000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Port.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object memVlrDepBancario: TfrxMemoView
          Left = 468.661720000000000000
          Top = 5.133858270000020000
          Width = 79.370078740157500000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object memPortDepBancario: TfrxMemoView
          Left = 586.582638110000000000
          Top = 5.133858270000020000
          Width = 128.503958980000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
        object mem_X_DepBancario: TfrxMemoView
          Left = 4.779530000000000000
          Top = 4.559059999999990000
          Width = 11.338590000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'X')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object CCabecalhoCheques: TfrxChild
        FillType = ftBrush
        Height = 24.566931570000000000
        Top = 257.008040000000000000
        Width = 718.110700000000000000
        Child = frxReport.CDDebitoConta
        PrintChildIfInvisible = True
        Stretched = True
        object shpValorCabCheque: TfrxShapeView
          Left = 436.535433070000000000
          Top = 2.000000000000000000
          Width = 113.763779530000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape7: TfrxShapeView
          Top = 2.000000000000000000
          Width = 136.062992125984000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo28: TfrxMemoView
          Left = 20.574830000000000000
          Top = 5.779529999999971000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cheque n'#186)
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape8: TfrxShapeView
          Left = 136.062992125984000000
          Top = 2.000000000000000000
          Width = 102.803149606299000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo29: TfrxMemoView
          Left = 137.952755905512000000
          Top = 5.779529999999971000
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape9: TfrxShapeView
          Left = 238.866141732283000000
          Top = 2.000000000000000000
          Width = 75.968503937007900000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo30: TfrxMemoView
          Left = 241.889763779528000000
          Top = 5.779529999999971000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape10: TfrxShapeView
          Left = 315.212598425197000000
          Top = 2.000000000000000000
          Width = 121.322834645669000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo31: TfrxMemoView
          Left = 321.259842519685000000
          Top = 5.425170000000040000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C/C:')
          ParentFont = False
          VAlign = vaCenter
        end
        object memValorCabCheques: TfrxMemoView
          Left = 438.425196850000000000
          Top = 5.425170000000040000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape12: TfrxShapeView
          Left = 4.779530000000000000
          Top = 5.779522680000010000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object shpPortCabCheque: TfrxShapeView
          Left = 550.299173540000000000
          Top = 2.000000000000000000
          Width = 166.299251650000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object memPortCabCheques: TfrxMemoView
          Left = 555.590551181102000000
          Top = 5.425170000000040000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Port.:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object CHistorico: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 540.472790000000000000
        Width = 718.110700000000000000
        Child = frxReport.Cdesmenbramento
        Stretched = True
        object Subreport3: TfrxSubreport
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Page = frxReport.Page2
        end
      end
      object CChequesTerceiros: TfrxChild
        FillType = ftBrush
        Height = 24.566931570000000000
        Top = 400.630180000000000000
        Width = 718.110700000000000000
        Child = frxReport.CDinheiro
        PrintChildIfInvisible = True
        Stretched = True
        object Subreport1: TfrxSubreport
          Width = 715.464566930000000000
          Height = 15.118120000000000000
          Page = frxReport.ChequesTerceiros
          PrintOnParent = True
        end
      end
      object CDinheiro: TfrxChild
        FillType = ftBrush
        Height = 26.456695350000000000
        Top = 449.764070000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Shape29: TfrxShapeView
          Top = 4.000000000000000000
          Width = 436.157480314961000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape30: TfrxShapeView
          Left = 436.401980000000000000
          Top = 4.000000000000000000
          Width = 113.763779527559000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo52: TfrxMemoView
          Left = 438.425196850394000000
          Top = 7.779530000000020000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape31: TfrxShapeView
          Left = 550.299212600000000000
          Top = 4.000000000000000000
          Width = 166.299212600000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo53: TfrxMemoView
          Left = 555.590551181102000000
          Top = 7.779530000000020000
          Width = 30.236220472440900000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Port.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape32: TfrxShapeView
          Left = 4.677180000000000000
          Top = 7.779530000000020000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object Memo56: TfrxMemoView
          Left = 18.897650000000000000
          Top = 7.779530000000020000
          Width = 41.574830000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dinheiro:')
          ParentFont = False
          VAlign = vaCenter
        end
        object memVlrDinheiro: TfrxMemoView
          Left = 468.661720000000000000
          Top = 7.779530000000020000
          Width = 79.370078740157500000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object memPortDinheiro: TfrxMemoView
          Left = 586.582638110000000000
          Top = 7.779530000000020000
          Width = 128.503958980000000000
          Height = 11.338582680000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          VAlign = vaCenter
        end
        object mem_X_Dinheiro: TfrxMemoView
          Left = 4.779530000000000000
          Top = 7.559059999999990000
          Width = 11.338590000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'X')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object CDDebitoConta: TfrxChild
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        Child = frxReport.CDepBancario
        PrintChildIfInvisible = True
        object Shape25: TfrxShapeView
          Left = 315.212598430000000000
          Top = 2.000000000000000000
          Width = 121.322834650000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape24: TfrxShapeView
          Left = 238.866141730000000000
          Top = 2.000000000000000000
          Width = 75.968503940000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape18: TfrxShapeView
          Left = 136.062992130000000000
          Top = 2.000000000000000000
          Width = 102.803149610000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape11: TfrxShapeView
          Left = 4.677180000000000000
          Top = 5.000000000000060000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object Memo15: TfrxMemoView
          Left = 20.574830000000000000
          Top = 5.000000000000060000
          Width = 109.606370000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'D'#233'bito em nossa conta:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 137.952755905512000000
          Top = 5.000000000000000000
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Banco:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 241.889763779528000000
          Top = 5.000000000000000000
          Width = 41.574803150000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag'#234'ncia: ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Left = 321.259842519685000000
          Top = 5.000000000000000000
          Width = 22.677165350000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C/C:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape6: TfrxShapeView
          Top = 2.000000000000000000
          Width = 136.062992125984000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
      end
      object Cdesmenbramento: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 582.047620000000000000
        Width = 718.110700000000000000
        Child = frxReport.Child1
        object Subreport2: TfrxSubreport
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          Page = frxReport.Page1
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 105.622140000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo9: TfrxMemoView
          Left = 0.779530000000000000
          Top = 71.606370000000000000
          Width = 71.055118110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Tipo Doc. (*)')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 72.063080000000000000
          Top = 71.606370000000000000
          Width = 94.866141730000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'N'#186' Documento')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 166.889920000000000000
          Top = 71.606370000000000000
          Width = 116.787401570000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'CNPJ')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 283.582870000000000000
          Top = 71.606370000000000000
          Width = 230.551181100000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Cedente')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 513.795278030000000000
          Top = 71.606370000000000000
          Width = 88.818897640000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Data Baixa')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 602.748033940000000000
          Top = 71.606370000000000000
          Width = 114.519685040000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Valor R$')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 111.716605000000000000
          Width = 495.118430000000000000
          Height = 26.456710000000000000
          AutoWidth = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Border'#244' para Pagamentos de Contas em Pasta PJ ')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Top = 26.015770000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Line2: TfrxLineView
          Top = 45.574830000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 44.913420000000000000
          Width = 710.551640000000000000
          Height = 15.118107800000000000
          StretchMode = smMaxHeight
          DataField = 'CTP_MENSAG'
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_MENSAG"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 12.220470000000000000
          Top = 27.574830000000000000
          Width = 702.992580000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'EMP_NOMEMP'
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."EMP_NOMEMP"]')
          ParentFont = False
        end
        object memSelecionarOpc: TfrxMemoView
          Left = 3.779530000000000000
          Top = 58.031540000000000000
          Width = 132.283550000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '(Op'#231#245'es selecionadas abaixo)')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 615.252010000000000000
          Top = 7.322820000000000000
          Width = 98.267701890000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'P'#225'gina: [Page]')
          ParentFont = False
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 623.622450000000000000
        Width = 718.110700000000000000
        object MemoCTA_DESCTA: TfrxMemoView
          Left = 375.063187400000000000
          Top = 1.889763780000000000
          Width = 342.047244090000000000
          Height = 18.897650000000000000
          Visible = False
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTA_DESCTA"]')
          ParentFont = False
          WordWrap = False
        end
        object MemoPlaCta: TfrxMemoView
          Top = 1.913371180000000000
          Width = 165.543368110000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Pln. de Cta. Da Baixa')
          ParentFont = False
        end
        object MemoCTP_CODBAI: TfrxMemoView
          Left = 168.078850000000000000
          Top = 1.889763779527560000
          Width = 112.629935910000000000
          Height = 18.897637800000000000
          Visible = False
          DataSet = frxDBDatasetGenPag
          DataSetName = 'frxDBDatasetGenPag'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_CTABAI"]')
          ParentFont = False
          WordWrap = False
        end
        object MemoPlaDesc: TfrxMemoView
          Left = 282.905690000000000000
          Top = 1.889763780000000000
          Width = 89.952755910000000000
          Height = 18.897650000000000000
          Visible = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
      end
      object Header5: TfrxHeader
        FillType = ftBrush
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        Child = frxReport.CCheques
      end
    end
    object ChequesEmitidos: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Width = 0.500000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 24.566931570000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetChqsEmi
        DataSetName = 'frxDBDatasetChqsEmi'
        PrintChildIfInvisible = True
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object shpPortChEmi: TfrxShapeView
          Left = 547.472790000000000000
          Top = 1.133890000000000000
          Width = 168.188976380000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Shape13: TfrxShapeView
          Top = 1.133890000000000000
          Width = 136.062987240000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo33: TfrxMemoView
          Left = 20.574830000000000000
          Top = 4.913420000000000000
          Width = 49.133890000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cheque n'#186)
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape15: TfrxShapeView
          Left = 136.196970000000000000
          Top = 1.133890000000000000
          Width = 67.275585669291300000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo34: TfrxMemoView
          Left = 138.456688030000000000
          Top = 4.913420000000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bco:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape16: TfrxShapeView
          Left = 202.897637800000000000
          Top = 1.133890000000000000
          Width = 60.094485748031500000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo35: TfrxMemoView
          Left = 204.755895750000000000
          Top = 4.913420000000000000
          Width = 18.897650000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag.:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape17: TfrxShapeView
          Left = 262.574803150000000000
          Top = 1.133890000000000000
          Width = 102.047244090000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo36: TfrxMemoView
          Left = 266.480290550000000000
          Top = 4.913385830000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C/C:')
          ParentFont = False
          VAlign = vaCenter
        end
        object shpValorChEmi: TfrxShapeView
          Left = 365.157480310000000000
          Top = 1.133890000000000000
          Width = 77.858262830000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object memValorChEmi: TfrxMemoView
          Left = 367.700760550000000000
          Top = 4.913385830000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          Left = 67.149660000000000000
          Top = 4.913420000000000000
          Width = 64.252010000000000000
          Height = 11.338582680000000000
          DataField = 'EMI_NUMCHQ'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."EMI_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 163.433210000000000000
          Top = 4.913420000000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          DataField = 'EMI_CODBCO'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."EMI_CODBCO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 227.157700000000000000
          Top = 4.913420000000000000
          Width = 34.015770000000000000
          Height = 11.338582680000000000
          DataField = 'EMI_NUMAGE'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."EMI_NUMAGE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 292.102660000000000000
          Top = 4.913385830000000000
          Width = 69.921259840000000000
          Height = 11.338582680000000000
          DataField = 'EMI_CONCOR'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."EMI_CONCOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape14: TfrxShapeView
          Left = 5.543290000000000000
          Top = 5.133882680000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object Memo16: TfrxMemoView
          Left = 5.779530000000000000
          Top = 5.574830000000000000
          Width = 11.338590000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'X')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memPortChEmi: TfrxMemoView
          Left = 550.457020000000000000
          Top = 4.913385830000000000
          Width = 26.456710000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Port.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object memValorChEmi_: TfrxMemoView
          Left = 401.441250000000000000
          Top = 4.913385830000000000
          Width = 37.795300000000000000
          Height = 11.338582680000000000
          DataField = 'CHQ_VALCHQ'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memPortChEmi_: TfrxMemoView
          Left = 579.693260000000000000
          Top = 4.913385830000000000
          Width = 134.173228346456700000
          Height = 11.338582680000000000
          DataField = 'POR_NOMPOR'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."POR_NOMPOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object ShapeChqVenc: TfrxShapeView
          Left = 442.771653540000000000
          Top = 1.133858270000000000
          Width = 103.937007874015700000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object memChqDtavenc: TfrxMemoView
          Left = 492.897960000000000000
          Top = 4.913385830000000000
          Width = 51.023622050000000000
          Height = 11.338582680000000000
          DataField = 'CHQ_DTAVEN'
          DataSet = frxDBDatasetChqsEmi
          DataSetName = 'frxDBDatasetChqsEmi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsEmi."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memChqVenc: TfrxMemoView
          Left = 445.527559060000000000
          Top = 4.913385830000000000
          Width = 45.440940000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Dta Venc:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
    object ChequesTerceiros: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 40.062992125984200000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetChqsTerceiros
        DataSetName = 'frxDBDatasetChqsTerceiros'
        RowCount = 0
        object Shape19: TfrxShapeView
          Top = 1.000000000000000000
          Width = 136.062992130000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo18: TfrxMemoView
          Left = 20.031496060000000000
          Top = 4.779530000000000000
          Width = 56.692950000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cheq.Rep n'#186)
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape20: TfrxShapeView
          Left = 136.196970000000000000
          Top = 1.000000000000000000
          Width = 102.803149606299000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo19: TfrxMemoView
          Left = 140.456688030000000000
          Top = 4.779530000000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Bco:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape21: TfrxShapeView
          Left = 239.244087170000000000
          Top = 1.000000000000000000
          Width = 75.968503937007900000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo20: TfrxMemoView
          Left = 241.755895750000000000
          Top = 4.779530000000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Ag.:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape22: TfrxShapeView
          Left = 315.212598425197000000
          Top = 1.000000000000000000
          Width = 122.456692910000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo23: TfrxMemoView
          Left = 317.102362204724000000
          Top = 4.425170000000000000
          Width = 22.677180000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'C/C:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape23: TfrxShapeView
          Left = 437.401980000000000000
          Top = 1.000000000000000000
          Width = 113.007874020000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo38: TfrxMemoView
          Left = 439.921230550000000000
          Top = 4.425170000000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Valor:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 77.149660000000000000
          Top = 4.779530000000000000
          Width = 56.692950000000000000
          Height = 11.338582680000000000
          DataField = 'CHQ_NUMCHQ'
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_NUMCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 167.874150000000000000
          Top = 4.779530000000000000
          Width = 64.252010000000000000
          Height = 11.338582680000000000
          DataField = 'CHQ_CODBCO'
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_CODBCO"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 264.378170000000000000
          Top = 4.779530000000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          DataField = 'CHQ_NUMAGE'
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_NUMAGE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 340.323130000000000000
          Top = 4.425170000000000000
          Width = 94.488250000000000000
          Height = 11.338582680000000000
          DataField = 'CHQ_CONCOR'
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_CONCOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape27: TfrxShapeView
          Left = 550.299173540000000000
          Top = 1.000000000000000000
          Width = 166.299251650000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo48: TfrxMemoView
          Left = 554.456653860000000000
          Top = 4.425170000000000000
          Width = 30.236240000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Port.:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 471.661720000000000000
          Top = 4.425170000000000000
          Width = 75.590600000000000000
          Height = 11.338582680000000000
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.ThousandSeparator = '.'
          DisplayFormat.FormatStr = '#,##0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_VALCHQ"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 586.472790000000000000
          Top = 4.425170000000000000
          Width = 128.504020000000000000
          Height = 11.338582680000000000
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."POR_NOMPOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape28: TfrxShapeView
          Left = 3.779530000000000000
          Top = 4.779530000000000000
          Width = 11.338590000000000000
          Height = 11.338590000000000000
        end
        object Memo51: TfrxMemoView
          Left = 4.779530000000000000
          Top = 5.440947320000000000
          Width = 11.338590000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'X')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape26: TfrxShapeView
          Top = 20.031496060000000000
          Width = 314.834645670000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo49: TfrxMemoView
          Left = 20.031496060000000000
          Top = 22.677180000000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Emitente:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Shape33: TfrxShapeView
          Left = 315.212598430000000000
          Top = 20.031496060000000000
          Width = 122.456692910000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo54: TfrxMemoView
          Left = 317.102362200000000000
          Top = 22.677180000000000000
          Width = 56.692950000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Data Vencto:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Shape34: TfrxShapeView
          Left = 437.425480000000000000
          Top = 20.031496060000000000
          Width = 113.007874020000000000
          Height = 18.897637800000000000
          Frame.Width = 0.500000000000000000
        end
        object Memo55: TfrxMemoView
          Left = 439.315243770000000000
          Top = 22.543333940000000000
          Width = 45.354360000000000000
          Height = 11.338582680000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Repasse:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 68.031540000000000000
          Top = 22.677180000000000000
          Width = 241.889920000000000000
          Height = 11.338582680000000000
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_NOMEMI"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 374.173470000000000000
          Top = 22.677180000000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_DTAVEN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 483.779840000000000000
          Top = 22.677180000000000000
          Width = 60.472480000000000000
          Height = 11.338582680000000000
          DataSet = frxDBDatasetChqsTerceiros
          DataSetName = 'frxDBDatasetChqsTerceiros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBDatasetChqsTerceiros."CHQ_DTAREP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object MasterData3: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetCTPDET
        DataSetName = 'frxDBDatasetCTPDET'
        RowCount = 0
        object Memo64: TfrxMemoView
          Left = 73.700787400000000000
          Width = 89.952755910000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxDBDatasetCTPDET'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCTPDET."CODCTA"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo60: TfrxMemoView
          Left = 166.677165350000000000
          Width = 346.960627480000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxDBDatasetCTPDET'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCTPDET."DESCC"]'
            ']')
          ParentFont = False
          WordWrap = False
        end
        object Memo66: TfrxMemoView
          Width = 71.055118110000000000
          Height = 18.897637800000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxDBDatasetCTPDET'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCTPDET."CODEMP"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo68: TfrxMemoView
          Left = 515.795610000000000000
          Width = 82.393700790000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxDBDatasetCTPDET'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCTPDET."VALOR"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo70: TfrxMemoView
          Left = 600.921257400000000000
          Width = 116.409448820000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetCTPDET
          DataSetName = 'frxDBDatasetCTPDET'
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetCTPDET."PORCENT"]%')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 51.606321180000000000
        Top = 98.267780000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo62: TfrxMemoView
          Left = 73.590600000000000000
          Top = 28.929141181102400000
          Width = 89.952768110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd. Pl. Contas')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 166.677165350000000000
          Top = 28.897650000000000000
          Width = 346.960808110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Top = 28.929141180000000000
          Width = 71.055118110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'd. Emp.')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Top = 7.559060000000000000
          Width = 717.354748110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'INFORMA'#199#213'ES DO DESMEMBRAMENTO DA DUPLICATA')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 515.795610000000000000
          Top = 28.795300000000000000
          Width = 82.393708110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 600.724800000000000000
          Top = 28.795300000000000000
          Width = 116.409478110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Porcentual %')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 215.433210000000000000
        Width = 718.110700000000000000
        object Line4: TfrxLineView
          Left = 1.000000000000000000
          Top = 7.559059999999990000
          Width = 714.331170000000000000
          Color = clBlack
          Frame.Style = fsDouble
          Frame.Typ = [ftTop]
        end
      end
    end
    object Page2: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle2: TfrxReportTitle
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object MasterData4: TfrxMasterData
        FillType = ftBrush
        Height = 25.456710000000000000
        Top = 241.889920000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetCADPAG
        DataSetName = 'frxDBDatasetCADPAG'
        RowCount = 0
        Stretched = True
        object Memo72: TfrxMemoView
          Left = -0.440940000000000000
          Top = 2.000000000000000000
          Width = 357.165354330000000000
          Height = 18.897637800000000000
          StretchMode = smActualHeight
          DataSet = frxDBDatasetCADPAG
          DataSetName = 'frxDBDatasetCADPAG'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_HIST02"]'
            '                                           ')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Left = 360.275820000000000000
          Top = 1.779530000000000000
          Width = 357.165354330000000000
          Height = 18.897637800000000000
          StretchMode = smActualHeight
          DataSet = frxDBDatasetCADPAG
          DataSetName = 'frxDBDatasetCADPAG'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_HISBAI"]')
          ParentFont = False
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Height = 20.795300000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo2: TfrxMemoView
          Left = 1.000000000000000000
          Top = 1.000000000000000000
          Width = 716.220472440000000000
          Height = 17.007874020000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Historico do Border'#244)
          ParentFont = False
        end
      end
      object Header3: TfrxHeader
        FillType = ftBrush
        Height = 40.692950000000000000
        Top = 291.023810000000000000
        Width = 718.110700000000000000
        PrintChildIfInvisible = True
        object Memo71: TfrxMemoView
          Width = 717.354748110000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Portador(es)')
          ParentFont = False
        end
        object Memo78: TfrxMemoView
          Top = 21.795300000000100000
          Width = 241.889766220000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo79: TfrxMemoView
          Left = 244.669450000000000000
          Top = 21.574830000000000000
          Width = 472.441096220000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
      end
      object MasterData5: TfrxMasterData
        FillType = ftBrush
        Height = 21.677180000000000000
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetMOVBAN
        DataSetName = 'frxDBDatasetMOVBAN'
        RowCount = 0
        object Memo80: TfrxMemoView
          Left = 244.669450000000000000
          Top = 2.779530000000020000
          Width = 472.818897640000000000
          Height = 18.897637800000000000
          DataSet = frxDBDatasetMOVBAN
          DataSetName = 'frxDBDatasetMOVBAN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDatasetMOVBAN."POR_NOMPOR"]'
            '                                           ')
          ParentFont = False
          WordWrap = False
        end
        object Memo82: TfrxMemoView
          Left = 0.559060000000000000
          Top = 2.779530000000020000
          Width = 241.889771100000000000
          Height = 18.897650000000000000
          DataSet = frxDBDatasetMOVBAN
          DataSetName = 'frxDBDatasetMOVBAN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxDBDatasetMOVBAN."CTB_CODPOR"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Header4: TfrxHeader
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        object Memo76: TfrxMemoView
          Width = 357.165354330000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Hist'#243'rico 2')
          ParentFont = False
        end
        object Memo77: TfrxMemoView
          Left = 359.496290000000000000
          Top = 0.133890000000000000
          Width = 357.165354330000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Hist'#243'rico da Baixa')
          ParentFont = False
        end
      end
      object MasterData6: TfrxMasterData
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDatasetCADPAG
        DataSetName = 'frxDBDatasetCADPAG'
        RowCount = 0
        Stretched = True
        object Memo74: TfrxMemoView
          Left = 73.149660000000000000
          Top = 1.000000000000000000
          Width = 643.653543307087000000
          Height = 18.897637800000000000
          StretchMode = smActualHeight
          DataSet = frxDBDatasetCADPAG
          DataSetName = 'frxDBDatasetCADPAG'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxDBDatasetGenPag."CTP_HIST01"]')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Top = 0.889763780000000000
          Width = 71.810916220000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Hist'#243'rico 1')
          ParentFont = False
        end
      end
    end
  end
  object frxDBDatasetGenPag: TfrxDBDataset
    UserName = 'frxDBDatasetGenPag'
    CloseDataSource = False
    DataSource = dtsGenPag
    BCDToCurrency = False
    Left = 186
    Top = 95
  end
  object frxDBDatasetChqsEmi: TfrxDBDataset
    UserName = 'frxDBDatasetChqsEmi'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CTB_CODPOR=CTB_CODPOR'
      'POR_NOMPOR=POR_NOMPOR'
      'EMI_CODBCO=EMI_CODBCO'
      'EMI_CONCOR=EMI_CONCOR'
      'EMI_NUMAGE=EMI_NUMAGE'
      'EMI_NUMCHQ=EMI_NUMCHQ'
      'CHQ_VALCHQ=CHQ_VALCHQ'
      'CHQ_TIPCHQ=CHQ_TIPCHQ'
      'CHQ_DTAEMI=CHQ_DTAEMI'
      'CHQ_BOMPAR=CHQ_BOMPAR'
      'CHQ_NOMEMI=CHQ_NOMEMI'
      'CHQ_DTAVEN=CHQ_DTAVEN')
    DataSource = dtsChqsEmi
    BCDToCurrency = False
    Left = 186
    Top = 151
  end
  object cdsChqsEmi: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 149
    object cdsChqsEmiCTB_CODPOR: TStringField
      FieldName = 'CTB_CODPOR'
      Size = 200
    end
    object cdsChqsEmiPOR_NOMPOR: TStringField
      FieldName = 'POR_NOMPOR'
      Size = 30
    end
    object cdsChqsEmiEMI_CODBCO: TStringField
      FieldName = 'EMI_CODBCO'
      Size = 200
    end
    object cdsChqsEmiEMI_CONCOR: TStringField
      FieldName = 'EMI_CONCOR'
      Size = 200
    end
    object cdsChqsEmiEMI_NUMAGE: TStringField
      FieldName = 'EMI_NUMAGE'
      Size = 200
    end
    object cdsChqsEmiEMI_NUMCHQ: TStringField
      FieldName = 'EMI_NUMCHQ'
      Size = 200
    end
    object cdsChqsEmiCHQ_VALCHQ: TFloatField
      FieldName = 'CHQ_VALCHQ'
    end
    object cdsChqsEmiCHQ_TIPCHQ: TStringField
      FieldName = 'CHQ_TIPCHQ'
      Size = 30
    end
    object cdsChqsEmiCHQ_DTAEMI: TStringField
      FieldName = 'CHQ_DTAEMI'
      Size = 10
    end
    object cdsChqsEmiCHQ_BOMPAR: TStringField
      FieldName = 'CHQ_BOMPAR'
      Size = 10
    end
    object cdsChqsEmiCHQ_DTAVEN: TStringField
      FieldName = 'CHQ_DTAVEN'
      Size = 30
    end
    object cdsChqsEmiCHQ_NOMEMI: TStringField
      FieldName = 'CHQ_NOMEMI'
      Size = 50
    end
  end
  object frxDBDatasetChqsTerceiros: TfrxDBDataset
    UserName = 'frxDBDatasetChqsTerceiros'
    CloseDataSource = False
    DataSource = dtsChqsTerceiros
    BCDToCurrency = False
    Left = 184
    Top = 196
  end
  object dtsChqsTerceiros: TDataSource
    Left = 280
    Top = 204
  end
  object frxDBDatasetMOVBAN: TfrxDBDataset
    UserName = 'frxDBDatasetMOVBAN'
    CloseDataSource = False
    DataSource = dtsMOVBAN
    BCDToCurrency = False
    Left = 184
    Top = 260
  end
  object dtsMOVBAN: TDataSource
    DataSet = cdsChqsEmi
    Left = 280
    Top = 260
  end
  object frxDBDatasetCTPDET: TfrxDBDataset
    UserName = 'frxDBDatasetCTPDET'
    CloseDataSource = False
    DataSource = dtsCTPDET
    BCDToCurrency = False
    Left = 184
    Top = 44
  end
  object dtsCTPDET: TDataSource
    Left = 280
    Top = 44
  end
  object frxDBDatasetCADPAG: TfrxDBDataset
    UserName = 'frxDBDatasetCADPAG'
    CloseDataSource = False
    DataSource = dtsCADPAG
    BCDToCurrency = False
    Left = 40
    Top = 196
  end
  object dtsCADPAG: TDataSource
    Left = 32
    Top = 252
  end
  object frxPDFExportBordero: TfrxPDFExport
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
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 48
    Top = 32
  end
end
