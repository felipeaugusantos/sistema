inherited frmAtualizacaoCotacaoDolarNosCatalogosConfirma: TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma
  Width = 1357
  Height = 685
  BorderStyle = bsSingle
  Caption = 'Atualiza'#231#227'o da Cota'#231#227'o do Dolar Nos Cat'#225'logos - Confirma'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1357
  ExplicitHeight = 685
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 614
    Width = 1351
    ExplicitTop = 614
    ExplicitWidth = 1351
    inherited FlwBotoes: TFlowPanel
      Width = 1347
      ExplicitTop = 2
      ExplicitWidth = 1347
    end
    inherited btnSair: TBitBtnLocked
      Left = 1271
      ExplicitLeft = 1271
    end
  end
  inherited pnlStatus: TPanel
    Top = 640
    Width = 1351
    ExplicitTop = 640
    ExplicitWidth = 1351
    inherited pnlNomeForm: TPanel
      Left = 1180
      ExplicitLeft = 1180
    end
    inherited pnlInfo: TPanel
      Width = 1180
      ExplicitWidth = 1180
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1351
    Height = 579
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir o filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      object cxgItensViewCodIte: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CAT_CODITE'
        BestFitMaxWidth = 20
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 60
      end
      object cxgItensViewCodFab: TcxGridDBColumn
        Caption = 'C'#243'd. Fabr.'
        DataBinding.FieldName = 'CODFAB'
        Width = 111
      end
      object cxgItensViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 206
      end
      object cxgItensUNIDADE: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'UNI_SIGUNI'
      end
      object cxgItensViewPRECUS: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(Atual)'
        DataBinding.FieldName = 'CAT_PRECUS'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 128
      end
      object cxgItensViewPRECUS_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o de Custo(Novo)'
        DataBinding.FieldName = 'CAT_PRECUS_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Styles.Content = cxStyle1
        Width = 121
      end
      object cxgItensViewPRECOM: TcxGridDBColumn
        Caption = 'Pre'#231'o Compra(Atual)'
        DataBinding.FieldName = 'CAT_PRECOM'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 115
      end
      object cxgItensViewMARBR1: TcxGridDBColumn
        Caption = 'Margem Bruta 1 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR1'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR1_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 1 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR1_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE1: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE1'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE1_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 1 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE1_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewMARBR2: TcxGridDBColumn
        Caption = 'Margem Bruta 2 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR2'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR2_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 2 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR2_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE2: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE2'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE2_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 2 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE2_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewMARBR3: TcxGridDBColumn
        Caption = 'Margem Bruta 3 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR3'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR3_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 3 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR3_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE3: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE3'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE3_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 3 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE3_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewMARBR4: TcxGridDBColumn
        Caption = 'Margem Bruta 4 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR4'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR4_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 4 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR4_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE4: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE4'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE4_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 4 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE4_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewMARBR5: TcxGridDBColumn
        Caption = 'Margem Bruta 5 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR5'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR5_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 5 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR5_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE5: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE5'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE5_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 5 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE5_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewMARBR6: TcxGridDBColumn
        Caption = 'Margem Bruta 6 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR6'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR6_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 6 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR6_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE6: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE6'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE6_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 6 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE6_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewMARBR7: TcxGridDBColumn
        Caption = 'Margem Bruta 7 (Atual)'
        DataBinding.FieldName = 'CAT_MARBR7'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewMARBR7_NOV: TcxGridDBColumn
        Caption = 'Margem Bruta 7 (Novo)'
        DataBinding.FieldName = 'CAT_MARBR7_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
      object cxgItensViewPREVE7: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7 (Atual)'
        DataBinding.FieldName = 'CAT_PREVE7'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Width = 124
      end
      object cxgItensViewPREVE7_NOV: TcxGridDBColumn
        Caption = 'Pre'#231'o Venda 7 (Novo)'
        DataBinding.FieldName = 'CAT_PREVE7_NOV'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '0,.00'
        Properties.UseThousandSeparator = True
        Visible = False
        Styles.Content = cxStyle1
        Width = 124
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlProgress: TPanel [4]
    Left = 0
    Top = 579
    Width = 1351
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object lblInf: TLabel
      Left = 0
      Top = 0
      Width = 1351
      Height = 18
      Align = alClient
      Caption = 'lblStatus'
      Visible = False
      ExplicitWidth = 41
      ExplicitHeight = 14
    end
    object prgProgress: TProgressBar
      Left = 0
      Top = 18
      Width = 1351
      Height = 17
      Align = alBottom
      TabOrder = 0
      Visible = False
    end
  end
  object dtsItens: TDataSource
    Left = 544
    Top = 328
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
