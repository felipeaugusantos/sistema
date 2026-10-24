inherited frmNotasFulfillmentPat: TfrmNotasFulfillmentPat
  Width = 801
  Height = 509
  Caption = 'Auditoria de Notas Emitidas pelo Fulfillment'
  ExplicitWidth = 801
  ExplicitHeight = 509
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 438
    Width = 795
    ExplicitTop = 438
    ExplicitWidth = 795
    inherited FlwBotoes: TFlowPanel
      Width = 791
      ExplicitWidth = 791
      inherited btnConfirma: TBitBtnLocked
        Width = 137
        Caption = '[ F10 ] Mostrar notas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000060000
          000A0000000A0000000A0000000A0000000B0000000B0000000B0000000B0000
          000B0000000B0000000B0000000B0000000B00000007000000027E5D52BDAF82
          72FFAF8272FFAE8172FFAE8072FFAE8071FFAE8071FFAE8070FFAD8070FFAD7F
          70FFAD7F70FFAC7F6FFFAC7F6FFFAD7E6FFF7C5B4FBE00000007B28577FFFCF8
          F6FFFCF8F5FFFBF7F6FFFBF7F5FFFBF7F5FFFBF7F5FFFBF6F4FFFBF6F4FFFBF6
          F3FFFBF6F3FFFBF6F3FFFAF5F2FFFAF5F2FFAE8072FF0000000AB5897AFFFCF9
          F7FFC59062FFC59062FFC58F61FFC58E60FFC48F60FFC58E60FFC48E5FFFC48D
          5FFFC48D5EFFC48C5EFFC48C5DFFFBF6F3FFB18475FF0000000AB68C7EFFFDFA
          F8FFCD9F75FFECD5B5FFE5C59CFFE5C49CFFE5C39BFFE4C49AFFE4C299FFE5C3
          9AFFE4C298FFE4C298FFC48E5FFFFBF7F5FFB28778FF00000009B98F81FFFDFB
          F9FFCEA178FFCEA177FFCEA077FFCDA077FFCEA077FFCEA077FFCDA076FFCDA0
          76FFCDA075FFCD9F75FFC69062FFFBF7F6FFB58A7CFF00000009BB9385FFFDFB
          FAFFF7F0EBFFF8EFEBFFF8F0EBFFF7EFEBFFF7EFEBFFF7F0EBFFF8EFEBFFF7EF
          EAFFF8EFEAFFF7EFEAFFF8EFEBFFFCF9F7FFB88E7FFF00000008BE9688FFFEFC
          FBFFCA9B6FFFCA9A6EFFCA996DFFCA996DFFCA986BFFC9976BFFC9966AFFC997
          6AFFC89569FFC99568FFC89568FFFCF9F8FFBA9183FF00000007C0998BFFFEFC
          FCFFD2A880FFF1E0C8FFE9CEAAFFE9CEA9FFE8CDA9FFE9CCA8FFE9CCA7FFE8CB
          A6FFE8CBA6FFE8CBA5FFCA976BFFFDFAF9FFBD9587FF00000007C29C8EFFFEFD
          FCFFD2A982FFD3A982FFD2AA82FFD2A981FFD2A881FFD2A881FFD2A981FFD1A8
          80FFD1A880FFD2A780FFCB9A6FFFFDFBFAFFC0978AFF00000006C49E91FFFEFE
          FDFFF9F0EDFFF8F1EDFFF9F0EDFFF9F0EDFFF8F1EDFFF8F0EDFFF8F1ECFFF8F0
          EDFFF8F0ECFFF8F0ECFFF8F0ECFFFDFCFBFFC29B8DFF00000006C6A093FFFFFE
          FEFFD1A77EFFD1A67DFFD1A67CFFD1A57BFFD0A57BFFCFA47AFFCFA379FFCFA2
          78FFCFA177FFCEA176FFCEA176FFFEFCFBFFC49E90FF00000005C7A396FFFFFE
          FEFFD6B18AFFF5E9D6FFEDD8B8FFEDD8B8FFEDD7B7FFECD7B6FFECD6B5FFECD5
          B5FFECD5B5FFECD4B3FFD0A479FFFEFDFCFFC5A093FF00000005C8A497FFFFFF
          FFFFD7B38DFFD7B38CFFD7B28CFFD8B18CFFD7B28BFFD7B28BFFD6B18AFFD7B1
          8AFFD6B18AFFD7B08AFFD1A77EFFFEFDFDFFC7A295FF00000004CAA699FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFFFEFEFFFEFEFEFFC8A497FF00000003967C72BECAA7
          9AFFCAA79AFFCAA79AFFCAA79AFFCAA79AFFCAA699FFCAA699FFCAA699FFCAA6
          99FFCAA699FFCAA699FFCAA699FFCAA699FF967B70BF00000002}
        ModalResult = 0
        NumGlyphs = 1
        ExplicitWidth = 137
      end
      object btnQtdXML: TBitBtn
        Left = 137
        Top = 0
        Width = 334
        Height = 22
        Caption = '[ F5 ] Mostrar quantidade de XMLs para os arquivos marcados'
        TabOrder = 1
        OnClick = btnQtdXMLClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 715
      ExplicitLeft = 715
    end
  end
  inherited pnlStatus: TPanel
    Top = 464
    Width = 795
    ExplicitTop = 464
    ExplicitWidth = 795
    inherited pnlNomeForm: TPanel
      Left = 624
      ExplicitLeft = 624
    end
    inherited pnlInfo: TPanel
      Width = 624
      ExplicitWidth = 624
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 795
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Top = 18
      Width = 218
      Height = 14
      Caption = 'Pasta dos arquivos de nota eletr'#244'nica (*.ZIP):'
    end
    inline fraPathXml: TfraDirectoryEditFocus
      Left = 11
      Top = 31
      Width = 774
      Height = 22
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 11
      ExplicitTop = 31
      ExplicitWidth = 774
      inherited edtDirectory: TEditFocus
        Width = 749
        ExplicitWidth = 749
        ExplicitHeight = 22
      end
      inherited btnOpenDirectory: TcxButton
        Left = 751
        ExplicitLeft = 751
      end
    end
  end
  object cxgZip: TcxGrid [3]
    Left = 0
    Top = 73
    Width = 795
    Height = 365
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvZip: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsArquivos
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum arquivo *.zip encontrado>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvZipColumn1: TcxGridDBColumn
        Caption = 'Nome do Arquivo'
        DataBinding.FieldName = 'NOMARQ'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 604
      end
      object cxvZipColumn2: TcxGridDBColumn
        Caption = 'Quantidade de XMLs'
        DataBinding.FieldName = 'QTDARQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 111
      end
      object cxvZipColumn3: TcxGridDBColumn
        Caption = 'Verificar'
        DataBinding.FieldName = 'MARCAD'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
    end
    object cxgZipLevel1: TcxGridLevel
      GridView = cxvZip
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 576
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 136
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 104
    Top = 208
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15066597
    end
  end
  object dtsArquivos: TDataSource
    Left = 104
    Top = 272
  end
end
