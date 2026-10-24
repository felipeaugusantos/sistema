object frmTabelasDoItemGrid: TfrmTabelasDoItemGrid
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object cxvPrecos: TcxDBVerticalGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    LayoutStyle = lsMultiRecordView
    LookAndFeel.ScrollbarMode = sbmClassic
    OptionsView.BandsInterval = 0
    OptionsView.RowHeaderWidth = 184
    OptionsView.ValueWidth = 105
    OptionsView.NavigatorOffset = 30
    OptionsView.RecordsInterval = 10
    OptionsBehavior.GoToNextCellOnEnter = True
    OptionsBehavior.GoToNextCellOnTab = True
    OptionsBehavior.BandSizing = False
    OptionsBehavior.HeaderSizing = False
    OptionsData.Editing = False
    OptionsData.Appending = False
    OptionsData.Deleting = False
    OptionsData.DeletingConfirmation = False
    OptionsData.Inserting = False
    Navigator.Buttons.CustomButtons = <>
    Styles.Background = cxsColunaFixa
    TabOrder = 0
    DataController.GridMode = True
    Version = 1
    object cxvPrecosTABELA: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = ' Tabela de Pre'#231'o   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taCenter
      Properties.DataBinding.FieldName = 'TABELA'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      Styles.Content = cxsColunaFixa
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxvPrecosTabFornecedor: TcxDBEditorRow
      Properties.Caption = 'Tabela do Fornecedor  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taCenter
      Properties.DataBinding.FieldName = 'ITE_CODTAB'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 1
      ParentID = 0
      Index = 0
      Version = 1
    end
    object cxvPrecosDBEditorRow3: TcxDBEditorRow
      Properties.Caption = 'Nome da tabela   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'NOMTAB'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 2
      ParentID = 1
      Index = 0
      Version = 1
    end
    object cxvPrecosDBEditorRow2: TcxDBEditorRow
      Properties.Caption = 'Fornecedor da Tabela  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'FORNEC'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 3
      ParentID = 1
      Index = 1
      Version = 1
    end
    object cxvPrecosCatMarIde: TcxCategoryRow
      Options.ShowExpandButton = False
      Options.TabStop = False
      Properties.Caption = 'Margem Ideal'
      Styles.Header = cxsNegrito
      Visible = False
      ID = 4
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxvPrecosMARIDE: TcxDBEditorRow
      Properties.Caption = 'Margem Ideal   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_MARIDE'
      Styles.Header = cxsMargem
      ID = 5
      ParentID = 4
      Index = 0
      Version = 1
    end
    object cxvPrecosPREIDE: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o Venda Ideal   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 4
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'PREIDE'
      Properties.Options.Editing = False
      Styles.Header = cxsPreco
      Styles.Content = cxsColunaFixa
      ID = 6
      ParentID = 4
      Index = 1
      Version = 1
    end
    object cxvPrecosCatPreVen: TcxCategoryRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda'
      Styles.Header = cxsNegrito
      ID = 7
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxvPrecosMARBRU: TcxDBEditorRow
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_MARBRU'
      Styles.Header = cxsMargem
      ID = 8
      ParentID = 7
      Index = 0
      Version = 1
    end
    object cxvPrecosMARMK3: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'MARMK3'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      Styles.Content = cxsColunaFixa
      Visible = False
      ID = 9
      ParentID = 7
      Index = 1
      Version = 1
    end
    object cxvPrecosCOMTBL: TcxDBEditorRow
      Properties.Caption = 'Comiss'#227'o   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_COMTBL'
      Styles.Header = cxsColunaFixa
      ID = 10
      ParentID = 7
      Index = 2
      Version = 1
    end
    object cxvPrecosPREVEN: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.FieldName = 'ITE_PREVEN'
      Styles.Header = cxsPreco
      Styles.Content = cxsNegrito
      ID = 11
      ParentID = 7
      Index = 3
      Version = 1
    end
    object cxvPrecosVENDOL: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda US$   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'ITE_VENDOL'
      Properties.Options.Editing = False
      Styles.Header = cxsDolar
      Styles.Content = cxsColunaFixa
      ID = 12
      ParentID = 7
      Index = 4
      Version = 1
    end
    object cxvPrecosPromocao: TcxCategoryRow
      Properties.Caption = 'Pre'#231'o de Promo'#231#227'o'
      ID = 13
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxvPrecosPRO_MARGEM: TcxDBEditorRow
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '0.0000'
      Properties.DataBinding.FieldName = 'ITE_MARPRO'
      Properties.OnGetDisplayText = cxvPrecosPRO_MARGEMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 14
      ParentID = 13
      Index = 0
      Version = 1
    end
    object cxvPrecosPRO_PREVEN: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '0.0000'
      Properties.DataBinding.FieldName = 'ITE_VENPRO'
      Properties.OnGetDisplayText = cxvPrecosPRO_PREVENPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 15
      ParentID = 13
      Index = 1
      Version = 1
    end
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 496
    Top = 328
    PixelsPerInch = 96
    object cxStyleZebra: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxsColunaFixa: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
    object cxsColunaFixaDestaque: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxsPreco: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxsMargem: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxsTituloBlue: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clBtnFace
      TextColor = clBlack
    end
    object cxsTituloRed: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clBtnFace
      TextColor = clRed
    end
    object cxsNegrito: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsDolar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16770261
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
