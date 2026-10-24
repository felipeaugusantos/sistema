inherited frmPainelMovimentacaoGondola: TfrmPainelMovimentacaoGondola
  Width = 1366
  Height = 621
  Caption = 'Painel de Reposi'#231#227'o G'#244'ndola'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1366
  ExplicitHeight = 621
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 546
    Width = 1360
    Height = 30
    ExplicitTop = 546
    ExplicitWidth = 1360
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 1356
      Height = 26
      ExplicitWidth = 1356
      ExplicitHeight = 26
      object btnEfetivar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 183
        Height = 24
        Caption = '&Gerar Transferencias/Negar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0002000000060000000900000006000000030000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000040000
          000A000000160000001F000000170000000E0000000400000002000000060000
          000A0000000A0000000A0000000A00000007000000040000000A000000120000
          001B3D29239C714C43FF311F1A9C0000001E0000001000000009000000140000
          001B0000001D0000001D0000001B000000140000000D0D09073221161369251A
          1579725145F5C2B0A7FF5F3F36F52316137B1D13106C0B0706380C5435C71073
          48FF107348FF107348FF0F7246FF0A5032C70000000F523B32BC987F76FF8467
          5DFFBFAEA4FFE2D9D2FFC6B7B1FF7D5F56FF896D63FF472F27BE148457FF70F0
          CEFF70F0CEFF47E9BAFF47E9BAFF117D51FF0000000D3C2C287EA48A80FFECE7
          E3FFBDA69CFF9E7E70FFC3AFA6FFEAE2DEFF997C72FF38282381169665FF92F9
          E1FF92F9E1FF92F9E1FF8CF8DDFF158E5EFF00000010000000198A6A5CFCEAE4
          E0FF8B6B5FFF281E1A6D8B6B60FFE7DFD9FF765549FC00000019137A55C117A3
          70FF17A370FF17A370FF18A06CFF13754FC50000001842332C89AC9388FFEFEA
          E6FFB19E98FF755349FFAC978FFFE9E1DCFFA1887EFF3A2A2483000000000000
          00058A6657FF00000016000000160000001A989898A4B9A197FFB7A095FFA88A
          7FFFD9CDC7FFF6F3F1FFD4C5BEFFA4877AFFB1998EFF665146B9000000000000
          00028A6657FF8A6657FF8A6657FF8A6657FF99796CFFEEE8E5FFE1D7D3FF3228
          235997786AF3E2D8D2FF8E6E62F23127225830252153120E0C22000000000000
          000000000000000000140000001E8A6657FF0000001E00000014000000060000
          000257453D8AA28273FF54413A8A000000020000000000000000000000000000
          0000000000009E693CC9CD874CFFCB8549FFCA8347FF9A6334CA000000090000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000D19158FFF0CF9EFFEFCB97FFEDC791FFCC874BFF0000000A0000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000D59861FFF6DFB9FFF5DBB3FFF3D8ADFFCF8D53FF000000090000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000D89F6AFFFBECD0FFFAEACDFFF9E8C9FFD3945CFF000000060000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000A87F58C4DAA36FFFD9A16CFFD89E68FFA4764EC4000000020000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 0
        OnClick = btnEfetivarClick
      end
      object btnMostraEstoque: TBitBtnLocked
        Left = 183
        Top = 0
        Width = 144
        Height = 24
        Caption = '[ F1 ] Definir como Negado'
        TabOrder = 1
        OnClick = btnMostraEstoqueClick
      end
      object BitBtnLocked1: TBitBtnLocked
        Left = 327
        Top = 0
        Width = 152
        Height = 24
        Caption = '[ F2 ] Definir como Autorizado'
        TabOrder = 2
        OnClick = BitBtnLocked1Click
      end
      object BitBtnLocked2: TBitBtnLocked
        Left = 479
        Top = 0
        Width = 152
        Height = 24
        Caption = '[ F3 ] Definir como Indefinido '
        TabOrder = 3
        OnClick = BitBtnLocked2Click
      end
      object btnGerPed: TBitBtnLocked
        Left = 631
        Top = 0
        Width = 136
        Height = 24
        Caption = '&Imprimir Separa'#231#227'o'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
          000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
          FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
          00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
          00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
          FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
          0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
          05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
          55557F7777777555555500000005555555557777777555555555}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnGerPedClick
      end
      object btnReimprime: TBitBtnLocked
        Left = 767
        Top = 0
        Width = 146
        Height = 24
        Caption = '&Reimprimir Separa'#231#227'o'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
          000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
          FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
          00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
          00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
          FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
          0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
          05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
          55557F7777777555555500000005555555557777777555555555}
        NumGlyphs = 2
        TabOrder = 5
        OnClick = btnReimprimeClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1277
      Top = 5
      ExplicitLeft = 1277
      ExplicitTop = 5
    end
  end
  inherited pnlStatus: TPanel
    Top = 576
    Width = 1360
    ExplicitTop = 576
    ExplicitWidth = 1360
    inherited pnlNomeForm: TPanel
      Left = 1189
      ExplicitLeft = 1189
    end
    inherited pnlInfo: TPanel
      Width = 1189
      ExplicitWidth = 1189
    end
  end
  object cxDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1360
    Height = 528
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
    end
    object cxgSolicitacao: TcxGridDBBandedTableViewCitel
      OnKeyPress = cxgSolicitacaoKeyPress
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgSolicitacaoCustomDrawCell
      OnEditKeyPress = cxgSolicitacaoEditKeyPress
      OnFocusedItemChanged = cxgSolicitacaoFocusedItemChanged
      OnFocusedRecordChanged = cxgSolicitacaoFocusedRecordChanged
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Bands = <
        item
          FixedKind = fkLeft
          Options.Sizing = False
          Width = 300
        end
        item
          Caption = 'Dados da Solicita'#231#227'o'
          Width = 1529
        end
        item
          Caption = 'Origem'
          FixedKind = fkRight
          Width = 392
        end>
      Zebra = False
      Destaque = False
      DestacarRegistro = False
      CorZebra = clMoneyGreen
      object cxgSolicitacaoSOL_STATUS: TcxGridDBBandedColumn
        Caption = 'A'#231#227'o'
        DataBinding.FieldName = 'SOL_STATUS'
        OnGetDisplayText = cxgSolicitacaoSOL_STATUSGetDisplayText
        Options.Editing = False
        Width = 88
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_DTASOL: TcxGridDBBandedColumn
        Caption = 'Dta. Solicita'#231#227'o'
        DataBinding.FieldName = 'SOL_DTASOL'
        PropertiesClassName = 'TcxLabelProperties'
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn3: TcxGridDBBandedColumn
        Caption = 'Operador Solicita'#231#227'o'
        DataBinding.FieldName = 'OPESOL'
        Options.Editing = False
        Width = 200
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn4: TcxGridDBBandedColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'SOL_CODITE'
        Options.Editing = False
        Width = 61
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn5: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 260
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn6: TcxGridDBBandedColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Options.Editing = False
        Width = 160
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn7: TcxGridDBBandedColumn
        Caption = 'Unid.'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Options.Editing = False
        Width = 89
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn8: TcxGridDBBandedColumn
        Caption = 'Localiza'#231#227'o Fisica'
        DataBinding.FieldName = 'SOL_LOCFIS'
        Options.Editing = False
        Width = 104
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_NUMLOT: TcxGridDBBandedColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'SOL_NUMLOT'
        Options.Editing = False
        Width = 105
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_QTDITE: TcxGridDBBandedColumn
        Caption = 'Qtd. Solicitada'
        DataBinding.FieldName = 'SOL_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 93
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_FISORI: TcxGridDBBandedColumn
        Caption = 'Localiza'#231#227'o Fisica'
        DataBinding.FieldName = 'SOL_FISORI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_LOTORI: TcxGridDBBandedColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'SOL_LOTORI'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 100
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_QTDATD: TcxGridDBBandedColumn
        Caption = 'Qtd. Atendida'
        DataBinding.FieldName = 'SOL_QTDATD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.OnValidate = cxgSolicitacaoSOL_QTDATDPropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Width = 86
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSALDIS: TcxGridDBBandedColumn
        Caption = 'Sald. Dispon.'
        DataBinding.FieldName = 'SALDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgSolicitacaoMARCAD: TcxGridDBBandedColumn
        DataBinding.FieldName = 'MARCAD'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgSolicitacaoTEM_LOTE: TcxGridDBBandedColumn
        DataBinding.FieldName = 'TEM_LOTE'
        Visible = False
        GroupSummaryAlignment = taRightJustify
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgSolicitacaoSOL_OBSERV: TcxGridDBBandedColumn
        Caption = 'Observa'#231#227'o da Solicita'#231#227'o'
        DataBinding.FieldName = 'SOL_OBSERV'
        Options.Editing = False
        Width = 352
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn1: TcxGridDBBandedColumn
        Caption = 'Impresso?'
        DataBinding.FieldName = 'SOL_IMPREA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 61
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgSolicitacaoColumn2: TcxGridDBBandedColumn
        Caption = 'Operador Separa'#231#227'o'
        DataBinding.FieldName = 'OPESEL'
        Options.Editing = False
        Width = 151
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgSolicitacao
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 528
    Width = 1360
    Height = 18
    Align = alBottom
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 1358
      Height = 16
      Align = alClient
      Caption = 
        '    [F5]-Marca Todos    [F6]-Desmarca Todos    [Espa'#231'o]- Marca/D' +
        'esmarca]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 2
      ExplicitTop = 6
    end
  end
  object dtsDados: TDataSource
    Left = 504
    Top = 320
  end
  object dtsAcao: TDataSource
    DataSet = dxMemData1
    Left = 712
    Top = 272
  end
  object cxEditRepository1: TcxEditRepository
    Left = 672
    Top = 296
    PixelsPerInch = 96
    object cxLkpAcao: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'KEY'
      Properties.ListColumns = <
        item
          FieldName = 'VALOR'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsAcao
    end
  end
  object dxMemData1: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F0200000004000000030004004B4559000A00000001
      00060056414C4F52000100000000010A000000496E646566696E69646F010100
      000001060000004E656761646F0102000000010A0000004175746F72697A6164
      6F}
    SortOptions = []
    Left = 1072
    Top = 264
    object dxMemData1KEY: TIntegerField
      FieldName = 'KEY'
    end
    object dxMemData1VALOR: TStringField
      FieldName = 'VALOR'
      Size = 10
    end
  end
end
