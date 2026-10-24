inherited frmCadLeadOrcamentos: TfrmCadLeadOrcamentos
  Width = 737
  Height = 355
  Caption = 'Or'#231'amentos'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 737
  ExplicitHeight = 355
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 282
    Width = 731
    ExplicitTop = 282
    ExplicitWidth = 731
    inherited FlwBotoes: TFlowPanel
      Width = 727
      ExplicitWidth = 727
      object btnDesvincular: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = 'Desvincular Or'#231'.'
        TabOrder = 0
        OnClick = btnDesvincularClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 651
      ExplicitLeft = 651
    end
  end
  inherited pnlStatus: TPanel
    Top = 310
    Width = 731
    ExplicitTop = 310
    ExplicitWidth = 731
    inherited pnlNomeForm: TPanel
      Left = 560
      ExplicitLeft = 560
    end
    inherited pnlInfo: TPanel
      Width = 560
      ExplicitWidth = 560
    end
  end
  object cxgOrcamentos: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 731
    Height = 282
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgOrcamentosDBTableViewCitel1: TcxGridDBTableViewCitel
      OnMouseDown = cxgOrcamentosDBTableViewCitel1MouseDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgOrcamentosDBTableViewCitel1Column7: TcxGridDBColumn
        Caption = 'Selecionar'
        DataBinding.FieldName = 'MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taCenter
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        VisibleForEditForm = bTrue
        Width = 62
      end
      object cxgOrcamentosDBTableViewCitel1Column1: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'FGO_NUMDOC'
        Options.Editing = False
        Width = 90
      end
      object cxgOrcamentosDBTableViewCitel1Column2: TcxGridDBColumn
        Caption = 'Especie'
        DataBinding.FieldName = 'FGO_ESPDOC'
        Options.Editing = False
        Width = 55
      end
      object cxgOrcamentosDBTableViewCitel1Column6: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'FGO_CODEMP'
        Options.Editing = False
        Width = 58
      end
      object cxgOrcamentosDBTableViewCitel1Column3: TcxGridDBColumn
        Caption = 'C'#243'd. cliente'
        DataBinding.FieldName = 'FGO_CODCLI'
        Options.Editing = False
        Width = 75
      end
      object cxgOrcamentosDBTableViewCitel1Column4: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Options.Editing = False
        Width = 202
      end
      object cxgOrcamentosDBTableViewCitelLINGRU: TcxGridDBColumn
        Caption = 'Linha/Grupo'
        DataBinding.FieldName = 'FGO_LINGRU'
        Width = 70
      end
      object cxgOrcamentosDBTableViewCitel1Column5: TcxGridDBColumn
        Caption = 'Total de Produtos'
        DataBinding.FieldName = 'FGO_TOTPRO'
        Options.Editing = False
        Width = 100
      end
    end
    object cxgOrcamentosLevel1: TcxGridLevel
      GridView = cxgOrcamentosDBTableViewCitel1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 216
    Top = 112
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
  end
  object popMenu: TPopupMenu
    Left = 343
    Top = 42
    object mnuEfetivarOrcamento: TMenuItem
      Caption = 'Efetivar em Pedido'
      ShortCut = 32881
      OnClick = mnuEfetivarOrcamentoClick
    end
    object mnuAlterarDocumento: TMenuItem
      Caption = 'Alterar Documento'
      ShortCut = 32882
      OnClick = mnuAlterarDocumentoClick
    end
    object mnuEnviarEmail: TMenuItem
      Caption = 'Enviar por E-mail'
      ShortCut = 32883
      OnClick = mnuEnviarEmailClick
    end
    object mnuGerarPDF: TMenuItem
      Caption = 'Gerar PDF'
      ShortCut = 32884
      OnClick = mnuGerarPDFClick
    end
    object mnuReimprimir: TMenuItem
      Caption = 'Reimprimir'
      ShortCut = 32885
      OnClick = mnuReimprimirClick
    end
    object mnuGerarVendaPerdida: TMenuItem
      Caption = 'Gerar Venda Perdida'
      ShortCut = 32886
      OnClick = mnuGerarVendaPerdidaClick
    end
    object mnuDesmembrar: TMenuItem
      Caption = 'Desmembrar'
      ShortCut = 32887
      OnClick = mnuDesmembrarClick
    end
    object mnuBaixar: TMenuItem
      Caption = 'Baixar (n'#227'o ser'#225' entregue)'
      ShortCut = 32888
      OnClick = mnuBaixarClick
    end
    object mnuAnaliseCreditoDEPS: TMenuItem
      Caption = 'Solicitar an'#225'lise de cr'#233'dito DEPS'
      OnClick = mnuAnaliseCreditoDEPSClick
    end
  end
end
