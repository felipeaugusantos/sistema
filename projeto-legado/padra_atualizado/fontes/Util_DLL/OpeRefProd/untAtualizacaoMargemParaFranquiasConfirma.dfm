inherited frmAtualizacaoMargemParaFranquiasConfirma: TfrmAtualizacaoMargemParaFranquiasConfirma
  Width = 824
  Height = 428
  BorderStyle = bsSingle
  Caption = 'Atualiza'#231#227'o de Margem para Franquias - Confirma'
  WindowState = wsMaximized
  ExplicitWidth = 824
  ExplicitHeight = 428
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 357
    Width = 818
    ExplicitTop = 357
    ExplicitWidth = 818
    inherited FlwBotoes: TFlowPanel
      Width = 814
      ExplicitWidth = 814
    end
    inherited btnSair: TBitBtnLocked
      Left = 735
      ExplicitLeft = 735
    end
  end
  inherited pnlStatus: TPanel
    Top = 383
    Width = 818
    ExplicitTop = 383
    ExplicitWidth = 818
    inherited pnlNomeForm: TPanel
      Left = 647
      ExplicitLeft = 647
    end
    inherited pnlInfo: TPanel
      Width = 647
      ExplicitWidth = 647
    end
  end
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 818
    Height = 357
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvDados: TcxGridDBTableViewCitel
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
      object cxvPRODUTO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'PRODUTO'
        Visible = False
        GroupIndex = 0
      end
      object cxvITE_CODEMP: TcxGridDBColumn
        Caption = 'Empresa Matriz'
        DataBinding.FieldName = 'ITE_CODEMP'
      end
      object cxvITE_REGTRI: TcxGridDBColumn
        Caption = 'Regime Tributario'
        DataBinding.FieldName = 'COD_REGTRI'
        Width = 116
      end
      object cxvITE_MARBR1: TcxGridDBColumn
        Caption = 'Margem Bruta 1'
        DataBinding.FieldName = 'ITE_MARBR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR1_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 1(Novo)'
        DataBinding.FieldName = 'ITE_MARBR1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1'
        DataBinding.FieldName = 'ITE_PREVE1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE1_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1(Novo)'
        DataBinding.FieldName = 'ITE_PREVE1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_MARBR2: TcxGridDBColumn
        Caption = 'Margem Bruta 2'
        DataBinding.FieldName = 'ITE_MARBR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR2_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 2(Novo)'
        DataBinding.FieldName = 'ITE_MARBR2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2'
        DataBinding.FieldName = 'ITE_PREVE2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE2_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2(Novo)'
        DataBinding.FieldName = 'ITE_PREVE2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_MARBR3: TcxGridDBColumn
        Caption = 'Margem Bruta 3'
        DataBinding.FieldName = 'ITE_MARBR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR3_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 3(Novo)'
        DataBinding.FieldName = 'ITE_MARBR3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3'
        DataBinding.FieldName = 'ITE_PREVE3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE3_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3(Novo)'
        DataBinding.FieldName = 'ITE_PREVE3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_MARBR4: TcxGridDBColumn
        Caption = 'Margem Bruta 4'
        DataBinding.FieldName = 'ITE_MARBR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR4_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 4(Novo)'
        DataBinding.FieldName = 'ITE_MARBR4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4'
        DataBinding.FieldName = 'ITE_PREVE4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE4_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4(Novo)'
        DataBinding.FieldName = 'ITE_PREVE4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_MARBR5: TcxGridDBColumn
        Caption = 'Margem Bruta 5'
        DataBinding.FieldName = 'ITE_MARBR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR5_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 5(Novo)'
        DataBinding.FieldName = 'ITE_MARBR5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5'
        DataBinding.FieldName = 'ITE_PREVE5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE5_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5(Novo)'
        DataBinding.FieldName = 'ITE_PREVE5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_MARBR6: TcxGridDBColumn
        Caption = 'Margem Bruta 6'
        DataBinding.FieldName = 'ITE_MARBR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR6_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 6(Novo)'
        DataBinding.FieldName = 'ITE_MARBR6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6'
        DataBinding.FieldName = 'ITE_PREVE6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE6_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6(Novo)'
        DataBinding.FieldName = 'ITE_PREVE6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_MARBR7: TcxGridDBColumn
        Caption = 'Margem Bruta 7'
        DataBinding.FieldName = 'ITE_MARBR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_MARBR7_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 7(Novo)'
        DataBinding.FieldName = 'ITE_MARBR7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
      object cxvITE_PREVE7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7'
        DataBinding.FieldName = 'ITE_PREVE7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 100
      end
      object cxvITE_PREVE7_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7(Novo)'
        DataBinding.FieldName = 'ITE_PREVE7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = '0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 120
      end
    end
    object cxldados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object dtsDados: TDataSource
    Left = 400
    Top = 200
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clInactiveCaption
    end
  end
end
