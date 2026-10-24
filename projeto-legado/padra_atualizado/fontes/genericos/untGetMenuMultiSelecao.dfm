inherited frmGetMenuMultiSelecao: TfrmGetMenuMultiSelecao
  Left = 335
  Top = 253
  VertScrollBar.Range = 0
  BorderIcons = []
  Caption = ''
  ClientHeight = 294
  ClientWidth = 556
  Position = poMainFormCenter
  ExplicitWidth = 562
  ExplicitHeight = 323
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 269
    Width = 556
    ExplicitTop = 245
    ExplicitWidth = 556
    inherited FlwBotoes: TFlowPanel
      Width = 552
      ExplicitWidth = 552
    end
    inherited btnSair: TBitBtnLocked
      Left = 57
      ExplicitLeft = 57
    end
  end
  inherited pnlStatus: TPanel
    Top = 61
    Width = 138
    Height = 1
    Align = alNone
    Visible = False
    ExplicitTop = 61
    ExplicitWidth = 138
    ExplicitHeight = 1
    inherited pnlNomeForm: TPanel
      Left = -33
      Height = 1
      ExplicitLeft = -33
      ExplicitHeight = 1
    end
    inherited pnlInfo: TPanel
      Width = 69
      Height = 1
      ExplicitWidth = 69
      ExplicitHeight = 1
    end
    inherited pnlBotoesTrace: TPanel
      Height = 1
      ExplicitHeight = 1
      inherited btnIniciarTrace: TSpeedButton
        Height = 1
        ExplicitHeight = 1
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 1
        ExplicitHeight = 1
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 1
        ExplicitHeight = 1
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 1
        ExplicitHeight = 1
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 556
    Height = 269
    Visible = False
    ExplicitWidth = 556
    ExplicitHeight = 245
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 548
      ExplicitHeight = 213
    end
  end
  object FlowPanel1: TFlowPanel [3]
    Left = 0
    Top = 269
    Width = 556
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 3
    object btnConfirma: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 121
      Height = 22
      Caption = '[F10] Confirma'
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
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 121
      Top = 0
      Width = 145
      Height = 22
      Caption = '[SPACE] Marcar/Desmarca'
      TabOrder = 3
      OnClick = btnMarDesClick
    end
    object btnMarTodos: TBitBtnLocked
      Left = 266
      Top = 0
      Width = 134
      Height = 22
      Caption = '[F2] Marcar todos'
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
      TabOrder = 1
      OnClick = btnMarTodosClick
    end
    object btnDesmarTodos: TBitBtnLocked
      Left = 400
      Top = 0
      Width = 134
      Height = 22
      Caption = '[F3] Desmarcar todos'
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
      TabOrder = 2
      OnClick = btnDesmarTodosClick
    end
  end
  object dbgItens: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 556
    Height = 269
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 245
    object dbgItensDBTableView: TcxGridDBTableView
      OnDblClick = dbgItensDBTableViewDblClick
      Navigator.Buttons.CustomButtons = <>
      Navigator.InfoPanel.Visible = True
      OnCustomDrawCell = dbgItensDBTableViewCustomDrawCell
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = dtsItens
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.GroupByBox = False
      object dbgItensDBTableViewSELECE: TcxGridDBColumn
        Caption = 'Selecionar'
        DataBinding.FieldName = 'SELECE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.DisplayChecked = '1'
        Properties.DisplayUnchecked = '0'
        Properties.FullFocusRect = True
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        VisibleForCustomization = False
        Width = 65
      end
      object dbgItensDBTableViewDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 487
      end
    end
    object dbgItensLevel: TcxGridLevel
      GridView = dbgItensDBTableView
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 64
    Top = 56
  end
  object cdsItens: TUniClientDataSet
    PersistDataPacket.Data = {
      5F0000009619E0BD0100000018000000030000000000030000005F000653454C
      4543450400010000000000064445534352490100490000000100055749445448
      02000200640006434F4449474F01004900000001000557494454480200020006
      000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'SELECE'
        DataType = ftInteger
      end
      item
        Name = 'DESCRI'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 6
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 88
    object cdsItensSELECE: TIntegerField
      FieldName = 'SELECE'
    end
    object cdsItensDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 100
    end
    object cdsItensCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
  end
end
