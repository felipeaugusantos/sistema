inherited frmAtuCadProdutosIteFor: TfrmAtuCadProdutosIteFor
  Width = 1024
  Height = 592
  BorderStyle = bsSizeable
  Caption = 'Produtos com Pre'#231'o de Custo diferente na tabela do fornecedor '
  ExplicitWidth = 1024
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 511
    Width = 1008
    TabOrder = 1
    ExplicitTop = 511
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Left = 169
      Width = 837
      ExplicitLeft = 3
      TabOrder = 1
      ExplicitTop = 2
      ExplicitWidth = 1004
      inherited btnConfirma: TBitBtnLocked
        Width = 185
        Align = alLeft
        Caption = '[ F10 ] Atualiza pre'#231'os produtos'
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
        NumGlyphs = 1
        ExplicitWidth = 185
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 167
      Align = alLeft
      Caption = 'Retornar '#224' Tabela de Pre'#231'os'
      ExplicitLeft = 186
      TabOrder = 0
      ExplicitTop = 2
      ExplicitWidth = 167
    end
    object btnMarcaTodos: TBitBtnLocked
      Left = 477
      Top = 2
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
      TabOrder = 3
      OnClick = btnMarcaTodosClick
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 599
      Top = 2
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
      TabOrder = 4
      OnClick = btnDesmarcaTodosClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 353
      Top = 2
      Width = 125
      Height = 22
      Caption = '[ F5 ] Marca / Desmarca'
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnMarDesClick
    end
    object btnProsseguir: TBitBtnLocked
      Left = 738
      Top = 2
      Width = 267
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = 'Gravar Tabela de Pre'#231'os sem atualizar Cad. Produtos'
      ModalResult = 1
      TabOrder = 5
      OnClick = btnProsseguirClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 537
    Width = 1008
    TabOrder = 2
    ExplicitTop = 537
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
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 491
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          Caption = 'Produto'
          FixedKind = fkLeft
          Width = 308
        end
        item
          Caption = 'Pre'#231'o de Custo'
          Width = 260
        end
        item
          Caption = 'Tabela 1'
          Width = 320
        end
        item
          Caption = 'Tabela 2'
          Width = 320
        end
        item
          Caption = 'Tabela 3'
          Width = 320
        end
        item
          Caption = 'Tabela 4'
          Width = 320
        end
        item
          Caption = 'Tabela 5'
          Width = 320
        end
        item
          Caption = 'Tabela 6'
          Width = 320
        end
        item
          Caption = 'Tabela 7'
          Width = 320
        end
        item
          Caption = 'Fornecedor Atual'
          Width = 250
        end
        item
          Caption = 'Atualizar'
          FixedKind = fkRight
          Width = 60
        end>
      object cxvItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 64
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        Width = 244
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensPRECUS: TcxGridDBBandedColumn
        Caption = 'Atual'
        DataBinding.FieldName = 'ITE_PRECUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensNOVCUS: TcxGridDBBandedColumn
        Caption = 'Novo'
        DataBinding.FieldName = 'ITE_PRECUS_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        OnCustomDrawCell = cxvItensNOVCUSCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARBR1: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV1: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensPREVE1: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensMARBR2: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV2: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARBR3: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV3: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARBR4: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV4: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARBR5: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV5: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARBR6: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV6: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARBR7: TcxGridDBBandedColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'ITE_MARBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 8
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensMARNV7: TcxGridDBBandedColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'ITE_MARBR7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 8
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensPREVE7: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 8
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPRENV1: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensPREVE2: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPRENV2: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensPREVE3: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPRENV3: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensPREVE4: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPRENV4: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 5
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensPREVE5: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPRENV5: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensPREVE6: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Atual'
        DataBinding.FieldName = 'ITE_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 7
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensPRENV6: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 7
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensPRENV7: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Novo'
        DataBinding.FieldName = 'ITE_PREVE7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 8
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensATUALI: TcxGridDBBandedColumn
        Caption = 'Atualizar'
        DataBinding.FieldName = 'TIPATU'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.ImmediateUpdateText = True
        Properties.Items.Strings = (
          'Margem'
          'Pre'#231'o de Venda')
        Properties.OnCloseUp = cxvItensATUALIPropertiesCloseUp
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensCODFOR: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODFOR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 60
        Position.BandIndex = 9
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensNOMFOR: TcxGridDBBandedColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'FOR_NOMFOR'
        Options.Editing = False
        Width = 190
        Position.BandIndex = 9
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMARDES: TcxGridDBBandedColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'MARDES'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        OnCustomDrawCell = cxvItensMARDESCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 10
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  object pnlTail: TPanel [4]
    Left = 0
    Top = 491
    Width = 1008
    Height = 20
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object Label2: TLabel
      Left = 181
      Top = 3
      Width = 124
      Height = 14
      Caption = 'Menor Pre'#231'o de Custo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape2: TShape
      Left = 160
      Top = 3
      Width = 18
      Height = 14
      Brush.Color = clRed
      Pen.Style = psClear
    end
    object Label1: TLabel
      Left = 28
      Top = 3
      Width = 119
      Height = 14
      Caption = 'Maior Pre'#231'o de Custo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape1: TShape
      Left = 8
      Top = 3
      Width = 18
      Height = 14
      Brush.Color = clBlue
      Pen.Style = psClear
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 336
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 600
    Top = 336
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 120
    Top = 152
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14606014
    end
  end
end
