object frmTabelasDoItemEmpresaFrame: TfrmTabelasDoItemEmpresaFrame
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
    OptionsView.CellEndEllipsis = True
    OptionsView.BandsInterval = 0
    OptionsView.RowHeaderWidth = 184
    OptionsView.ValueWidth = 105
    OptionsView.NavigatorOffset = 30
    OptionsView.RecordsInterval = 10
    OptionsBehavior.GoToNextCellOnEnter = True
    OptionsBehavior.GoToNextCellOnTab = True
    OptionsBehavior.BandSizing = False
    OptionsBehavior.HeaderSizing = False
    OptionsData.Appending = False
    OptionsData.Deleting = False
    OptionsData.DeletingConfirmation = False
    OptionsData.Inserting = False
    Navigator.Buttons.CustomButtons = <>
    Styles.Background = cxsColunaFixa
    TabOrder = 0
    OnItemChanged = cxvPrecosItemChanged
    DataController.GridMode = True
    Version = 1
    object cxvPrecosDBEditorRow1: TcxDBEditorRow
      Properties.Caption = 'Tabela de Pre'#231'o   '
      Properties.HeaderAlignmentHorz = taCenter
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
    object cxvPrecosSUBFED: TcxDBEditorRow
      Properties.Caption = 'Impostos Federais (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosSUBFEDEditPropertiesValidate
      Properties.DataBinding.FieldName = 'CUS_SUBFED'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosSUBFEDPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 1
      ParentID = 0
      Index = 0
      Version = 1
    end
    object cxvPrecosIMPFED: TcxDBEditorRow
      Properties.Caption = 'Impostos Federais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosIMPFEDEditPropertiesValidate
      Properties.DataBinding.FieldName = 'CUS_IMPFED'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosSUBFEDPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 2
      ParentID = 0
      Index = 1
      Version = 1
    end
    object cxvPrecosICMSAI: TcxDBEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosICMSAIEditPropertiesValidate
      Properties.DataBinding.FieldName = 'CUS_ICMSAI'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosSUBFEDPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 3
      ParentID = 0
      Index = 2
      Version = 1
    end
    object cxvPrecosDESOPE: TcxDBEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESOPEEditPropertiesValidate
      Properties.DataBinding.FieldName = 'CUS_DESOPE'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosSUBFEDPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 4
      ParentID = 0
      Index = 3
      Version = 1
    end
    object cxvPrecosOUTVAL: TcxDBEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.FieldName = 'CUS_OUTVAL'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosOUTVALPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 5
      ParentID = 0
      Index = 4
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
