inherited frmAltPrecoGlobalMargemNeg: TfrmAltPrecoGlobalMargemNeg
  Width = 1032
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o das Margens Negativas dos Itens '
  WindowState = wsMaximized
  ExplicitWidth = 1032
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 1016
    ExplicitTop = 517
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 1012
      TabOrder = 2
      ExplicitWidth = 780
    end
    inherited btnSair: TBitBtnLocked
      Left = 933
      ExplicitLeft = 701
    end
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 3
      Width = 111
      Height = 22
      Caption = '[ F10 ] Confirma'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1016
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 845
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 845
      ExplicitWidth = 613
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1016
    Height = 517
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 784
    object cxvItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = cxvItensViewEditKeyDown
      DataController.DataSource = dtsMarNeg
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxs2
      object cxvItensViewColumn1: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'ITE_CODEMP'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 62
      end
      object cxgItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Options.Editing = False
        Width = 60
      end
      object cxgItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 328
      end
      object cxgItensMARBR1: TcxGridDBColumn
        Caption = '% Margem 1'
        DataBinding.FieldName = 'ITE_MARBR1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensMARLQ1: TcxGridDBColumn
        Caption = '% Margem Liq.1'
        DataBinding.FieldName = 'ITE_MARLQ1_NOV'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensPREVE1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1'
        DataBinding.FieldName = 'ITE_PREVE1_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensMARBR2: TcxGridDBColumn
        Caption = '% Margem 2'
        DataBinding.FieldName = 'ITE_MARBR2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensMARLQ2: TcxGridDBColumn
        Caption = '% Margem Liq.2'
        DataBinding.FieldName = 'ITE_MARLQ2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensPREVE2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2'
        DataBinding.FieldName = 'ITE_PREVE2_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensMARBR3: TcxGridDBColumn
        Caption = '% Margem 3'
        DataBinding.FieldName = 'ITE_MARBR3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensPREVE3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3'
        DataBinding.FieldName = 'ITE_PREVE3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensMARLQ3: TcxGridDBColumn
        Caption = '% Margem Liq.3'
        DataBinding.FieldName = 'ITE_MARLQ3_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensMARBR4: TcxGridDBColumn
        Caption = '% Margem 4'
        DataBinding.FieldName = 'ITE_MARBR4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensMARLQ4: TcxGridDBColumn
        Caption = '% Margem Liq.4'
        DataBinding.FieldName = 'ITE_MARLQ4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensPREVE4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4'
        DataBinding.FieldName = 'ITE_PREVE4_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensMARBR5: TcxGridDBColumn
        Caption = '% Margem 5'
        DataBinding.FieldName = 'ITE_MARBR5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensMARLQ5: TcxGridDBColumn
        Caption = '% Margem Liq.5'
        DataBinding.FieldName = 'ITE_MARLQ5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensPREVE5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5'
        DataBinding.FieldName = 'ITE_PREVE5_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensMARBR6: TcxGridDBColumn
        Caption = '% Margem 6'
        DataBinding.FieldName = 'ITE_MARBR6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensMARLQ6: TcxGridDBColumn
        Caption = '% Margem Liq.6'
        DataBinding.FieldName = 'ITE_MARLQ6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensPREVE6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6'
        DataBinding.FieldName = 'ITE_PREVE6_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
      object cxgItensMARBR7: TcxGridDBColumn
        Caption = '% Margem 7'
        DataBinding.FieldName = 'ITE_MARBR7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxgItensMARLQ7: TcxGridDBColumn
        Caption = '% Margem Liq.7'
        DataBinding.FieldName = 'ITE_MARLQ7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgItensPREVE7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7'
        DataBinding.FieldName = 'ITE_PREVE7_NOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
      end
    end
    object cxlGrid1Level1: TcxGridLevel
      GridView = cxvItensView
    end
  end
  object cxs1: TcxStyleRepository
    Left = 96
    Top = 176
    PixelsPerInch = 96
    object cxs2: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object dtsMarNeg: TDataSource
    Left = 560
    Top = 208
  end
end
