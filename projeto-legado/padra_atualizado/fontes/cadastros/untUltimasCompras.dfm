inherited frmUltimasCompras: TfrmUltimasCompras
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = #218'ltimas Compras'
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 784
    TabOrder = 2
    ExplicitTop = 517
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 780
      ExplicitWidth = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 701
      ExplicitLeft = 701
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    TabOrder = 4
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
  object pnlOpcoes: TPanel [2]
    Left = 0
    Top = 65
    Width = 784
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object rdgEmpresas: TRadioGroup
      Left = 14
      Top = 6
      Width = 616
      Height = 39
      Caption = 'Exibir compras'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'da empresa logada'
        'de todas as empresas')
      TabOrder = 0
      OnClick = rdgEmpresasClick
    end
    object btnCfgGri: TBitBtnLocked
      Left = 641
      Top = 19
      Width = 131
      Height = 22
      Caption = 'Confi&gura colunas '
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
        00090000000E0000000F00000010000000100000001100000011000000110000
        00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
        4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
        ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
        6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
        9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
        71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
        64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
        75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
        B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
        78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
        BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
        7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
        BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
        7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
        C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
        84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
        C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
        87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
        D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
        8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
        97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
        8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
        AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
        91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
        F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
        95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
        FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
        6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
        93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
      TabOrder = 1
      OnClick = btnCfgGriClick
    end
  end
  object cxgUltCmp: TcxGridCitel [3]
    Left = 0
    Top = 115
    Width = 784
    Height = 402
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgUltCmpView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsCompras
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgUltCmpDTA_MOV: TcxGridDBColumn
        Caption = 'Data Mov.'
        DataBinding.FieldName = 'DTA_MOV'
        SortIndex = 0
        SortOrder = soDescending
        Width = 68
      end
      object cxgUltCmpHOR_MOV: TcxGridDBColumn
        Caption = 'Hora Mov.'
        DataBinding.FieldName = 'HOR_MOV'
        SortIndex = 1
        SortOrder = soDescending
        Width = 70
      end
      object cxgUltCmpNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Width = 80
      end
      object cxgUltCmpESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        Width = 29
      end
      object cxgUltCmpCODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CODEMP'
        Width = 31
      end
      object cxgUltCmpDTADOC: TcxGridDBColumn
        Caption = 'Data Doc.'
        DataBinding.FieldName = 'DTADOC'
        Width = 60
      end
      object cxgUltCmpPEDCOM: TcxGridDBColumn
        Caption = 'Ped. Compra'
        DataBinding.FieldName = 'PEDCOM'
        Width = 80
      end
      object cxgUltCmpFORNECEDOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'FORNECEDOR'
        Width = 217
      end
      object cxgUltCmpUNICOM: TcxGridDBColumn
        Caption = 'Un. Compra'
        DataBinding.FieldName = 'UNICOM'
        Width = 62
      end
      object cxgUltCmpUNIVEN: TcxGridDBColumn
        Caption = 'Un. Venda'
        DataBinding.FieldName = 'UNIVEN'
        Width = 60
      end
      object cxgUltCmpQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 72
      end
      object cxgUltCmpPR_UNITARIO: TcxGridDBColumn
        Caption = 'Unit'#225'rio'
        DataBinding.FieldName = 'PR_UNITARIO'
        HeaderAlignmentHorz = taRightJustify
        Width = 69
      end
      object cxgUltCmpPR_TOTAL: TcxGridDBColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'PR_TOTAL'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 82
      end
      object cxgUltCmpPR_UNITIMP: TcxGridDBColumn
        Caption = 'Unit.c/ Impostos'
        DataBinding.FieldName = 'PR_UNITIMP'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxgUltCmpTOTIMP: TcxGridDBColumn
        Caption = 'Total c/ Impostos'
        DataBinding.FieldName = 'TOTIMP'
        HeaderAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxgUltCmpOPERAD: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'OPERAD'
        Width = 151
      end
      object cxgUltCmpCONPAG: TcxGridDBColumn
        Caption = 'Cond. Pag'
        DataBinding.FieldName = 'CONPAG'
        Width = 150
      end
      object cxgUltCmpViewCFOP: TcxGridDBColumn
        Caption = 'CFOP'
        DataBinding.FieldName = 'CLAFIS'
      end
    end
    object cxgUltCmpLevel1: TcxGridLevel
      GridView = cxgUltCmpView
    end
  end
  object pnlFornecedor: TPanel [4]
    Left = 0
    Top = 0
    Width = 784
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object rdgFornecedor: TRadioGroup
      Left = 14
      Top = 8
      Width = 616
      Height = 57
      Caption = 'Fornecedor'
      ItemIndex = 1
      Items.Strings = (
        'da Entrada de Mercadorias'
        'Todos')
      TabOrder = 0
      OnClick = rdgFornecedorClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 296
  end
  object dtsCompras: TDataSource
    Left = 424
    Top = 320
  end
end
