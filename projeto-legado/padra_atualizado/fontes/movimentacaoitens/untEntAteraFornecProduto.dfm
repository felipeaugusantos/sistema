inherited frmEntAteraFornecProduto: TfrmEntAteraFornecProduto
  Width = 800
  Height = 600
  Caption = 'Altera'#231#227'o do Fornecedor Principal do Produto'
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 794
    TabOrder = 1
    ExplicitTop = 527
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 610
      ExplicitTop = 2
      ExplicitWidth = 610
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 111
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
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 111
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
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 234
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
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 612
      Top = 2
      Width = 180
      Height = 24
      Align = alRight
      Caption = '&Sair sem alterar o fornecedor'
      ExplicitLeft = 612
      ExplicitTop = 2
      ExplicitWidth = 180
      ExplicitHeight = 24
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 527
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgItensSELECI: TcxGridDBColumn
        Caption = 'Atualizar'
        DataBinding.FieldName = 'SELECI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgItensSELECIPropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 56
      end
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 52
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 179
      end
      object cxgItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Options.Editing = False
        Width = 52
      end
      object cxgItensCODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        Options.Editing = False
        Width = 68
      end
      object cxgItensNOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Options.Editing = False
        Width = 115
      end
      object cxgItensDTAULT: TcxGridDBColumn
        Caption = #218'ltima Compra'
        DataBinding.FieldName = 'DTAULT'
        Options.Editing = False
        Width = 76
      end
      object cxgItensPREULT: TcxGridDBColumn
        Caption = 'Vr.'#218'lt.Compra'
        DataBinding.FieldName = 'PREULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;(0.0000)'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 85
      end
      object cxgItensIMPULT: TcxGridDBColumn
        Caption = #218'lt.Comp + Imp.'
        DataBinding.FieldName = 'IMPULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;(0.0000)'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 82
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 794
    TabOrder = 2
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
end
