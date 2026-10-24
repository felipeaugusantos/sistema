object frmQckLoteSeparacaoWMS: TfrmQckLoteSeparacaoWMS
  Left = 0
  Top = 0
  Caption = 'frmQckLoteSeparacaoWMS'
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
  object frxReport: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39422.366011261600000000
    ReportOptions.LastChange = 44257.623447361110000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      'end.')
    Left = 136
    Top = 56
    Datasets = <
      item
        DataSet = frxMovGer
        DataSetName = 'frxMovGer'
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
      LeftMargin = 7.500000000000000000
      RightMargin = 7.500000000000000000
      TopMargin = 7.500000000000000000
      BottomMargin = 7.500000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      Frame.Width = 2.000000000000000000
      object frxPageHeader: TfrxPageHeader
        FillType = ftBrush
        Height = 120.972690000000000000
        Top = 18.897650000000000000
        Width = 737.008350000000000000
        object memo1: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Width = 483.840000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[<frxMovGer."NOMEMP">]')
          ParentFont = False
        end
        object NROPG2: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 622.188000000000000000
          Top = 92.610000000000000000
          Width = 109.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]/[TotalPages#]')
          ParentFont = False
        end
        object memo2: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.134000000000000000
          Top = 88.074000000000000000
          Width = 735.588000000000000000
          Height = 3.780000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          WordWrap = False
        end
        object memo3: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 92.610000000000000000
          Width = 617.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'SEPARA'#199#195'O N'#186' '#39' + <frxMovger."NUMLOT">')
          ParentFont = False
          WordWrap = False
        end
        object memo4: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 15.120000000000000000
          Width = 483.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxMovger."EENDER">  + '#39', '#39' + <frxMovger."EENDNU">  + '#39' '#39' + <f' +
              'rxMovger."EBAIRR">]')
          ParentFont = False
          WordWrap = False
        end
        object memo5: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 28.728000000000000000
          Width = 483.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxMovger."ENDNCI">  + '#39' - '#39' + <frxMovger."EESTAD">  + '#39' - CEP' +
              ': '#39' + <frxMovger."EMPCEP">]')
          ParentFont = False
          WordWrap = False
        end
        object memo6: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 42.336000000000000000
          Width = 200.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '['#39'CNPJ: '#39' + <frxMovger."CGCEMP">]')
          ParentFont = False
          WordWrap = False
        end
        object memo7: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.480000000000000000
          Top = 69.552000000000010000
          Width = 200.000000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '['#39'Fone: '#39' + FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxMovger."EMP' +
              'FO1">)]')
          ParentFont = False
          WordWrap = False
        end
        object memo8: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 458.136000000000000000
          Top = 42.336000000000000000
          Width = 263.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '['#39'IE: '#39' + <frxMovger."IESEMP">]')
          ParentFont = False
          WordWrap = False
        end
        object memo9: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 458.136000000000000000
          Top = 69.552000000000010000
          Width = 262.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '['#39'Fax: '#39' + FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxMovger."FAXE' +
              'MP">)]')
          ParentFont = False
          WordWrap = False
        end
        object memo10: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 249.102000000000000000
          Top = 55.944000000000000000
          Width = 483.840000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."EMAEMP">]')
          ParentFont = False
        end
      end
      object HeaderData1: TfrxHeader
        FillType = ftBrush
        Height = 18.900000000000000000
        Top = 200.315090000000000000
        Width = 737.008350000000000000
        OnBeforePrint = 'HeaderOnBeforePrint'
        ReprintOnNewPage = True
        object mmoCorHeaderData: TfrxMemoView
          Align = baClient
          Width = 737.008350000000000000
          Height = 18.900000000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clSilver
        end
        object memo11: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 175.014000000000000000
          Width = 3.024000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object memo12: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 297.864000000000000000
          Width = 3.024000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object memo13: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 123.000000000000000000
          Top = 2.268000000000086000
          Width = 49.140000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'C'#211'DIGO'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo14: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 306.180000000000000000
          Top = 2.268000000000086000
          Width = 260.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'DESCRI'#199#195'O / REFER'#202'NCIA'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo15: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 260.064000000000000000
          Top = 2.268000000000086000
          Width = 34.020000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'UNID.'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo16: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 179.928000000000000000
          Top = 2.268000000000086000
          Width = 75.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '['#39'QUANTIDADE'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo17: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 117.000000000000000000
          Width = 3.000000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
        object memo18: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.890000000000000000
          Top = 2.268000000000086000
          Width = 100.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'LOCALIZA'#199#195'O'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo19: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 257.040000000000000000
          Width = 3.024000000000000000
          Height = 18.144000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          ParentFont = False
          WordWrap = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 14.360000000000000000
        Top = 241.889920000000000000
        Width = 737.008350000000000000
        Columns = 1
        ColumnWidth = 737.100000000000000000
        DataSet = frxMovGer
        DataSetName = 'frxMovGer'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 737.008350000000000000
          Height = 14.360000000000000000
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> Mod 2 = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clActiveBorder
        end
        object memo20: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 179.928000000000000000
          Width = 74.844000000000000000
          Height = 13.986000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<frxMovger."QTDITE">]')
          ParentFont = False
        end
        object memo21: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 306.936000000000000000
          Width = 138.000000000000000000
          Height = 14.000000000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."DESITE">]')
          ParentFont = False
        end
        object memo22: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 123.000000000000000000
          Width = 46.000000000000000000
          Height = 13.986000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."CODITE">]')
          ParentFont = False
        end
        object memo23: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 260.000000000000000000
          Width = 34.020000000000000000
          Height = 13.986000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."SIGUNI">]')
          ParentFont = False
        end
        object memo24: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.890000000000000000
          Width = 109.000000000000000000
          Height = 14.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."LOCFIS">]')
          ParentFont = False
        end
      end
      object PageFooter: TfrxPageFooter
        FillType = ftBrush
        Height = 113.400000000000000000
        Top = 317.480520000000000000
        Width = 737.008350000000000000
        object memo25: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 0.961999999999079600
          Width = 735.588000000000000000
          Height = 4.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          WordWrap = False
        end
        object memo26: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 48.099999999999910000
          Width = 735.588000000000000000
          Height = 3.780000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          WordWrap = False
        end
        object memo27: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 52.099999999999910000
          Width = 60.480000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'Vendedor:'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo28: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 52.099999999999910000
          Width = 440.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."CODVEN">  + '#39' - '#39' + <frxMovger."NOMVEN">]')
          ParentFont = False
          WordWrap = False
        end
        object memo29: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 5.175999999999988000
          Width = 98.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'Transportadora:'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo30: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 102.816000000000000000
          Top = 5.175999999999988000
          Width = 625.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxMovger."CODTRA">  + '#39' - '#39' + <frxMovger."NOMTRA">  + '#39'  FONE' +
              ': '#39' + FormatMaskText('#39'(99)99999-9999;0;_'#39' ,<frxMovGer."FONTRA">)' +
              ']')
          ParentFont = False
          WordWrap = False
        end
        object memo31: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 1.000000000000000000
          Top = 66.099999999999910000
          Width = 66.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'Digitador:'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo32: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 73.000000000000000000
          Top = 66.100000000000030000
          Width = 656.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[<frxMovger."CODDIG">  + '#39' - '#39' + <frxMovger."NOMDIG">]')
          ParentFont = False
          WordWrap = False
        end
        object memo33: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Top = 18.928000000000000000
          Width = 97.902000000000000000
          Height = 15.120000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '['#39'Entrega:'#39']')
          ParentFont = False
          WordWrap = False
        end
        object memo34: TfrxMemoView
          Description = '#18#27#80#27#87#49'
          Left = 102.816000000000000000
          Top = 18.928000000000000000
          Width = 626.000000000000000000
          Height = 15.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            
              '[<frxMovger."ETENDE">  + '#39' - '#39' + <frxMovger."ETBAIR">  + '#39' - '#39' +' +
              ' <frxMovger."ETNCID">  + '#39' - '#39' + <frxMovger."ETESTA">]')
          ParentFont = False
          WordWrap = False
        end
      end
    end
  end
  object frxMovGer: TfrxDBDataset
    UserName = 'frxMovGer'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 136
    Top = 112
  end
end
