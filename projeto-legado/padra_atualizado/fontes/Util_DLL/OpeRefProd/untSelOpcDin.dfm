inherited frmSelOpcDin: TfrmSelOpcDin
  Width = 500
  Height = 420
  Caption = 'Selecionar Opcoes'
  ExplicitWidth = 500
  ExplicitHeight = 420
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 349
    Width = 494
    ExplicitTop = 349
    ExplicitWidth = 494
    inherited FlwBotoes: TFlowPanel
      Width = 490
      ExplicitLeft = 6
      ExplicitTop = -2
      ExplicitWidth = 490
      object btnMarcaTodos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 118
        Height = 22
        Caption = '[ F1 ] - Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 193
        Top = 0
        Width = 128
        Height = 22
        Caption = '[ F2 ] - Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 411
      ExplicitLeft = 411
    end
  end
  inherited pnlStatus: TPanel
    Top = 375
    Width = 494
    ExplicitTop = 375
    ExplicitWidth = 494
    inherited pnlNomeForm: TPanel
      Left = 323
      ExplicitLeft = 323
    end
    inherited pnlInfo: TPanel
      Width = 323
      ExplicitWidth = 323
    end
  end
  object cxgOpcoes: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 494
    Height = 349
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvOpcoes: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsOpcoes
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvSelecionado: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'OPC_SEL'
        Width = 50
      end
      object cxvDescricao: TcxGridDBColumn
        Caption = 'Descricao'
        DataBinding.FieldName = 'OPC_DESCRICAO'
        Options.Editing = False
        Width = 400
      end
      object cxvId: TcxGridDBColumn
        Caption = 'Id'
        DataBinding.FieldName = 'OPC_ID'
        Visible = False
        Options.Editing = False
      end
    end
    object cxlOpcoes: TcxGridLevel
      GridView = cxvOpcoes
    end
  end
  object cdsOpcoes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 8
  end
  object dtsOpcoes: TDataSource
    DataSet = cdsOpcoes
    Left = 424
    Top = 56
  end
end
