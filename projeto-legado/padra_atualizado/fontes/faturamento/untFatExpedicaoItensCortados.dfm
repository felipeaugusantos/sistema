inherited frmFatExpedicaoItensCortados: TfrmFatExpedicaoItensCortados
  Left = 407
  Top = 222
  Width = 800
  Height = 393
  Caption = 'Itens Cortados'
  Position = poScreenCenter
  ExplicitWidth = 800
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 320
    Width = 794
    ExplicitTop = 320
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
    end
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
  end
  inherited pnlStatus: TPanel
    Top = 348
    Width = 794
    ExplicitTop = 348
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object cxGridCitel1: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 794
    Height = 320
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridCitel1TableView1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridCitel1TableView1CODITE: TcxGridDBColumn
        Caption = 'Cod.Item'
        DataBinding.FieldName = 'CODITE'
        Width = 72
      end
      object cxGridCitel1TableView1CODFAB: TcxGridDBColumn
        Caption = 'Cod.Fabr.'
        DataBinding.FieldName = 'CODFAB'
        Width = 96
      end
      object cxGridCitel1TableView1LOCEST: TcxGridDBColumn
        Caption = 'Loc.Estoque'
        DataBinding.FieldName = 'LOCEST'
        Width = 103
      end
      object cxGridCitel1TableView1DESITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'DESITE'
        Width = 282
      end
      object cxGridCitel1TableView1MLTVEN: TcxGridDBColumn
        Caption = 'Mult.Venda'
        DataBinding.FieldName = 'MLTVEN'
      end
      object cxGridCitel1TableView1UNIDAD: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'UNIDAD'
        Width = 46
      end
      object cxGridCitel1TableView1QTDCOR: TcxGridDBColumn
        Caption = 'Qtde.'
        DataBinding.FieldName = 'QTDCOR'
      end
      object cxGridCitel1TableView1SALDIS: TcxGridDBColumn
        Caption = 'Sal.Disp'
        DataBinding.FieldName = 'SALDIS'
        Options.Editing = False
      end
      object cxGridCitel1TableView1ENTSAI: TcxGridDBColumn
        Caption = 'Ent/Sai'
        DataBinding.FieldName = 'ENTSAI'
        Width = 40
      end
    end
    object cxGridCitel1Level1: TcxGridLevel
      GridView = cxGridCitel1TableView1
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 504
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 648
    Top = 136
  end
  object dtsDados: TDataSource
    Left = 232
    Top = 80
  end
end
