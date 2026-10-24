inherited frmConsExtBanPen: TfrmConsExtBanPen
  Width = 639
  Height = 494
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta Lan'#231'amentos Extrato Eletr'#244'nico Pendentes'
  Position = poMainFormCenter
  ExplicitWidth = 639
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 421
    Width = 633
    ExplicitTop = 421
    ExplicitWidth = 633
    inherited FlwBotoes: TFlowPanel
      Width = 629
      TabOrder = 5
      ExplicitWidth = 629
    end
    inherited btnSair: TBitBtnLocked
      Left = 550
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 4
      ExplicitLeft = 550
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 105
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[F10] Confirma'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      Glyph.Data = {
        36030000424D36030000000000003600000028000000100000000C0000000100
        2000000000000003000000000000000000000000000000000000000000000000
        00000000000000000000000000000020004E004C00AE00000008000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000021004F007000E6008000FF004100B7000000070000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000092909550C7A0CE7008700FF008700FF008700FF004300B30000
        0005000000000000000000000000000000000000000000000000000000000000
        000009290956429B42EC48AC48FF2C9F2CFF0C910CFF048D04FF048D04FF0142
        01AE000000040000000000000000000000000000000000000000000000000A2A
        0A564C9E4CEC56B256FF54B154FF52B152FF50B050FF3CA63CFF249C24FF1494
        14FF094109A900000003000000000000000000000000000000000927095355A5
        55ED61B761FF60B760FF5EB65EFF408C40D8174D179153AB53F758B358FF53B1
        53FF46AB46FF285428AE000000020000000000000000000000000314032C4D95
        4DDB6BBC6BFF6ABB6AFF479047D902100225000000001441147E5DAD5DF761B7
        61FF60B660FF5EB65EFF335833AB000000010000000000000000000000000314
        032C529552DB519251D9021002250000000000000000000000001541157D65B2
        65F76BBC6BFF69BB69FF68BA68FF335433A60000000100000000000000000000
        00000314032C0210022500000000000000000000000000000000000000001641
        167D6CB66CF774C074FF73BF73FF71BE71FF365136A100000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00001743177D75BC75F77DC47DFF7CC37CFF7CBF7CFE1438146A000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000001843187D7FC07FF785C585FE2E652EA900010002000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000001941197B306530A60001000200000000}
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnMarcaDesmarca: TBitBtnLocked
      Left = 115
      Top = 3
      Width = 140
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[Espa'#231'o] Marca/Desmarca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 1
      OnClick = btnMarcaDesmarcaClick
    end
    object btnMarcaTodos: TBitBtnLocked
      Left = 257
      Top = 3
      Width = 117
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[F7] Marca Todos'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 2
      OnClick = btnMarcaTodosClick
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 376
      Top = 3
      Width = 117
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[F8] Desmarcar Todos'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Font.Quality = fqClearType
      ParentFont = False
      TabOrder = 3
      OnClick = btnDesmarcaTodosClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 449
    Width = 633
    ExplicitTop = 449
    ExplicitWidth = 633
    inherited pnlNomeForm: TPanel
      Left = 462
      ExplicitLeft = 462
    end
    inherited pnlInfo: TPanel
      Width = 462
      ExplicitWidth = 462
    end
  end
  object grdLanPend: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 633
    Height = 421
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    LookAndFeel.SkinName = ''
    ExplicitTop = -3
    object grdLanPendDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdLanPendDBTableView1CustomDrawCell
      OnEditing = grdLanPendDBTableView1Editing
      DataController.DataSource = dsLancamentos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      object grdLanPendDBTableView1Column3: TcxGridDBColumn
        DataBinding.FieldName = 'EXT_MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = grdLanPendDBTableView1Column3PropertiesChange
        Options.Filtering = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.ShowCaption = False
        Width = 20
        IsCaptionAssigned = True
      end
      object grdLanPendDBTableView1Column2: TcxGridDBColumn
        Caption = 'Data Lan'#231'amento'
        DataBinding.FieldName = 'EXT_DTALAN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 124
      end
      object grdLanPendDBTableView1Column5: TcxGridDBColumn
        Caption = 'Banco'
        DataBinding.FieldName = 'EXT_CODBCO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
      end
      object grdLanPendDBTableView1Column1: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'PORTADOR'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        Visible = False
        GroupIndex = 0
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 166
      end
      object grdLanPendDBTableView1Column4: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDREG'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 146
      end
      object grdLanPendDBTableView1Column6: TcxGridDBColumn
        DataBinding.FieldName = 'EXT_CODPOR'
        Visible = False
      end
    end
    object grdLanPendLevel1: TcxGridLevel
      GridView = grdLanPendDBTableView1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 477
    Top = 65520
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 448
    Top = 65520
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 506
    Top = 65520
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 408
    Top = 88
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
  end
  object dsLancamentos: TDataSource
    Left = 312
    Top = 128
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 528
    Top = 56
    PixelsPerInch = 96
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
  end
end
