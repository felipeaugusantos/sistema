object frmTabelasDoItemFrame: TfrmTabelasDoItemFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 616
  Align = alClient
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  ExplicitHeight = 305
  object cxvPrecos: TcxDBVerticalGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 597
    Align = alClient
    LayoutStyle = lsMultiRecordView
    LookAndFeel.ScrollbarMode = sbmClassic
    OptionsView.CellEndEllipsis = True
    OptionsView.ScrollBars = ssVertical
    OptionsView.BandsInterval = 0
    OptionsView.RowHeaderWidth = 221
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
    OnDrawValue = cxvPrecosDrawValue
    OnEditing = cxvPrecosEditing
    OnItemChanged = cxvPrecosItemChanged
    OnKeyDown = cxvPrecosKeyDown
    OnKeyPress = cxvPrecosKeyPress
    DataController.GridMode = True
    ExplicitHeight = 286
    Version = 1
    object cxvPrecosTABELA: TcxDBEditorRow
      Options.ShowExpandButton = False
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
    object cxvPrecosCUSATI: TcxDBEditorRow
      Properties.Caption = 'Custo Ativo  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxLabelProperties'
      Properties.EditProperties.Alignment.Horz = taCenter
      Properties.EditProperties.Alignment.Vert = taVCenter
      Properties.DataBinding.FieldName = 'CUSATI'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosCUSATIPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 1
      ParentID = 0
      Index = 0
      Version = 1
    end
    object cxvPrecosTabFornecedor: TcxDBEditorRow
      Options.ShowExpandButton = False
      Properties.Caption = 'Tabela do Fornecedor  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.Alignment.Horz = taCenter
      Properties.EditProperties.OnValidate = cxvPrecosDBEditorRow1EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_CODTAB'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 2
      ParentID = 0
      Index = 1
      Version = 1
    end
    object cxvPrecosDBEditorRow3: TcxDBEditorRow
      Properties.Caption = 'Nome da tabela   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'NOMTAB'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 3
      ParentID = 2
      Index = 0
      Version = 1
    end
    object cxvPrecosDBEditorRow2: TcxDBEditorRow
      Options.Moving = False
      Options.ShowExpandButton = False
      Properties.Caption = 'Fornecedor da Tabela  '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'FORNEC'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 4
      ParentID = 2
      Index = 1
      Version = 1
    end
    object cxvPrecosAbreviacaoICMS: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Properties.Caption = 'Abrevia'#231#227'o de ICMS'
      ID = 5
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxvPrecosCODABF: TcxDBEditorRow
      Properties.Caption = 'Abrevia'#231#227'o Fiscal   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.DataBinding.FieldName = 'ITE_CODABF'
      Properties.OnGetDisplayText = cxvPrecosCODABFPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 6
      ParentID = 5
      Index = 0
      Version = 1
    end
    object cxvPrecosIVA: TcxDBEditorRow
      Properties.Caption = 'IVA   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '0.0000'
      Properties.DataBinding.FieldName = 'ITE_IVA'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 7
      ParentID = 5
      Index = 1
      Version = 1
    end
    object cxvPrecosCategoryRow1: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Properties.Caption = 'Pre'#231'o de Compra'
      Styles.Header = cxsNegrito
      ID = 8
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxvPrecosPREDOL: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Em D'#243'lar   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      Properties.EditProperties.ImmediatePost = True
      Properties.EditProperties.ValueChecked = 'S'
      Properties.EditProperties.ValueUnchecked = 'N'
      Properties.DataBinding.FieldName = 'ITE_PREDOL'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 9
      ParentID = 8
      Index = 0
      Version = 1
    end
    object cxvPrecosPREEMB: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Pre'#231'o de Compra Embalagem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxvPrecosPRECOMEditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_PRECOM'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixaDestaque
      ID = 10
      ParentID = 8
      Index = 1
      Version = 1
    end
    object cxvPrecosPRECOM: TcxDBEditorRow
      Tag = 1
      Height = 17
      Properties.Caption = 'Pre'#231'o de Compra   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxvPrecosPRECOMEditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_PRECOM'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixaDestaque
      ID = 11
      ParentID = 8
      Index = 2
      Version = 1
    end
    object cxvPrecosDESF01: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto 01 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESF01'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 12
      ParentID = 8
      Index = 3
      Version = 1
    end
    object cxvPrecosDESF02: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto 02 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESF02'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 13
      ParentID = 8
      Index = 4
      Version = 1
    end
    object cxvPrecosDESF03: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto 03 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESF03'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 14
      ParentID = 8
      Index = 5
      Version = 1
    end
    object cxvPrecosDESF04: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto 04 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESF04'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 15
      ParentID = 8
      Index = 6
      Version = 1
    end
    object cxvPrecosDESF05: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto 05 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESF05'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 16
      ParentID = 8
      Index = 7
      Version = 1
    end
    object cxvPrecosDESF06: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto 06 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESF06'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 17
      ParentID = 8
      Index = 8
      Version = 1
    end
    object cxvPrecosCOMLIQ: TcxDBEditorRow
      Expanded = False
      Properties.Caption = 'Pre'#231'o de Compra L'#237'quido   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.DataBinding.FieldName = 'ITE_COMLIQ'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      ID = 18
      ParentID = 8
      Index = 9
      Version = 1
    end
    object cxvPrecosCatPreCus: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo'
      Styles.Header = cxsNegrito
      ID = 19
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxvPrecosICMENT: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'ICMS de Entrada (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_ICMENT'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 20
      ParentID = 19
      Index = 0
      Version = 1
    end
    object cxvPrecosSUBFED: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Impostos Federais (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_SUBFED'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 21
      ParentID = 19
      Index = 1
      Version = 1
    end
    object cxvPrecosIPIENT: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'IPI Entrada (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_IPIENT'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 22
      ParentID = 19
      Index = 2
      Version = 1
    end
    object cxvPrecosFREENT: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Frete (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_FREENT'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 23
      ParentID = 19
      Index = 3
      Version = 1
    end
    object cxvPrecosVALFRE: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Valor do Frete  (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_VALFRE'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 24
      ParentID = 19
      Index = 4
      Version = 1
    end
    object cxvPrecosACRFIN: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Acr'#233'scimo Financeiro (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_ACRFIN'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 25
      ParentID = 19
      Index = 5
      Version = 1
    end
    object cxvPrecosSUBSTI: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Substitui'#231#227'o Tribut'#225'ria (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_SUBSTI'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 26
      ParentID = 19
      Index = 6
      Version = 1
    end
    object cxvPrecosDESADB: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Descontos Adicionais (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESADB'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 27
      ParentID = 19
      Index = 7
      Version = 1
    end
    object cxvPrecosTCIFCU: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'TCIF (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_TCIFCU'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 28
      ParentID = 19
      Index = 8
      Version = 1
    end
    object cxvPrecosTSCUST: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'TS (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_TSCUST'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 29
      ParentID = 19
      Index = 9
      Version = 1
    end
    object cxvPrecosDEPICO: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto PIS/COFINS (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DEPICO'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 30
      ParentID = 19
      Index = 10
      Version = 1
    end
    object cxvPrecosDEICMS: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Desconto ICMS (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DEICMS'
      Properties.Options.Editing = False
      Styles.Header = cxsColunaFixa
      ID = 31
      ParentID = 19
      Index = 11
      Version = 1
    end
    object cxvPrecosFATREG: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Fator Regional (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_FATREG'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 32
      ParentID = 19
      Index = 12
      Version = 1
    end
    object cxvPrecosPRECUS: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'ITE_PRECUS'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      ID = 33
      ParentID = 19
      Index = 13
      Version = 1
    end
    object cxvPrecosCatCusRea: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo Real'
      Styles.Header = cxsNegrito
      ID = 34
      ParentID = -1
      Index = 4
      Version = 1
    end
    object cxvPrecosOUTVAL: TcxDBEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_OUTVAL'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 35
      ParentID = 34
      Index = 0
      Version = 1
    end
    object cxvPrecosICMSAI: TcxDBEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_ICMSAI'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 36
      ParentID = 34
      Index = 1
      Version = 1
    end
    object cxvPrecosIMPFED: TcxDBEditorRow
      Tag = 1
      Properties.Caption = 'Impostos Federais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_IMPFED'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 37
      ParentID = 34
      Index = 2
      Version = 1
    end
    object cxvPrecosDESOPE: TcxDBEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosDESF01EditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_DESOPE'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 38
      ParentID = 34
      Index = 3
      Version = 1
    end
    object cxvPrecosCUSREA: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Custo Real   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'ITE_CUSREA'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixaDestaque
      Styles.Content = cxsColunaFixaDestaque
      ID = 39
      ParentID = 34
      Index = 4
      Version = 1
    end
    object cxvPrecosCatMarIde: TcxCategoryRow
      Options.ShowExpandButton = False
      Options.TabStop = False
      Properties.Caption = 'Margem Ideal'
      Styles.Header = cxsNegrito
      Visible = False
      ID = 40
      ParentID = -1
      Index = 5
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
      ID = 41
      ParentID = 40
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
      ID = 42
      ParentID = 40
      Index = 1
      Version = 1
    end
    object cxvPrecosCatPreVen: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda'
      Styles.Header = cxsNegrito
      ID = 43
      ParentID = -1
      Index = 6
      Version = 1
    end
    object cxvPrecosMARBRU: TcxDBEditorRow
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosMARBRUEditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_MARBRU'
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsMargem
      ID = 44
      ParentID = 43
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
      ID = 45
      ParentID = 43
      Index = 1
      Version = 1
    end
    object cxvPrecosCOMTBL: TcxDBEditorRow
      Properties.Caption = 'Comiss'#227'o   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.EditProperties.OnValidate = cxvPrecosCOMTBLEditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_COMTBL'
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 46
      ParentID = 43
      Index = 2
      Version = 1
    end
    object cxvPrecosVENDOL: TcxDBEditorRow
      Options.TabStop = False
      Properties.Caption = 'Pre'#231'o de Venda US$   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.DataBinding.FieldName = 'ITE_VENDOL'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsDolar
      Styles.Content = cxsColunaFixa
      ID = 47
      ParentID = 43
      Index = 3
      Version = 1
    end
    object cxvPrecosPREVEN: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxvPrecosPREVENEditPropertiesValidate
      Properties.DataBinding.FieldName = 'ITE_PREVEN'
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsPreco
      Styles.Content = cxsNegrito
      ID = 48
      ParentID = 43
      Index = 4
      Version = 1
    end
    object cxvPrecosPREREV: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Revista   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_PREREV'
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsMargem
      Visible = False
      ID = 49
      ParentID = 43
      Index = 5
      Version = 1
    end
    object cxvPrecosDESREV: TcxDBEditorRow
      Properties.Caption = 'Desconto Revista   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_DESREV'
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsMargem
      Visible = False
      ID = 50
      ParentID = 43
      Index = 6
      Version = 1
    end
    object cxvPrecosPromocao: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Properties.Caption = 'Pre'#231'o de Promo'#231#227'o'
      ID = 51
      ParentID = -1
      Index = 7
      Version = 1
    end
    object cxvPrecosPRO_MARGEM: TcxDBEditorRow
      Properties.Caption = 'Margem   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '0.0000'
      Properties.DataBinding.FieldName = 'ITE_MARPRO'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRO_MARGEMPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 52
      ParentID = 51
      Index = 0
      Version = 1
    end
    object cxvPrecosPRO_PREVEN: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = '0.0000'
      Properties.DataBinding.FieldName = 'ITE_VENPRO'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRO_PREVENPropertiesGetDisplayText
      Styles.Header = cxsColunaFixa
      ID = 53
      ParentID = 51
      Index = 1
      Version = 1
    end
    object cxvPrecosGiro: TcxCategoryRow
      Height = 10
      Options.ShowExpandButton = False
      Properties.Caption = 'Defini'#231#227'o do Giro'
      ID = 54
      ParentID = -1
      Index = 8
      Version = 1
    end
    object cxvPrecosMARGIR: TcxDBEditorRow
      Properties.Caption = 'Margem Padr'#227'o    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_MARGIR'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosDESF01PropertiesGetDisplayText
      Styles.Header = cxsMargem
      ID = 55
      ParentID = 54
      Index = 0
      Version = 1
    end
    object cxvPrecosVENGIR: TcxDBEditorRow
      Properties.Caption = 'Pre'#231'o de Venda Padr'#227'o    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DecimalPlaces = 2
      Properties.EditProperties.DisplayFormat = ',0.00;-,0.00'
      Properties.DataBinding.FieldName = 'ITE_VENGIR'
      Properties.Options.Editing = False
      Properties.OnGetDisplayText = cxvPrecosPRECOMPropertiesGetDisplayText
      Styles.Header = cxsMargem
      ID = 56
      ParentID = 54
      Index = 1
      Version = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 23
    Height = 24
    BevelOuter = bvNone
    TabOrder = 1
    object btnExpand: TSpeedButton
      Left = 0
      Top = 23
      Width = 23
      Height = 23
      Align = alTop
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000002000000070000
        000A0000000A0000000A0000000A0000000A0000000700000002000000000000
        00000000000000000000000000000000000000000000000000050000000E0000
        0013000000130000001300000013000000130000000E00000005000000000000
        0000000000000000000000000000000000000000000000000002896154FF8961
        54FF896154FF896154FF896154FF896154FF896154FF00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000050000000E00000013000000130000000E00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000005BA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000050000000E00000013000000130000000E00000005000000000000
        0000000000020000000600000008000000060000000200000002000000070000
        000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
        000000000006000000120000001A0000001200000006000000050000000E0000
        0013000000130000001300000013000000130000000E00000005000000020000
        00060000000F16412FBB1F5D43FF16412FBB0000000F00000008896154FF8961
        54FF896154FF896154FF896154FF896154FF896154FF00000005000000060000
        00120000001E24654AFF4FC59EFF24654AFF0000001E00000012000000060000
        0000000000050000000E00000013000000130000000E00000005000000081C4C
        39BA296D52FF296D52FF60CEAAFF296D52FF296D52FF1C4C39BA000000080000
        000000000005BA9182FFBA9182FFBA9182FFBA9182FF00000005000000062F77
        5AFFAAEDDBFF73D6B7FF73D6B7FF73D6B7FF73D6B7FF2F775AFF000000060000
        0000000000050000000E00000013000000130000000E00000005000000022459
        44B4347F62FF347F62FF84DFC3FF347F62FF347F62FF245944B5000000090000
        000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
        000000000006398769FFAAEDDBFF398769FF00000006000000050000000E0000
        0013000000130000001300000013000000130000000E00000005000000000000
        0000000000022A614DB43C8C6EFF2A614DB40000000200000002896154FF8961
        54FF896154FF896154FF896154FF896154FF896154FF00000002}
      Layout = blGlyphTop
      OnClick = btnExpandClick
      ExplicitTop = 0
      ExplicitWidth = 807
    end
    object btnCollapse: TSpeedButton
      Left = 0
      Top = 0
      Width = 23
      Height = 23
      Align = alTop
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000002000000070000
        000A0000000A0000000A0000000A0000000A0000000700000002000000000000
        00000000000000000000000000000000000000000000000000050000000E0000
        0013000000130000001300000013000000130000000E00000005000000000000
        0000000000000000000000000000000000000000000000000002896154FF8961
        54FF896154FF896154FF896154FF896154FF896154FF00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000050000000E00000013000000130000000E00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000005BA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000050000000E00000013000000130000000E00000005000000000000
        0000000000000000000000000000000000000000000000000002000000070000
        000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
        00000000000000000000000000000000000000000000000000050000000E0000
        0013000000130000001300000013000000130000000E00000005000000020000
        0006000000090000000A0000000A0000000A0000000900000008896154FF8961
        54FF896154FF896154FF896154FF896154FF896154FF00000005000000060000
        00120000001B0000001C0000001C0000001C0000001B00000012000000060000
        0000000000050000000E00000013000000130000000E00000005000000082728
        85BA383ABFFF383ABFFF383ABFFF383ABFFF383ABFFF272885BA000000080000
        000000000005BA9182FFBA9182FFBA9182FFBA9182FF0000000500000006494A
        C8FF7C97F0FF7C97F0FF7C97F0FF7C97F0FF7C97F0FF494AC8FF000000060000
        0000000000050000000E00000013000000130000000E00000005000000023B3C
        91B45556CFFF5556CFFF5556CFFF5556CFFF5556CFFF3B3C8FB5000000090000
        000A0000000CBA9182FFBA9182FFBA9182FFBA9182FF00000005000000000000
        00000000000000000000000000000000000000000000000000050000000E0000
        0013000000130000001300000013000000130000000E00000005000000000000
        0000000000000000000000000000000000000000000000000002896154FF8961
        54FF896154FF896154FF896154FF896154FF896154FF00000002}
      Layout = blGlyphTop
      OnClick = btnExpandClick
      ExplicitTop = 8
      ExplicitWidth = 25
    end
  end
  object pnlLegenda: TPanel
    Left = 0
    Top = 597
    Width = 451
    Height = 19
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 286
    object Shape1: TShape
      Left = 15
      Top = 3
      Width = 14
      Height = 13
      Brush.Color = clMoneyGreen
    end
    object Label1: TLabel
      Left = 35
      Top = 3
      Width = 239
      Height = 13
      Caption = 'Os valores ser'#227'o replicados para todas as tabelas'
    end
    object Shape2: TShape
      Left = 313
      Top = 2
      Width = 14
      Height = 14
      Brush.Color = clYellow
    end
    object Label2: TLabel
      Left = 333
      Top = 3
      Width = 471
      Height = 13
      Caption = 
        'Aten'#231#227'o, estas tabelas est'#227'o ativas, ao confirmar ira levar os v' +
        'alores para o Cadastro de Produto'
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
    object cxStyle1: TcxStyle
    end
    object cxStyle2: TcxStyle
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
  end
end
