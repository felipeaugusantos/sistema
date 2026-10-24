inherited frmRecuperaPedidoSelec: TfrmRecuperaPedidoSelec
  Width = 795
  Height = 432
  BorderStyle = bsSizeable
  Caption = 'Pedidos que n'#227'o foram finalizados corretamente'
  ExplicitWidth = 795
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 779
    TabOrder = 1
    ExplicitTop = 351
    ExplicitWidth = 779
    inherited FlwBotoes: TFlowPanel
      Width = 698
      ExplicitWidth = 775
      inherited btnConfirma: TBitBtnLocked
        Width = 135
        Caption = '&Recuperar pedido'
        ExplicitWidth = 135
      end
      object btnDescarta: TBitBtnLocked
        Left = 135
        Top = 0
        Width = 237
        Height = 22
        Caption = '&Descarta c'#243'pia de seguran'#231'a do pedido'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
        TabOrder = 1
        OnClick = btnDescartaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 700
      Top = 2
      Align = alRight
      Caption = 'S&air'
      ExplicitLeft = 696
    end
  end
  inherited pnlStatus: TPanel
    Top = 377
    Width = 779
    TabOrder = 2
    ExplicitTop = 377
    ExplicitWidth = 779
    inherited pnlNomeForm: TPanel
      Left = 608
      ExplicitLeft = 608
    end
    inherited pnlInfo: TPanel
      Width = 608
      ExplicitWidth = 608
    end
  end
  object cxgPedidos: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 779
    Height = 351
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvPedidos: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvPedidosColumn1: TcxGridDBColumn
        Caption = 'C'#243'd. Ope.'
        DataBinding.FieldName = 'CODOPE'
        HeaderAlignmentHorz = taCenter
        Width = 64
      end
      object cxvPedidosColumn2: TcxGridDBColumn
        Caption = 'Nome Operador'
        DataBinding.FieldName = 'NOMOPE'
        Width = 105
      end
      object cxvPedidosColumn3: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 58
      end
      object cxvPedidosNUMPED: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'NUMPED'
        HeaderAlignmentHorz = taCenter
        Width = 113
      end
      object cxvPedidosColumn5: TcxGridDBColumn
        Caption = 'C'#243'd. Fornec.'
        DataBinding.FieldName = 'CODFOR'
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 76
      end
      object cxvPedidosColumn6: TcxGridDBColumn
        Caption = 'Nome Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 215
      end
      object cxvPedidosColumn7: TcxGridDBColumn
        Caption = 'Data Pedido'
        DataBinding.FieldName = 'DTAPED'
        HeaderAlignmentHorz = taCenter
        Width = 121
      end
    end
    object cxgPedidosLevel1: TcxGridLevel
      GridView = cxvPedidos
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 520
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 480
  end
end
