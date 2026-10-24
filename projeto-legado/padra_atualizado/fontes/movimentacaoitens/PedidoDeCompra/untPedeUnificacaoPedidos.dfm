inherited frmPedeUnificacaoPedidos: TfrmPedeUnificacaoPedidos
  Width = 1024
  Height = 581
  BorderStyle = bsSizeable
  Caption = 'Unifica'#231#227'o de Pedidos de Compra'
  ExplicitWidth = 1024
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 500
    Width = 1008
    Height = 26
    TabOrder = 2
    ExplicitTop = 500
    ExplicitWidth = 1008
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 927
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 1004
      ExplicitHeight = 24
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 174
        Height = 22
        Caption = '[ F10 ] Confirma unifica'#231#227'o'
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
        Left = 174
        Top = 0
        Width = 202
        Height = 22
        Caption = '[ ENTER ] Marca / Desmarca Pedido'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarDesClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 376
        Top = 0
        Width = 141
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
        Left = 517
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
        TabOrder = 3
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Align = alRight
      ExplicitLeft = 927
      ExplicitTop = 2
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label3: TLabel
      Left = 32
      Top = 19
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lbl1: TLabel
      Left = 7
      Top = 44
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 93
      Top = 15
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtNomFor: TEditFocus
      Left = 164
      Top = 15
      Width = 501
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 93
      Top = 38
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnEnter = edtCodEmpEnter
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 164
      Top = 38
      Width = 501
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAlterar: TBitBtnLocked
      Left = 671
      Top = 39
      Width = 130
      Height = 22
      Caption = 'Carregar &Pedidos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
        CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
        A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
        820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
        860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
        C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
        D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
        9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 4
      OnClick = btnAlterarClick
    end
  end
  object cxggItens: TcxGridCitel [3]
    Left = 0
    Top = 73
    Width = 1008
    Height = 386
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 384
    object cxgItens: TcxGridDBTableViewCitel
      OnKeyDown = cxgItensKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOTIPI
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOTSUB
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOTGER
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITESEL'
          Column = cxgItensTOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'IPISEL'
          Column = cxgItensTOTIPI
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'SUBSEL'
          Column = cxgItensTOTSUB
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'GERSEL'
          Column = cxgItensTOTGER
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOTCBS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'CBSSEL'
          Column = cxgItensTOTCBS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOTIBS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'IBSSEL'
          Column = cxgItensTOTIBS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensTOT_IS
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'IS_SEL'
          Column = cxgItensTOT_IS
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgItensNUMPED: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'NUMPED'
        HeaderAlignmentHorz = taCenter
        Width = 83
      end
      object cxgItensEMPORI: TcxGridDBColumn
        Caption = 'Emp.Ori.'
        DataBinding.FieldName = 'EMPORI'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgItensEMPDES: TcxGridDBColumn
        Caption = 'Emp.Des.'
        DataBinding.FieldName = 'EMPDES'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgItensDTAPED: TcxGridDBColumn
        Caption = 'Dt. Pedido'
        DataBinding.FieldName = 'DTAPED'
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object cxgItensDTAENT: TcxGridDBColumn
        Caption = 'Dt. Entrega'
        DataBinding.FieldName = 'DTAENT'
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object cxgItensCONPAG: TcxGridDBColumn
        Caption = 'Condi'#231#227'o de Pagamento'
        DataBinding.FieldName = 'CONPAG'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;_'
        Width = 190
      end
      object cxgItensTOTITE: TcxGridDBColumn
        Caption = 'Total Itens'
        DataBinding.FieldName = 'TOTITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensTOTIPI: TcxGridDBColumn
        Caption = 'Total IPI'
        DataBinding.FieldName = 'TOTIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensTOTCBS: TcxGridDBColumn
        Caption = 'Total CBS'
        DataBinding.FieldName = 'TOTCBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensTOTIBS: TcxGridDBColumn
        Caption = 'Total IBS'
        DataBinding.FieldName = 'TOTIBS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensTOT_IS: TcxGridDBColumn
        Caption = 'Total IS'
        DataBinding.FieldName = 'TOT_IS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensTOTSUB: TcxGridDBColumn
        Caption = 'Total Subst.'
        DataBinding.FieldName = 'TOTSUB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensTOTGER: TcxGridDBColumn
        Caption = 'Total Geral'
        DataBinding.FieldName = 'TOTGER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensAUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTINC'
        Visible = False
      end
      object cxgItensNOTAS: TcxGridDBColumn
        Caption = 'NFE'
        DataBinding.FieldName = 'NOTAS'
        Width = 138
      end
      object cxgItensQTD_BAIPED: TcxGridDBColumn
        DataBinding.FieldName = 'QTD_BAIPED'
        Visible = False
      end
    end
    object cxggItensLevel1: TcxGridLevel
      GridView = cxgItens
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 459
    Width = 1008
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    ExplicitTop = 457
    object Shape3: TShape
      Left = 12
      Top = 14
      Width = 14
      Height = 14
      Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
      Brush.Color = clSilver
      ParentShowHint = False
      ShowHint = True
    end
    object Label8: TLabel
      Left = 30
      Top = 14
      Width = 240
      Height = 14
      Caption = 'Pedidos com Pr'#233'-nota ou j'#225' vinculados para baixa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Panel2: TPanel
      Left = 645
      Top = 0
      Width = 363
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Label17: TLabel
        Left = 19
        Top = 8
        Width = 427
        Height = 14
        AutoSize = False
        Caption = 'Primeira linha de total = TOTAL DE TODOS OS PEDIDOS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 19
        Top = 21
        Width = 327
        Height = 14
        Caption = 'Segunda linha de total = TOTAL DOS PEDIDOS SELECIONADOS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 526
    Width = 1008
    TabOrder = 3
    ExplicitTop = 526
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
    Left = 200
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 88
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 168
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 88
    Top = 168
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 88
    Top = 312
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14408667
    end
  end
end
