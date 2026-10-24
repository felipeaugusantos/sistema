inherited frmSelecionaTabPre: TfrmSelecionaTabPre
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Selecione as Tabelas de Pre'#231'o para ativa'#231#227'o'
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
      ExplicitWidth = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 703
      TabOrder = 5
      ExplicitLeft = 703
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 109
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
    end
    object btnMarcaTodos: TBitBtnLocked
      Left = 156
      Top = 3
      Width = 122
      Height = 22
      Caption = '[ F6 ] Marca Todas'
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
      Left = 295
      Top = 3
      Width = 141
      Height = 22
      Caption = '[ F7 ] Desmarca Todas'
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
    object btnMarca: TBitBtnLocked
      Left = 452
      Top = 3
      Width = 149
      Height = 22
      Caption = '[ ENTER ] Marca / Desmarca'
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnMarcaClick
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
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 784
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label11: TLabel
      Left = 13
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label1: TLabel
      Left = 86
      Top = 18
      Width = 144
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o da Tabela de Pre'#231'o'
    end
    object edtTabPre: TEditFocus
      Tag = 99
      Left = 13
      Top = 32
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtTabPreKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtNomTab: TEditFocus
      Tag = 99
      Left = 85
      Top = 32
      Width = 370
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 71
    Width = 784
    Height = 405
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro selecionado>'
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'TAB_CODTAB'
        SortIndex = 1
        SortOrder = soAscending
        Width = 65
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'TAB_NOMTAB'
        SortIndex = 0
        SortOrder = soAscending
        Width = 247
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Descri'#231#227'o no Fornecedor'
        DataBinding.FieldName = 'TAB_DESTAB'
        Width = 218
      end
      object cxgItensViewColumn6: TcxGridDBColumn
        Caption = 'Ativa'
        DataBinding.FieldName = 'TAB_ATICMP'
        HeaderAlignmentHorz = taCenter
        Width = 42
      end
      object cxgItensViewColumn4: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'TAB_CODFOR'
        HeaderAlignmentHorz = taCenter
        Width = 68
      end
      object cxgItensViewColumn5: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Width = 191
      end
      object cxgItensMARCADO: TcxGridDBColumn
        DataBinding.FieldName = 'MARCADO'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 476
    Width = 784
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object Label2: TLabel
      Left = 40
      Top = 15
      Width = 133
      Height = 14
      Caption = 'Tabelas que ser'#227'o ativadas'
    end
    object Shape1: TShape
      Left = 16
      Top = 11
      Width = 20
      Height = 20
      Brush.Color = clMoneyGreen
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 392
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
    Top = 400
  end
end
