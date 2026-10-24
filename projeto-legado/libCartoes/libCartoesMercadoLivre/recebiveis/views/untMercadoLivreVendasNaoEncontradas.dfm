inherited frmMercadoLivreVendasNaoEncontradas: TfrmMercadoLivreVendasNaoEncontradas
  Left = 313
  Top = 166
  Width = 900
  Height = 522
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Mercado Livre - Incluir Vendas N'#227'o Encontradas'
  Constraints.MinHeight = 350
  Constraints.MinWidth = 700
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 900
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 452
    Width = 894
    Height = 25
    Enabled = True
    Visible = True
    ExplicitTop = 452
    ExplicitWidth = 894
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 813
      Height = 21
      ExplicitWidth = 813
      ExplicitHeight = 21
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 21
        Align = alLeft
        Caption = '[ F10 ] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnMarcarTodas: TBitBtnLocked
        Left = 105
        Top = 0
        Width = 105
        Height = 21
        Caption = '[ F7 ] Marcar Todas'
        TabOrder = 1
        OnClick = btnMarcarTodasClick
      end
      object btnDesmarcarTodas: TBitBtnLocked
        Left = 210
        Top = 0
        Width = 120
        Height = 21
        Caption = '[ F8 ] Desmarcar Todas'
        TabOrder = 2
        OnClick = btnDesmarcarTodasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 815
      Top = 2
      Height = 21
      Align = alRight
      Caption = 'Sair'
      ExplicitLeft = 815
      ExplicitTop = 2
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 477
    Width = 894
    ExplicitTop = 477
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 676
      Width = 218
      ExplicitLeft = 676
      ExplicitWidth = 218
    end
    inherited pnlInfo: TPanel
      Width = 676
      ExplicitWidth = 676
    end
  end
  inherited pgcDados: TPageControl
    Left = 864
    Top = 526
    Width = 46
    Height = 45
    Align = alNone
    ExplicitLeft = 864
    ExplicitTop = 526
    ExplicitWidth = 46
    ExplicitHeight = 45
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 38
      ExplicitHeight = 13
    end
  end
  object dbgVendas: TcxGridCitel [3]
    Left = 0
    Top = 0
    Width = 894
    Height = 452
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgVendasDados: TcxGridDBTableViewCitel
      OnDblClick = dbgVendasDadosDblClick
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgVendasDadosCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar as vendas'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object dbgVendasDadosMARCADO: TcxGridDBColumn
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Properties.OnEditValueChanged = dbgVendasDadosMARCADOPropertiesEditValueChanged
        MinWidth = 25
        Options.Filtering = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 25
        IsCaptionAssigned = True
      end
      object dbgVendasDadosREL_NUMNSU: TcxGridDBColumn
        Caption = 'ID da Venda (Envio)'
        DataBinding.FieldName = 'REL_NUMNSU'
        Options.Editing = False
        Options.Focusing = False
        Width = 120
      end
      object dbgVendasDadosORDEID: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'ORDEID'
        Options.Editing = False
        Options.Focusing = False
        Width = 125
      end
      object dbgVendasDadosREL_DTA_CV: TcxGridDBColumn
        Caption = 'Data da Venda'
        DataBinding.FieldName = 'REL_DTA_CV'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 85
      end
      object dbgVendasDadosREL_VALBRU: TcxGridDBColumn
        Caption = 'Valor Bruto'
        DataBinding.FieldName = 'REL_VALBRU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Options.Focusing = False
        Width = 85
      end
      object dbgVendasDadosREL_VALTAX: TcxGridDBColumn
        Caption = 'Taxa'
        DataBinding.FieldName = 'REL_VALTAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object dbgVendasDadosREL_VALFRE: TcxGridDBColumn
        Caption = 'Frete'
        DataBinding.FieldName = 'REL_VALFRE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object dbgVendasDadosREL_VALLIQ: TcxGridDBColumn
        Caption = 'Valor L'#237'quido'
        DataBinding.FieldName = 'REL_VALLIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Options.Focusing = False
        Width = 85
      end
      object dbgVendasDadosREL_DESCRI: TcxGridDBColumn
        Caption = 'Inconsist'#234'ncia'
        DataBinding.FieldName = 'REL_DESCRI'
        Options.Editing = False
        Options.Focusing = False
        Width = 210
      end
    end
    object dbgVendasNivel: TcxGridLevel
      GridView = dbgVendasDados
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 776
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 776
    Top = 184
  end
end
