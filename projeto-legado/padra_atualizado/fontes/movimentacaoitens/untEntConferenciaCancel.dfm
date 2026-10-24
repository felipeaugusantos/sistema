inherited frmEntConferenciaCancel: TfrmEntConferenciaCancel
  Width = 713
  Height = 467
  BorderStyle = bsSizeable
  Caption = 'Cancelamento de Confer'#234'ncia'
  OnClose = FormClose
  ExplicitWidth = 713
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 384
    Width = 697
    ExplicitTop = 384
    ExplicitWidth = 697
    inherited FlwBotoes: TFlowPanel
      Width = 693
      ExplicitTop = 2
      ExplicitWidth = 693
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 126
        Height = 22
        Caption = '[ F10 ] &Confirma'
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
      object btnMarDes: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 175
        Height = 22
        Caption = '[ SPACE ] Marca/Desmarca'
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
        OnClick = btnMarDesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 617
      Caption = 'Sair'
      ExplicitLeft = 617
    end
  end
  object cxgPedidos: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 697
    Height = 384
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgPedidosView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgPedidosViewCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgPedidosNUMPED: TcxGridDBColumn
        Caption = 'N'#250'm.Pedido'
        DataBinding.FieldName = 'NUMPED'
        Width = 87
      end
      object cxgPedidosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Width = 64
      end
      object cxgPedidosDTAPED: TcxGridDBColumn
        Caption = 'Data Pedido'
        DataBinding.FieldName = 'DTAPED'
        Width = 78
      end
      object cxgPedidosCODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'CODFOR'
        Width = 77
      end
      object cxgPedidosNOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 276
      end
      object cxgPedidosTOTITE: TcxGridDBColumn
        Caption = 'Total do Itens'
        DataBinding.FieldName = 'TOTITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxgPedidosMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxgPedidosLevel1: TcxGridLevel
      GridView = cxgPedidosView
    end
  end
  inherited pnlStatus: TPanel
    Top = 412
    Width = 697
    ExplicitTop = 412
    ExplicitWidth = 697
    inherited pnlNomeForm: TPanel
      Left = 526
      ExplicitLeft = 526
    end
    inherited pnlInfo: TPanel
      Width = 526
      ExplicitWidth = 526
    end
  end
end
