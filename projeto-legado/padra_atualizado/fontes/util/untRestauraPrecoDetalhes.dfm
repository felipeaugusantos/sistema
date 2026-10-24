inherited frmRestauraPrecoDetalhes: TfrmRestauraPrecoDetalhes
  Width = 1298
  Height = 630
  BorderStyle = bsSizeable
  Caption = 'Restaura'#231#227'o de Pre'#231'o - Detalhes'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1298
  ExplicitHeight = 630
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 547
    Width = 1282
    ExplicitTop = 547
    ExplicitWidth = 1282
    inherited FlwBotoes: TFlowPanel
      Width = 1278
      ExplicitWidth = 1278
    end
    inherited btnSair: TBitBtnLocked
      Left = 1202
      ExplicitLeft = 1202
    end
  end
  inherited pnlStatus: TPanel
    Top = 575
    Width = 1282
    ExplicitTop = 575
    ExplicitWidth = 1282
    inherited pnlNomeForm: TPanel
      Left = 1111
      ExplicitLeft = 1111
    end
    inherited pnlInfo: TPanel
      Width = 1111
      ExplicitWidth = 1111
    end
  end
  object cxgItens: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1282
    Height = 547
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvItensCustomDrawCell
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = 13499135
      object cxvItensColumn1: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'ITE_CODEMP'
      end
      object cxvItensColumn2: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'ITE_CODITE'
      end
      object cxgITE_DESITE: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 300
      end
      object cxgITE_PRECUS_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o Custo(Antigo)'
        DataBinding.FieldName = 'ITE_PRECUS_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 110
      end
      object cxgITE_PRECUS_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o Custo(Novo)'
        DataBinding.FieldName = 'ITE_PRECUS_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 110
      end
      object cxgITE_PREVE1_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 1(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE1_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 135
      end
      object cxgITE_PREVE1_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 1(Novo)'
        DataBinding.FieldName = 'ITE_PREVE1_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 135
      end
      object cxgITE_MARBR1_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 1(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR1_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR1_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 1(Novo)'
        DataBinding.FieldName = 'ITE_MARBR1_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB1_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 1(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB1_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB1_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 1(Novo)'
        DataBinding.FieldName = 'ITE_COMTB1_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PREVE2_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 2(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE2_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_PREVE2_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 2(Novo)'
        DataBinding.FieldName = 'ITE_PREVE2_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_MARBR2_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 2(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR2_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR2_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 2(Novo)'
        DataBinding.FieldName = 'ITE_MARBR2_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB2_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 2(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB2_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB2_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 2(Novo)'
        DataBinding.FieldName = 'ITE_COMTB2_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PREVE3_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 3(Antigo) '
        DataBinding.FieldName = 'ITE_PREVE3_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_PREVE3_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 3(Novo) '
        DataBinding.FieldName = 'ITE_PREVE3_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_MARBR3_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 3(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR3_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR3_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 3(Novo)'
        DataBinding.FieldName = 'ITE_MARBR3_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB3_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 3(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB3_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB3_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 3(Novo)'
        DataBinding.FieldName = 'ITE_COMTB3_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PREVE4_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 4(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE4_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_PREVE4_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 4(Novo)'
        DataBinding.FieldName = 'ITE_PREVE4_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_MARBR4_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 4(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR4_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR4_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 4(Novo)'
        DataBinding.FieldName = 'ITE_MARBR4_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB4_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 4(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB4_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB4_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 4(Novo)'
        DataBinding.FieldName = 'ITE_COMTB4_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PREVE5_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 5(Antigo) '
        DataBinding.FieldName = 'ITE_PREVE5_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_PREVE5_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 5(Novo) '
        DataBinding.FieldName = 'ITE_PREVE5_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_MARBR5_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 5(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR5_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR5_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 5(Novo)'
        DataBinding.FieldName = 'ITE_MARBR5_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB5_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 5(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB5_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB5_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 5(Novo)'
        DataBinding.FieldName = 'ITE_COMTB5_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PREVE6_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 6(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE6_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_PREVE6_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 6(Novo)'
        DataBinding.FieldName = 'ITE_PREVE6_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_MARBR6_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 6(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR6_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR6_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 6(Novo)'
        DataBinding.FieldName = 'ITE_MARBR6_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB6_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 6(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB6_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB6_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 6(Novo)'
        DataBinding.FieldName = 'ITE_COMTB6_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PREVE7_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 7(Antigo)'
        DataBinding.FieldName = 'ITE_PREVE7_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_PREVE7_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda 7(Novo)'
        DataBinding.FieldName = 'ITE_PREVE7_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 137
      end
      object cxgITE_MARBR7_ANT: TcxGridDBColumn
        Caption = 'Margem Bruta 7(Antigo)'
        DataBinding.FieldName = 'ITE_MARBR7_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_MARBR7_ATU: TcxGridDBColumn
        Caption = 'Margem Bruta 7(Novo)'
        DataBinding.FieldName = 'ITE_MARBR7_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 124
      end
      object cxgITE_COMTB7_ANT: TcxGridDBColumn
        Caption = 'Comiss'#227'o 7(Antigo)'
        DataBinding.FieldName = 'ITE_COMTB7_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_COMTB7_ATU: TcxGridDBColumn
        Caption = 'Comiss'#227'o 7(Novo)'
        DataBinding.FieldName = 'ITE_COMTB7_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 105
      end
      object cxgITE_PRECOM_ANT: TcxGridDBColumn
        Caption = 'Pre'#231'o de Compra(Antigo)'
        DataBinding.FieldName = 'ITE_PRECOM_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 130
      end
      object cxgITE_PRECOM_ATU: TcxGridDBColumn
        Caption = 'Pre'#231'o de Compra(Novo)'
        DataBinding.FieldName = 'ITE_PRECOM_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 130
      end
      object cxgITE_DESF01_ANT: TcxGridDBColumn
        Caption = 'Desc. Fornec. 1(Antigo)'
        DataBinding.FieldName = 'ITE_DESF01_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF01_ATU: TcxGridDBColumn
        Caption = 'Desc. Fornec. 1(Novo)'
        DataBinding.FieldName = 'ITE_DESF01_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF02_ANT: TcxGridDBColumn
        Caption = 'Desc. Fornec. 2(Antigo)'
        DataBinding.FieldName = 'ITE_DESF02_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF02_ATU: TcxGridDBColumn
        Caption = 'Desc. Fornec. 2(Novo)'
        DataBinding.FieldName = 'ITE_DESF02_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF03_ANT: TcxGridDBColumn
        Caption = 'Desc. Fornec. 3(Antigo)'
        DataBinding.FieldName = 'ITE_DESF03_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF03_ATU: TcxGridDBColumn
        Caption = 'Desc. Fornec. 3(Novo)'
        DataBinding.FieldName = 'ITE_DESF03_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF04_ANT: TcxGridDBColumn
        Caption = 'Desc. Fornec. 4(Antigo)'
        DataBinding.FieldName = 'ITE_DESF04_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF04_ATU: TcxGridDBColumn
        Caption = 'Desc. Fornec. 4(Novo)'
        DataBinding.FieldName = 'ITE_DESF04_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF05_ANT: TcxGridDBColumn
        Caption = 'Desc. Fornec. 5(Antigo)'
        DataBinding.FieldName = 'ITE_DESF05_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF05_ATU: TcxGridDBColumn
        Caption = 'Desc. Fornec. 5(Novo)'
        DataBinding.FieldName = 'ITE_DESF05_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF06_ANT: TcxGridDBColumn
        Caption = 'Desc. Fornec. 6(Antigo)'
        DataBinding.FieldName = 'ITE_DESF06_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_DESF06_ATU: TcxGridDBColumn
        Caption = 'Desc. Fornec. 6(Novo)'
        DataBinding.FieldName = 'ITE_DESF06_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 125
      end
      object cxgITE_SUBFED_ANT: TcxGridDBColumn
        Caption = 'Impostos Federais (-)(Antigo)'
        DataBinding.FieldName = 'ITE_SUBFED_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 150
      end
      object cxgITE_SUBFED_ATU: TcxGridDBColumn
        Caption = 'Impostos Federais (-)(Novo)'
        DataBinding.FieldName = 'ITE_SUBFED_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 150
      end
      object cxgITE_IPIENT_ANT: TcxGridDBColumn
        Caption = 'IPI Entrada (+)(Antigo)'
        DataBinding.FieldName = 'ITE_IPIENT_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 115
      end
      object cxgITE_IPIENT_ATU: TcxGridDBColumn
        Caption = 'IPI Entrada (+)(Novo)'
        DataBinding.FieldName = 'ITE_IPIENT_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 115
      end
      object cxgITE_FREENT_ANT: TcxGridDBColumn
        Caption = 'Frete (+)(Antigo)'
        DataBinding.FieldName = 'ITE_FREENT_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 90
      end
      object cxgITE_FREENT_ATU: TcxGridDBColumn
        Caption = 'Frete (+)(Novo)'
        DataBinding.FieldName = 'ITE_FREENT_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 90
      end
      object cxgITE_VALFRE_ANT: TcxGridDBColumn
        Caption = 'Valor Frete (+)(Antigo)'
        DataBinding.FieldName = 'ITE_VALFRE_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 118
      end
      object cxgITE_VALFRE_ATU: TcxGridDBColumn
        Caption = 'Valor Frete (+)(Novo)'
        DataBinding.FieldName = 'ITE_VALFRE_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 118
      end
      object cxgITE_ACRFIN_ANT: TcxGridDBColumn
        Caption = 'Acr'#233'scimo Finan. (+)(Antigo)'
        DataBinding.FieldName = 'ITE_ACRFIN_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 150
      end
      object cxgITE_ACRFIN_ATU: TcxGridDBColumn
        Caption = 'Acr'#233'scimo Finan. (+)(Novo)'
        DataBinding.FieldName = 'ITE_ACRFIN_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 150
      end
      object cxgITE_SUBSTI_ANT: TcxGridDBColumn
        Caption = 'Sub. Tribut'#225'ria (+)(Antigo)'
        DataBinding.FieldName = 'ITE_SUBSTI_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 135
      end
      object cxgITE_SUBSTI_ATU: TcxGridDBColumn
        Caption = 'Sub. Tribut'#225'ria (+)(Novo)'
        DataBinding.FieldName = 'ITE_SUBSTI_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 135
      end
      object cxgITE_DESADB_ANT: TcxGridDBColumn
        Caption = 'Descontos Adicionais (Boleto) (-)(Antigo)'
        DataBinding.FieldName = 'ITE_DESADB_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 210
      end
      object cxgITE_DESADB_ATU: TcxGridDBColumn
        Caption = 'Descontos Adicionais (Boleto) (-)(Novo)'
        DataBinding.FieldName = 'ITE_DESADB_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 210
      end
      object cxgITE_OUTVAL_ANT: TcxGridDBColumn
        Caption = 'Outros Valores (+)(Antigo)'
        DataBinding.FieldName = 'ITE_OUTVAL_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 140
      end
      object cxgITE_OUTVAL_ATU: TcxGridDBColumn
        Caption = 'Outros Valores (+)(Novo)'
        DataBinding.FieldName = 'ITE_OUTVAL_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 140
      end
      object cxgITE_ICMSAI_ANT: TcxGridDBColumn
        Caption = 'ICMS Sa'#237'da (+)(Antigo)'
        DataBinding.FieldName = 'ITE_ICMSAI_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 120
      end
      object cxgITE_ICMSAI_ATU: TcxGridDBColumn
        Caption = 'ICMS Sa'#237'da (+)(Novo)'
        DataBinding.FieldName = 'ITE_ICMSAI_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 120
      end
      object cxgITE_IMPFED_ANT: TcxGridDBColumn
        Caption = 'Impostos Federais (+)(Antigo)'
        DataBinding.FieldName = 'ITE_IMPFED_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 155
      end
      object cxgITE_IMPFED_ATU: TcxGridDBColumn
        Caption = 'Impostos Federais (+)(Novo)'
        DataBinding.FieldName = 'ITE_IMPFED_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 155
      end
      object cxgITE_DESOPE_ANT: TcxGridDBColumn
        Caption = 'Despesas Operacionais (+)(Antigo)'
        DataBinding.FieldName = 'ITE_DESOPE_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 180
      end
      object cxgITE_DESOPE_ATU: TcxGridDBColumn
        Caption = 'Despesas Operacionais (+)(Antigo)'
        DataBinding.FieldName = 'ITE_DESOPE_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 180
      end
      object cxgITE_ICMENT_ANT: TcxGridDBColumn
        Caption = 'ICMS Entrada (-)(Antigo)'
        DataBinding.FieldName = 'ITE_ICMENT_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 130
      end
      object cxgITE_ICMENT_ATU: TcxGridDBColumn
        Caption = 'ICMS Entrada (-)(Novo)'
        DataBinding.FieldName = 'ITE_ICMENT_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.0000'
        MinWidth = 130
      end
      object cxgITE_TCIFCU_ANT: TcxGridDBColumn
        Caption = 'TCIF (+)(Antigo)'
        DataBinding.FieldName = 'ITE_TCIFCU_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 6
        Properties.DisplayFormat = '0.000000'
      end
      object cxgITE_TCIFCU_ATU: TcxGridDBColumn
        Caption = 'TCIF (+)(Novo)'
        DataBinding.FieldName = 'ITE_TCIFCU_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 6
        Properties.DisplayFormat = '0.000000'
      end
      object cxgITE_TSCUST_ANT: TcxGridDBColumn
        Caption = 'TS (+)(Antigo)'
        DataBinding.FieldName = 'ITE_TSCUST_ANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 6
        Properties.DisplayFormat = '0.000000'
      end
      object cxgITE_TSCUST_ATU: TcxGridDBColumn
        Caption = 'TS (+)(Novo)'
        DataBinding.FieldName = 'ITE_TSCUST_ATU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 6
        Properties.DisplayFormat = '0.000000'
      end
      object cxgITE_DEPICO_ANT: TcxGridDBColumn
        Caption = 'Desconto PIS/COFINS (-)(Antigo)'
        DataBinding.FieldName = 'ITE_DEPICO_ANT'
      end
      object cxgITE_DEPICO_ATU: TcxGridDBColumn
        Caption = 'Desconto PIS/COFINS (-)(Novo)'
        DataBinding.FieldName = 'ITE_DEPICO_ATU'
      end
      object cxgITE_DEICMS_ANT: TcxGridDBColumn
        Caption = 'Desconto ICMS (-)(Antigo)'
        DataBinding.FieldName = 'ITE_DEICMS_ANT'
      end
      object cxgITE_DEICMS_ATU: TcxGridDBColumn
        Caption = 'Desconto ICMS (-)(Novo)'
        DataBinding.FieldName = 'ITE_DEICMS_ATU'
      end
      object cxgITE_FATREG_ANT: TcxGridDBColumn
        Caption = 'Fator Regional (+)(Antigo)'
        DataBinding.FieldName = 'ITE_FATREG_ANT'
      end
      object cxgITE_FATREG_ATU: TcxGridDBColumn
        Caption = 'Fator Regional (+)(Novo)'
        DataBinding.FieldName = 'ITE_FATREG_ATU'
      end
    end
    object cxlItens: TcxGridLevel
      GridView = cxvItens
    end
  end
  object dtsItens: TDataSource
    Left = 476
    Top = 300
  end
end
