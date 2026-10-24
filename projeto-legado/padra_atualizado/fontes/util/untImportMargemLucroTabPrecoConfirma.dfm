inherited frmImportMargemLucroTabPrecoConfirma: TfrmImportMargemLucroTabPrecoConfirma
  Width = 791
  Height = 536
  BorderStyle = bsSizeable
  Caption = 'Confirma'#231#227'o'
  WindowState = wsMaximized
  ExplicitWidth = 791
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 454
    Width = 775
    ExplicitTop = 454
    ExplicitWidth = 775
    inherited btnSair: TBitBtnLocked
      Left = 694
      Top = 2
      TabOrder = 2
      ExplicitLeft = 694
      ExplicitTop = 2
    end
    object btnVisProdNaoImp: TBitBtnLocked
      Left = 77
      Top = 2
      Width = 196
      Height = 22
      Caption = 'Visualizar Relat'#243'rio de Criticas'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000030000000C000000120000001400000014000000150000
        0015000000140000000D00000003000000000000000000000000000000000000
        00000000000000000009896256C2BD8A78FFBE8A78FFBD8A78FFBD8978FFBD89
        78FFBE8978FF876356C30000000B000000000000000000000000000000030000
        000E0000001500000021C08D7CFFF6EEE9FFF5EDE9FFF5EDE9FFF5ECE8FFF4EC
        E8FFF5ECE7FFBF8D7BFF00000026000000180000000F000000040000000C7B50
        42C5A76E5BFF9F6755FFC2917FFFF7F0ECFFE2B47DFFE2B37AFFE1B077FFE0AE
        72FFF6EEEAFFC2907FFF845545FF895847FF613E32C70000000E00000011BB7E
        6BFFECD9CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFE0B1
        76FFF7F0EDFFC59483FFE0CBBCFFEBD8CBFFB67763FF0000001400000010BE85
        71FFF1E5DAFFECDBD0FF7A4835FF7A4835FF7A4835FF7A4835FF7A4835FF7A48
        35FF7A4835FF7A4835FFEBDBCFFFF1E2D8FFB97C69FF000000130000000EC28B
        78FFF5EEE7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7
        DDFFF2E7DEFFF2E7DDFFF2E5DEFFF5EDE6FFBC826EFF000000120000000CC793
        7FFFFAF4F1FFCDBEB8FF6F5448FF614337FF614035FF5F3F34FF5E3F33FF5D3D
        32FF5D3D34FF6A4C44FFCABCB6FFF9F5F1FFC18875FF000000100000000ACC99
        86FFFDFAFAFF7D6054FF745043FF744F43FF744E43FF734E43FF734E42FF724D
        42FF724C41FF724C40FF73584DFFFDFAFAFFC58F7CFF0000000E00000008CF9F
        8DFFFFFFFFFF7A5A4CFF8E695AFFF9F4F1FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5
        DEFFF6EFEBFF866253FF704F43FFFFFFFFFFCA9683FF0000000B00000005BE95
        84E9F5ECE8FF866656FF977262FFFAF6F4FFF2E8E3FFF1E8E1FFF1E7E2FFF1E7
        E1FFF8F2EEFF8E6A5BFF7A5B4CFFF5EAE6FFBA8E7DEA00000008000000023429
        2545A78375CC947262FFA07B6AFFFCF9F8FFF3EBE6FFF4EAE5FFF2EAE5FFF3EA
        E3FFF9F5F3FF977263FF876658FFA68072CE3428234800000003000000000000
        0001000000030000000AC89B89FFFDFBFAFFF5EDE8FFF4EDE8FFF5EDE7FFF5EC
        E7FFFBF7F6FFC59685FF00000011000000040000000200000000000000000000
        00000000000000000005CA9E8DFFFEFCFCFFF7F0ECFFF6EFEBFFF7EFEBFFF5EF
        EAFFFCFAF8FFC89A89FF00000009000000000000000000000000000000000000
        00000000000000000003CDA291FFFEFEFDFFFEFDFDFFFEFDFCFFFEFCFCFFFEFC
        FBFFFDFBFAFFCB9F8DFF00000007000000000000000000000000000000000000
        000000000000000000019A796DBFCFA493FFCEA493FFCEA493FFCEA492FFCDA3
        91FFCDA391FF98786BC100000004000000000000000000000000}
      ModalResult = 1
      TabOrder = 1
      OnClick = btnVisProdNaoImpClick
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 775
    Height = 454
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive, fcoShowOperatorDescription]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir o filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensViewCodIte: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        BestFitMaxWidth = 20
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 60
      end
      object cxgItensViewDesIte: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DesIte'
        Width = 228
      end
      object cxgItensViewCodFab: TcxGridDBColumn
        Caption = 'C'#243'd. Fabr.'
        DataBinding.FieldName = 'CodFab'
        Width = 111
      end
      object cxgItensViewMarT1A: TcxGridDBColumn
        Caption = '% Margem 1 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR1'
        Width = 105
      end
      object cxgItensViewMarT1N: TcxGridDBColumn
        Caption = '% Margem 1 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR1_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE1'
        Width = 118
      end
      object cxgItensViewTabPreN1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE1_NOV'
        Width = 118
      end
      object cxgItensViewMarT2A: TcxGridDBColumn
        Caption = '% Margem 2 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR2'
        Width = 105
      end
      object cxgItensViewMarT2N: TcxGridDBColumn
        Caption = '% Margem 2 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR2_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2(Atual)'
        DataBinding.FieldName = 'ITE_PREVE2'
        Width = 118
      end
      object cxgItensViewTabPreN2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE2_NOV'
        Width = 118
      end
      object cxgItensViewMarT3A: TcxGridDBColumn
        Caption = '% Margem 3 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR3'
        Width = 105
      end
      object cxgItensViewMarT3N: TcxGridDBColumn
        Caption = '% Margem 3 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR3_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE3'
        Width = 118
      end
      object cxgItensViewTabPreN3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE3_NOV'
        Width = 118
      end
      object cxgItensViewMarT4A: TcxGridDBColumn
        Caption = '% Margem 4 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR4'
        Width = 105
      end
      object cxgItensViewMarT4N: TcxGridDBColumn
        Caption = '% Margem 4 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR4_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE4'
        Width = 118
      end
      object cxgItensViewTabPreN4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE4_NOV'
        Width = 118
      end
      object cxgItensViewMarT5A: TcxGridDBColumn
        Caption = '% Margem 5 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR5'
        Width = 105
      end
      object cxgItensViewMarT5N: TcxGridDBColumn
        Caption = '% Margem 5 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR5_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE5'
        Width = 118
      end
      object cxgItensViewTabPreN5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE5_NOV'
        Width = 118
      end
      object cxgItensViewMarT6A: TcxGridDBColumn
        Caption = '% Margem 6 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR6'
        Width = 105
      end
      object cxgItensViewMarT6N: TcxGridDBColumn
        Caption = '% Margem 6 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR6_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE6'
        Width = 118
      end
      object cxgItensViewTabPreN6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE6_NOV'
        Width = 118
      end
      object cxgItensViewMarT7A: TcxGridDBColumn
        Caption = '% Margem 7 (Atual)'
        DataBinding.FieldName = 'ITE_MARBR7'
        Width = 105
      end
      object cxgItensViewMarT7N: TcxGridDBColumn
        Caption = '% Margem 7 (Nova)'
        DataBinding.FieldName = 'ITE_MARBR7_NOV'
        Width = 105
      end
      object cxgItensViewTabPreA7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7 (Atual)'
        DataBinding.FieldName = 'ITE_PREVE7'
        Width = 118
      end
      object cxgItensViewTabPreN7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7 (Novo)'
        DataBinding.FieldName = 'ITE_PREVE7_NOV'
        Width = 118
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 482
    Width = 775
    ExplicitTop = 482
    ExplicitWidth = 775
    inherited pnlNomeForm: TPanel
      Left = 604
      ExplicitLeft = 604
    end
    inherited pnlInfo: TPanel
      Width = 604
      ExplicitWidth = 604
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 568
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 32
  end
  object dtsDados: TDataSource
    Left = 304
    Top = 32
  end
  object frxRelatorio: TfrxDBDataset
    Description = 'Dados do relat'#243'rio'
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 224
    Top = 32
  end
  object frxGen: TfrxUserDataSet
    UserName = 'frxGen'
    Fields.Strings = (
      'EMP_NOMEMP'
      'REL_NOMREL')
    OnGetValue = frxGenGetValue
    Left = 176
    Top = 32
  end
  object frxRepNaoImp: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42160.701267916670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."DESEXC"> = '#39#39' then'
      
        '    chdObservacao.Visible := False                              ' +
        '    '
      '  else'
      '    chdObservacao.Visible := True;'
      
        '  mmoZebra2.Visible := not mmoZebra2.Visible;                   ' +
        '                                                                ' +
        '                        '
      'end;'
      ''
      'procedure chdObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  mmoZebra2.Color := mmoZebra.Color  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 136
    Top = 96
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
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
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 200.315090000000000000
        Width = 748.800000012278100000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxRepNaoImp.chdObservacao
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 748.800000012278100000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 63.118110240000000000
          Width = 113.385804800000000000
          Height = 15.118120000000000000
          DataField = 'CODBAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 182.173228350000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DataField = 'CODFOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 262.677165350000000000
          Width = 102.047241650000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 369.637795280000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR1_NOV"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 424.818897640000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR2_NOV"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 478.866141730000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR3_NOV"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 532.535433070000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR4_NOV"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 586.960629920000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR5_NOV"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 641.385826770000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR6_NOV"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 695.811023620000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_MARBR7_NOV"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 321.260050000000000000
        Width = 748.800000012278100000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 158.740260000000000000
        Width = 748.800000012278100000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 748.800000012278100000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.267716540000009000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 63.252010000000000000
          Top = 1.267716540000009000
          Width = 113.385804800000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Barras')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 182.196828430000000000
          Top = 1.267716540000009000
          Width = 75.590504800000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd. Fornec.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 262.567100000000000000
          Top = 1.267716540000009000
          Width = 102.047214800000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Fabrica')
          ParentFont = False
        end
        object mmoMarg1: TfrxMemoView
          Left = 369.732530000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B. 1')
          ParentFont = False
        end
        object mmoMarg2: TfrxMemoView
          Left = 424.645950000000000000
          Top = 1.267716540000009000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B. 2')
          ParentFont = False
        end
        object mmoMarg3: TfrxMemoView
          Left = 478.779840000000000000
          Top = 1.267716540000009000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B. 3')
          ParentFont = False
        end
        object mmoMarg4: TfrxMemoView
          Left = 532.693260000000000000
          Top = 1.267716540000009000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B. 4')
          ParentFont = False
        end
        object mmoMarg5: TfrxMemoView
          Left = 586.827150000000000000
          Top = 1.267716540000009000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B.5')
          ParentFont = False
        end
        object mmoMarg6: TfrxMemoView
          Left = 641.520100000000000000
          Top = 1.267716540000009000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B.6')
          ParentFont = False
        end
        object mmoMarg7: TfrxMemoView
          Left = 695.653990000000000000
          Top = 1.000000000000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'Mar B.7')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 18.897650000000000000
        Width = 748.800000012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 9.600000006139060000
          Top = 9.440940000000001000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 129.600000006139100000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 681.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object chdObservacao: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 241.889920000000000000
        Width = 748.800000012278100000
        OnBeforePrint = 'chdObservacaoOnBeforePrint'
        Stretched = True
        object mmoZebra2: TfrxMemoView
          Align = baClient
          Width = 748.800000012278100000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          UseDefaultCharset = True
        end
        object Memo24: TfrxMemoView
          Left = 3.999999999999999000
          Top = 1.559059999999988000
          Width = 740.787848270000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESEXC"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = -1.220470000000000000
          Top = 15.897650000000030000
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxRepNaoImp2: TfrxReport
    Version = '5.3.14'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42160.701267916700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalImp' +
        'resso.Text;                                                     ' +
        '               '
      'end;'
      '  '
      'procedure rlbDetalhesOnAfterPrint(Sender: TfrxComponent);'
      'begin'
      '  if <frxRelatorio."DESEXC"> = '#39#39' then'
      
        '    chdObservacao.Visible := False                              ' +
        '    '
      '  else'
      '    chdObservacao.Visible := True;'
      
        '  mmoZebra2.Visible := not mmoZebra2.Visible;                   ' +
        '                                                                ' +
        '                        '
      'end;'
      ''
      'procedure chdObservacaoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '//  mmoZebra2.Color := mmoZebra.Color  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 104
    Top = 200
    Datasets = <
      item
        DataSet = frxGen
        DataSetName = 'frxGen'
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
    object qckPagina: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      PaperWidth = 203.199868770000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 200.315090000000000000
        Width = 748.800000012278100000
        OnAfterPrint = 'rlbDetalhesOnAfterPrint'
        Child = frxRepNaoImp2.chdObservacao
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        RowCount = 0
        Stretched = True
        object mmoZebra: TfrxMemoView
          Align = baClient
          Width = 748.800000012278100000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
          ParentFont = False
          UseDefaultCharset = True
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          DataField = 'CODITE'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."CODITE"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 63.118110240000000000
          Width = 113.385804800000000000
          Height = 15.118120000000000000
          DataField = 'CODBAR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODBAR"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 182.173228350000000000
          Width = 75.590551180000000000
          Height = 15.118120000000000000
          DataField = 'CODFOR'
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFOR"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 262.677165350000000000
          Width = 102.047241650000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."CODFAB"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 369.637795280000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE1_NOV"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 424.818897640000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE2_NOV"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 478.866141730000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE3_NOV"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 532.535433070000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE4_NOV"]')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 586.960629920000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE5_NOV"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 641.385826770000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE6_NOV"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 695.811023620000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREVE7_NOV"]')
          ParentFont = False
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 321.260050000000000000
        Width = 748.800000012278100000
        object rllNomeForm: TfrxMemoView
          Left = 1.600000000000000000
          Top = 17.000000000000000000
          Width = 374.400000000000000000
          Height = 17.000000000000000000
          DataField = 'REL_NOMREL'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            '[frxGen."REL_NOMREL"]')
          ParentFont = False
        end
        object rllTotalImpresso: TfrxMemoView
          Left = 393.600000000000000000
          Top = 17.000000000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 158.740260000000000000
        Width = 748.800000012278100000
        ReprintOnNewPage = True
        object Memo1: TfrxMemoView
          Align = baClient
          Width = 748.800000012278100000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.267716540000010000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 63.252010000000000000
          Top = 1.267716540000010000
          Width = 113.385804800000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Barras')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 182.196828430000000000
          Top = 1.267716540000010000
          Width = 75.590504800000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'd. Fornec.')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 262.567100000000000000
          Top = 1.267716540000010000
          Width = 102.047214800000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'C'#243'digo de Fabrica')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 369.732530000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 1')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 424.645950000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 2')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 478.779840000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 3')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 532.693260000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 4')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 586.827150000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 5')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 641.520100000000000000
          Top = 1.267716540000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 6')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 695.653990000000000000
          Top = 1.000000000000000000
          Width = 49.133858270000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'P. VEN 7')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 77.425170000000000000
        Top = 18.897650000000000000
        Width = 748.800000012278100000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 9.600000006139060000
          Top = 9.440940000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          DataField = 'EMP_NOMEMP'
          DataSet = frxGen
          DataSetName = 'frxGen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxGen."EMP_NOMEMP"]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 129.600000006139100000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
        object rllPagina: TfrxMemoView
          Left = 633.600000000000000000
          Top = 34.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Left = 681.600000000000000000
          Top = 51.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
        object Date: TfrxMemoView
          Left = 556.800000000000000000
          Top = 51.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
      end
      object chdObservacao: TfrxChild
        FillType = ftBrush
        Height = 18.897650000000000000
        Top = 241.889920000000000000
        Width = 748.800000012278100000
        OnBeforePrint = 'chdObservacaoOnBeforePrint'
        Stretched = True
        object mmoZebra2: TfrxMemoView
          Align = baClient
          Width = 748.800000012278100000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          UseDefaultCharset = True
        end
        object Memo24: TfrxMemoView
          Left = 4.000000000000000000
          Top = 1.559060000000000000
          Width = 740.787848270000000000
          Height = 11.338590000000000000
          StretchMode = smMaxHeight
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.FormatStr = '#0.00'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[frxRelatorio."DESEXC"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = -1.220470000000000000
          Top = 15.897650000000000000
          Width = 748.346940000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
end
