inherited frmEntSelecionaNotaElet: TfrmEntSelecionaNotaElet
  Left = 137
  Top = 157
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Selec'#227'o de NFe para Confer'#234'ncia'
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 372
    Width = 784
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 73
    ExplicitWidth = 319
  end
  object cxgConsulta: TcxGridCitel [1]
    Left = 0
    Top = 33
    Width = 784
    Height = 339
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvConsulta: TcxGridDBTableViewCitel
      OnKeyDown = cxvConsultaKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvConsultaCustomDrawCell
      DataController.DataSource = dtsConsulta
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvConsultaIDEDIG: TcxGridDBColumn
        Caption = 'Seq.Conf.'
        DataBinding.FieldName = 'IDEDIG'
        SortIndex = 0
        SortOrder = soAscending
        Width = 52
      end
      object cxvConsultaAGEREC: TcxGridDBColumn
        Caption = 'C'#243'd. Plano de Rec.'
        DataBinding.FieldName = 'AGEREC'
        Width = 99
      end
      object cxvConsultaNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        HeaderAlignmentHorz = taCenter
        Width = 97
      end
      object cxvConsultaESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        HeaderAlignmentHorz = taCenter
        Width = 30
      end
      object cxvConsultaSERDOC: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERDOC'
        Width = 35
      end
      object cxvConsultaDTAEMI: TcxGridDBColumn
        Caption = 'Dta.Emiss.'
        DataBinding.FieldName = 'DTAEMI'
        HeaderAlignmentHorz = taCenter
        Width = 69
      end
      object cxvConsultaDTAENT: TcxGridDBColumn
        Caption = 'Data de Entrada'
        DataBinding.FieldName = 'DTAENT'
        Width = 100
      end
      object cxvConsultaCODFOR: TcxGridDBColumn
        Caption = 'C'#243'd.For.'
        DataBinding.FieldName = 'CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 61
      end
      object cxvConsultaRAZSOC: TcxGridDBColumn
        Caption = 'Raz'#227'o Social'
        DataBinding.FieldName = 'RAZSOC'
        Width = 250
      end
      object cxvConsultaNOMFOR: TcxGridDBColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'NOMFOR'
        Width = 250
      end
      object cxvConsultaVALDOC: TcxGridDBColumn
        Caption = 'Total Itens'
        DataBinding.FieldName = 'VALDOC'
        HeaderAlignmentHorz = taRightJustify
        Width = 104
      end
      object cxvConsultaMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxvConsultaAUTOINCREM: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
    end
    object cxgConsultaLevel: TcxGridLevel
      GridView = cxvConsulta
    end
  end
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 784
    ExplicitTop = 517
    ExplicitWidth = 784
    DesignSize = (
      784
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 780
      ExplicitWidth = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 664
      Width = 118
      TabOrder = 3
      ExplicitLeft = 664
      ExplicitWidth = 118
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 165
      Height = 22
      Caption = '[ F10 ] Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
    object btnSeleciona: TBitBtnLocked
      Left = 169
      Top = 3
      Width = 165
      Height = 22
      Caption = '[ ENTER/ SPACE] Seleciona'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
        83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
        DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
        AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
        00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
        E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
        0066000066000066000066000066000066000066000066000066000066000066
        00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
        3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
        0066000066000066000066000066000066000066000066000066000066000066
        00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
        ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
        CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
        00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
        F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
        0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
        D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
        2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
        43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
        DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
        FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
        0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
        82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnSelecionaClick
    end
    object btnGerarCSV: TBitBtnLocked
      Left = 335
      Top = 3
      Width = 165
      Height = 22
      Caption = '[ F11 ] Gerar CSV'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0002000000090000000E0000000F000000100000001000000011000000110000
        00110000001200000012000000110000000C0000000300000000000000000000
        00087B5043C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D
        59FFAA6C59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000
        000CAD735FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1
        EDFFF8F1ECFFF8F0EBFFF8F0EAFFD5B6ADFF00000011000000003E5803AD5D81
        05FF5C8004FF5B7F04FF5A7E03FF5A7D03FF587C02FF577B02FF567902FF5679
        01FF557800FF537700FF547700FF537600FF537600FF385000AD5E8306FFFAF6
        F6FF5D8105FFF9F5F3FF5C7F04FFF8F2F1FFF7F2EFFFA7B678FFF7EFEDFFF6EE
        EBFFA6B476FF557801FFF4ECE7FF547700FFF3EAE5FF537600FF5F8406FFFBF7
        F6FF5D8205FFF9F5F4FF5C8004FFF8F4F2FF5A7E03FF597D03FF587C02FFA8B6
        78FFF6EEEBFF567901FFF5EDE8FF537700FFF4EBE6FF537600FF618507FFADBE
        7FFFFBF7F6FFACBD7DFF5B8104FFF9F5F2FF5B7F04FF5A7E03FFA9B879FFF6F1
        EEFF597B03FF557A01FFA6B376FFF5EDE8FFA4B274FF547700FF608606FFFCF8
        F8FF5F8406FFFBF7F6FF5F8206FFFAF5F3FF5C8004FF5B7F04FFF8F3F0FF5A7D
        03FF587C02FF577A02FFF6EEEAFF547801FFF4ECE8FF537700FF618607FFFBFA
        F9FF618507FFFAF8F7FF5D8306FFFAF7F5FF5D8105FF5D8005FFAAB97BFFF8F2
        F0FFF7F2EFFF597C02FFF6EFECFF557A01FFF5EDE9FF557801FF425B05AD6186
        07FF608507FF5F8506FF5F8406FF5E8306FF5E8305FF5D8105FF5D8005FF5B7F
        04FF5A7E03FF577C03FF567B02FF577B02FF567A01FF3A5201AD000000000000
        0006C18F7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5
        F0FFFAF4EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B00000000000000000000
        0006C49382FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4
        F2FFFBF5F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B00000000000000000000
        0005C79985FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6
        F4FFFCF6F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A00000000000000000000
        0004C99A89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFE
        FDFFFEFEFDFFFEFDFDFFFEFDFDFFC49382FF0000000800000000000000000000
        0002977567C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A
        88FFC99987FFC79887FFC89886FF927163C20000000500000000000000000000
        0001000000020000000300000004000000040000000500000005000000050000
        0006000000060000000600000006000000050000000100000000}
      TabOrder = 4
      OnClick = btnGerarCSVClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
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
  object dbgPedidos: TDBGridCitel [4]
    Left = 0
    Top = 375
    Width = 784
    Height = 120
    Align = alBottom
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgPedidosDrawColumnCell
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'PCG_NUMPED'
        Title.Caption = 'Num. Pedido'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_CODEMP'
        Title.Caption = 'Empresa'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMFOR'
        Title.Caption = 'Fornecedor'
        Width = 313
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAPED'
        Title.Caption = 'Dt. Emiss'#227'o'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PCG_DTAENT'
        Title.Caption = 'Dt. Entrega'
        Width = 72
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PCG_TOTGER'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total Pedido'
        Width = 103
        Visible = True
      end>
  end
  object pnlTail: TPanel [5]
    Left = 0
    Top = 495
    Width = 784
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 5
    object shpGarantia: TShape
      Left = 8
      Top = 3
      Width = 16
      Height = 16
      Brush.Color = clRed
    end
    object Label1: TLabel
      Left = 28
      Top = 4
      Width = 404
      Height = 14
      Caption = 
        'Pedido referente a garantia enviada ao fornecedor (Aguardando Re' +
        'torno).'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlHeader: TPanel [6]
    Left = 0
    Top = 0
    Width = 784
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    Visible = False
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 160
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 192
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 120
    Top = 104
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 152
    Top = 104
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    AfterScroll = cdsConsultaAfterScroll
    Left = 184
    Top = 104
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 216
    Top = 104
  end
end
