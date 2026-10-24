inherited frmCadPromocoesItensAdd: TfrmCadPromocoesItensAdd
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Produtos que Ser'#227'o Adicionados na Promo'#231#227'o'
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1008
    ExplicitTop = 519
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 925
      ExplicitLeft = 925
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
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
  object grdDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 519
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosTvCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 55
      end
      object grdDadosTvDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 250
      end
      object grdDadosTvQTDLIM: TcxGridDBColumn
        Caption = 'Qtde.Limite'
        DataBinding.FieldName = 'X_QTDLIM'
      end
      object grdDadosTvQTDMIN: TcxGridDBColumn
        Caption = 'Qtd.M'#237'nima'
        DataBinding.FieldName = 'X_QTDMIN'
      end
      object grdDadosTvPRECUS: TcxGridDBColumn
        Caption = 'Pre'#231'o Custo'
        DataBinding.FieldName = 'X_PRECUS'
        Width = 70
      end
      object grdDadosTvPREVEN: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda'
        DataBinding.FieldName = 'X_PREVEN'
        Width = 70
      end
      object grdDadosTvCOMVAR: TcxGridDBColumn
        Caption = '% Comiss. Vend. Interno'
        DataBinding.FieldName = 'X_COMVAR'
        Width = 125
      end
      object grdDadosTvCOMATA: TcxGridDBColumn
        Caption = '% Comiss. Repres. Ext. Loja'
        DataBinding.FieldName = 'X_COMATA'
        Width = 145
      end
      object grdDadosTvCOMDIS: TcxGridDBColumn
        Caption = '% Comiss. Repres. Ext. Distrib.'
        DataBinding.FieldName = 'X_COMDIS'
        Width = 155
      end
      object grdDadosTvPRZMED: TcxGridDBColumn
        Caption = 'Prz M'#233'd. Cond. Pagto.'
        DataBinding.FieldName = 'X_PRZMED'
        Width = 115
      end
    end
    object grdDadosLv: TcxGridLevel
      GridView = grdDadosTv
    end
  end
  object dtsDados: TDataSource
    Left = 456
    Top = 512
  end
end
