inherited frmLiberaPrepTE: TfrmLiberaPrepTE
  Width = 1024
  Height = 751
  BorderStyle = bsSizeable
  Caption = 
    'Libera'#231#227'o da Prepara'#231#227'o de Transfer'#234'ncia de Estoque - Itens aind' +
    'a n'#227'o liberados'
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 751
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 667
    Width = 1008
    Height = 45
    TabOrder = 2
    ExplicitTop = 667
    ExplicitWidth = 1008
    ExplicitHeight = 45
    inherited FlwBotoes: TFlowPanel
      Top = 18
      Width = 1004
      Height = 25
      Align = alBottom
      ExplicitTop = 18
      ExplicitWidth = 1004
      ExplicitHeight = 25
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 155
        Height = 22
        Caption = '[ F10 ] Liberar prep. de TE'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnGravarClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 155
        Top = 0
        Width = 145
        Height = 22
        Caption = '[ ENTER ] Marca / Desmarca'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarDesClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 300
        Top = 0
        Width = 120
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
        Left = 420
        Top = 0
        Width = 140
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
      object btnExcluir: TBitBtnLocked
        Left = 560
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ DEL ] Excluir'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        OnClick = btnExcluirClick
      end
      object btnGiroEstoqueVenda: TBitBtnLocked
        Left = 680
        Top = 0
        Width = 120
        Height = 22
        Caption = 'Giro Estoque - Venda'
        TabOrder = 5
        OnClick = btnGiroEstoqueVendaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      Top = 18
      Caption = 'Sair'
      ExplicitLeft = 928
      ExplicitTop = 18
    end
    object btnPedCompGrid: TBitBtnLocked
      Left = 800
      Top = 18
      Width = 130
      Height = 22
      Caption = '[ F12 ] Ped. Compra (Grid)'
      TabOrder = 2
      OnClick = btnPedCompGridClick
    end
    object pnlLegenda: TPanel
      Left = 2
      Top = 2
      Width = 1004
      Height = 15
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object shpSelec: TShape
        Left = 4
        Top = 3
        Width = 12
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clMoneyGreen
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object lblSelec: TLabel
        Left = 22
        Top = 1
        Width = 84
        Height = 14
        Caption = 'Selec. para baixa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 651
    Width = 1008
    ExplicitTop = 651
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
    Top = 0
    Width = 1008
    Height = 651
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvItensCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' itens para a gera'#231#227'o'
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      object cxvItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        HeaderAlignmentHorz = taCenter
        Width = 55
      end
      object cxvItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        SortIndex = 0
        SortOrder = soAscending
        Width = 317
      end
      object cxvItensNOMFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'NOMFOR'
        Width = 200
      end
      object cxvItensREFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        Width = 105
      end
      object cxvItensSIGUNI: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'SIGUNI'
        Width = 51
      end
      object cxvItensQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 85
      end
      object cxvItensEMPORI: TcxGridDBColumn
        Caption = 'Emp. Origem'
        DataBinding.FieldName = 'EMPORI'
        HeaderAlignmentHorz = taCenter
        Width = 74
      end
      object cxvItensSALORI: TcxGridDBColumn
        Caption = 'Saldo Orig.'
        DataBinding.FieldName = 'SALORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Width = 74
      end
      object cxvItensEMPDES: TcxGridDBColumn
        Caption = 'Emp. Destino'
        DataBinding.FieldName = 'EMPDES'
        HeaderAlignmentHorz = taCenter
        Width = 74
      end
      object cxvItensSALDES: TcxGridDBColumn
        Caption = 'Saldo Des.'
        DataBinding.FieldName = 'SALDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Width = 74
      end
      object cxvItensCODOPE: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'CODOPE'
        HeaderAlignmentHorz = taCenter
        Width = 63
      end
      object cxvItensDTACAD: TcxGridDBColumn
        Caption = 'Data Cad.'
        DataBinding.FieldName = 'DTACAD'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Width = 78
      end
      object cxvItensHORCAD: TcxGridDBColumn
        Caption = 'Hora Cad.'
        DataBinding.FieldName = 'HORCAD'
        HeaderAlignmentHorz = taCenter
        SortIndex = 2
        SortOrder = soAscending
        Width = 85
      end
      object cxvItensLIBERA: TcxGridDBColumn
        DataBinding.FieldName = 'LIBERA'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 192
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 192
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 688
    Top = 288
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15066597
    end
  end
end
