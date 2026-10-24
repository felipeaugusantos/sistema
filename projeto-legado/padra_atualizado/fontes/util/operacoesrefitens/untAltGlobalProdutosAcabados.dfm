inherited frmAltGlobalProdutosAcabados: TfrmAltGlobalProdutosAcabados
  Width = 1166
  Height = 701
  Caption = 'Altera'#231#227'o Global de Produtos Acabados'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1166
  ExplicitHeight = 701
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 629
    Width = 1160
    ExplicitTop = 629
    ExplicitWidth = 1160
    inherited FlwBotoes: TFlowPanel
      Width = 1156
      ExplicitTop = 2
      ExplicitWidth = 1156
    end
  end
  inherited pgcDados: TPageControl
    Width = 1160
    Height = 629
    Visible = False
    ExplicitWidth = 1160
    ExplicitHeight = 629
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1152
      ExplicitHeight = 597
    end
  end
  object cxGProdAcab: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1160
    Height = 629
    Align = alClient
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGProdAcabDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGColAlterado: TcxGridDBColumn
        Caption = '[ ]'
        DataBinding.FieldName = 'REG_EDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'EDITADO'
        Properties.ValueUnchecked = 'N_EDITADO'
        Options.Editing = False
        Options.FilteringWithFindPanel = False
        Width = 27
      end
      object cxGColCodigoAca: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODACA'
        Options.Editing = False
        Width = 56
      end
      object cxGColDtaVenda: TcxGridDBColumn
        Caption = 'Dt. Venda'
        DataBinding.FieldName = 'DTAVEN'
        Options.Editing = False
        Width = 88
      end
      object cxGColIdePro: TcxGridDBColumn
        Caption = 'IdePro'
        DataBinding.FieldName = 'IDEPRO'
        Options.Editing = False
        Width = 67
      end
      object cxGColDescricao: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESCRI'
        Options.Editing = False
        Width = 350
      end
      object cxGColSaldos: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'SALDOS'
        Options.Editing = False
      end
      object cxGColPrecoCusto: TcxGridDBColumn
        Caption = 'Pr. Custo'
        DataBinding.FieldName = 'PRECUS'
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda: TcxGridDBColumn
        Caption = 'Pr. Venda'
        DataBinding.FieldName = 'PREVEN'
        Options.Editing = False
        Width = 89
      end
      object cxGColMargem: TcxGridDBColumn
        Caption = 'Margem Atual'
        DataBinding.FieldName = 'MARGEM_V'
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo: TcxGridDBColumn
        Caption = 'Pr. Venda Novo'
        DataBinding.FieldName = 'PREVNO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ValidateOnEnter = True
        Properties.OnValidate = cxGColPrecoVendaNovoPropertiesValidate
        OnCustomDrawCell = cxGColPrecoVendaNovoCustomDrawCell
        Width = 89
      end
      object cxGColMargemNova: TcxGridDBColumn
        Caption = 'Margem Nova'
        DataBinding.FieldName = 'MARGEM_N'
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda1: TcxGridDBColumn
        Caption = 'Pr. Venda 1'
        DataBinding.FieldName = 'PREVE1'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoMargemAtual1: TcxGridDBColumn
        Caption = 'Margem 1 Atual '
        DataBinding.FieldName = 'MAATU1'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo1: TcxGridDBColumn
        Caption = 'Pr. Venda 1 Novo'
        DataBinding.FieldName = 'PREVN1'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo1PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo1CustomDrawCell
        Width = 89
      end
      object cxGColMargemNova1: TcxGridDBColumn
        Caption = 'Margem 1 Nova'
        DataBinding.FieldName = 'MANOV1'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda2: TcxGridDBColumn
        Caption = 'Pr. Venda 2'
        DataBinding.FieldName = 'PREVE2'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoMargemAtual2: TcxGridDBColumn
        Caption = 'Margem 2 Atual'
        DataBinding.FieldName = 'MAATU2'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo2: TcxGridDBColumn
        Caption = 'Pr. Venda 2 Novo'
        DataBinding.FieldName = 'PREVN2'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo2PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo2CustomDrawCell
        Width = 89
      end
      object cxGColPrecoMargemNova2: TcxGridDBColumn
        Caption = 'Margem 2 Nova'
        DataBinding.FieldName = 'MANOV2'
        Visible = False
        Options.Editing = False
        VisibleForEditForm = bFalse
        Width = 89
      end
      object cxGColPrecoVenda3: TcxGridDBColumn
        Caption = 'Pr. Venda 3'
        DataBinding.FieldName = 'PREVE3'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColMargemAtual3: TcxGridDBColumn
        Caption = 'Margem 3 Atual'
        DataBinding.FieldName = 'MAATU3'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo3: TcxGridDBColumn
        Caption = 'Pr. Venda 3 Novo'
        DataBinding.FieldName = 'PREVN3'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo3PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo3CustomDrawCell
        Width = 89
      end
      object cxGColMargemNova3: TcxGridDBColumn
        Caption = 'Margem 3 Nova'
        DataBinding.FieldName = 'MANOV3'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda4: TcxGridDBColumn
        Caption = 'Pr. Venda 4'
        DataBinding.FieldName = 'PREVE4'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColMargemAtual4: TcxGridDBColumn
        Caption = 'Margem 4 Atual'
        DataBinding.FieldName = 'MAATU4'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo4: TcxGridDBColumn
        Caption = 'Pr. Venda 4 Novo'
        DataBinding.FieldName = 'PREVN4'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo4PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo4CustomDrawCell
        Width = 89
      end
      object cxGColMargemNova4: TcxGridDBColumn
        Caption = 'Margem 4 Nova'
        DataBinding.FieldName = 'MANOV4'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda5: TcxGridDBColumn
        Caption = 'Pr. Venda 5'
        DataBinding.FieldName = 'PREVE5'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColMargem5Atual: TcxGridDBColumn
        Caption = 'Margem 5 Atual'
        DataBinding.FieldName = 'MAATU5'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo5: TcxGridDBColumn
        Caption = 'Pr. Venda 5 Novo'
        DataBinding.FieldName = 'PREVN5'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo5PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo5CustomDrawCell
        Width = 89
      end
      object cxGColMargemNova5: TcxGridDBColumn
        Caption = 'Margem 5 Nova'
        DataBinding.FieldName = 'MANOV5'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda6: TcxGridDBColumn
        Caption = 'Pr. Venda 6'
        DataBinding.FieldName = 'PREVE6'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColMargemAtual6: TcxGridDBColumn
        Caption = 'Margem 6 Atual'
        DataBinding.FieldName = 'MAATU6'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo6: TcxGridDBColumn
        Caption = 'Pr. Venda 6 Novo'
        DataBinding.FieldName = 'PREVN6'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo6PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo6CustomDrawCell
        Width = 89
      end
      object cxGColMargemNova6: TcxGridDBColumn
        Caption = 'Margem 6 Nova'
        DataBinding.FieldName = 'MANOV6'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVenda7: TcxGridDBColumn
        Caption = 'Pr. Venda 7'
        DataBinding.FieldName = 'PREVE7'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColMargem7Atual: TcxGridDBColumn
        Caption = 'Margem 7 Atual'
        DataBinding.FieldName = 'MAATU7'
        Visible = False
        Options.Editing = False
        Width = 89
      end
      object cxGColPrecoVendaNovo7: TcxGridDBColumn
        Caption = 'Pr. Venda 7 Novo'
        DataBinding.FieldName = 'PREVN7'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxGColPrecoVendaNovo7PropertiesValidate
        Visible = False
        OnCustomDrawCell = cxGColPrecoVendaNovo7CustomDrawCell
        Width = 89
      end
      object cxGColMargem7Nova: TcxGridDBColumn
        Caption = 'Margem 7 Nova'
        DataBinding.FieldName = 'MANOV7'
        Visible = False
        Options.Editing = False
        Width = 89
      end
    end
    object cxGProdAcabLevel1: TcxGridLevel
      GridView = cxGProdAcabDBTableView1
    end
  end
  object pnlBotoesAltGlobal: TPanel [4]
    Left = 0
    Top = 629
    Width = 1160
    Height = 27
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Shape3: TShape
      Left = 959
      Top = 7
      Width = 13
      Height = 14
      Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
      Brush.Color = clYellow
      ParentShowHint = False
      ShowHint = True
    end
    object lblEditado: TLabel
      Left = 976
      Top = 7
      Width = 81
      Height = 14
      Caption = 'Pode ser editado'
    end
    object btnGravar: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 138
      Height = 23
      Align = alLeft
      Caption = '[F10] Gravar Novo Pre'#231'o'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnFator: TBitBtnLocked
      Left = 140
      Top = 2
      Width = 174
      Height = 23
      Align = alLeft
      Caption = '[ F2 ] Aplicar Fator no Pr. Venda'
      TabOrder = 1
      OnClick = btnFatorClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 1088
      Top = 2
      Width = 70
      Height = 23
      Align = alRight
      Caption = '&Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 656
    Width = 1160
    ExplicitTop = 656
    ExplicitWidth = 1160
    inherited pnlNomeForm: TPanel
      Left = 989
      ExplicitLeft = 989
    end
    inherited pnlInfo: TPanel
      Width = 989
      ExplicitWidth = 989
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 512
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 584
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 112
  end
end
