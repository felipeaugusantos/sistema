inherited frmImportaPrecos: TfrmImportaPrecos
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Importa'#231#227'o de Precos'
  WindowState = wsMaximized
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 784
    ExplicitTop = 517
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 780
      TabOrder = 2
      ExplicitWidth = 780
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 225
        Height = 22
        Caption = '[ F10 ] Atualizar Pre'#231'os nos Cadastros'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnGravarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 701
      TabOrder = 0
      ExplicitLeft = 701
    end
    object btnRelInc: TBitBtnLocked
      Left = 324
      Top = 3
      Width = 181
      Height = 22
      Caption = '[ F8 ] Relat'#243'rio de Inconsist'#234'ncias'
      TabOrder = 1
      OnClick = btnRelIncClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    TabOrder = 2
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  object pnlPath: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lbl1: TLabel
      Left = 16
      Top = 12
      Width = 156
      Height = 14
      Caption = 'Importar pre'#231'os do arquivo XLS:'
    end
    object lbl2: TLabel
      Left = 92
      Top = 38
      Width = 80
      Height = 14
      Caption = 'Pre'#231'o de Venda:'
    end
    object cbbTabPre: TComboBoxFocus
      Tag = 99
      Left = 173
      Top = 33
      Width = 87
      Height = 22
      Style = csDropDownList
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object btnCarregar: TBitBtnLocked
      Left = 622
      Top = 33
      Width = 139
      Height = 22
      Caption = '[ F7 ] Carregar Pre'#231'os'
      TabOrder = 1
      OnClick = btnCarregarClick
    end
    object btnHlpImp: TBitBtnLocked
      Left = 595
      Top = 33
      Width = 24
      Height = 22
      Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnHlpImpClick
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 73
    Width = 784
    Height = 444
    Align = alClient
    TabOrder = 1
    object cxbItens: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '< Nenhum item importado >'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxs2
      Bands = <
        item
          Width = 55
        end
        item
          Width = 706
        end>
      object cxcItensDBBandedTableView1Column1: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column2: TcxGridDBBandedColumn
        Caption = '%Margem Nova'
        DataBinding.FieldName = 'MARNOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 112
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column3: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 73
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column4: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 158
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column5: TcxGridDBBandedColumn
        Caption = 'Uni.'
        DataBinding.FieldName = 'SIGUNI'
        Width = 32
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column6: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda Anterior'
        DataBinding.FieldName = 'PREANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 110
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column7: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda Novo'
        DataBinding.FieldName = 'PRENOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 109
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxcItensDBBandedTableView1Column8: TcxGridDBBandedColumn
        Caption = '%Margem Anterior'
        DataBinding.FieldName = 'MARANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 112
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
    end
    object cxlGrid1Level1: TcxGridLevel
      GridView = cxbItens
    end
  end
  object edtPath: TFilenameEditFocus [4]
    Left = 174
    Top = 8
    Properties.Buttons = <
      item
        Default = True
        Glyph.SourceDPI = 96
        Glyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E0000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000004020FF406040FF406040FF4060
          40FF004020FF0000000000000000000000000000000000000000806040FFC080
          60FFC06060FFC0A080FFA4A0A0FF408060FF40A080FF40C080FF40C080FF40C0
          80FF40A060FF408060FF00000000000000000000000000000000C08060FFFFFF
          FFFFFFFFFFFFC0DCC0FF408060FF40C0A0FF40C0A0FF40A060FF408060FF40A0
          60FF40C0A0FF40C080FF408060FF000000000000000000000000C08060FFFFFF
          FFFFF0FBFFFF80A0A0FF40C0A0FF40E0A0FF40C0A0FF408060FFFFFFFFFF4080
          60FF40E0A0FF40C0A0FF40A080FF004040FF0000000000000000C08060FFFFFF
          FFFFF0FBFFFF40A080FF80E0C0FF40A080FF408060FF408060FFF0FBFFFF4080
          60FF408060FF40A080FF40C0A0FF408060FF0000000000000000C08060FFFFFF
          FFFFFFFFFFFF40A060FF80E0C0FF408060FFC0DCC0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF408060FF40E0A0FF408060FF0000000000000000C08060FFFFFF
          FFFFFFFFFFFF40A080FFC0DCC0FF80A080FF408060FF408060FFFFFFFFFF4080
          60FF408060FF40A080FF80E0C0FF408060FF0000000000000000C08080FFFFFF
          FFFFFFFFFFFF80C0A0FF80C0C0FFF0FBFFFFF0FBFFFF40A080FFF0FBFFFF40A0
          80FFC0DCC0FFC0DCC0FF80C0A0FF406040FF0000000000000000C08080FFFFFF
          FFFFFFFFFFFFF0FBFFFF40A080FFC0DCC0FFF0FBFFFF80C0A0FF40A080FF80A0
          A0FFF0FBFFFFC0DCC0FF40A080FF000000000000000000000000C08080FFFFFF
          FFFFFFFFFFFFFFFFFFFFC0DCC0FF40A080FF80C0C0FFF0FBFFFFF0FBFFFFF0FB
          FFFF80C0C0FF40A080FF004020FF000000000000000000000000C08080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFF80C0C0FF40C080FF40A080FF40C0
          80FF80C0C0FFC0C0C0FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC0A080FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC08080FF00000000000000000000000000000000C0A080FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFC0A080FF00000000000000000000000000000000808060FFC0A0
          80FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A080FFC0A0
          80FFC0A080FF808060FF000000000000000000000000}
        Kind = bkGlyph
      end>
    StyleFocused.Color = clInfoBk
    TabOrder = 4
    Width = 587
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 824
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 856
  end
  object cxs1: TcxStyleRepository
    Left = 128
    Top = 32
    PixelsPerInch = 96
    object cxs2: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object frxInconsistencias: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42103.623466284720000000
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
      'procedure mmoStatusOnBeforePrint(Sender: TfrxComponent);'
      '  Var'
      
        '    strSatus: String;                                           ' +
        '            '
      'begin'
      '  strSatus := <frxRelat."STATUS">;               '
      '  Case strSatus[1] Of'
      
        '    '#39'I'#39': mmoStatus.Text := '#39'ITEM N'#195'O ENCONTRADO'#39';               ' +
        '                          '
      
        '    '#39'T'#39': mmoStatus.Text := '#39'TABELA DE PRE'#199'OS DO FORNCEDOR N'#195'O CA' +
        'DASTRADA'#39';                                         '
      
        '    '#39'P'#39': mmoStatus.Text := '#39'PRE'#199'O DE VENDA ZERADO OU INV'#193'LIDO NO' +
        ' XML'#39';                                         '
      '  End;            '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 696
    Top = 224
    Datasets = <
      item
        DataSet = frxDBInconsistencia
        DataSetName = 'frxRelat'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 17.000000000000000000
        ParentFont = False
        Top = 207.874150000000000000
        Width = 718.110700000000000000
        DataSet = frxDBInconsistencia
        DataSetName = 'frxRelat'
        RowCount = 0
        object mmoZebra: TfrxMemoView
          Width = 718.488179210000000000
          Height = 15.118120000000000000
          DisplayFormat.DecimalSeparator = ','
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -9
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line> Mod 2 = 0'
          Highlight.FillType = ftBrush
        end
        object frxRelatoriofrxRelatorio: TfrxMemoView
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelat."CODITE"]')
        end
        object Memo1: TfrxMemoView
          Left = 49.133890000000000000
          Width = 238.110390000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            '[frxRelat."DESITE"]')
        end
        object Memo2: TfrxMemoView
          Left = 291.023810000000000000
          Top = 0.220470000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelat."PRENOV"]')
        end
        object mmoStatus: TfrxMemoView
          Left = 381.732530000000000000
          Width = 328.819110000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'mmoStatusOnBeforePrint'
          Memo.UTF8W = (
            '[frxRelat."STATUS"]')
        end
      end
      object rlbRodape: TfrxPageFooter
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Height = 30.220470000000000000
        ParentFont = False
        Top = 287.244280000000000000
        Width = 718.110700000000000000
        object rllTotalImpresso: TfrxMemoView
          Left = 363.363760000000000000
          Top = 5.661410000000000000
          Width = 355.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllTotalImpressoOnBeforePrint'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(rlbDetalhes)]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 17.000000000000000000
        ParentFont = False
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Width = 717.732056460000000000
          Height = 15.118110240000000000
          Fill.BackColor = clSilver
        end
        object Memo10: TfrxMemoView
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'C'#211'DIGO - DESCRI'#199#195'O DO ITEM')
        end
        object Memo3: TfrxMemoView
          Left = 291.023810000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'PRE'#199'O NOVO')
        end
        object Memo4: TfrxMemoView
          Left = 381.732530000000000000
          Width = 287.244280000000000000
          Height = 15.118120000000000000
          Memo.UTF8W = (
            'INCONSIST'#202'NCIA')
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 84.984230000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = -5.744650000000000000
          Top = 17.000000000000000000
          Width = 729.600000000000000000
          Height = 17.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMEMP]')
          ParentFont = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 135.042765000000000000
          Top = 34.000000000000000000
          Width = 448.025170000000000000
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
          Left = 599.584230000000000000
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
          Left = 647.584230000000000000
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
          Left = 553.020470000000000000
          Top = 51.000000000000000000
          Width = 90.784230000000000000
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
        object Line2: TfrxLineView
          Align = baWidth
          Top = 75.590600000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBInconsistencia: TfrxDBDataset
    UserName = 'frxRelat'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 648
    Top = 224
  end
end
