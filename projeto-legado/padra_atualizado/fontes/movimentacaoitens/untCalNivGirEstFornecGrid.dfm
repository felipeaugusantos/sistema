inherited frmCalNivGirEstFornecGrid: TfrmCalNivGirEstFornecGrid
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 
    'C'#225'lculo do N'#237'vel de Giro de Estoque por Fornecedor - Itens movim' +
    'entados'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 1008
    ExplicitTop = 517
    ExplicitWidth = 1024
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      TabOrder = 5
      ExplicitWidth = 1020
    end
    inherited btnSair: TBitBtnLocked
      Left = 927
      ExplicitLeft = 943
    end
    object btnGravar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 169
      Height = 22
      Caption = '[ F10 ] Gravar N'#237'vel de Giro'
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
    object btnGraMkp: TBitBtnLocked
      Left = 179
      Top = 3
      Width = 169
      Height = 22
      Caption = '[ F10 ] Gravar Markup'
      Enabled = False
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
      TabOrder = 2
      OnClick = btnGraMkpClick
    end
    object btnInfMkp: TBitBtnLocked
      Left = 352
      Top = 3
      Width = 169
      Height = 22
      Caption = 'Infomar Markup por grupo'
      Enabled = False
      TabOrder = 3
      OnClick = btnInfMkpClick
    end
    object btnExcel: TBitBtnLocked
      Left = 524
      Top = 3
      Width = 169
      Height = 22
      Caption = 'Gerar Excel'
      Enabled = False
      TabOrder = 4
      OnClick = btnExcelClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
    ExplicitWidth = 1024
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 853
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 853
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 49
    Width = 1008
    Height = 255
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 1024
    ExplicitHeight = 324
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      OnFocusedItemChanged = cxgItensViewFocusedItemChanged
      DataController.DataSource = dtsItens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Nehum registro selecionado '
      OptionsView.GroupByBox = False
      object cxgItensViewColumn1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 40
      end
      object cxgItensViewColumn2: TcxGridDBColumn
        Caption = 'C'#243'digo de F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Width = 139
      end
      object cxgItensViewColumn3: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 194
      end
      object cxgItensSITPRO: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITPRO'
        Options.Editing = False
        Width = 61
      end
      object cxgItensQTDITE: TcxGridDBColumn
        Caption = 'Qtd.Vendida'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensPRECUS: TcxGridDBColumn
        Caption = 'Pre'#231'o Unit'#225'rio M'#233'dio'
        DataBinding.FieldName = 'VALUNI'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 117
      end
      object cxgItensViewColumn8: TcxGridDBColumn
        Caption = 'Val.Unit'#225'rio'
        DataBinding.FieldName = 'VALUNI'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensViewColumn9: TcxGridDBColumn
        Caption = 'Venda Total'
        DataBinding.FieldName = 'TOTITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 82
      end
      object cxgItensCODGRP: TcxGridDBColumn
        Caption = 'Grupo Produto'
        DataBinding.FieldName = 'DESGRU'
        Visible = False
        GroupIndex = 0
        Options.Editing = False
        Options.CellMerging = True
      end
      object cxgItensViewColumn10: TcxGridDBColumn
        Caption = 'Represent.'
        DataBinding.FieldName = 'REPITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 65
      end
      object cxgItensViewColumn11: TcxGridDBColumn
        Caption = 'Acumulado'
        DataBinding.FieldName = 'REPACU'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 82
      end
      object cxgItensNVLFOR: TcxGridDBColumn
        Caption = 'N'#237'vel ABC'
        DataBinding.FieldName = 'NVLFOR'
        HeaderAlignmentHorz = taCenter
        Width = 60
      end
      object cxgItensViewColumn12: TcxGridDBColumn
        Caption = '%Margem'
        DataBinding.FieldName = 'MARBRU'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object cxgItensViewColumn14: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda'
        DataBinding.FieldName = 'PREVEN'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensViewColumn15: TcxGridDBColumn
        Caption = 'Pre. Revista'
        DataBinding.FieldName = 'PREREV'
        Visible = False
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxgItensPERMKP: TcxGridDBColumn
        Caption = 'Margem (%)'
        DataBinding.FieldName = 'MARBRU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgItensViewPRECUS: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo'
        DataBinding.FieldName = 'PRECUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensPREVEN: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda'
        DataBinding.FieldName = 'PREVEN_CNV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        HeaderAlignmentHorz = taRightJustify
        Width = 88
      end
      object cxgItensViewPRECU1: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(1)'
        DataBinding.FieldName = 'ITE_PRECUS1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE1_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 1(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE1_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 90
        Options.Editing = False
        Width = 116
      end
      object cxgItensViewPREVE1: TcxGridDBColumn
        Caption = 'Pre. Venda 1(Novo)'
        DataBinding.FieldName = 'ITE_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
        Width = 106
      end
      object cxgItensViewPRECU2: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(2)'
        DataBinding.FieldName = 'ITE_PRECUS2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE2_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 2(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE2_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 116
        Options.Editing = False
      end
      object cxgItensViewPREVE2: TcxGridDBColumn
        Caption = 'Pre. Venda 2(Novo)'
        DataBinding.FieldName = 'ITE_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
      end
      object cxgItensViewPRECU3: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(3)'
        DataBinding.FieldName = 'ITE_PRECUS3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE3_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 3(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE3_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 116
        Options.Editing = False
      end
      object cxgItensViewPREVE3: TcxGridDBColumn
        Caption = 'Pre. Venda 3(Novo)'
        DataBinding.FieldName = 'ITE_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
      end
      object cxgItensViewPRECU4: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(4)'
        DataBinding.FieldName = 'ITE_PRECUS4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE4_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 4(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE4_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 116
        Options.Editing = False
      end
      object cxgItensViewPREVE4: TcxGridDBColumn
        Caption = 'Pre. Venda 4(Novo)'
        DataBinding.FieldName = 'ITE_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
      end
      object cxgItensViewPRECU5: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(5)'
        DataBinding.FieldName = 'ITE_PRECUS5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE5_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 5(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE5_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 116
        Options.Editing = False
      end
      object cxgItensViewPREVE5: TcxGridDBColumn
        Caption = 'Pre. Venda 5(Novo)'
        DataBinding.FieldName = 'ITE_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
      end
      object cxgItensViewPRECU6: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(6)'
        DataBinding.FieldName = 'ITE_PRECUS6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE6_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 6(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE6_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 116
        Options.Editing = False
      end
      object cxgItensViewPREVE6: TcxGridDBColumn
        Caption = 'Pre. Venda 6(Novo)'
        DataBinding.FieldName = 'ITE_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
      end
      object cxgItensViewPRECU7: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(7)'
        DataBinding.FieldName = 'ITE_PRECUS7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        Visible = False
        Options.Editing = False
      end
      object cxgItensViewPREVE7_OLD: TcxGridDBColumn
        Caption = 'Pre. Venda 7(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE7_OLD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        MinWidth = 116
        Options.Editing = False
      end
      object cxgItensViewPREVE7: TcxGridDBColumn
        Caption = 'Pre. Venda 7(Novo)'
        DataBinding.FieldName = 'ITE_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        Visible = False
        OnGetDisplayText = cxgItensViewPREVE1GetDisplayText
        MinWidth = 106
        Options.Editing = False
      end
      object cxgItensPREREV: TcxGridDBColumn
        Caption = 'Pre'#231'o de Revista'
        DataBinding.FieldName = 'PREREV_CNV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 91
      end
      object cxgItensViewTABPR1: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR1'
        Visible = False
      end
      object cxgItensViewTABPR2: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR2'
        Visible = False
      end
      object cxgItensViewTABPR3: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR3'
        Visible = False
      end
      object cxgItensViewTABPR4: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR4'
        Visible = False
      end
      object cxgItensViewTABPR5: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR5'
        Visible = False
      end
      object cxgItensViewTABPR6: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR6'
        Visible = False
      end
      object cxgItensViewTABPR7: TcxGridDBColumn
        DataBinding.FieldName = 'ITE_TABPR7'
        Visible = False
      end
      object cxgItensATU_CADPRO: TcxGridDBColumn
        Caption = 'Atu. Cad. Prod.'
        DataBinding.FieldName = 'ATUPRO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Visible = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 408
    Width = 1008
    Height = 38
    Align = alBottom
    BevelOuter = bvLowered
    Enabled = False
    ParentColor = True
    TabOrder = 3
    ExplicitWidth = 1024
    object Label1: TLabel
      Left = 34
      Top = 11
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label8: TLabel
      Left = 655
      Top = 6
      Width = 258
      Height = 14
      Caption = '[ F5 ] - Marca todos para atulizar cadastro de Produto'
    end
    object Label9: TLabel
      Left = 655
      Top = 21
      Width = 277
      Height = 14
      Caption = '[ F6 ] - Desmarca todos para atulizar cadastro de Produto'
    end
    object DBEditFocus1: TDBEditFocus
      Left = 60
      Top = 7
      Width = 61
      Height = 22
      DataField = 'CODITE'
      DataSource = dtsItens
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Left = 122
      Top = 7
      Width = 527
      Height = 22
      Color = 16768952
      DataField = 'DESITE'
      DataSource = dtsItens
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object prgProgresso: TProgressBar [4]
    Left = 0
    Top = 504
    Width = 1008
    Height = 13
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
    ExplicitWidth = 1024
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 0
    Width = 1008
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Enabled = False
    ParentColor = True
    TabOrder = 5
    ExplicitWidth = 1024
    object Label2: TLabel
      Left = 13
      Top = 14
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object lblTabSelecionada: TLabel
      Left = 0
      Top = 35
      Width = 1008
      Height = 14
      Align = alBottom
      Caption = 'Tabela de Pre'#231'o Selecionada: '
      ExplicitWidth = 145
    end
    object DBEditFocus3: TDBEditFocus
      Left = 76
      Top = 9
      Width = 61
      Height = 22
      DataField = 'CODFOR'
      DataSource = dtsItens
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus4: TDBEditFocus
      Left = 138
      Top = 9
      Width = 643
      Height = 22
      Color = 16768952
      DataField = 'NOMFOR'
      DataSource = dtsItens
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel3: TPanel [6]
    Left = 0
    Top = 446
    Width = 1008
    Height = 58
    Align = alBottom
    BevelOuter = bvLowered
    Enabled = False
    ParentColor = True
    TabOrder = 6
    ExplicitWidth = 1024
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 768
      Height = 56
      Align = alLeft
      Caption = 'Total de Itens'
      TabOrder = 0
      object Label3: TLabel
        Left = 9
        Top = 30
        Width = 91
        Height = 14
        Caption = 'Tabela fornecedor:'
      end
      object Label4: TLabel
        Left = 169
        Top = 30
        Width = 102
        Height = 14
        Caption = 'Fornecedor principal:'
      end
      object Label5: TLabel
        Left = 339
        Top = 30
        Width = 69
        Height = 14
        Caption = 'Itens gerados:'
      end
      object Label6: TLabel
        Left = 476
        Top = 30
        Width = 65
        Height = 14
        Caption = 'Qtd. Vendida:'
      end
      object Label7: TLabel
        Left = 610
        Top = 30
        Width = 67
        Height = 14
        Caption = 'Total Vendido:'
      end
      object edtTabFor: TEditFocus
        Left = 103
        Top = 24
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 0
        Text = 'edtTabFor'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtForPri: TEditFocus
        Left = 273
        Top = 24
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 1
        Text = 'edtTabFor'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtIteGer: TEditFocus
        Left = 410
        Top = 24
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = clWhite
        ReadOnly = True
        TabOrder = 2
        Text = 'edtTabFor'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdVen: TEditFocus
        Left = 545
        Top = 24
        Width = 57
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 3
        Text = 'edtQtdVen'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotVen: TEditFocus
        Left = 682
        Top = 24
        Width = 81
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        ReadOnly = True
        TabOrder = 4
        Text = 'edtTotVen'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlTabelasAtivas: TPanel [7]
    Left = 0
    Top = 373
    Width = 1008
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    ExplicitWidth = 1024
    object chkTabelasAtivas: TCheckListBox
      Left = 0
      Top = 0
      Width = 598
      Height = 35
      Align = alClient
      Columns = 6
      ItemHeight = 14
      Items.Strings = (
        'Tabela Pre'#231'o 1'
        'Tabela Pre'#231'o 2'
        'Tabela Pre'#231'o 3'
        'Tabela Pre'#231'o 4'
        'Tabela Pre'#231'o 5'
        'Tabela Pre'#231'o 6'
        'Tabela Pre'#231'o 7')
      TabOrder = 0
      ExplicitLeft = 92
      ExplicitWidth = 586
    end
    object Panel4: TPanel
      Left = 696
      Top = 0
      Width = 312
      Height = 35
      Align = alRight
      TabOrder = 1
      object Shape1: TShape
        Left = 5
        Top = 2
        Width = 14
        Height = 14
        Brush.Color = cl3DLight
      end
      object Label10: TLabel
        Left = 24
        Top = 2
        Width = 267
        Height = 14
        Caption = 'Tabela do fornecedor n'#227'o esta ativa na tabela de pre'#231'o'
      end
      object Shape2: TShape
        Left = 5
        Top = 18
        Width = 14
        Height = 14
        Brush.Color = clMoneyGreen
      end
      object Label11: TLabel
        Left = 24
        Top = 18
        Width = 222
        Height = 14
        Caption = 'Tabela do fornecedor ativa na tabela de pre'#231'o'
      end
    end
    object chkExibirCalculo: TCheckBox
      AlignWithMargins = True
      Left = 601
      Top = 3
      Width = 92
      Height = 29
      Align = alRight
      Caption = 'Exibir C'#225'lculo'
      TabOrder = 2
      OnClick = chkExibirCalculoClick
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitHeight = 35
    end
  end
  object pnlCalculo: TPanel [8]
    Left = 0
    Top = 304
    Width = 1008
    Height = 69
    Align = alBottom
    TabOrder = 8
    Visible = False
    object lblDadosExibidos: TLabel
      Left = 1
      Top = 1
      Width = 1006
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'lblDadosExibidos'
      ExplicitWidth = 81
    end
    object memCalculo: TRichEdit
      Left = 505
      Top = 15
      Width = 502
      Height = 53
      Align = alClient
      Lines.Strings = (
        'memCalculo')
      ReadOnly = True
      TabOrder = 0
      Zoom = 100
      ExplicitLeft = 192
      ExplicitTop = 18
      ExplicitWidth = 185
      ExplicitHeight = 45
    end
    object memFormula: TRichEdit
      Left = 1
      Top = 15
      Width = 504
      Height = 53
      Align = alLeft
      Lines.Strings = (
        'RichEdit1')
      ReadOnly = True
      TabOrder = 1
      Zoom = 100
      ExplicitHeight = 45
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 144
  end
  object dtsItens: TDataSource
    Left = 48
    Top = 144
  end
end
