inherited frmAltEfetivacaoSelec: TfrmAltEfetivacaoSelec
  Width = 1024
  Height = 455
  BorderStyle = bsSizeable
  Caption = 'Manuten'#231#227'o dos Itens para Atualiza'#231#227'o de Pre'#231'os'
  WindowState = wsMaximized
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1024
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 372
    Width = 1008
    ExplicitTop = 372
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Left = 587
      Width = 358
      TabOrder = 4
      ExplicitLeft = 577
      ExplicitWidth = 368
      object btnGravaAteracoes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 150
        Height = 24
        Caption = '[ F10 ] Salva  Altera'#231#245'es'
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
        OnClick = btnGravaAteracoesClick
      end
      object pnlLegenda: TPanel
        Left = 150
        Top = 0
        Width = 184
        Height = 22
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object shpAltera: TShape
          Left = 2
          Top = 2
          Width = 18
          Height = 18
          Brush.Color = 8454143
        end
        object Label1: TLabel
          Left = 24
          Top = 4
          Width = 160
          Height = 14
          Caption = 'Valores que podem ser alterados'
        end
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 945
      Top = 2
      Width = 61
      Height = 24
      Align = alRight
      Caption = 'Sair'
      TabOrder = 5
      ExplicitLeft = 945
      ExplicitTop = 2
      ExplicitWidth = 61
      ExplicitHeight = 24
    end
    object btnMarcaTodos: TBitBtnLocked
      Left = 334
      Top = 2
      Width = 115
      Height = 24
      Align = alLeft
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
      ExplicitLeft = 327
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 449
      Top = 2
      Width = 138
      Height = 24
      Align = alLeft
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
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 181
      Height = 24
      Align = alLeft
      Caption = '[ F8 ] Exclui Itens Selecionados'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnMarDes: TBitBtnLocked
      Left = 183
      Top = 2
      Width = 151
      Height = 24
      Align = alLeft
      Caption = '[ ESPA'#199'O ] Marca / Desmarca'
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnMarDesClick
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 372
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          FixedKind = fkLeft
        end
        item
          Caption = 'Pre'#231'os que ser'#227'o alterados'
          HeaderAlignmentHorz = taLeftJustify
        end>
      object cxgItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'PRE_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 61
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 140
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensPRECOM: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Compra'
        DataBinding.FieldName = 'PRE_PRECOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 93
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDESF01: TcxGridDBBandedColumn
        Caption = 'Desconto 01'
        DataBinding.FieldName = 'PRE_DESF01'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensDESF02: TcxGridDBBandedColumn
        Caption = 'Desconto 02'
        DataBinding.FieldName = 'PRE_DESF02'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensDESF03: TcxGridDBBandedColumn
        Caption = 'Desconto 03'
        DataBinding.FieldName = 'PRE_DESF03'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensDESF04: TcxGridDBBandedColumn
        Caption = 'Desconto 04'
        DataBinding.FieldName = 'PRE_DESF04'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensDESF05: TcxGridDBBandedColumn
        Caption = 'Desconto 05'
        DataBinding.FieldName = 'PRE_DESF05'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensDESF06: TcxGridDBBandedColumn
        Caption = 'Desconto 06'
        DataBinding.FieldName = 'PRE_DESF06'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensICMENT: TcxGridDBBandedColumn
        Caption = 'ICMS de Entrada'
        DataBinding.FieldName = 'PRE_ICMENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensSUBFED: TcxGridDBBandedColumn
        Caption = 'Impostos Federais (-)'
        DataBinding.FieldName = 'PRE_SUBFED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensIPIENT: TcxGridDBBandedColumn
        Caption = 'IPI de Entrada'
        DataBinding.FieldName = 'PRE_IPIENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensFREENT: TcxGridDBBandedColumn
        Caption = '% Frete'
        DataBinding.FieldName = 'PRE_FREENT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensVALFRE: TcxGridDBBandedColumn
        Caption = 'Valor Frete'
        DataBinding.FieldName = 'PRE_VALFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxgItensACRFIN: TcxGridDBBandedColumn
        Caption = 'Acr'#233'scimo Financeiro'
        DataBinding.FieldName = 'PRE_ACRFIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxgItensSUBSTI: TcxGridDBBandedColumn
        Caption = 'Substitui'#231#227'o'
        DataBinding.FieldName = 'PRE_SUBSTI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxgItensDESADB: TcxGridDBBandedColumn
        Caption = 'Desconto Adicional'
        DataBinding.FieldName = 'PRE_DESADB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxgItensPRECUS: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o de Custo'
        DataBinding.FieldName = 'PRE_PRECUS_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxgItensOUTVAL: TcxGridDBBandedColumn
        Caption = 'Outros Valores'
        DataBinding.FieldName = 'PRE_OUTVAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxgItensICMSAI: TcxGridDBBandedColumn
        Caption = 'ICMS de Sa'#237'da'
        DataBinding.FieldName = 'PRE_ICMSAI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxgItensIMPFED: TcxGridDBBandedColumn
        Caption = 'Impostos Federais. (+)'
        DataBinding.FieldName = 'PRE_IMPFED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxgItensDESOPE: TcxGridDBBandedColumn
        Caption = 'Despesas Operacionais'
        DataBinding.FieldName = 'PRE_DESOPE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxgItensMARBR1: TcxGridDBBandedColumn
        Caption = '% Margem 1'
        DataBinding.FieldName = 'PRE_MARBR1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxgItensCOMTB1: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 1'
        DataBinding.FieldName = 'PRE_COMTB1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxgItensPREVE1: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 1'
        DataBinding.FieldName = 'PRE_PREVE1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
      object cxgItensMARBR2: TcxGridDBBandedColumn
        Caption = '% Margem 2'
        DataBinding.FieldName = 'PRE_MARBR2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 24
        Position.RowIndex = 0
      end
      object cxgItensCOMTB2: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 2'
        DataBinding.FieldName = 'PRE_COMTB2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 25
        Position.RowIndex = 0
      end
      object cxgItensPREVE2: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 2'
        DataBinding.FieldName = 'PRE_PREVE2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 26
        Position.RowIndex = 0
      end
      object cxgItensMARBR3: TcxGridDBBandedColumn
        Caption = '% Margem 3'
        DataBinding.FieldName = 'PRE_MARBR3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 27
        Position.RowIndex = 0
      end
      object cxgItensCOMTB3: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 3'
        DataBinding.FieldName = 'PRE_COMTB3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 28
        Position.RowIndex = 0
      end
      object cxgItensPREVE3: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 3'
        DataBinding.FieldName = 'PRE_PREVE3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 29
        Position.RowIndex = 0
      end
      object cxgItensMARBR4: TcxGridDBBandedColumn
        Caption = '% Margem 4'
        DataBinding.FieldName = 'PRE_MARBR4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 30
        Position.RowIndex = 0
      end
      object cxgItensCOMTB4: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 4'
        DataBinding.FieldName = 'PRE_COMTB4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 31
        Position.RowIndex = 0
      end
      object cxgItensPREVE4: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 4'
        DataBinding.FieldName = 'PRE_PREVE4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 32
        Position.RowIndex = 0
      end
      object cxgItensMARBR5: TcxGridDBBandedColumn
        Caption = '% Margem 5'
        DataBinding.FieldName = 'PRE_MARBR5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 33
        Position.RowIndex = 0
      end
      object cxgItensCOMTB5: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 5'
        DataBinding.FieldName = 'PRE_COMTB5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 34
        Position.RowIndex = 0
      end
      object cxgItensPREVE5: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 5'
        DataBinding.FieldName = 'PRE_PREVE5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 35
        Position.RowIndex = 0
      end
      object cxgItensMARBR6: TcxGridDBBandedColumn
        Caption = '% Margem 6'
        DataBinding.FieldName = 'PRE_MARBR6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 36
        Position.RowIndex = 0
      end
      object cxgItensCOMTB6: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 6'
        DataBinding.FieldName = 'PRE_COMTB6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 37
        Position.RowIndex = 0
      end
      object cxgItensPREVE6: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 6'
        DataBinding.FieldName = 'PRE_PREVE6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 38
        Position.RowIndex = 0
      end
      object cxgItensMARBR7: TcxGridDBBandedColumn
        Caption = '% Margem 7'
        DataBinding.FieldName = 'PRE_MARBR7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000;-0.0000'
        Properties.OnValidate = cxgItensMARBR1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 39
        Position.RowIndex = 0
      end
      object cxgItensCOMTB7: TcxGridDBBandedColumn
        Caption = 'Comiss'#227'o 7'
        DataBinding.FieldName = 'PRE_COMTB7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 40
        Position.RowIndex = 0
      end
      object cxgItensPREVE7: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o Venda 7'
        DataBinding.FieldName = 'PRE_PREVE7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        Properties.OnValidate = cxgItensPREVE1PropertiesValidate
        OnCustomDrawCell = cxgItensMARBR1CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 41
        Position.RowIndex = 0
      end
      object cxgItensMARCAD: TcxGridDBBandedColumn
        DataBinding.FieldName = 'MARCAD'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensPROPRI: TcxGridDBBandedColumn
        Caption = 'Sequencial de Atualiza'#231#227'o'
        DataBinding.FieldName = 'PRE_PROPRI'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensViewColumn1: TcxGridDBBandedColumn
        Caption = 'Nota Fiscal'
        DataBinding.FieldName = 'DET_NUMDOC'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 88
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensViewCUSREA: TcxGridDBBandedColumn
        Caption = 'Custo Real'
        DataBinding.FieldName = 'CUSTO_REAL'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 72
        Position.BandIndex = 1
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  inherited pnlStatus: TPanel
    Top = 400
    Width = 1008
    ExplicitTop = 400
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 216
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 128
    Top = 140
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15066597
    end
  end
end
