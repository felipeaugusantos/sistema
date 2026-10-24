inherited frmSpoolTransferenciaEdicao: TfrmSpoolTransferenciaEdicao
  Width = 1024
  Height = 695
  BorderStyle = bsSizeable
  Caption = 'Transfer'#234'ncia de produtos entre lojas'
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 695
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 614
    Width = 1008
    TabOrder = 1
    ExplicitTop = 614
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnConfirma: TBitBtnLocked
        Width = 119
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 119
      end
      object btnMarcarItem: TBitBtnLocked
        Left = 119
        Top = 0
        Width = 148
        Height = 22
        Caption = '[ F5 ] Marca/Desmarca Item'
        TabOrder = 1
        OnClick = btnMarcarItemClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 267
        Top = 0
        Width = 123
        Height = 22
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 390
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnDesmarcaTodosClick
      end
      object btnCfgGri: TBitBtnLocked
        Left = 531
        Top = 0
        Width = 148
        Height = 22
        Caption = 'Confi&gura colunas'
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
        TabOrder = 4
        OnClick = btnCfgGriClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 925
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 640
    Width = 1008
    TabOrder = 2
    ExplicitTop = 640
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 70
    Width = 1008
    Height = 484
    Align = alClient
    TabOrder = 0
    object cxvItens: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvItensCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.OnChanged = cxvItensDataControllerFilterChanged
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00;-#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxvItensQTDITE
        end>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsCustomize.ColumnSorting = False
      OptionsCustomize.BandMoving = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum produto para transferir>'
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          Caption = 'Produto'
          FixedKind = fkLeft
          Options.Moving = False
        end
        item
          Caption = 'Saldos'
        end>
      object cxvItensEMPORI: TcxGridDBBandedColumn
        Caption = 'Emp. Origem'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 66
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 240
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensQTDITE: TcxGridDBBandedColumn
        Caption = 'Qtd. Transferir'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.OnValidate = cxvItensQTDITEPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 89
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensSALFIS_Destino: TcxGridDBBandedColumn
        Caption = 'Saldo F'#237's. Destino'
        DataBinding.FieldName = 'SALFIS_DES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensSALDIS_Destino: TcxGridDBBandedColumn
        Caption = 'Saldo Disp. Destino'
        DataBinding.FieldName = 'SALDIS_DES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensSALBAS_Destino: TcxGridDBBandedColumn
        Caption = 'Saldo Base Compra Dest.'
        DataBinding.FieldName = 'SALBAS_DES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvItensQTDEXC: TcxGridDBBandedColumn
        Caption = 'Excedente Origem'
        DataBinding.FieldName = 'QTDEXC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvItensSIGUNI: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 49
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensCODITE: TcxGridDBBandedColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 63
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensSUGEST: TcxGridDBBandedColumn
        Caption = 'Sugest'#227'o'
        DataBinding.FieldName = 'SUGEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 61
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensMARDES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensMINDES: TcxGridDBBandedColumn
        Caption = 'Estoq. M'#237'n. Destino'
        DataBinding.FieldName = 'MINDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvItensSIITE: TcxGridDBBandedColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxvItensSALFIS_Origem: TcxGridDBBandedColumn
        Caption = 'Saldo F'#237's. Origem'
        DataBinding.FieldName = 'SALFIS_ORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxvItensSALDIS_Origem: TcxGridDBBandedColumn
        Caption = 'Saldo Disp. Origem'
        DataBinding.FieldName = 'SALDIS_ORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxvItensDIAEST_Origem: TcxGridDBBandedColumn
        Caption = 'Dias Est. Origem'
        DataBinding.FieldName = 'DIAEST_ORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '#,##0;-#,##0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 68
        Position.BandIndex = 1
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxvItensDIAEST_Destino: TcxGridDBBandedColumn
        Caption = 'Dias Est. Destino'
        DataBinding.FieldName = 'DIAEST_DES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '#,##0;-#,##0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvItensDIATRA_Destino: TcxGridDBBandedColumn
        Caption = 'Dias Est. Destino c/ Transf.'
        DataBinding.FieldName = 'DIATRA_DES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '#,##0;-#,##0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvItensSALBAS_Origem: TcxGridDBBandedColumn
        Caption = 'Saldo Base Compra Orig.'
        DataBinding.FieldName = 'SALBAS_ORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxvItensESTMIN: TcxGridDBBandedColumn
        Caption = 'Estoq. M'#237'n.Origem'
        DataBinding.FieldName = 'ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxvItensMEDORI: TcxGridDBBandedColumn
        Caption = 'M'#233'dia Dia Destino'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvItensMEDDES: TcxGridDBBandedColumn
        Caption = 'M'#233'dia Dia Origem'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxvItensEMPDES: TcxGridDBBandedColumn
        Caption = 'Emp. Destino'
        DataBinding.FieldName = 'EMPDES'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        GroupIndex = 0
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 64
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensQTDALT: TcxGridDBBandedColumn
        Caption = 'Alterado'
        DataBinding.FieldName = 'QTDALT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 55
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensFORFIL: TcxGridDBBandedColumn
        Caption = 'Empresa Origem'
        DataBinding.FieldName = 'EMPORI'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 1
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 554
    Width = 1008
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object shpAbaixoZero: TShape
      Left = 13
      Top = 6
      Width = 14
      Height = 14
      Brush.Color = clBlack
    end
    object lblMsgReq: TLabel
      Left = 30
      Top = 6
      Width = 209
      Height = 14
      Caption = '(S0) Saldo dispon'#237'vel menor ou igual a zero'
    end
    object shpTransfere: TShape
      Left = 311
      Top = 6
      Width = 14
      Height = 14
      Brush.Color = 16767927
    end
    object Label1: TLabel
      Left = 328
      Top = 6
      Width = 141
      Height = 14
      Caption = 'Marcados para transfer'#234'ncia'
    end
    object shpAbaixoMinimo: TShape
      Left = 13
      Top = 21
      Width = 14
      Height = 14
      Brush.Color = clRed
    end
    object Label2: TLabel
      Left = 30
      Top = 21
      Width = 231
      Height = 14
      Caption = '(AB) Saldo dispon'#237'vel abaixo do estoque m'#237'nimo'
    end
    object shpAcimaMinimo: TShape
      Left = 13
      Top = 36
      Width = 14
      Height = 14
      Brush.Color = 28416
    end
    object Label3: TLabel
      Left = 30
      Top = 36
      Width = 267
      Height = 14
      Caption = '(AC) Saldo dispon'#237'vel acima ou igual ao estoque m'#237'nimo'
    end
    object Label4: TLabel
      Left = 500
      Top = 6
      Width = 353
      Height = 14
      AutoSize = False
      Caption = 
        'Coluna "Alterado": Fica marcada se a quantidade a transferir '#233' a' +
        'lterada'
    end
    object lblTitTotPes: TLabel
      Left = 311
      Top = 36
      Width = 151
      Height = 14
      Alignment = taRightJustify
      Caption = 'Litro/Kilo Total Selecionado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotPes: TLabel
      Left = 466
      Top = 36
      Width = 87
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTitPesoBruto: TLabel
      Left = 686
      Top = 36
      Width = 64
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso Bruto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotPesoBruto: TLabel
      Left = 756
      Top = 36
      Width = 87
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 0
    Width = 1008
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 4
    object rdgAgrupar: TRadioGroup
      Left = 13
      Top = 5
      Width = 612
      Height = 55
      Caption = 'Agrupar por'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Empresa Destino'
        'Produto'
        'Empresa Origem (Fornecedor Filial)')
      TabOrder = 0
      OnClick = rdgAgruparClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 112
    Top = 264
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 112
    Top = 200
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 56
    Top = 336
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14671839
    end
  end
end
